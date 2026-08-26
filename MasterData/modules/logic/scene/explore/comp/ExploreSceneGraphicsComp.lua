-- chunkname: @modules/logic/scene/explore/comp/ExploreSceneGraphicsComp.lua

module("modules.logic.scene.explore.comp.ExploreSceneGraphicsComp", package.seeall)

local ExploreSceneGraphicsComp = class("ExploreSceneGraphicsComp", BaseSceneComp)

function ExploreSceneGraphicsComp:onInit()
	return
end

function ExploreSceneGraphicsComp:onSceneStart(sceneId, levelId)
	self:_refreshGraphics()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnQualityChange, self._refreshGraphics, self)

	self.projPhysics = UnityEngine.Physics.simulationMode
	self.projTransforms = UnityEngine.Physics.autoSyncTransforms
	UnityEngine.Physics.simulationMode = UnityEngine.SimulationMode.Script
	UnityEngine.Physics.autoSyncTransforms = true
	RenderPipelineSetting.selectedOutlineToggle = false
	RenderPipelineSetting.ForwardPlusToggle = true

	local camera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()

	self.uiCameraData = uiCamera:GetComponent(PostProcessingMgr.PPCustomCamDataType)
	self.cacheUINeedLights = self.uiCameraData.needLights
	self.uiCameraData.needLights = false
	self._farClip = camera.farClipPlane
	self._nearClip = camera.nearClipPlane
	camera.nearClipPlane = 1
	camera.farClipPlane = 220

	UnityEngine.Shader.EnableKeyword("_FASTER_BLOOM")
	PostProcessingMgr.setCameraLayer(camera, "UI3DAfterPostProcess", true)

	if BootNativeUtil.isMobilePlayer() or SLFramework.FrameworkSettings.IsEditor then
		RenderPipelineSetting.uiUnderclocking = true
	end
end

function ExploreSceneGraphicsComp:onSceneClose()
	RenderPipelineSetting.uiUnderclocking = false
	self.uiCameraData.needLights = self.cacheUINeedLights

	UnityEngine.Shader.DisableKeyword("_FASTER_BLOOM")
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, self._refreshGraphics, self)
	PostProcessingMgr.instance:setRenderShadow(true)
	UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", 0)
	UnityEngine.Shader.DisableKeyword("_QUALITY_LOW")
	UnityEngine.Shader.DisableKeyword("_QUALITY_MEDIUM")

	UnityEngine.QualitySettings.globalTextureMipmapLimit = 0
	UnityEngine.Physics.simulationMode = self.projPhysics
	UnityEngine.Physics.autoSyncTransforms = self.projTransforms
	self.projPhysics = nil
	self.uiCameraData = nil

	local camera = CameraMgr.instance:getMainCamera()

	camera.nearClipPlane = self._nearClip
	camera.farClipPlane = self._farClip

	local mainCustomCameraData = camera:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	mainCustomCameraData.renderScale = 1

	PostProcessingMgr.setCameraLayer(camera, "UI3DAfterPostProcess", false)
	PostProcessingMgr.setCameraLayer(camera, "CullOnLowQuality", false)

	RenderPipelineSetting.selectedOutlineToggle = false
	RenderPipelineSetting.ForwardPlusToggle = false
end

function ExploreSceneGraphicsComp:_refreshGraphics()
	local camera = CameraMgr.instance:getMainCamera()
	local mainCustomCameraData = camera:GetComponent(PostProcessingMgr.PPCustomCamDataType)
	local quality = GameGlobalMgr.instance:getScreenState():getLocalQuality()

	if quality == ModuleEnum.Performance.High then
		PostProcessingMgr.instance:setRenderShadow(true)

		mainCustomCameraData.renderScale = 1

		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", -0.5)
		UnityEngine.Shader.DisableKeyword("_QUALITY_LOW")
		UnityEngine.Shader.DisableKeyword("_QUALITY_MEDIUM")

		UnityEngine.QualitySettings.globalTextureMipmapLimit = 0

		PostProcessingMgr.setCameraLayer(camera, "CullOnLowQuality", true)
	elseif quality == ModuleEnum.Performance.Middle then
		mainCustomCameraData.renderScale = 0.8

		PostProcessingMgr.instance:setRenderShadow(true)
		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", 0)
		UnityEngine.Shader.EnableKeyword("_QUALITY_MEDIUM")
		UnityEngine.Shader.DisableKeyword("_QUALITY_LOW")

		UnityEngine.QualitySettings.globalTextureMipmapLimit = 0

		PostProcessingMgr.setCameraLayer(camera, "CullOnLowQuality", true)
	elseif quality == ModuleEnum.Performance.Low then
		mainCustomCameraData.renderScale = 0.6

		PostProcessingMgr.instance:setRenderShadow(false)
		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", 1)
		UnityEngine.Shader.DisableKeyword("_QUALITY_MEDIUM")
		UnityEngine.Shader.EnableKeyword("_QUALITY_LOW")

		UnityEngine.QualitySettings.globalTextureMipmapLimit = 1

		PostProcessingMgr.setCameraLayer(camera, "CullOnLowQuality", false)
	end
end

return ExploreSceneGraphicsComp
