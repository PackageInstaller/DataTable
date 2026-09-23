function Awake()    
    InitRT();    
    FixScale();    

    --开启战斗场景镜头
    local xluaCamera = CameraMgr:GetXLuaCamera();
    if(xluaCamera)then
        xluaCamera.SetEnable(true);
    end      
end

function InitRT()
    --LogError("InitRT");
    local goRT = CSAPI.GetGlobalGO("CommonRT")
    CSAPI.SetRenderTexture(flipImg,goRT);
    CSAPI.SetCameraRenderTarget(CameraMgr:GetCameraGO(),goRT);    
end

function OnInit()
    InitListener();
end

function InitListener()
    eventMgr = ViewEvent.New();
      
    eventMgr:AddListener(EventType.Fight_Camera_Eff,OnCameraEff);  
    eventMgr:AddListener(EventType.Fight_Fade, OnCreateFade)
    eventMgr:AddListener(EventType.Fight_View_Mask, SetMaskState)
    eventMgr:AddListener(EventType.Game_Quality_Changed,OnGameQualityChanged)
    
    eventMgr:AddListener(EventType.Screen_Scale,OnScreenScale)    
end
function OnDestroy()
    eventMgr:ClearListener();
end


function OnGameQualityChanged(param)    
    FuncUtil:Call(InitRT,nil,50); 
    InitRT();    
end

function OnCameraEff(actionName)
    CSAPI.ApplyAction(flipImg,actionName);
end

function OnCreateFade(param)
    CSAPI.ApplyAction(flipImg,"action_fade_fight" .. (param or ""));
    CSAPI.ApplyAction(flipImg,"action_fight_img_fade_in" .. (param or ""));    
end

function SetMaskState(state)
    CSAPI.SetGOActive(mask,state);
end


function OnScreenScale(param)
    FixScale();
end    
function FixScale()
    local screenVal = SettingMgr:GetScreenCount() or 0;
    CSAPI.SetRtRect(flipImg,-screenVal,screenVal,0,0);
end