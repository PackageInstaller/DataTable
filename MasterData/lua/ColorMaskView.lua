
function OnInit()
	InitListener();
    FuncUtil:Call(Close,nil,3000);--自动关闭
end

function InitListener()
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Common_Color_Mask_Close, ApplyFadeOut);
end
function OnDestroy()
	eventMgr:ClearListener();
	EventMgr.Dispatch(EventType.Common_Color_Mask_Close);	
end

function ApplyFadeOut()
    CSAPI.SetGOActive(outAction,true);
    FuncUtil:Call(Close,nil,600);
end

function Close()	
	if(view and view.Close) then		
		view:Close();
		view = nil;		
	end
end