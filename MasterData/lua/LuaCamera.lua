--摄像机

function Start()
    EventMgr.AddListener(EventType.SkyBox_Changed,OnSkyBoxChanged);
    EventMgr.AddListener(EventType.Scene_Mask_Changed,OnSceneMask);

    cameraScene = ComUtil.GetCom(sceneCamera,"Camera");
    cameraSceneFar = ComUtil.GetCom(sceneCameraFar,"Camera");
    cameraSceneMask = ComUtil.GetCom(sceneMaskCamera,"Camera");
    --cameraEff = ComUtil.GetCom(effectCamera,"Camera");
    cameraMain = ComUtil.GetCom(gameObject,"Camera");

    local goUICamera = CSAPI.GetGlobalGO("UICamera");
    cameraUI = ComUtil.GetCom(goUICamera,"Camera");

     _G.xluaCamera = this;

     SetEnable(false);
end

function SetEnable(state)
    cameraScene.enabled = state;
    cameraSceneFar.enabled = state;
    --cameraEff.enabled = state;
    cameraMain.enabled = state;

    --LogError("state:" .. tostring(state));
    CSAPI.SetGOActive(gameObject,state);
end

function OnSkyBoxChanged()
    CSAPI.SetSkyBox(gameObject,SkyBoxMgr:GetCurrSkyBox());
    --CSAPI.SetSkyBox(sceneCamera,SkyBoxMgr:GetCurrSkyBox());
end



function OnSceneMask(state)
    --LogError("mask state" .. tostring(state));
    currState = state;
    if(state)then
        ApplyMaskFadeIn();
    else
        ApplyMaskFadeOut();
    end
end

--function Update()
--    if(CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.A) )then     
--        --ApplyMaskFadeIn();
--        CreateCameraEffs({{res="replace_camera_RobelitDaoGuang001",ignore_help=1,delay=2400,time=80},{res="replace_camera_RobelitDaoGuang002",ignore_help=1,delay=2710,time=80},{res="replace_camera_RobelitDaoGuang004",ignore_help=1,delay=3600,time=80},{res="replace_camera_RobelitDaoGuang003",ignore_help=1,delay=3000,time=80}});
--    end
----    if(CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.S) )then   
----        ApplyMaskFadeOut();        
----    end
--end


function ApplyMaskFadeIn(actionName)
    actionName = actionName or "action_scene_camera_mask_fade_in";
    CSAPI.SetGOActive(sceneMaskCamera,true);  
    CSAPI.ApplyAction(goMask,actionName,OnFadeInComplete);
end


function ApplyMaskFadeOut(actionName)
    actionName = actionName or "action_scene_camera_mask_fade_out";
    CSAPI.SetGOActive(sceneCamera,true);  
    CSAPI.ApplyAction(goMask,actionName,OnFadeOutComplete);
end

function OnFadeInComplete()
    if(currState)then
        CSAPI.SetGOActive(sceneCamera,false);  
    end
end

function OnFadeOutComplete()
    if(not currState)then
        CSAPI.SetGOActive(sceneMaskCamera,false);  
    end
end

function SetSceneCameraFarState(state)
    CSAPI.SetGOActive(sceneCameraFar,state and true or false);
    cameraScene.clearFlags = state and 4 or 2;
end



--创建镜头效果
function CreateCameraEffs(cameraEffs)
    if(cameraEffs)then
        for i = 1,#cameraEffs do
            local cameraEff = cameraEffs[i];            
            if(cameraEff.delay and cameraEff.delay > 0)then
                FuncUtil:Call(CreateCameraEff,nil,cameraEff.delay,cameraEff);
            else
                CreateCameraEff(cameraEff);
            end
        end
    end
end
function CreateCameraEff(cameraEff)
    if(cameraEff == nil)then
        return;
    end

--    LogError("创建镜头效果：");
--    LogError(cameraEff);
    local res = cameraEff.res;
    res = string.find(res,"/") and res or ("camera_effs/" .. res);
    res = ResUtil.prefab_effect .. "/" .. res;  
    local go = CSAPI.CreateGO(res);
    if(IsNil(go))then
        return;
    end

    local lua = ComUtil.GetLuaTable(go);
    OnCameraEffCreated(lua);

    if(cameraEff.time)then        
        FuncUtil:Call(lua.Recover,nil,cameraEff.time);
    end    
end

function OnCameraEffCreated(luaEff)
    luaCameraEffs = luaCameraEffs or {};
    effIndex = effIndex and (effIndex + 1) or 1;
    luaCameraEffs[effIndex] = luaEff;

    --LogError(luaEff.gameObject.name);
end
function RemoveCameraEffs()
    EventMgr.Dispatch(EventType.Fight_Remove_Camera_Eff,nil);

    if(luaCameraEffs)then
        for _,luaEff in pairs(luaCameraEffs) do
            if(luaEff and luaEff.Recover)then
                luaEff.Recover();
            end
        end
    end
    luaCameraEffs = nil;
end