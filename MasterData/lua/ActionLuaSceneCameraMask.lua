--Lua Action
--场景遮罩镜头效果

--代替的相机
local targetCamera;

function OnEnable()    
    EventMgr.AddListener(EventType.Fight_Remove_Camera_Eff,OnRemoveCameraEff);
    isRecovered = nil;

    --LogError(gameObject.name .. "  Created");
end


function ApplySceneMask()
    local xluaCamera = CameraMgr:GetXLuaCamera();
    if(not xluaCamera)then
        LogError("找不到LuaCamera组件");
        return;
    end

    ApplyCamera(xluaCamera.cameraSceneMask)
end


function ApplyCamera(camera)
    targetCamera = camera;
    CSAPI.SetGOActive(targetCamera.gameObject,true);
    myCamera = ComUtil.GetComInChildren(gameObject,"Camera");
   
    if(myCamera)then
        myCamera.enabled = true;        
        targetCamera.enabled = false;

        local goRT = CSAPI.GetGlobalGO("CommonRT")
        CSAPI.SetCameraRenderTarget(gameObject,goRT);       
    end
   

    CSAPI.SetParent(gameObject,targetCamera.gameObject);

    if(actionStart)then
        CSAPI.ApplyAction(goAction or gameObject,actionStart.name);
        EventMgr.Dispatch(EventType.Fight_Scene_Emission_Up);
    end
end


function OnRemoveCameraEff()
    Recover();
end

function OnComplete()
    Recover();
end

function OnDestroy()
    Recover();
end

function OnRecycle()
    Recover();
end

function Recover()    
    if(isRecovered)then
        return;
    end
    isRecovered = true;

    if(actionComplete)then
        CSAPI.ApplyAction(goAction or gameObject,actionComplete.name,DoRecover);
        EventMgr.Dispatch(EventType.Fight_Scene_Emission_Down);
    else
        DoRecover();
    end    
end

function DoRecover()
    if(targetCamera)then
        CSAPI.RemoveGO(gameObject);
        CSAPI.SetGOActive(targetCamera.gameObject,false);

        if(myCamera)then
            myCamera.enabled = false;
            targetCamera.enabled = true;
        end
        targetCamera = nil;

        EventMgr.RemoveListener(EventType.Fight_Remove_Camera_Eff,OnRemoveCameraEff);

    end
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
goAction=nil;
actionStart=nil;
end
----#End#----