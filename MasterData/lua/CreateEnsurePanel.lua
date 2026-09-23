function Awake()
    local str1 = LanguageMgr:GetTips(10008)
    CSAPI.SetText(txt1, str1)
    local str2 = LanguageMgr:GetTips(10009)
    CSAPI.SetText(txt2, str2)
end

function OnInit()
    -- 事件监听
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    eventMgr:AddListener(EventType.Role_FirstCreate_End, FirstEnd)
end
function OnDestroy()
    eventMgr:ClearListener()
end

function OnViewOpened(viewKey)
    if (viewKey == "RoleInfo") then
        CSAPI.SetScale(gameObject, 0, 0, 0)
    end
end
function OnViewClosed(viewKey)
    if (viewKey == "RoleInfo") then
        CSAPI.SetScale(gameObject, 1, 1, 1)
    end
end

function OnOpen()
    local rewards = data[1]
    cb = data[2]

    -- grid
    list = GridUtil.GetGridObjectDatas(rewards)
    items = items or {}
    ItemUtil.AddItems("RoleLittleCard/CreateCacheItem", items, list, grid, nil, 1, 10)
end

function OnClickCancel()
    view:Close()
end

function OnClickOK()
    if (cb) then
        cb()
    end
    --view:Close()
    if CSAPI.IsADV() or CSAPI.IsDomestic() then BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_RESTRUCTURE_RESULT) end
end

function FirstEnd()
    view:Close()
end