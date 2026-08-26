-- chunkname: @modules/logic/scene/pushbox/comp/PushBoxSceneCameraComp.lua

module("modules.logic.scene.pushbox.comp.PushBoxSceneCameraComp", package.seeall)

local PushBoxSceneCameraComp = class("PushBoxSceneCameraComp", BaseSceneComp)

function PushBoxSceneCameraComp:onInit()
	self._scene = self:getCurScene()
	self._cameraTrace = CameraMgr.instance:getCameraTrace()
end

function PushBoxSceneCameraComp:onSceneStart(sceneId, levelId)
	local focusTrs = CameraMgr.instance:getFocusTrs()

	transformhelper.setPos(focusTrs, 0, 0, 0)

	self._cameraTrace.EnableTrace = false

	gohelper.setActive(CameraMgr.instance:getVirtualCameraGO(), false)
	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), 0, -5.8, -200)
	transformhelper.setLocalRotation(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)

	CameraMgr.instance:getMainCamera().farClipPlane = 1000
end

function PushBoxSceneCameraComp:onSceneClose()
	CameraMgr.instance:getMainCamera().farClipPlane = 500
end

return PushBoxSceneCameraComp
