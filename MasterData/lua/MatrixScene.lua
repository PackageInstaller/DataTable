local recordBeginTime = 0
local Top=nil;
local curBuildID = nil -- 当前选择的建筑
--------------------------------------------------预警时间
local wTimer = 0
local wRunTime = false
local time = 0
local time2 = 3
------------------------------------------------------刷新资源时间管理
-- local rRunTime = false
-- local rFastestData = nil --{time,id} 最快刷新的建筑
function Awake()
    -- 添加问号 rui 211130 --因为不是通过openview打开的，所以要手动添加
    UIUtil:AddQuestionItem("Matrix", gameObject,AdaptiveScreen)

    recordBeginTime = CSAPI.GetRealTime()

    CSAPI.SetGOActive(warning, false)
    CSAPI.SetGOActive(tipsObjs, false)
    CSAPI.SetGOActive(mask, false)
    time = Time.time
end

-- local rTime = 0
function OnInit()
    Top=UIUtil:AddTop2("MatrixView", top, Back1, Back2, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Matrix_Building_Update, RefreshPanel) -- 建筑更新
    eventMgr:AddListener(EventType.Matrix_Assualt, RefreshPanel) -- 突袭更新

    -- 改变预警等级
    eventMgr:AddListener(EventType.Matrix_WarningLv_Update, function()
        SetWarning()
        -- SetItems()
    end)
    -- eventMgr:AddListener(EventType.Matrix_Building_Upgrade, function(_name)
    --     LanguageMgr:ShowTips(2007, _name)
    -- end)

    -- --查看建筑 {建筑id,按钮下标}
    -- eventMgr:AddListener(EventType.Matrix_Building_Click, function(_datas)
    -- 	curBuildID = _datas and _datas[1] or nil
    -- 	local index = _datas and _datas[2] or nil
    -- 	CSAPI.SetGOActive(grid1, curBuildID == nil)
    -- 	if(curBuildID) then
    -- 		CSAPI.SetGOActive(tipsObjs, false)	
    -- 		CSAPI.SetRectAngle(imgTipsL, 0, 180, 0)
    -- 		CSAPI.OpenView("MatrixBuilding", curBuildID, index)
    -- 	end
    -- end)  
    -- 突袭更新
    -- eventMgr:AddListener(EventType.Matrix_BuildingObj_Create, AddBuildUI)  --突袭更新
    -- eventMgr:AddListener(EventType.Loading_Complete, function()
    -- 	CSAPI.PlayUISound("ui_popup_open")	
    -- end)
end

function Back1()
    if (Time.time - time < time2) then
        return
    end
    CSAPI.OpenView("Dialog", {
        content = LanguageMgr:GetTips(2001),
        okCallBack = function()
            MatrixMgr:Quit()
        end
    })
end
function Back2()
    if (Time.time - time < time2) then
        return
    end
    MatrixMgr:Quit()
end

function OnDestroy()
    eventMgr:ClearListener()
    Exit1()
    RecordMgr:Save(RecordMode.View, recordBeginTime, "ui_id=" .. RecordViews.Matrix)
end

function OnOpen()
    -- UpdateAll()
    RefreshPanel()
end

function Update()
    if (wRunTime) then
        wTimer = wTimer - Time.deltaTime
        if (wTimer < 0) then
            wTimer = 0.2
            SetWarningTime2()
        end
    end
    -- if(rRunTime) then	
    -- 	if(TimeUtil:GetTime() > rFastestData.time) then
    -- 		BuildingProto:GetBuildUpdate(rFastestData.ids)
    -- 		rFastestData = nil
    -- 		rRunTime = false
    -- 	end
    -- end
end

function RefreshPanel()
    InitUI()

    InitGround()

    InitModel()
end

function InitUI()
    -- 来袭倒数  --本次屏蔽/10月
    -- SetWarningTime()
    -- 电力人力
    SetBaseInfo()
    -- 按钮
    -- SetItems()
    -- 电力状态
    SetPowerState()
    -- SetWarning()
    SetTipsObjs()

    -- 资源红点
    SetRed1()
    -- 人员红点
    SetRed2()
    -- 建筑红点 
    SetRed3()
end

function SetRed1()
    local isRed = false
    local _data = MatrixMgr:GetBuildingDataByType(BuildsType.ProductionCenter)
    if (_data) then
        local arrGifts = _data:GetMaterials()
        isRed = arrGifts and #arrGifts > 0
    end
    UIUtil:SetRedPoint(btn1, isRed, 113.5, 26.7, 0)
end

function SetRed2()
    local isRed = MatrixMgr:CheckAllRoleRed()
    UIUtil:SetRedPoint(btn2, isRed, 113.5, 26.7, 0)
end

-- 可建筑，可升级
function SetRed3()
    local isRed = MatrixMgr:CheckBuildRed()
    UIUtil:SetRedPoint(btn3, isRed, 113.5, 26.7, 0)
end

function SetPowerState()
    local runingLv = MatrixMgr:GetMatrixInfo().runTypeCfgId or 1
    local str = Cfgs.CfgBGobalPower:GetByID(runingLv).name or ""
    CSAPI.SetText(txtPowerState, str)
    CSAPI.SetGOActive(powerState, str ~= "")
    -- if (str ~= "") then
    --     local img = runingLv > 1 and "img9_01_01.png" or "img9_01_02.png"
    --     CSAPI.LoadImg(powerState, "UIs/Matrix/" .. img, true, nil, true)
    -- end

    -- red 
end

-- 地面碰撞
function InitGround()
    if (not ground) then
        CSAPI.CreateGOAsync("Scenes/Matrix/MatrixGround", 0, 0, 0, nil, function(go)
            ground = ComUtil.GetLuaTable(go)
            ground.Init(this)
            ground.Refresh()
            CSAPI.SetGOActive(go, false)
            LoadSuccess()
        end)
    else
        ground.Refresh()
    end
end

function InitModel()
    if (not matrixModelGOs) then
        matrixModelGOs = {}
        local sceneCfg = Cfgs.scene:GetByKey("MatrixScene")
        local res = sceneCfg.res
        local count = #res
        for i, v in ipairs(res) do
            CSAPI.CreateGOAsync(v, 0, 0, 0, nil, function(go)
                table.insert(matrixModelGOs, go)
                count = count - 1
                if (count <= 0) then
                    LoadSuccess()
                end
            end)
        end
    end
end

-- function SetItems()
-- 	indexs = {1, 2, 4}
-- 	items2 = items2 or {}
-- 	ItemUtil.AddItems("Matrix/MatrixDownItem1", items2, indexs, grid1, ItemClickCB2, 1, {curIndex2})
-- 	CSAPI.SetGOActive(grid1, curBuildID == nil)
-- end
-- local curIndex2 = 0
-- function ItemClickCB2(index)
-- 	if(curIndex2 ~= 0) then
-- 		items2[curIndex2].Select(false)
-- 	end
-- 	if(index ~= 0) then
-- 		items2[index].Select(true)
-- 	end
-- 	curIndex2 = index
-- end
function SetBaseInfo()
    -- 电力
    local curPower1, curPower2 = MatrixMgr:GetPower()
    curPower1 = math.abs(curPower1)
    curPower2 = math.floor(curPower2)
    CSAPI.SetText(txtPower, curPower1 .. "/" .. curPower2 .. " kW")

    local img = curPower1 > curPower2 and "img9_01_02.png" or "img9_01_01.png"
    CSAPI.LoadImg(powerState, "UIs/Matrix/" .. img, true, nil, true)
    local isRed = curPower1 > curPower2
    UIUtil:SetRedPoint(rightTop, isRed, -75, -16, 0)

    local isRed = curPower1 > curPower2
    UIUtil:SetRedPoint(node, isRed, 104.8, 91.6, 0)

    -- 人力
    local curRole1, curRole2 = MatrixMgr:GetRoleCnt()
    CSAPI.SetText(txtRole, curRole1 .. "/" .. curRole2 .. " P")
end

-- 来袭预警
function SetWarningTime()
    wRunTime = false
    isIn, baseTime1 = MatrixAssualtTool:CheckIsRun()
    if (not isIn) then
        -- 未开始
        baseTime1 = nil
        local lv = MatrixMgr:GetWarningLv()
        local cfg = Cfgs.CfgBAssault:GetByID(lv)
        if (cfg and cfg.openTimes) then
            local timeData = TimeUtil:GetTimeHMS(TimeUtil:GetTime(), "*t")
            for i, v in ipairs(cfg.openTimes) do
                for k, m in ipairs(v) do
                    if (timeData.hour < v[1]) then
                        baseTime1 = (v[1] - timeData.hour - 1) * 3600 + (59 - timeData.min) * 60 + (60 - timeData.sec)
                        break
                    elseif (timeData.hour < v[2]) then
                        baseTime1 = 0
                        break
                    end
                end
                if (baseTime1 ~= nil) then
                    break
                end
            end
            -- 第二天
            if (baseTime1 == nil) then
                local v = cfg.openTimes[1]
                baseTime1 = (24 - timeData.hour - 1) * 3600 + (59 - timeData.min) * 60 + (60 - timeData.sec)
                baseTime1 = baseTime1 + v[1] * 3600
            end
        end
    end
    curTime = TimeUtil:GetTime()
    baseTime1 = baseTime1 == nil and 0 or baseTime1
    SetWarningTime2()
end

function SetWarningTime2()
    if (baseTime1 == 0) then
        needTime = 0
    else
        needTime = baseTime1 - (TimeUtil:GetTime() - curTime)
    end
    wRunTime = needTime > 0
    if (isIn) then
        LanguageMgr:SetText(txtWarningTime2, 10001)
    else
        LanguageMgr:SetText(txtWarningTime2, 10000)
    end
    CSAPI.SetText(txtWarningTime3, TimeUtil:GetTimeStr(needTime))
end

-- 预警等级
function SetWarning()
    local warningLv = MatrixMgr:GetWarningLv()
    local cfg = Cfgs.CfgBAssault:GetByID(warningLv)
    CSAPI.SetImgColorByCode(imgWarning, cfg.colorName or "000000")
end

function SetTipsObjs()
    local b1 = MatrixMgr:ShowQP()
    local code1 = b1 and "FFC146" or "ffffff"
    CSAPI.SetImgColorByCode(imgTips1, code1, true)

    local b2 = MatrixMgr:ShowRole()
    local code2 = b2 and "FFC146" or "ffffff"
    CSAPI.SetImgColorByCode(imgTips2, code2, true)

    local b3 = MatrixMgr:ShowHP()
    local code3 = b3 and "FFC146" or "ffffff"
    CSAPI.SetImgColorByCode(imgTips3, code3, true)
    local angle = tipsObjs.activeSelf and 0 or 180
    CSAPI.SetRectAngle(imgTipsL, 0, angle, 0)
end

-- end
function OnClickTipsL()
    local b = not tipsObjs.activeSelf
    CSAPI.SetGOActive(tipsObjs, b)

    local angle = b and 0 or 180
    CSAPI.SetRectAngle(imgTipsL, 0, angle, 0)
end

-- 气泡
function OnClickTips1()
    local b = MatrixMgr:ShowQP()
    MatrixMgr:ShowQP(not b)
    TipsRefresh()
end
-- 人员
function OnClickTips2()
    local b = MatrixMgr:ShowRole()
    MatrixMgr:ShowRole(not b)
    TipsRefresh()
end
-- 血量
function OnClickTips3()
    local b = MatrixMgr:ShowHP()
    MatrixMgr:ShowHP(not b)
    TipsRefresh()
end
function TipsRefresh()
    SetTipsObjs()
    if (ground) then
        ground.Refresh()
    end
end

-- function LookBuilding(b)
-- 	--CSAPI.SetGOActive(warning, not b)   --本次屏蔽/10月
-- 	ShowBuildingUI(not b)
-- end
function ShowBuildingUI(b)
    CSAPI.SetGOActive(buildingUIParent, b)
    CSAPI.SetGOActive(btnOverLook, b)
    -- CSAPI.SetGOActive(grid1, b)
    CSAPI.SetGOActive(top, b)
    CSAPI.SetGOActive(rightTop, b)
end

-- 转换到俯视角
function OnClickOverLook()
    if (isMoveing) then
        return
    end
    isMoveing = true
    CSAPI.SetGOActive(mask, true)
    if (ground) then
        ShowBuildingUI(false)
        ground.MoveToOver(function()
            CSAPI.SetGOActive(mask, false)
            ShowBuildingUI(true)
            CSAPI.PlayUISound("ui_infolineeject_out_2")
            isMoveing = false
        end)
        ground.ResetUIPos()
    end
end

-- 收取资源
function OnClick1()
    local _data = MatrixMgr:GetBuildingDataByType(BuildsType.ProductionCenter)
    if (_data) then
        CSAPI.OpenView("MatrixResPanel", _data)
    else
        LanguageMgr:ShowTips(2005)
    end
end

-- 驻员状况
function OnClick2()
    CSAPI.OpenView("MatrixAllBuilding")
end

-- 基地建造
function OnClick3()
    CSAPI.OpenView("MatrixCreate")
end

-- 电力提示
function OnClickPower()
    local buildData = MatrixMgr:GetBuildingDataByType(BuildsType.PowerHouse)
    if (buildData) then
        -- 不是在建造中
        local buildingState = buildData:GetState()
        if (buildingState == nil or buildingState ~= MatrixBuildingType.Create) then
            EventMgr.Dispatch(EventType.Matrix_Indoor_Change, {"MatrixBuilding", buildData})
        end
    else
        CSAPI.OpenView("MatrixCreateInfo", 1002)
    end
end

------------------------------------------------------------------------------
-- 当前场景的资源加载完毕
function LoadSuccess()
    if (loadCount == nil) then
        loadCount = 2
    end
    loadCount = loadCount - 1
    if (loadCount <= 0 and data[2]) then
        data[2](this)
    end
end

-- 开始展示界面
function LoadingComplete()
    if (ground) then
        CSAPI.SetGOActive(ground and ground.gameObject, true)
    end
    CSAPI.SetGOActive(gameObject, true)
    CSAPI.PlayUISound("ui_popup_open")

    -- 建造升级提示 
    FuncUtil:Call(function()
        MatrixMgr:PlayTips()
    end, nil, 500)
end

-- 进场动画 0.5s
function EnterAnim()
    ground.EnterAnim()
end

function Exit()
    Exit1()

    view:Close()
end

function Exit1()
    if (ground) then
        ground.Exit()
        CSAPI.RemoveGO(ground.gameObject)
    end
    ground = nil

    if (matrixModelGOs) then
        for i, v in pairs(matrixModelGOs) do
            CSAPI.RemoveGO(v)
        end
    end
    matrixModelGOs = nil

    view:Close()
end

------------------------------------------------------------------------------
---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if  Top.OnClickBack then
        Top.OnClickBack();
    end
end
