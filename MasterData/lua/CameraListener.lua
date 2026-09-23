function Awake()
    --EventMgr.AddListener(EventType.Scene_Load_Complete,OnSceneLoadComplete);
    EventMgr.AddListener(EventType.Camera_Shake,OnShake);
end


--�����������
--function OnSceneLoadComplete(param)
--    if(param ~= nil) then
--       local cfgScene = Cfgs.scene:GetByID(param);
--       local cameraSetting = cfgScene.camera_setting;
--       if(cameraSetting ~= nil)then
--            for _,v in ipairs(cameraSetting)do
--                CameraMgr:ApplyCommonAction(nil,v);
--            end
--        else
--            CameraMgr:ApplyCommonAction(nil,CameraActionMgr.fight_start);
--            CameraMgr:ApplyCommonAction(nil,CameraActionMgr.fight_enter);
--        end
--    end
--end

function OnShake(param)
   CameraMgr:Shake(param);
end