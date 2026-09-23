local curDatas = nil

function Awake()
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/Exploration/ExplorationMissionItem",LayoutCallBack,true);

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Mission_List, OnMissionListRefresh)
end

function LayoutCallBack(index)
    local _data=curDatas[index];
    local item=layout:GetItemLua(index);
    if item then
        item.Refresh(_data,data.isMax)
    end
end

function OnMissionListRefresh(_data)
    if not _data then
        RefreshPanel()
        return
    end

    local rewards = _data[2]
    RefreshPanel()
    if (#rewards > 0) then
        UIUtil:OpenReward({rewards})
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    if data then
        RefreshPanel()
    end
    
end

function RefreshPanel()
    curDatas = MissionMgr:GetActivityDatas(data.type,data.group)
    SetItems()
end

function SetItems()
    layout:IEShowList(#curDatas)
end

function OnClickMask()
    view:Close()
end
