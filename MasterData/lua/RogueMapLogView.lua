local curDatas = nil
local layout = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/RogueMap/RogueMapLogItem", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RogueMap_Log_Refresh,OnPanelRefresh)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if lua then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data)
    end
end

function OnPanelRefresh(proto)
    curDatas = RogueMapMgr:GetLogArr()
    RefreshPanel()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    -- if RogueMapMgr:CheckLogRed() then
        FightProto:RogueMapSupportLog(0)
    -- else
    --     curDatas = RogueMapMgr:GetLogArr()
    --     RefreshPanel()
    -- end
end

function RefreshPanel()
    SetItems()
end

function SetItems()
    layout:IEShowList(#curDatas,OnItemLoadCB)
end

function OnItemLoadCB()
    RogueMapMgr:SaveLogNews()
end

function OnClickClose()
    view:Close()
end