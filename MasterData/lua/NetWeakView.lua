require "LoginCommFuns";
local str = "LOADING";
local text = nil;
local bgFade = nil
local iconFade = nil
local iconCanvasGroup = nil
function OnInit()
	LoginProto.isOnline=false;
	InitListener();
	-- text = ComUtil.GetCom(Loading, "Text");	
	-- text.text = str;
	-- FuncUtil:Call(DoString, nil, 600);
	bgFade = ComUtil.GetCom(bg_fade, "ActionFade")
	iconFade = ComUtil.GetCom(icon_fade, "ActionFade")
	iconCanvasGroup = ComUtil.GetCom(icon, "CanvasGroup")

	--暂停会导致连不上
	local timeScale = Time.timeScale;
    if(timeScale and timeScale < 0.01)then
        CSAPI.ClearTimeScaleCtrl();
        CSAPI.SetTimeScale(1);
    end
    if CSAPI.IsADV() or CSAPI.IsDomestic() then
        ShiryuSDK.OnRoleOffline()
    end
end

function InitListener()
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Net_Work, OnNetWork);
	eventMgr:AddListener(EventType.Net_Disconnect, OnNetDisconnect);
	eventMgr:AddListener(EventType.Net_Connect_Fail, OnNetConnectFail);	
end

function OnNetExc()
	if(isClosed) then
		return;
	end
    
    if(isOpened)then
        return;
    end
    isOpened = 1;

	CSAPI.OpenView("DialogTopest",
	{    
		content = LanguageMgr:GetByID(38011),
		okCallBack = SureRelogin,
        cancelCallBack = CancelRelogin,
	});
end

function SureRelogin()
	isOpened = nil;
	ReloginAccount();
end

function CancelRelogin()
    isOpened = nil;

    NetMgr.net:Disconnect();    
	ToLogin();
    CloseView();   
end

function OnDestroy()
    if CSAPI.IsADV() or CSAPI.IsDomestic() then
        ShiryuSDK.OnRoleOnline()
    end
	eventMgr:ClearListener();
	-- text=nil;
end

function OnNetWork(o)
	Log("net work!!!");
	CloseView();
end

function OnNetDisconnect(param)
    local currTime = CSAPI.GetTime();
    local lastReloginTime = GetReloginTime();
    if(lastReloginTime and currTime and currTime - lastReloginTime < 60)then 
        
        reloginCount = reloginCount or 0;
        if(reloginCount > 3)then
            NetMgr.net:Disconnect();
            BackToLogin();     
            CloseView();   
            return;
        else
            reloginCount = reloginCount + 1;
        end                  
    end    

	ReloginAccount();	
	FuncUtil:Call(OnNetExc, nil, 5000);
end


function OnNetConnectFail(param)
	OnNetExc();
end

function CloseView()
	CSAPI.SetGOActive(startAction, false)
--    if(iconCanvasGroup and iconFade)then
--	    iconFade.delayValue = iconCanvasGroup.alpha
--	    iconFade.from = iconCanvasGroup.alpha
--    end
	CSAPI.SetGOActive(endAction, true)
	bgFade:Play(1, 0, 400, 0, function()
        DoClose();		
	end)	
    FuncUtil:Call(DoClose, nil, 450);--确保关闭
end

function DoClose()
    if(isClosed)then
        return;
    end
    isClosed = 1;

    if(not IsNil(view))then
        view:Close();
    end
end