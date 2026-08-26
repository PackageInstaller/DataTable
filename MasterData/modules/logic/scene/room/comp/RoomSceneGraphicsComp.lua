-- chunkname: @modules/logic/scene/room/comp/RoomSceneGraphicsComp.lua

module("modules.logic.scene.room.comp.RoomSceneGraphicsComp", package.seeall)

local RoomSceneGraphicsComp = class("RoomSceneGraphicsComp", BaseSceneComp)

function RoomSceneGraphicsComp:onInit()
	self.LAYER_MASK_CullByDistance = LayerMask.GetMask("CullByDistance")
	self.LAYER_MASK_CullOnLowQuality = LayerMask.GetMask("CullOnLowQuality")
	self.LAYER_INDEX_CullByDistance = LayerMask.NameToLayer("CullByDistance")
	self.LAYER_INDEX_CullOnLowQuality = LayerMask.NameToLayer("CullOnLowQuality")
	self.highQualityCullingDistance = 6
	self.middleQualityCullingDistance = 5.5
	self.lowQualityCullingDistance = 3.5

	if BootNativeUtil.isAndroid() then
		local gpuName = UnityEngine.SystemInfo.graphicsDeviceName

		self.compatibility = string.find(gpuName, "^Adreno") or string.find(gpuName, "^Mali")
		self.compatibility = self.compatibility or SDKMgr.instance:isEmulator()
	else
		self.compatibility = true
	end

	if SDKMgr.instance:isEmulator() then
		SceneCulling.useBurst = false
	end
end

function RoomSceneGraphicsComp:init(sceneId, levelId)
	self._unitPPVolume = gohelper.findChildComponent(CameraMgr.instance:getMainCameraGO(), "PPVolume", PostProcessingMgr.PPVolumeWrapType)

	self:_refreshGraphics()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnQualityChange, self._refreshGraphics, self)

	self.projPhysics = UnityEngine.Physics.simulationMode
	self.projTransforms = UnityEngine.Physics.autoSyncTransforms
	UnityEngine.Physics.simulationMode = UnityEngine.SimulationMode.Script
	UnityEngine.Physics.autoSyncTransforms = true

	local camera = CameraMgr.instance:getMainCamera()
	local mainCustomCameraData = camera:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	self.useLightData = mainCustomCameraData.useLightData
	self.useLightmap = mainCustomCameraData.useLightmap
	self.useProbe = mainCustomCameraData.useProbe
	mainCustomCameraData.useProbe = false
	mainCustomCameraData.useLightmap = false
	mainCustomCameraData.useLightData = false

	local uiCamera = CameraMgr.instance:getUICamera()

	self.uiCameraData = uiCamera:GetComponent(PostProcessingMgr.PPCustomCamDataType)
	self.cacheUINeedLights = self.uiCameraData.needLights
	self.uiCameraData.needLights = false
	self.lodBias = UnityEngine.QualitySettings.lodBias

	UnityEngine.Shader.EnableKeyword("_FASTER_BLOOM")

	local ambient = self:getCurScene().go.sceneAmbient

	ambient:SetReflectionType(0)

	RenderPipelineSetting.useRenderOpaqueWithSceneColorPass = true

	PostProcessingMgr.setCameraLayerInt(camera, self.LAYER_MASK_CullByDistance, true)
	PostProcessingMgr.setCameraLayerInt(camera, self.LAYER_MASK_CullOnLowQuality, false)

	camera.layerCullSpherical = true

	if BootNativeUtil.isWindows() then
		RenderPipelineSetting.ForwardPlusToggle = true
	end

	if BootNativeUtil.isWindows() then
		local quality = GameGlobalMgr.instance:getScreenState():getLocalQuality()

		if quality == ModuleEnum.Performance.High then
			self:getCurScene().loader:makeSureLoaded({
				RoomScenePreloader.DiffuseGI
			}, self._OnGetInstance, self)
		end
	end
end

function RoomSceneGraphicsComp:_OnGetInstance()
	self.go_GI = RoomGOPool.getInstance(RoomScenePreloader.DiffuseGI, self:getCurScene().go.sceneGO, "diffuse_gi")

	transformhelper.setPos(self.go_GI.transform, 0, 0, 0)
end

function RoomSceneGraphicsComp:setPPValue(key, value)
	if self._unitPPVolume then
		self._unitPPVolume.refresh = true
		self._unitPPVolume[key] = value
	end
end

function RoomSceneGraphicsComp:onSceneClose()
	UnityEngine.Shader.DisableKeyword("_FASTER_BLOOM")

	self.uiCameraData.needLights = self.cacheUINeedLights
	self.uiCameraData = nil

	PostProcessingMgr.instance:setRenderShadow(true)
	PostProcessingMgr.instance:clearLayerCullDistance()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, self._refreshGraphics, self)

	local camera = CameraMgr.instance:getMainCamera()
	local mainCustomCameraData = camera:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	self.overLookFlag = nil
	mainCustomCameraData.renderScale = 1
	mainCustomCameraData.useProbe = self.useProbe
	mainCustomCameraData.useLightmap = self.useLightmap
	mainCustomCameraData.useLightData = self.useLightData
	mainCustomCameraData.disableTransparentBackToFrontSort = false
	UnityEngine.Physics.simulationMode = self.projPhysics
	UnityEngine.Physics.autoSyncTransforms = self.projTransforms
	self.projPhysics = nil
	self.projTransforms = nil
	UnityEngine.QualitySettings.lodBias = self.lodBias

	PostProcessingMgr.setCameraLayerInt(camera, self.LAYER_MASK_CullOnLowQuality, false)
	PostProcessingMgr.setCameraLayerInt(camera, self.LAYER_MASK_CullByDistance, false)

	camera.layerCullSpherical = false

	self:setPPValue("ssaoEnable", false)

	self._unitPPVolume = nil
	RenderPipelineSetting.useRenderOpaqueWithSceneColorPass = false
	UnityEngine.QualitySettings.globalTextureMipmapLimit = 0

	if BootNativeUtil.isWindows() then
		RenderPipelineSetting.ForwardPlusToggle = false
	end

	self.go_GI = nil
end

function RoomSceneGraphicsComp:_refreshGraphics()
	local quality = GameGlobalMgr.instance:getScreenState():getLocalQuality()
	local camera = CameraMgr.instance:getMainCamera()
	local mainCustomCameraData = camera:GetComponent(PostProcessingMgr.PPCustomCamDataType)
	local sceneCulling = self:getCurScene().go.sceneCulling

	if quality == ModuleEnum.Performance.High then
		PostProcessingMgr.instance:setRenderShadow(true)

		mainCustomCameraData.renderScale = 1
		sceneCulling.smallRate = 0.005
		sceneCulling.proxyRate = 0.015
		UnityEngine.QualitySettings.lodBias = 1

		if self.compatibility then
			self:setPPValue("ssaoEnable", true)
			self:setPPValue("ssaoIntensity", 0.38)
			self:setPPValue("ssaoRadius", 0.07)
			self:setPPValue("ssaoRenderScale", 0.2)
			self:setPPValue("ssaoDepthQuality", 1)
		end

		PostProcessingMgr.instance:setLayerCullDistance(self.LAYER_INDEX_CullByDistance, self.highQualityCullingDistance)
		PostProcessingMgr.instance:setLayerCullDistance(self.LAYER_INDEX_CullOnLowQuality, self.highQualityCullingDistance)

		UnityEngine.QualitySettings.globalTextureMipmapLimit = 0
	elseif quality == ModuleEnum.Performance.Middle then
		mainCustomCameraData.renderScale = 0.8
		UnityEngine.QualitySettings.lodBias = 0.9

		PostProcessingMgr.instance:setRenderShadow(true)
		self:setPPValue("ssaoEnable", false)

		local ambient = self:getCurScene().go.sceneAmbient

		ambient:SetReflectionType(0)
		PostProcessingMgr.instance:setLayerCullDistance(self.LAYER_INDEX_CullByDistance, self.middleQualityCullingDistance)
		PostProcessingMgr.instance:setLayerCullDistance(self.LAYER_INDEX_CullOnLowQuality, self.middleQualityCullingDistance)

		sceneCulling.smallRate = 0.02
		sceneCulling.proxyRate = 0.03
		UnityEngine.QualitySettings.globalTextureMipmapLimit = 0
	elseif quality == ModuleEnum.Performance.Low then
		mainCustomCameraData.renderScale = 0.7
		UnityEngine.QualitySettings.lodBias = 0.7

		PostProcessingMgr.instance:setRenderShadow(false)
		self:setPPValue("ssaoEnable", false)

		local ambient = self:getCurScene().go.sceneAmbient

		ambient:SetReflectionType(0)
		PostProcessingMgr.instance:setLayerCullDistance(self.LAYER_INDEX_CullByDistance, self.lowQualityCullingDistance)
		PostProcessingMgr.instance:setLayerCullDistance(self.LAYER_INDEX_CullOnLowQuality, self.lowQualityCullingDistance)

		sceneCulling.smallRate = 0.03
		sceneCulling.proxyRate = 0.075
		UnityEngine.QualitySettings.globalTextureMipmapLimit = 1
	end
end

function RoomSceneGraphicsComp:setupShadowParam(isOverlook, distance)
	if self.overLookFlag ~= isOverlook then
		local sceneShadow, ambient
		local scene = self:getCurScene()
		local camera = CameraMgr.instance:getMainCamera()

		if scene ~= nil and scene.go ~= nil then
			sceneShadow = scene.go.sceneShadow
			ambient = scene.go.sceneAmbient
		end

		if sceneShadow ~= nil then
			if isOverlook then
				sceneShadow.overrideShadowCascadesOption = true
				sceneShadow.shadowCascadesOption = UnityEngine.Rendering.Universal.ShadowCascadesOption.NoCascades
				sceneShadow.overrideShadowResolution = true
				sceneShadow.shadowResolution = 1600
				sceneShadow.softShadow = true
			else
				sceneShadow.overrideShadowCascadesOption = true
				sceneShadow.shadowCascadesOption = UnityEngine.Rendering.Universal.ShadowCascadesOption.TwoCascades
				sceneShadow.overrideShadowResolution = true
				sceneShadow.shadowResolution = 2048
				sceneShadow.softShadow = true
			end

			sceneShadow:ApplyProperty()
		end

		local quality = GameGlobalMgr.instance:getScreenState():getLocalQuality()
		local isHighQuality = quality == ModuleEnum.Performance.High

		if isHighQuality and self.compatibility then
			if isOverlook then
				ambient:SetReflectionType(0)
				self:setPPValue("ssaoIntensity", 0.38)
				self:setPPValue("ssaoRadius", 0.07)
			else
				ambient:SetReflectionType(1)
				self:setPPValue("ssaoIntensity", 0.38)
				self:setPPValue("ssaoRadius", 0.015)
			end
		end

		if isOverlook then
			PostProcessingMgr.setCameraLayerInt(camera, self.LAYER_MASK_CullOnLowQuality, false)
		elseif quality ~= ModuleEnum.Performance.Low then
			PostProcessingMgr.setCameraLayerInt(camera, self.LAYER_MASK_CullOnLowQuality, true)
		end

		local mainCustomCameraData = camera:GetComponent(PostProcessingMgr.PPCustomCamDataType)

		mainCustomCameraData.disableTransparentBackToFrontSort = not not isOverlook
		self.overLookFlag = isOverlook
	end
end

return RoomSceneGraphicsComp
