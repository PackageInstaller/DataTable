-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/motion/FamilySceneJoystickListenerEx.lua

module("logicscene.scene.component.motion.FamilySceneJoystickListenerEx", package.seeall)

local FamilySceneJoystickListenerEx = class("FamilySceneJoystickListenerEx", SceneJoystickListenerEx)

function FamilySceneJoystickListenerEx:onEnterSceneFinished(sceneId)
	self._mainPlayer = FamilySceneMainPlayer.instance:getMainPlayer()
	self._sceneId = sceneId
end

function FamilySceneJoystickListenerEx:setEnable(enable)
	self:_setJoystickListener(enable)
end

return FamilySceneJoystickListenerEx
