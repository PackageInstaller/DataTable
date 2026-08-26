-- chunkname: @modules/logic/partygamelobby/scene/comp/PartyGameLobbySceneCameraComp.lua

module("modules.logic.partygamelobby.scene.comp.PartyGameLobbySceneCameraComp", package.seeall)

local PartyGameLobbySceneCameraComp = class("PartyGameLobbySceneCameraComp", CommonSceneCameraComp)

function PartyGameLobbySceneCameraComp:getCameraFocus()
	self._gameParamCo = lua_partygame_param.configDict[self._gameId]

	local arr = {}

	if self._gameParamCo and not string.nilorempty(self._gameParamCo.focus) then
		arr = string.splitToNumber(self._gameParamCo.focus, "#")
	end

	return arr[1] or 0, arr[2] or 0, arr[3] or 0
end

function PartyGameLobbySceneCameraComp:_initCurSceneCameraTrace(levelId)
	self._cameraConfigId = PartyGameLobbyEnum.CameraId[levelId]
	self._cameraCO = lua_camera.configDict[self._cameraConfigId]

	self:resetParam()
	self:applyDirectly()
end

function PartyGameLobbySceneCameraComp:resetParam(cameraConfig)
	cameraConfig = cameraConfig or self._cameraCO

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

function PartyGameLobbySceneCameraComp:onScenePrepared(...)
	PartyGameLobbySceneCameraComp.super.onScenePrepared(self, ...)

	self._focusLimit = nil

	LateUpdateBeat:Add(self._lateUpdate, self)
end

function PartyGameLobbySceneCameraComp:_onScreenResize()
	local focusTrs = CameraMgr.instance:getFocusTrs()
	local x, y, z = transformhelper.getPos(focusTrs)

	self._cameraTrace:SetTargetFocusPos(x, y, z)
end

function PartyGameLobbySceneCameraComp:setFocus(x, y, z)
	if not self._cameraTrace then
		return
	end

	local focusTrs = CameraMgr.instance:getFocusTrs()

	transformhelper.setPos(focusTrs, x, y, z)
	self._cameraTrace:SetTargetFocusPos(x, y, z)
	self:applyDirectly()
end

function PartyGameLobbySceneCameraComp:setFocusTrans(trans)
	self._focusTrans = trans
end

function PartyGameLobbySceneCameraComp:_lateUpdate()
	if gohelper.isNil(self._focusTrans) then
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

function PartyGameLobbySceneCameraComp:_getMinMaxFov()
	return 10, 120
end

function PartyGameLobbySceneCameraComp:onSceneClose(...)
	PartyGameLobbySceneCameraComp.super.onSceneClose(self, ...)

	self._focusTrans = nil
	self._focusLimit = nil

	LateUpdateBeat:Remove(self._lateUpdate, self)
end

return PartyGameLobbySceneCameraComp
