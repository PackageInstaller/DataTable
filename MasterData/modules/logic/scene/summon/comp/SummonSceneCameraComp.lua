-- chunkname: @modules/logic/scene/summon/comp/SummonSceneCameraComp.lua

module("modules.logic.scene.summon.comp.SummonSceneCameraComp", package.seeall)

local SummonSceneCameraComp = class("SummonSceneCameraComp", CommonSceneCameraComp)

function SummonSceneCameraComp:onSceneStart(sceneId, levelId)
	SummonSceneCameraComp.super.onSceneStart(self, sceneId, levelId)
	self:recordCameraArguments()
end

function SummonSceneCameraComp:onScenePrepared(sceneId, levelId)
	return
end

function SummonSceneCameraComp:switchToChar()
	self._cameraTrace.enabled = true

	self:resetParam()
	self:applyDirectly()

	local cameraTf = CameraMgr.instance:getMainCameraTrs()

	transformhelper.setLocalPos(cameraTf, 0, 0, 0)
end

function SummonSceneCameraComp:switchToEquip()
	self._cameraTrace.enabled = false

	self:setEquipSceneArguments()
end

function SummonSceneCameraComp:recordCameraArguments()
	local camera = CameraMgr.instance:getMainCamera()
	local cameraTf = CameraMgr.instance:getMainCameraTrs()

	self._originPosX, self._originPosY, self._originPosZ = transformhelper.getLocalPos(cameraTf)
	self._originFOV = self._cameraCO.fov

	local cameraTraceGo = CameraMgr.instance:getCameraTraceGO()
	local cameraTraceTf = cameraTraceGo.transform

	self._originTracePosX, self._originTracePosY, self._originTracePosZ = transformhelper.getLocalPos(cameraTraceTf)
	self._originTraceRotation = cameraTraceTf.localEulerAngles
	self._isRecord = true
end

function SummonSceneCameraComp:resetCameraArguments()
	if not self._isRecord then
		return
	end

	local camera = CameraMgr.instance:getMainCamera()
	local cameraTf = CameraMgr.instance:getMainCameraTrs()
	local cameraTraceGo = CameraMgr.instance:getCameraTraceGO()
	local cameraTraceTf = cameraTraceGo.transform

	camera.fieldOfView = self:calcFOV(self._originFOV)

	transformhelper.setLocalPos(cameraTf, self._originPosX, self._originPosY, self._originPosZ)
	transformhelper.setLocalPos(cameraTraceTf, self._originTracePosX, self._originTracePosY, self._originTracePosZ)

	cameraTraceTf.localEulerAngles = self._originTraceRotation

	local cameraGo = CameraMgr.instance:getCameraRootGO()

	transformhelper.setLocalPos(cameraGo.transform, 0, 0, 0)
end

function SummonSceneCameraComp:setEquipSceneArguments()
	if not self._isRecord then
		return
	end

	local camera = CameraMgr.instance:getMainCamera()
	local cameraTf = CameraMgr.instance:getMainCameraTrs()
	local cameraTraceGo = CameraMgr.instance:getCameraTraceGO()
	local cameraTraceTf = cameraTraceGo.transform

	camera.fieldOfView = self:calcFOV(60)

	transformhelper.setLocalPos(cameraTf, 0, 2.13, -12.06)
	transformhelper.setLocalPos(cameraTraceTf, 0, 0, 0)

	cameraTraceTf.localEulerAngles = Vector3.zero
end

function SummonSceneCameraComp:calcFOV(curFOV)
	local fovRatio = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)
	local fov = curFOV * fovRatio
	local minFov, maxFov = self:_getMinMaxFov()

	fov = Mathf.Clamp(fov, minFov, maxFov)

	return fov
end

function SummonSceneCameraComp:_onScreenResize(width, height)
	return
end

function SummonSceneCameraComp:onSceneClose(sceneId, levelId)
	self._cameraTrace.EnableTrace = false

	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self:resetCameraArguments()

	self._isRecord = false
	self._cameraTrace.enabled = true
end

function SummonSceneCameraComp:onSceneHide()
	self:onSceneClose()
end

return SummonSceneCameraComp
