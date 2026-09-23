local layout = nil;

function Awake()
    layout = ComUtil.GetCom(hpage, "UISlideshow")
    layout:Init("UIs/SpecialReward/RewardSummerItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        lua.SetIndex(index)
        lua.Refresh(rewards[index])
    end
end

function OnEnable()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RewardPanel_Post_Close, OnClickMask)
end

function OnDisable()
    eventMgr:ClearListener()
    CloseCallBack();
end

function CloseCallBack()
    -- 关闭回调
    if (data.closeCallBack) then
        local callBack = data.closeCallBack;
        local caller = data.caller;
        data.closeCallBack = nil;
        data.caller = nil;
        callBack(caller);
    end
end

function OnDestroy()
    CloseCallBack();
end

function OnOpen()
    -- music
    CSAPI.PlayUISound("ui_getitems")

    rewards = data[1]
    if (rewards) then
        if not openSetting or not openSetting.isNoShrink then --合并
            rewards = RewardUtil.SetShrink(rewards)
        end
        ShowList()
    end
end

function ShowList()
    layout:IEShowList(#rewards,OnLoadSuccess)
end

function OnLoadSuccess()
    for i = 1, 12 do
        local lua = layout:GetItemLua(i)
        if lua then
            lua.ShowEnterAnim(400 + (((i - 6 > 0 and i - 6 or i) - 1) * 40))
        end
    end
end

function OnClickMask()
    if isClose then
        return
    end
    isClose = true

    EventMgr.Dispatch(EventType.RewardPanel_Close);
    EventMgr.Dispatch(EventType.Money_Update);
    EventMgr.Dispatch(EventType.Dungeon_Group_Open)

    UIUtil:SetObjFade(gameObject,1,0,function()
        view:Close()
    end,200)
end

function OnClickNext()
    local index = layout:GetCurPage()
    layout:MoveToIndex(index + 1)
end

function OnClickBack()
    local index = layout:GetCurPage()
    layout:MoveToIndex(index - 1)
end

