--Lua Action
--相机代替

--代替的相机
local targetCamera;

function OnEnable()    
    EventMgr.AddListener(EventType.Fight_Remove_Camera_Eff,OnRemoveCameraEff);
    isRecovered = nil;

    --LogError(gameObject.name .. "  Created");
end


--替换场景远景相机
function ApplySceneFar()
    local xluaCamera = CameraMgr:GetXLuaCamera();
    if(not xluaCamera)then
        LogError("找不到LuaCamera组件");
        return;
    end
    
    ApplyCamera(xluaCamera.cameraSceneFar)
    CSAPI.SetSkyBox(gameObject,SkyBoxMgr:GetCurrSkyBox());
end

--替换场景近景相机
function ApplyScene()
    local xluaCamera =CameraMgr:GetXLuaCamera();
    if(not xluaCamera)then
        LogError("找不到LuaCamera组件");
        return;
    end
    
    ApplyCamera(xluaCamera.cameraScene)
end

--替换场景遮罩相机
--function ApplySceneMask()
--    local xluaCamera =CameraMgr:GetXLuaCamera();
--    if(not xluaCamera)then
--        LogError("找不到LuaCamera组件");
--        return;
--    end

--    ApplyCamera(xluaCamera.cameraSceneMask)
--end

--替换特效相机
function ApplyEff()  
    local xluaCamera = CameraMgr:GetXLuaCamera();
    if(not xluaCamera)then
        LogError("找不到LuaCamera组件");
        return;
    end
    
    ApplyCamera(xluaCamera.cameraMain)
end

--替换场景远景相机
function ApplyMain()
    local xluaCamera = CameraMgr:GetXLuaCamera();
    if(not xluaCamera)then
        LogError("找不到LuaCamera组件");
        return;
    end
    
    ApplyCamera(xluaCamera.cameraMain)
end

function ApplyUI()
    local xluaCamera = CameraMgr:GetXLuaCamera();
    if(not xluaCamera)then
        LogError("找不到LuaCamera组件");
        return;
    end
    
    ApplyCamera(xluaCamera.cameraUI);
    
end

function ApplyUITop()
    local go = CSAPI.GetGlobalGO("UI_Layer_Top");
    CSAPI.SetParent(gameObject,go,true);
end

function ApplyCamera(camera)
    targetCamera = camera;

    myCamera = ComUtil.GetComInChildren(gameObject,"Camera");
   
    if(myCamera)then
        myCamera.enabled = true;        
        targetCamera.enabled = false;
    end

    local goRT = CSAPI.GetGlobalGO("CommonRT")
    CSAPI.SetCameraRenderTarget(gameObject,goRT);          
    CSAPI.SetParent(gameObject,targetCamera.gameObject);
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

    if(myCamera and targetCamera)then
        myCamera.enabled = false;
        targetCamera.enabled = true;
        targetCamera = nil;
    end

    EventMgr.RemoveListener(EventType.Fight_Remove_Camera_Eff,OnRemoveCameraEff);       
    CSAPI.RemoveGO(gameObject);
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  

end
----#End#----