-- chunkname: @modules/logic/scene/cachot/comp/CachotSceneCamera.lua

module("modules.logic.scene.cachot.comp.CachotSceneCamera", package.seeall)

local CachotSceneCamera = class("CachotSceneCamera", BaseSceneComp)

function CachotSceneCamera:onSceneStart(sceneId, levelId)
	self._scene = self:getCurScene()
	self._levelComp = self._scene.level

	local trace = CameraMgr.instance:getCameraTrace()

	self._traceEnabled = trace.enabled
	trace.enabled = false

	local camera = CameraMgr.instance:getMainCamera()
	local cameraTrs = CameraMgr.instance:getMainCameraTrs()

	self._rawCameraIsOrthographic = camera.orthographic
	self._rawCameraIsOrthographicSize = camera.orthographicSize

	gohelper.setActive(CameraMgr.instance:getVirtualCameraGO(), false)
	transformhelper.setLocalPos(cameraTrs, 0, 0, 0)
	transformhelper.setLocalRotation(cameraTrs, 0, 0, 0)

	camera.orthographic = true
	camera.orthographicSize = 5 * GameUtil.getAdapterScale(true)

	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self.onScreenResize, self)
end

function CachotSceneCamera:onScreenResize()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale(true)

	camera.orthographicSize = 5 * scale
end

function CachotSceneCamera:onSceneClose()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self.onScreenResize, self)

	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = self._rawCameraIsOrthographicSize
	camera.orthographic = self._rawCameraIsOrthographic

	local trace = CameraMgr.instance:getCameraTrace()

	trace.enabled = self._traceEnabled
end

return CachotSceneCamera
