-- chunkname: @modules/logic/scene/common/camera/CommonSceneCameraComp.lua

module("modules.logic.scene.common.camera.CommonSceneCameraComp", package.seeall)

local CommonSceneCameraComp = class("CommonSceneCameraComp", BaseSceneComp)

function CommonSceneCameraComp:onInit()
	self._scene = self:getCurScene()
	self._cameraTrace = CameraMgr.instance:getCameraTrace()
	self._cameraCO = nil
end

function CommonSceneCameraComp:onSceneStart(sceneId, levelId)
	self._cameraTrace.EnableTrace = true

	self:_initCurSceneCameraTrace(levelId)

	self._cameraTrace.EnableTrace = false

	self:_hideVirtualCamera()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self:_onScreenResize(UnityEngine.Screen.width, UnityEngine.Screen.height)
end

function CommonSceneCameraComp:onScenePrepared(sceneId, levelId)
	self._scene.level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
end

function CommonSceneCameraComp:onSceneClose()
	self._cameraTrace.EnableTrace = false

	self._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function CommonSceneCameraComp:_onLevelLoaded(levelId)
	local prevEnable = self._cameraTrace.EnableTrace

	self._cameraTrace.EnableTrace = true

	self:_initCurSceneCameraTrace(levelId)

	if not prevEnable then
		self._cameraTrace.EnableTrace = false
	end
end

function CommonSceneCameraComp:setCameraTraceEnable(isEnable)
	self._cameraTrace.EnableTrace = isEnable
end

function CommonSceneCameraComp:_initCurSceneCameraTrace(levelId)
	local sceneLevelCO = lua_scene_level.configDict[levelId]

	self._cameraCO = lua_camera.configDict[sceneLevelCO.cameraId]

	self:resetParam()
	self:applyDirectly()
end

function CommonSceneCameraComp:_hideVirtualCamera()
	gohelper.setActive(CameraMgr.instance:getVirtualCameraGO(), false)
	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
	transformhelper.setLocalRotation(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
end

function CommonSceneCameraComp:resetParam(cameraConfig)
	cameraConfig = cameraConfig or self._cameraCO

	local yaw = cameraConfig.yaw
	local pitch = cameraConfig.pitch
	local dist = cameraConfig.distance
	local fov = self:_calcFovInternal(cameraConfig)

	self.yaw = yaw

	self._cameraTrace:SetTargetParam(yaw, pitch, dist, fov, 0, 0, 0)

	local focusX = 0
	local focusY = cameraConfig.yOffset
	local focusZ = cameraConfig.focusZ

	self:setFocus(focusX, focusY, focusZ)
end

function CommonSceneCameraComp:_calcFovInternal(cameraConfig)
	local fovRatio = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)
	local fov = cameraConfig.fov * fovRatio
	local minFov, maxFov = self:_getMinMaxFov()

	fov = Mathf.Clamp(fov, minFov, maxFov)

	return fov
end

function CommonSceneCameraComp:_getMinMaxFov()
	return 35, 120
end

function CommonSceneCameraComp:_onScreenResize(width, height)
	self:resetParam()
	self:applyDirectly()
end

function CommonSceneCameraComp:getCurCO()
	return self._cameraCO
end

function CommonSceneCameraComp:applyDirectly()
	local focusTrs = CameraMgr.instance:getFocusTrs()

	self._cameraTrace:SetTargetFocusPos(transformhelper.getPos(focusTrs))
	self._cameraTrace:ApplyDirectly()
end

function CommonSceneCameraComp:setFocus(x, y, z)
	local focusTrs = CameraMgr.instance:getFocusTrs()

	transformhelper.setPos(focusTrs, x, y, z)
end

function CommonSceneCameraComp:setFocusX(x)
	local focusTrs = CameraMgr.instance:getFocusTrs()
	local _, focusY, focusZ = transformhelper.getPos(focusTrs)

	transformhelper.setPos(focusTrs, x, focusY, focusZ)
end

function CommonSceneCameraComp:resetFocus()
	self:setFocus(0, self._cameraCO.yOffset, self._cameraCO.focusZ)
end

function CommonSceneCameraComp:setEaseTime(easeTime)
	self._cameraTrace:SetEaseTime(easeTime)
end

function CommonSceneCameraComp:setEaseType(easeType)
	self._cameraTrace:SetEaseType(easeType)
end

function CommonSceneCameraComp:setFocusTransform(transform)
	self._cameraTrace:SetFocusTransform(transform)
end

function CommonSceneCameraComp:clearFocusTransform()
	self._cameraTrace:ClearFocusTransform()
end

function CommonSceneCameraComp:setDistance(distance)
	self._cameraTrace:SetTargetDistance(distance)
end

function CommonSceneCameraComp:resetDistance()
	self._cameraTrace:SetTargetDistance(self._cameraCO.distance)
end

function CommonSceneCameraComp:shake(duration, magnitude, shakeType, decreaseRate)
	self._cameraTrace:Shake(duration, magnitude, shakeType, decreaseRate)
end

function CommonSceneCameraComp:setRotate(yawAngle, pitchAngle)
	self._cameraTrace:SetTargetRotate(yawAngle, pitchAngle)
end

function CommonSceneCameraComp:setFov(fov)
	self._cameraTrace:SetTargetFov(fov)
end

return CommonSceneCameraComp
