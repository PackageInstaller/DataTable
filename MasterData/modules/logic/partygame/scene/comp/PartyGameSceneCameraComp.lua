-- chunkname: @modules/logic/partygame/scene/comp/PartyGameSceneCameraComp.lua

module("modules.logic.partygame.scene.comp.PartyGameSceneCameraComp", package.seeall)

local PartyGameSceneCameraComp = class("PartyGameSceneCameraComp", CommonSceneCameraComp)

function PartyGameSceneCameraComp:_initCurSceneCameraTrace()
	local curGame = PartyGameController.instance:getCurPartyGame()

	self._cameraCO = lua_camera.configDict[curGame:getCameraConfigId()]

	self:resetParam()
	self:setFocus(curGame:getCameraFocus())
	self:setClippingPlanes(self._cameraCO.far, (self._cameraCO.near or nil) and (self._cameraCO.near or 0))

	local fov = curGame:getGameFov()

	if fov then
		self:setFov(fov)
	end

	self:applyDirectly()
end

function PartyGameSceneCameraComp:onScenePrepared(...)
	PartyGameSceneCameraComp.super.onScenePrepared(self, ...)
end

function PartyGameSceneCameraComp:_onScreenResize()
	local focusTrs = CameraMgr.instance:getFocusTrs()
	local x, y, z = transformhelper.getPos(focusTrs)

	self._cameraTrace:SetTargetFocusPos(x, y, z)

	local fovRatio = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)
	local cameraConfig = self._cameraCO
	local fov = cameraConfig.fov * fovRatio
	local minFov, maxFov = self:_getMinMaxFov()

	minFov = minFov < self._cameraCO.fov and self._cameraCO.fov or minFov
	fov = Mathf.Clamp(fov, minFov, maxFov)

	local mainCamera = CameraMgr.instance:getMainCamera()

	mainCamera.fieldOfView = fov
end

function PartyGameSceneCameraComp:setFocus(x, y, z)
	if not self._cameraTrace then
		return
	end

	local focusTrs = CameraMgr.instance:getFocusTrs()

	transformhelper.setPos(focusTrs, x, y, z)
	self._cameraTrace:SetTargetFocusPos(x, y, z)
	self:applyDirectly()
end

function PartyGameSceneCameraComp:setClippingPlanes(far, near)
	local defaultFar = 150
	local defaultNear = 2
	local mainCamera = CameraMgr.instance:getMainCamera()

	self._oriFarClip = mainCamera.farClipPlane
	self._oriNearClip = mainCamera.nearClipPlane
	mainCamera.nearClipPlane = near and near == 0 and defaultNear or near
	mainCamera.farClipPlane = far and far == 0 and defaultFar or far
end

function PartyGameSceneCameraComp:set(x, y, z)
	if not self._cameraTrace then
		return
	end

	local focusTrs = CameraMgr.instance:getFocusTrs()

	transformhelper.setPos(focusTrs, x, y, z)
	self._cameraTrace:SetTargetFocusPos(x, y, z)
	self:applyDirectly()
end

function PartyGameSceneCameraComp:_lateUpdate()
	if not self._focusTrans then
		return
	end

	local x, y, z = transformhelper.getPos(self._focusTrans)

	if self._focusLimit then
		x = Mathf.Clamp(x, self._focusLimit[1][1], self._focusLimit[2][1])
		y = Mathf.Clamp(x, self._focusLimit[1][2], self._focusLimit[2][2])
		z = Mathf.Clamp(z, self._focusLimit[1][3], self._focusLimit[2][3])
	end

	self:setFocus(x, y, z)
end

function PartyGameSceneCameraComp:_calcFovInternal(cameraConfig)
	return cameraConfig.fov
end

function PartyGameSceneCameraComp:_getMinMaxFov()
	return 20, 120
end

function PartyGameSceneCameraComp:onSceneStart(sceneId, levelId)
	PartyGameSceneCameraComp.super.onSceneStart(self, sceneId, levelId)

	self._initFinish = false

	PartyGameController.instance:registerCallback(PartyGameEvent.LogicCalFinish, self._initFocusTrans, self)
end

function PartyGameSceneCameraComp:_initFocusTrans()
	if self._initFinish then
		return
	end

	self._focusLimit = nil

	local curGame = PartyGameController.instance:getCurPartyGame()
	local co = curGame:getGameConfig()

	if co and co.isFocusPlayer then
		local uid = curGame:getMainPlayerUid()
		local x, y, z = PartyGame.Runtime.GameLogic.GameInterfaceBase.GetPlayerPos(uid, 0, 0, 0)

		if not string.nilorempty(co.focusLimit) then
			local arr = GameUtil.splitString2(co.focusLimit, true)

			x = Mathf.Clamp(x, arr[1][1], arr[2][1])
			y = Mathf.Clamp(x, arr[1][2], arr[2][2])
			z = Mathf.Clamp(z, arr[1][3], arr[2][3])
			self._focusLimit = arr
		end

		self:setFocus(x, y, z)

		self._focusTrans = PartyGame.Runtime.GameLogic.GameInterfaceBase.GetPlayerTransform(uid)

		if self._focusTrans ~= nil then
			self._initFinish = true

			PartyGameController.instance:unregisterCallback(PartyGameEvent.LogicCalFinish, self._initFocusTrans, self)
			LateUpdateBeat:Add(self._lateUpdate, self)
		end
	else
		PartyGameController.instance:unregisterCallback(PartyGameEvent.LogicCalFinish, self._initFocusTrans, self)

		self._focusTrans = nil
	end
end

function PartyGameSceneCameraComp:onSceneClose(...)
	PartyGameSceneCameraComp.super.onSceneClose(self, ...)
	PartyGameController.instance:unregisterCallback(PartyGameEvent.LogicCalFinish, self._initFocusTrans, self)
	self:setClippingPlanes(self._oriFarClip, self._oriNearClip)

	self._initFinish = false
	self._focusTrans = nil
	self._focusLimit = nil

	LateUpdateBeat:Remove(self._lateUpdate, self)
end

return PartyGameSceneCameraComp
