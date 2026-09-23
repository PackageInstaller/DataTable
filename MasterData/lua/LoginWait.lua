local delayTime=0;
local eventMgr=nil;
function Awake()
    CSAPI.SetGOActive(exitObj,false);
    CSAPI.SetGOActive(waitObj,true);
    eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Login_Wait_Over,Close)
    eventMgr:AddListener(EventType.Login_wait_Update,Refresh)
end

function OnDisable()
    eventMgr:ClearListener();
end

function OnOpen()
    if data then
        CSAPI.SetText(txt_sort,tostring(data.waitCnt));
        delayTime=data.waitingTime;
        CSAPI.SetText(txt_waitTimeTips,LanguageMgr:GetTips(9008));
    end
end

function Refresh(proto)
    if proto then
        delayTime=0;
        delayTime=proto.waitingTime;
        CSAPI.SetText(txt_sort,tostring(proto.waitCnt));
    end
end
local isDefault=true;
function Update()
    if delayTime>0 then
        delayTime=delayTime-Time.deltaTime;
        if isDefault then
            CSAPI.SetGOActive(txt_waitTime,delayTime>0);
            CSAPI.SetGOActive(txt_waitTimeTips,delayTime<=0);
            isDefault=false;
        end
        if delayTime>0 then
            CSAPI.SetText(txt_waitTime,TimeUtil:GetTimeStr(delayTime));
        else
            CSAPI.SetGOActive(txt_waitTime,delayTime>0);
            CSAPI.SetGOActive(txt_waitTimeTips,delayTime<=0);
        end
    end
end


--点击退出界面
function OnClickOK()
    NetMgr.net:Disconnect()
    Close();
end

function Close()
    EventMgr.Dispatch(EventType.Login_Hide_Mask);
    view:Close();
end

--点击退出排队
function OnClickExit()
    CSAPI.SetGOActive(waitObj,false);
    CSAPI.SetGOActive(exitObj,true);
end