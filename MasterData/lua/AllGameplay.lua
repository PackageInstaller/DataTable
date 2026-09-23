function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/AllGameplay/AllGameplayItem", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    -- 物品更新
    eventMgr:AddListener(EventType.Bag_Update, function()
        layout:UpdateList()
    end)
end
function OnDestroy()
    eventMgr:ClearListener()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data)
    end
end

function Refresh()
    curDatas = Cfgs.AllGameplayCfg:GetAll()
    layout:IEShowList(#curDatas)
end

