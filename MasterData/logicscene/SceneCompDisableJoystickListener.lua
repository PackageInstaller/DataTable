-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/motion/SceneCompDisableJoystickListener.lua

module("logicscene.scene.component.motion.SceneCompDisableJoystickListener", package.seeall)

local SceneCompDisableJoystickListener = class("SceneCompDisableJoystickListener", SceneJoystickListenerEx)

function SceneCompDisableJoystickListener:setEnable(enable)
	self:_setJoystickListener(false)
end

function SceneCompDisableJoystickListener:_onKeycodeChange(keycode, isOn)
	return
end

function SceneCompDisableJoystickListener:onExitScene()
	self:_setJoystickListener(false)
end

function SceneCompDisableJoystickListener:_setJoystickListener(enable)
	SceneCompDisableJoystickListener.super._setJoystickListener(self, false)
end

return SceneCompDisableJoystickListener
