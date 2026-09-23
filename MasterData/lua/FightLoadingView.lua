function OnInit()
     InitListener();

     FuncUtil:Call(LoadingAni,nil,450);
     FuncUtil:Call(DoExitActions,nil,8000);
end

function LoadingAni()
    CSAPI.SetGOActive(tweenObj,true);
end

function OnOpen()
--    if(not data)then
--        Close();
--    end
end


function InitListener()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Loading_Complete,OnLoadingComplete); 
    eventMgr:AddListener(EventType.Loading_View_Delay_Close,OnDelayClose);
end
function OnDestroy()
    eventMgr:ClearListener();
end

function OnDelayClose(time)
    delayCloseTime = time;
end
function OnLoadingComplete()
    --LogError("close delay" .. tostring(delayCloseTime));
    FuncUtil:Call(DoExitActions,nil,delayCloseTime or 200);
    --DoExitActions();
end

function DoExitActions()
    if(isExited)then
        return;
    end
    isExited = true;
    CSAPI.SetGOActive(tweenObj,false);
    CSAPI.SetGOActive(exitActions,true);
    --Close();
    FuncUtil:Call(Close,nil,500);
end

function Close()
    if(view)then
        view:Close();
    end
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
goBar=nil;
exitActions=nil;
tweenObj=nil;
loading=nil;
loadPoint1=nil;
loadPoint2=nil;
loadPoint3=nil;
view=nil;
end
----#End#----