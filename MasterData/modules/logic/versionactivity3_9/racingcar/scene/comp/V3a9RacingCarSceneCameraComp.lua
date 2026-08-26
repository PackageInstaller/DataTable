-- chunkname: @modules/logic/versionactivity3_9/racingcar/scene/comp/V3a9RacingCarSceneCameraComp.lua

module("modules.logic.versionactivity3_9.racingcar.scene.comp.V3a9RacingCarSceneCameraComp", package.seeall)

local V3a9RacingCarSceneCameraComp = class("V3a9RacingCarSceneCameraComp", CommonSceneCameraComp)

function V3a9RacingCarSceneCameraComp:_initCurSceneCameraTrace(levelId)
	self._cameraConfigId = V3a9RacingCarEnum.CameraId[levelId]
	self._cameraCO = lua_camera.configDict[self._cameraConfigId]

	self:resetParam()
	self:applyDirectly()
end

function V3a9RacingCarSceneCameraComp:resetParam(cameraConfig)
	cameraConfig = cameraConfig or self._cameraCO

	if not cameraConfig then
		return
	end

	local yaw = cameraConfig.yaw
	local pitch = cameraConfig.pitch
	local dist = cameraConfig.distance
	local fov = self:_calcFovInternal(cameraConfig)

	self.yaw = yaw

	self._cameraTrace:SetTargetParam(yaw, pitch, dist, fov, 0, 0, 0)

	local focusX = cameraConfig.foucsX
	local focusY = cameraConfig.yOffset
	local focusZ = cameraConfig.focusZ

	self:setFocus(focusX, focusY, focusZ)
end

function V3a9RacingCarSceneCameraComp:onScenePrepared(...)
	V3a9RacingCarSceneCameraComp.super.onScenePrepared(self, ...)

	self._focusLimit = nil
end

function V3a9RacingCarSceneCameraComp:_onScreenResize()
	local focusTrs = CameraMgr.instance:getFocusTrs()
	local x, y, z = transformhelper.getPos(focusTrs)

	self._cameraTrace:SetTargetFocusPos(x, y, z)
end

function V3a9RacingCarSceneCameraComp:setFocus(x, y, z)
	if not self._cameraTrace then
		return
	end

	local focusTrs = CameraMgr.instance:getFocusTrs()

	transformhelper.setPos(focusTrs, x, y, z)
	self._cameraTrace:SetTargetFocusPos(x, y, z)
	self:applyDirectly()
end

function V3a9RacingCarSceneCameraComp:setFocusTrans(trans)
	self._focusTrans = trans
end

function V3a9RacingCarSceneCameraComp:_lateUpdate()
	if gohelper.isNil(self._focusTrans) then
		return
	end

	local x, y, z = transformhelper.getPos(self._focusTrans)

	if self._focusLimit then
		x = Mathf.Clamp(x, self._focusLimit[1][1], self._focusLimit[2][1])
		y = Mathf.Clamp(y, self._focusLimit[1][2], self._focusLimit[2][2])
		z = Mathf.Clamp(z, self._focusLimit[1][3], self._focusLimit[2][3])
	end

	self:setFocus(x, y, z)
end

function V3a9RacingCarSceneCameraComp:_getMinMaxFov()
	return 10, 120
end

function V3a9RacingCarSceneCameraComp:onSceneClose(...)
	V3a9RacingCarSceneCameraComp.super.onSceneClose(self, ...)

	self._focusTrans = nil
	self._focusLimit = nil

	LateUpdateBeat:Remove(self._lateUpdate, self)
end

return V3a9RacingCarSceneCameraComp
