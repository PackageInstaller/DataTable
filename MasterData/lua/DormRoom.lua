local isIn = false
-- 宿舍分区界面(基地界面的子界面)
-- function Awake()
-- 	layout = ComUtil.GetCom(vsv, "UIInfinite")
-- 	layout:Init("UIs/Dorm/DormRoomItem1", LayoutCallBack, true)
-- end
-- function LayoutCallBack(index)
-- 	local lua = layout:GetItemLua(index)
-- 	if(lua) then
-- 		local _data = curDatas[index]
-- 		lua.SetIndex(index)
-- 		lua.Refresh(_data, ItemClickCB)
-- 	end
-- end
function OnInit()
    -- UIUtil:AddTop2("DormRoom", gameObject, function()
    --     view:Close()
    -- end, nil, {})

    -- eventMgr = ViewEvent.New()
    -- --自己房间解锁
    -- eventMgr:AddListener(EventType.Dorm_Update, function()
    -- 	InitData()
    -- 	layout:UpdateList()
    -- end)
end

-- function OnDestroy()
-- 	eventMgr:ClearListener()
-- end

-- data = fid
function OnOpen()
    if(isIn) then 
        return
    end 
    isIn = true
    if (data) then
        -- 好友数据 --打开界面时请求
        DormProto:GetOpenDorm(data, function()
            InitData()
            -- layout:IEShowList(#curDatas)
            RefreshPanel()

            OnClickRoom1()
        end)
    else
        -- 自己的数据
        InitData()
        -- layout:IEShowList(#curDatas)
        RefreshPanel()
        
        -- 不能立即触发界面跳转，这个界面刚打开就立即关闭会有问题,用延迟错开
        FuncUtil:Call(OnClickRoom1, nil, 100)
    end
end

function RefreshPanel()
    curID = nil
    if(openSetting) then 
        curID = openSetting
    else 
        curID = curDatas[1].infos[1].id
    end 
    -- 最大人数
    local cfg = Cfgs.CfgDormRoom:GetByID(1)
    local maxLv = cfg.maxRole or 5
    -- 宿舍
    for k, v in ipairs(curDatas) do
        CSAPI.SetText(txtRoom, v.sName)
        for n, m in ipairs(v.infos) do
            CSAPI.SetText(txtRole, string.format("<color=#ffc146>%s</color><color=#929296>/%s</color>", m.roleNum, maxLv))
            --curID = m.id
        end
    end

    -- 心理辅导室
    -- 屏蔽
    CSAPI.SetGOActive(btnRoom2, false)
    CSAPI.SetGOActive(btnRoom1, false)
    --CSAPI.SetGOActive(anims, true)
end

-- 封装数据
function InitData()
    local cfgs = Cfgs.CfgDorm:GetAll()
    local openDatas = DormMgr:GetDormDatas(data)
    local floors = {}
    for i, v in ipairs(cfgs) do
        local floor = {}
        floor.sName = v.sName -- 楼层名称
        floor.infos = {}
        for k, m in ipairs(v.infos) do
            local id = GCalHelp:GetDormId(v.id, m.index)
            local openData = openDatas[id]
            local lv = 1
            local isRed = false
            local isOpen = false
            local roleNum = 0
            if (openData) then
                isOpen = true
                lv = openData:GetLv()
                isRed = openData:GetRed()
                roleNum = openData:GetNum()
            end
            local info = {}
            info.id = id -- 房间id
            info.lv = lv -- 房间等级
            info.isRed = isRed -- 房间是否有红点
            info.isOpen = isOpen -- 是否已开放
            info.roleNum = roleNum -- 房间人数
            info.cfg = m -- 表数据
            table.insert(floor.infos, info)
        end
        table.insert(floors, floor)
    end
    curDatas = floors
end

function ItemClickCB(id)

    CSAPI.SetGOActive(mask, true)

    local isChange = DormMgr:SetCurOpenData({id, data}) -- 设置将打开的新房间
    -- 进入基地、进入宿舍/切换宿舍
    local scene = SceneMgr:GetCurrScene()
    local isOpen = CSAPI.IsViewOpen("Dorm")
    if (scene.key == "Matrix") then
        -- 从基地进宿舍，切换房间
        if (isChange == nil or isChange) then
            local roomData = DormMgr:GetCurRoomData()
            if (roomData:GetIsInit()) then
                ToDorm(isOpen)
            else
                DormProto:GetDorm(data, id, function()
                    ToDorm(isOpen)
                end)
            end
        else
            -- LogError("选择了正在打开的房间")
            view:Close()
        end
    else
        -- 加载宿舍
        local roomData = DormMgr:GetCurRoomData()
        if (roomData and roomData:GetIsInit()) then
            LoadToDorm()
        else
            -- 房间数据未获取
            DormProto:GetDorm(data, id, function()
                LoadToDorm()
            end)
        end
    end
    -- view:Close()
end

function ToDorm(isOpen)
    if (isOpen) then
        EventMgr.Dispatch(EventType.Dorm_Change) -- 换房间
    else
        EventMgr.Dispatch(EventType.Matrix_Indoor_Change, {"Dorm"}) -- 进入房间
    end
    view:Close()
end

function LoadToDorm()
    MatrixMgr:SetMatrixViewData({true})
    DormMgr:SetOpenSceen("MajorCity")
    SceneLoader:Load("Matrix")
    view:Close()
end

function OnClickRoom1()
    if (curID) then
        ItemClickCB(curID)
    end
end

-- 心理辅导室
function OnClickRoom2()
    CSAPI.SetGOActive(mask, true)
    local _data = MatrixMgr:GetBuildingDataByType(BuildsType.PhyRoom)
    if (_data) then
        local scene = SceneMgr:GetCurrScene()
        local isOpen = CSAPI.IsViewOpen("Dorm")
        if (scene.key == "Matrix") then
            EventMgr.Dispatch(EventType.Matrix_Indoor_Change, {"MatrixBuilding", _data})
            view:Close()
        else
            MatrixMgr:SetMatrixViewData({false, _data})
            DormMgr:SetOpenSceen("MajorCity")
            SceneLoader:Load("Matrix")
        end
    else
        LogError("无建筑数据")
        view:Close()
    end
end
