-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/scene/component/RetrieveSceneCamera.lua

module("logic.extensions.retrieve.scene.component.RetrieveSceneCamera", package.seeall)

local M = class("RetrieveSceneCamera", SceneComponentBase)
local kMainCameraCullLayers = {
	SceneLayer.Default_Value,
	SceneLayer.Stone_Value,
	SceneLayer.Unit_Value
}
local kMainCameraVolumeLayers = {
	SceneLayer.Default_Value,
	SceneLayer.Unit_Value
}

function M:onInit()
	self._sceneId = false
	self._unitCamera = false
end

function M:onEnterScene(sceneId, bornX, bornZ)
	self._sceneId = sceneId

	self:_initCamera()
end

function M:_initCamera()
	local sceneCO = SceneConfig.instance:getSceneCO(self._sceneId)

	VirtualCameraMgr.instance:resetCameraSettings()
	VirtualCameraMgr.instance:setActiveCamera(sceneCO.cameraCode)
	VirtualCameraMgr.instance:setFollowConfiner(sceneCO.confinerResPath)

	local cameraCO = CameraConfig.instance:getCameraCO(sceneCO.cameraCode)

	if cameraCO then
		MainCameraMgr.instance:setCameraMaskMode(cameraCO.cameraMaskMode)
	end

	VolumeMgr.instance:turnOn(sceneCO.volumeResPath)

	self._cameraUnit = VirtualCameraMgr.instance:getActiveCamera()

	if self._cameraUnit and self._cameraUnit._relativeComponent then
		self._cameraUnit._relativeComponent.enabled = false
	end

	self:setCameraState()
end

function M:onExitScene()
	local sceneCO = SceneConfig.instance:getSceneCO(self._sceneId or 0)

	if sceneCO then
		VolumeMgr.instance:turnOff(sceneCO.volumeResPath)
	end

	MainCameraMgr.instance:setDefaultCameraMask()
	VirtualCameraMgr.instance:clearFollowConfiner()
end

function M:_addAdditionalUnitCamera()
	local mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCamera = mainCameraTarget:getCamera()

	mainCamera.cullingMask = Astral.LayerUtil.GetLayerMask(unpack(kMainCameraCullLayers))

	URPCameraUtils.SetVolumeLayerMask(mainCamera, Astral.LayerUtil.GetLayerMask(unpack(kMainCameraVolumeLayers)))
end

function M:_removeAdditionalUnitCamera()
	return
end

function M:setCameraState(leaveScene)
	local mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCamera = mainCameraTarget:getCamera()

	mainCamera.cullingMask = Astral.LayerUtil.GetLayerMask(unpack(kMainCameraCullLayers))

	URPCameraUtils.SetVolumeLayerMask(mainCamera, Astral.LayerUtil.GetLayerMask(unpack(kMainCameraVolumeLayers)))
end

function M:onLeaveScene(needUnloadRes)
	self:setCameraState()
end

function M:onReturnScene(needUnloadRes)
	self:_initCamera()
end

function M:onReturnSceneFinished(needUnloadRes)
	return
end

return M
