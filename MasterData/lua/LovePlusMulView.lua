local multiItem = nil

function Awake()
    local go = ResUtil:CreateUIGO("LovePlusPic/LovePlusMulLive2DItem", itemParent.transform)
    local lua = ComUtil.GetLuaTable(go)
    lua.Init(nil, nil, true)
    multiItem = lua
    multiItem.OnClickMask = OnClickMask
    CSAPI.SetGOActive(go,false)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClose)
end

function OnViewClose(viewKey)
    if gameObject and viewKey == "LovePlusListView" then
        view:Close()
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    if data then
        CSAPI.SetGOActive(multiItem.gameObject,true)
        CSAPI.SetGOActive(mask,true)
        multiItem.Refresh(data,LoadImgType.Main)
    end
end

function OnClickMask()
    CSAPI.SetGOActive(multiItem.gameObject,false)
    CSAPI.SetGOActive(mask,false)
end