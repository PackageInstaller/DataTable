local sectionData = nil
local curDatas = nil
local layout = nil
local isSelect = false
local cb = nil
local doubleCB = nil
local items = nil
local isMoveLeft = false -- 已经移到左边
local itemInfo = nil
local weekIds = {1023, 1017, 1018, 1019, 1020, 1021, 1022}

-- 多倍
-- local multiNum = 0
-- local isDoubleOpen = false
-- local isMultiUpdate = false
-- local multiUpdateTime = 0

-- 设置回调
function SetClickCB(_cb)
    cb = _cb
end

-- function SetDoubleCB(_cb)
--     doubleCB = _cb
-- end

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Section/SectionDailyItemR", LayoutCallBack, true)


    -- ShowDesc(false)
    SetSelect(false)
    CSAPI.SetGOActive(rightAction,false)

    SetTextDay()
end

function OnEnable()
    eventMgr = ViewEvent:New()
    -- eventMgr:AddListener(EventType.Dungeon_DailyData_Update,OnDailyDataUpdate)
end

function OnDailyDataUpdate()
    SetDouble()
end

function OnDisable()
    eventMgr:ClearListener()
end

-- function Update()
--     if isMultiUpdate or not sectionData then
--         return
--     end
--     if multiUpdateTime and TimeUtil:GetTime() >= multiUpdateTime then
--         isMultiUpdate = true
--         PlayerProto:SectionMultiInfo()
--     end
-- end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data)
        lua.SetClickCB(cb)
    end
end

-- 选中了物体
function SetSelect(_isSelect)
    isSelect = _isSelect
    CSAPI.SetGOActive(selectObj, isSelect)
end

function IsSelect()
    return isSelect
end

-- 传入sectionData
function Refresh(_data)
    sectionData = _data
    if sectionData then        
        -- SetDouble()
        SetGrid()
        SetDatas()
    end
end

-- 设置周数
function SetTextDay()
    local weekIdx = TimeUtil:GetWeekDay(TimeUtil:GetTime())
    LanguageMgr:SetText(txt_daily2, weekIds[weekIdx])
end

--------------------------------------------双倍
--[[
-- 设置双倍
function SetDouble()
    multiUpdateTime = DungeonMgr:GetMultiUpdateTime()
    if multiUpdateTime and TimeUtil:GetTime() < multiUpdateTime then
        isMultiUpdate = false
    end
    -- double		
    local hasMulti = DungeonUtil.HasMultiDesc(sectionData:GetID());
    local dStr = ""
    if hasMulti then
        dStr = DungeonUtil.GetMultiDesc(sectionData:GetID())
    end
    CSAPI.SetText(txtDouble, dStr);

    multiNum = DungeonUtil.GetMultiNum(sectionData:GetID())
    CSAPI.SetGOActive(btnMask, multiNum <= 0)
    if (multiNum > 0) then
        local doubleState = LoadDoubleState(sectionData:GetID())
        if (doubleState) then
            isDoubleOpen = doubleState.type == 1
        end
    else
        isDoubleOpen = false
    end
    SetDoubleState()
end

-- 设置双倍状态
function SetDoubleState()   
    CSAPI.SetGOActive(close,not isDoubleOpen)
    CSAPI.SetGOActive(open,isDoubleOpen)
    DungeonMgr:SetMultiReward(isDoubleOpen)
    SaveDoubleState(sectionData:GetID(), isDoubleOpen and 1 or 0)
end

-- 保存副本双倍状态
function SaveDoubleState(_id, _type)
    if (_id > 0) then
        local _data = LoadDoubleState(_id) or {}
        _data.id = _id
        _data.type = _type
        FileUtil.SaveToFile("doubleState_" .. _id .. ".txt", _data)
    end
end

-- 读取副本双倍状态
function LoadDoubleState(_id)
    return FileUtil.LoadByPath("doubleState_" .. _id .. ".txt")
end

function ShowDouble(b)
    isDoubleOpen = b
    SetDoubleState()
end

function IsDouble()
    return isDoubleOpen
end

function GetMultiNum()
    return multiNum
end

function OnClickDouble()
    isDoubleOpen = not isDoubleOpen
    if multiNum < 1 then
        LanguageMgr:ShowTips(8016)
        isDoubleOpen = false
    end
    SetDoubleState()
    -- LanguageMgr:ShowTips(24005)
end

function ShowDesc(b)
    CSAPI.SetGOActive(descObj,b)
end

function OnClickDesc()
    ShowDesc(true)
    if doubleCB then
        doubleCB(true)
    end
end--]]

-----------------------------------------------
-- 设置掉落信息
function SetGrid()
    local rewards = sectionData:GetFallRewards()
    local datas = GridUtil.GetGridObjectDatas2(rewards)
    items = items or {}
    items = ItemUtil.AddItems("Grid/GridItem", items, datas, gridNode, GridClickFunc.OpenInfoSmiple, 1)
end

-- 设置关卡
function SetDatas()
    local dungeonDailyCfgs = sectionData:GetDungeonCfgs()
    curDatas = {}
    if dungeonDailyCfgs then
        for _, cfg in pairs(dungeonDailyCfgs) do
            table.insert(curDatas, cfg)
        end
    end
    table.sort(curDatas, function(a, b)
        return a.id < b.id
    end)
    layout:IEShowList(#curDatas)
end

--无id传入时，默认最新关卡
function ClickItemByID(id)
    if curDatas then
        local lua = nil
        for k, v in ipairs(curDatas) do 
            local isOpen = DungeonMgr:IsDungeonOpen(v.id)
            if isOpen then
                if k > 6 then
                    layout:MoveToIndex(k - 5)
                end
                if v.id == id then
                    lua = layout:GetItemLua(k)
                elseif id == nil then
                    lua = layout:GetItemLua(k)
                end
            end
        end
        if lua then
            lua.OnClick()
        end
    end
end

--物品被隐藏可能出错
function GetItem(_index)
    return layout:GetItemLua(_index)
end

-----------------------------------------------动效

function PlayAnim()
    CSAPI.SetGOActive(rightAction,false)
    CSAPI.SetGOActive(rightAction,true)
end
