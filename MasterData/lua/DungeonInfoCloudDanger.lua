local cfg = nil
local data = nil
local sectionData = nil
local layout =nil
local svUtil =nil
local curDatas = nil
local currLevel = 1

function Awake()
    layout = ComUtil.GetCom(hsv, "UISV")
    if layout then
        layout:Init("UIs/DungeonActivity11/DungeonCloudDangerNum", LayoutCallBack, true)
        layout:AddOnValueChangeFunc(OnValueChange)    
    end
    svUtil = SVCenterDrag.New()
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        
    end
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local item = layout:GetItemLua(index)
    item.SetIndex(index)
    item.SetClickCB(OnClickItem)
    item.Refresh(_data)
    item.SetSelect(index == currLevel)
end

function OnClickItem(index)
    layout:MoveToCenter(index)
end

function OnValueChange()
    local index = layout:GetCurIndex()
    if index + 1 ~= currLevel then
        local item = layout:GetItemLua(currLevel)
        if item then
            item.SetSelect(false)
        end
        currLevel = index + 1
        local item = layout:GetItemLua(currLevel)
        if (item) then
            item.SetSelect(true);
        end
        SetArrows()
        CSAPI.SetGOActive(tipImg, currLevel == 1)
        CSAPI.SetGOActive(txt_tip, currLevel == 1)
        if curDatas then
            cfg = curDatas[currLevel]   
            EventMgr.Dispatch(EventType.Dungeon_InfoPanel_Update, cfg)
            -- Refresh()
        end
    end
    svUtil:Update()
end

function SetArrows()
    CSAPI.SetGOActive(btnFirst,currLevel ~= 1)
    CSAPI.SetGOActive(btnLast,currLevel ~= #curDatas)
end

function ShowDangeLevel(isDanger,cfgs,currDanger)
    CSAPI.SetGOActive(node,isDanger)
    CSAPI.SetGOActive(empty,not isDanger)
    currLevel = currDanger or currLevel
    if isDanger and cfgs then
        curDatas = cfgs
        svUtil:Init(layout, #curDatas, {100, 100}, 5, 0.1, 0.6)
        layout:IEShowList(#curDatas, nil, currLevel)
        SetArrows()
        CSAPI.SetGOActive(tipImg, currLevel == 1)
        CSAPI.SetGOActive(txt_tip, currLevel == 1)
        if curDatas then
            cfg = curDatas[currLevel]
            EventMgr.Dispatch(EventType.Dungeon_InfoPanel_Update, cfg)
            -- Refresh()
        end
    end
end

function SetEmptyStr(_str)
    CSAPI.SetText(txt_empty,_str)
end

function GetCurrDanger()
    return currLevel
end

function OnClickLast()
    if (currLevel ~= #curDatas) then
        layout:MoveToCenter(#curDatas)
    end
end

function OnClickFirst()
    if (currLevel ~= 1) then
        layout:MoveToCenter(1)
    end
end

function GetCurrLevel()
    return currLevel
end