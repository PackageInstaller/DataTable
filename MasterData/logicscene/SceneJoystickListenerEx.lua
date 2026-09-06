-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/motion/SceneJoystickListenerEx.lua

module("logicscene.scene.component.motion.SceneJoystickListenerEx", package.seeall)

local SceneJoystickListenerEx = class("SceneJoystickListenerEx", SceneComponentBase)

function SceneJoystickListenerEx:ctor(scene)
	SceneJoystickListenerEx.super.ctor(self, scene)
end

function SceneJoystickListenerEx:onInit()
	return
end

function SceneJoystickListenerEx:setEnable(enable)
	self:_setJoystickListener(enable)
end

function SceneJoystickListenerEx:onEnterSceneFinished(sceneId)
	self:_setJoystickListener(true)

	self._mainPlayer = SceneMainPlayer.instance:getMainPlayer()
	self._sceneId = sceneId

	if MountModel.instance:isTeamMountMember() then
		local view = VirtualJoystickModel.instance:getJoystickView()

		if view then
			view:setEnable(false)
		end
	end
end

function SceneJoystickListenerEx:_onKeycodeChange(keycode, isOn)
	local inst = KeycodeListener.instance

	if inst:isOn(UnityEngine.KeyCode.A) or inst:isOn(UnityEngine.KeyCode.D) or inst:isOn(UnityEngine.KeyCode.W) or inst:isOn(UnityEngine.KeyCode.S) then
		if not self._isAnyKeyDown then
			self:_onKeycodeDown()
		end
	elseif self._isAnyKeyDown then
		self:_onKeycodeUp()
	end
end

function SceneJoystickListenerEx:onExitScene()
	self:_setJoystickListener(false)
end

function SceneJoystickListenerEx:_setJoystickListener(enable)
	local view = VirtualJoystickModel.instance:getJoystickView()

	if view then
		view:setEnable(enable)
	end

	if enable then
		GlobalDispatcher:addListener(GlobalNotify.JoystickDown, self._onJoystickDown, self)
		GlobalDispatcher:addListener(GlobalNotify.JoystickUp, self._onJoystickUp, self)

		if KeycodeListener.instance.enabled then
			KeycodeListener.instance:addListener(UnityEngine.KeyCode.A, self._onKeycodeChange, self)
			KeycodeListener.instance:addListener(UnityEngine.KeyCode.D, self._onKeycodeChange, self)
			KeycodeListener.instance:addListener(UnityEngine.KeyCode.W, self._onKeycodeChange, self)
			KeycodeListener.instance:addListener(UnityEngine.KeyCode.S, self._onKeycodeChange, self)
		end
	else
		self._isJoystickDown = false
		self._isAnyKeyDown = false

		removetimer(self._checkJoystickMove, self)
		GlobalDispatcher:removeListener(GlobalNotify.JoystickDown, self._onJoystickDown, self)
		GlobalDispatcher:removeListener(GlobalNotify.JoystickUp, self._onJoystickUp, self)

		if KeycodeListener.instance.enabled then
			KeycodeListener.instance:removeListener(UnityEngine.KeyCode.A, self._onKeycodeChange, self)
			KeycodeListener.instance:removeListener(UnityEngine.KeyCode.D, self._onKeycodeChange, self)
			KeycodeListener.instance:removeListener(UnityEngine.KeyCode.W, self._onKeycodeChange, self)
			KeycodeListener.instance:removeListener(UnityEngine.KeyCode.S, self._onKeycodeChange, self)
		end
	end
end

function SceneJoystickListenerEx:_onKeycodeDown()
	self._isAnyKeyDown = true

	if not self._isJoystickDown then
		self._mainPlayer.spineMover:joystickOn(true)
		self._mainPlayer.syncPos:joystickOn(true)
		self._mainPlayer:stopAllActions()
		settimer(0, self._checkJoystickMove, self, true)
	end
end

function SceneJoystickListenerEx:_onKeycodeUp()
	self._isAnyKeyDown = false

	if not self._isJoystickDown then
		self._mainPlayer.spineMover:joystickOn(false)
		self._mainPlayer.syncPos:joystickOn(false)
		removetimer(self._checkJoystickMove, self)
		self._mainPlayer.mover:setJoystickListener()
	end
end

function SceneJoystickListenerEx:_onJoystickDown()
	self._isJoystickDown = true

	if not self._isAnyKeyDown then
		settimer(0, self._checkJoystickMove, self, true)
		self._mainPlayer:stopAllActions()
		self._mainPlayer.spineMover:joystickOn(true)
		self._mainPlayer.syncPos:joystickOn(true)
	end
end

function SceneJoystickListenerEx:_onJoystickUp()
	self._isJoystickDown = false

	if not self._isAnyKeyDown then
		removetimer(self._checkJoystickMove, self)
		self._mainPlayer.spineMover:joystickOn(false)
		self._mainPlayer.syncPos:joystickOn(false)
		self._mainPlayer.mover:setJoystickListener()
	end
end

function SceneJoystickListenerEx:_getCurJoystickInfo()
	local h = 0
	local v = 0
	local magnitude = 0

	if self._isJoystickDown then
		h, v, magnitude = VirtualJoystickFacade.instance:getVector()
	elseif self._isAnyKeyDown then
		local inst = KeycodeListener.instance

		if inst:isOn(UnityEngine.KeyCode.A) then
			h = h - 1
		end

		if inst:isOn(UnityEngine.KeyCode.D) then
			h = h + 1
		end

		if inst:isOn(UnityEngine.KeyCode.W) then
			v = v + 1
		end

		if inst:isOn(UnityEngine.KeyCode.S) then
			v = v - 1
		end

		magnitude = h == 0 and v == 0 and 0 or 1
	end

	return h, v, magnitude
end

function SceneJoystickListenerEx:_checkJoystickMove()
	local h, v, magnitude = self:_getCurJoystickInfo()
	local mover = self._mainPlayer.mover

	if magnitude == 0 then
		mover:setJoystickListener()

		return
	end

	if not self._mainPlayer:handleQueryFindWay() then
		return
	end

	mover:setJoystickListener(h, v)
end

return SceneJoystickListenerEx
