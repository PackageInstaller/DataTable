function Awake()    
    --goRT = CSAPI.GetGlobalGO("UIEffRT");
    CSAPI.SetCameraRenderTarget(gameObject,goRT);

    SetState(false);

    EventMgr.AddListener(EventType.UI_Eff_Enter,OnEnter);
    EventMgr.AddListener(EventType.UI_Eff_Exit,OnExit);

    --EventMgr.AddListener(EventType.Screen_Scale,OnScreenScale);
end

--function OnScreenScale(count)
--    CSAPI.SetRtRect(goNode,count, - count);
--end

function OnEnter(data)
   SetState(true);     

   data.goParent = data.go.transform.parent.gameObject;
   CSAPI.SetParent(data.go,goNode,true);

   CSAPI.ApplyAction(goRT,"action_ui_eff_enter");

   FuncUtil:Call(OnEnterComplete,nil,300,data);
end

function OnEnterComplete(data)
    if(IsNil(data.goParent))then
        CSAPI.RemoveGO(data.goParent);
    else
        CSAPI.SetParent(data.go,data.goParent,true);    
    end
    if(data.callBack)then
        data.callBack(data.caller);
    end

    SetState(false);    
end

function OnExit(data)
    SetState(true);     

   data.goParent = data.go.transform.parent.gameObject;
   CSAPI.SetParent(data.go,goNode,true);

   CSAPI.ApplyAction(goRT,"action_ui_eff_exit");

   FuncUtil:Call(OnExitComplete,nil,300,data);
end

function OnExitComplete(data)
    if(IsNil(data.go))then
        return;
    end

    if(IsNil(data.goParent))then
        CSAPI.RemoveGO(data.go);
    else
        CSAPI.SetParent(data.go,data.goParent,true);   
        CSAPI.SetLocalPos(data.go,-10000,0,0); 
    end
    
    if(data.callBack)then
        data.callBack(data.caller);
    end

    SetState(false);    
end

function SetState(state)
    CSAPI.SetGOActive(goRoot,state);
    CSAPI.SetGOActive(goRT,state);
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
goRoot=nil;
goNode=nil;
end
----#End#----