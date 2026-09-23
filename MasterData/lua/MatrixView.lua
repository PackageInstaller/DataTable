-- 基地场景包含10个场景的内容：MatrixScene、Dorm、BS_Indoor_xxx(8个建筑)
-- 不进行场景切换，而是通过更换场景内容来实现场景切换
-- MatrixView层级为Top,为切换提供渐入渐出动画
-- 【MatrixView和MatrixScene同时监听Matrix_Building_Update出现了重叠UI的问题，因为两次调用太快，并且都是异步导致
-- 所以第一次需要在所有建造数据都更新后再打开界面】
local isToBlack = 0
local isFirst = true

local rRunTime = false
local rFastestData = nil -- {time,id} 最快刷新的建筑

-- function Awake()
--     CSAPI.CreateGOAsync("Scenes/Dorm/DormAmbientSetting")
-- end

function OnInit()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Loading_Complete, LoadingComplete)
    eventMgr:AddListener(EventType.Matrix_Indoor_Change, function(_data)
        sceneKey = _data[1]
        sceneData = _data[2]
        OpenCurView()
    end)
    eventMgr:AddListener(EventType.Matrix_Building_Update, InitResetTime) -- 建筑更新
    EventMgr.Dispatch(EventType.Loading_Weight_Apply, "matrix_scene_enter") -- 不关闭loading界面
end

function OnDestroy()
    eventMgr:ClearListener()

    -- CSAPI.SetGOActive(CSAPI.GetGlobalGO("SceneGroundBox"), true)
end

function OnOpen()
    -- 防止打开两次
    if (isIn) then
        return
    end
    isIn = true

    local openData = MatrixMgr:GetMatrixViewData()
    local isDorm = openData[1] == nil and false or openData[1]
    local curData = openData[2] or nil
    MatrixMgr:SetMatrixViewData({})

    --
    sceneData = curData
    if (isDorm) then
        sceneKey = "Dorm"
    else
        sceneKey = sceneData and "MatrixBuilding" or "MatrixScene" -- MatrixBuilding 不会首次进入
    end

    UpdateAll()
end

function UpdateAll()
    local ids = {}
    local buildingDatas = MatrixMgr:GetBuildingDatas()
    for i, v in pairs(buildingDatas) do
        table.insert(ids, v:GetId())
    end
    if (ids and #ids > 0) then
        InitResetTime()
        OpenCurView()
    else
        LogError("基地没有建筑数据")
    end
end

-- 打开场景
-- 第一次：有加载界面，加载界面打开时加载当前场景的内容，在加载界面关闭后当前场景渐入）
-- 第n次：当前渐出，下一个界面加载完后，移除当前并且下一个渐入
function OpenCurView()
    if (isFirst) then
        isFirst = false
        CSAPI.OpenView(sceneKey, {sceneData, function(view)
            EventMgr.Dispatch(EventType.Loading_Weight_Update, "matrix_scene_enter") -- 关闭loading界面
        end})
    else
        MaskToBlack()
    end

    SetBgm()
end

--[[
基地 BGM_Plot_05
宿舍 Sys_Hostel
心理咨询室 Sys_ConsultationRoom
催眠游戏 Sys_OpinionGame
]]
function SetBgm()
    if (sceneKey == "Dorm") then
        CSAPI.PlayBGM(MatrixBGM.Dorm)
    else
        if (sceneKey == "MatrixBuilding" and sceneData:GetType() == BuildsType.PhyRoom) then
            CSAPI.PlayBGM(MatrixBGM.PhyRoom)
        else
            CSAPI.PlayBGM(MatrixBGM.Matrix)
        end
    end
end

-- 第一次加载完毕
function LoadingComplete()
    local go = CSAPI.GetView(sceneKey)
    if (go) then
        local curView = ComUtil.GetLuaTable(go)
        OpenComplete(curView)
    else
        LogError(string.format("view %s is nil", tostring(sceneKey)));
    end
end

function OpenComplete(curView)
    CSAPI.SetGOActive(toBlackObj, false)
    if (curView) then
        -- 显示go
        curView.LoadingComplete()
        -- 渐入
        MaskToWhite()
        -- 场景动画,相机动画
        curView.EnterAnim()
    end
    oldSceneKey = sceneKey
end

-- 渐入
function MaskToWhite()
    CSAPI.SetGOActive(toBlackObj, false)
    CSAPI.SetGOActive(toWhiteObj, true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(toWhiteObj, false)
    end, nil, 300)
end

-- 渐出 + 播放mv
function MaskToBlack()
    timer1 = Time.time
    isToBlack = 1
    CSAPI.SetGOActive(toBlackObj, true)
    CSAPI.SetGOActive(toWhiteObj, false)
    FuncUtil:Call(RemoveOldView, nil, 300) -- 移除旧界面
    FuncUtil:Call(function()
        -- 播放mv
        local neri = ResUtil:PlayVideo("loading_neri", gameObject)
        neri:AddCompleteEvent(function()
            -- 打开下一场景
            CSAPI.OpenView(sceneKey, {sceneData, OpenComplete})
        end)
    end, nil, 350)
end

-- 移除旧场景
function RemoveOldView()
    local go = oldSceneKey and CSAPI.GetView(oldSceneKey) or nil
    if (go) then
        local lua = ComUtil.GetLuaTable(go)
        lua.Exit()
    end
end

------------------------------------------------------建筑时间刷新管理
function Update()
    if (rRunTime) then
        if (TimeUtil:GetTime() > rRunTime) then
            --Log("请求更新建筑的时间点：" .. TimeUtil:GetTime())
            local ids = MatrixMgr:GetResetIds()
            if (#ids > 0) then
                BuildingProto:GetBuildUpdate(ids)
            end
            rRunTime = false
        end
    end
end

function InitResetTime()
    rRunTime = MatrixMgr:GetResetTime()
end

-- function InitResetTime()
--     rRunTime = false
--     rFastestData = {}
--     local _rFastestData = {} -- {{time,ids = {}}}
--     local buildingDatas = MatrixMgr:GetBuildingDatas()
--     local curTime = TimeUtil:GetTime()
--     for i, v in pairs(buildingDatas) do
--         -- if(v:CheckRunning()) then
--         local _baseTime = v:GetNextRefreshTime()
--         if (_baseTime and _baseTime ~= 0 and curTime <= _baseTime) then
--             if (_rFastestData[_baseTime]) then
--                 table.insert(_rFastestData[_baseTime].ids, v:GetId())
--             else
--                 _rFastestData[_baseTime] = {}
--                 _rFastestData[_baseTime].time = _baseTime
--                 _rFastestData[_baseTime].ids = {v:GetId()}
--             end
--         end
--         -- end
--     end
--     local _rFastestData2 = {}
--     for i, v in pairs(_rFastestData) do
--         table.insert(_rFastestData2, v)
--     end
--     if (#_rFastestData2 > 0) then
--         table.sort(_rFastestData2, function(a, b)
--             return a.time < b.time
--         end)
--         rFastestData = _rFastestData2[1]
--         rRunTime = true
--     end 
-- end
