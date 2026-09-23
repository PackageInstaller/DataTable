local isClose = false
local isStarClose = false
local bgFade = nil

function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Wait_Panel_Close, OnPanelClose);
    eventMgr:AddListener(EventType.View_Lua_Opened,OnViewOpened)

    bgFade = ComUtil.GetCom(bg_fade, "ActionFade")
end

function OnViewOpened(viewKey)
    if viewKey == "LoadDialog" then
        DoClose()
    end
end

function OnOpen()
    if CSAPI.IsViewOpen("LoadDialog") then
        DoClose()
    end
end

function OnPanelClose()
    isStarClose = true

    CSAPI.SetGOActive(startAction, false)
    CSAPI.SetGOActive(endAction, true)
	bgFade:Play(1, 0, 400, 0, function()
        DoClose()
	end)	
    FuncUtil:Call(DoClose, nil, 450);--确保关闭
end

function DoClose()
    if(isClosed)then
        return;
    end
    isClosed = true

    if(not IsNil(view))then
        view:Close();
    end	
end

function OnDestroy()
    eventMgr:ClearListener()
end