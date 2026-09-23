
function Awake()
    CameraMgr:SetCustomCameraState(false);
end
function OnEnable()
    CameraMgr:SetCustomCameraState(false);
end

function OnRecycle()
    CameraMgr:SetCustomCameraState(true);
end
function OnDestroy()
    CameraMgr:SetCustomCameraState(true);
end
