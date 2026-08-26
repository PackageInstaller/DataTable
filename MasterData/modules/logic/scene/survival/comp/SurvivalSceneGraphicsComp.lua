-- chunkname: @modules/logic/scene/survival/comp/SurvivalSceneGraphicsComp.lua

module("modules.logic.scene.survival.comp.SurvivalSceneGraphicsComp", package.seeall)

local SurvivalSceneGraphicsComp = class("SurvivalSceneGraphicsComp", BaseSceneComp)

function SurvivalSceneGraphicsComp:onInit()
	if BootNativeUtil.isAndroid() then
		local gpuName = UnityEngine.SystemInfo.graphicsDeviceName

		self.compatibility = string.find(gpuName, "^Adreno") or string.find(gpuName, "^Mali")
		self.compatibility = self.compatibility or SDKMgr.instance:isEmulator()
	else
		self.compatibility = true
	end
end

function SurvivalSceneGraphicsComp:setPPValue(key, value)
	if self._unitPPVolume then
		self._unitPPVolume.refresh = true
		self._unitPPVolume[key] = value
	end
end

function SurvivalSceneGraphicsComp:init(sceneId, levelId)
	self._unitPPVolume = gohelper.findChildComponent(CameraMgr.instance:getMainCameraGO(), "PPVolume", PostProcessingMgr.PPVolumeWrapType)

	self:_refreshGraphics()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnQualityChange, self._refreshGraphics, self)
	UnityEngine.Shader.EnableKeyword("_FASTER_BLOOM")

	RenderPipelineSetting.ForwardPlusToggle = true
	RenderPipelineSetting.useRenderOpaqueWithSceneColorPass = true

	local camera = CameraMgr.instance:getMainCamera()

	self._farClip = camera.farClipPlane
	self._nearClip = camera.nearClipPlane
	camera.nearClipPlane = 1
	camera.farClipPlane = 100
end

function SurvivalSceneGraphicsComp:onSceneClose()
	self:setPPValue("ssaoEnable", false)
	UnityEngine.Shader.DisableKeyword("_FASTER_BLOOM")

	RenderPipelineSetting.ForwardPlusToggle = false
	RenderPipelineSetting.useRenderOpaqueWithSceneColorPass = false

	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, self._refreshGraphics, self)

	UnityEngine.QualitySettings.globalTextureMipmapLimit = 0
	self._unitPPVolume = nil

	local camera = CameraMgr.instance:getMainCamera()

	camera.nearClipPlane = self._nearClip
	camera.farClipPlane = self._farClip
end

function SurvivalSceneGraphicsComp:_refreshGraphics()
	local camera = CameraMgr.instance:getMainCamera()
	local mainCustomCameraData = camera:GetComponent(PostProcessingMgr.PPCustomCamDataType)
	local quality = GameGlobalMgr.instance:getScreenState():getLocalQuality()

	if quality == ModuleEnum.Performance.High then
		PostProcessingMgr.instance:setRenderShadow(true)

		if self.compatibility then
			self:setPPValue("ssaoEnable", true)
			self:setPPValue("ssaoIntensity", 0.38)
			self:setPPValue("ssaoRadius", 0.07)
			self:setPPValue("ssaoRenderScale", 0.2)
			self:setPPValue("ssaoDepthQuality", 1)
		end

		mainCustomCameraData.renderScale = 1

		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", -0.5)

		UnityEngine.QualitySettings.globalTextureMipmapLimit = 0
	elseif quality == ModuleEnum.Performance.Middle then
		self:setPPValue("ssaoEnable", false)
		PostProcessingMgr.instance:setRenderShadow(true)

		mainCustomCameraData.renderScale = 1

		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", 0)

		UnityEngine.QualitySettings.globalTextureMipmapLimit = 0
	elseif quality == ModuleEnum.Performance.Low then
		self:setPPValue("ssaoEnable", false)
		PostProcessingMgr.instance:setRenderShadow(true)

		mainCustomCameraData.renderScale = 0.75

		UnityEngine.Shader.SetGlobalFloat("_GlobalMipBias", 0.5)

		UnityEngine.QualitySettings.globalTextureMipmapLimit = 1
	end
end

return SurvivalSceneGraphicsComp
