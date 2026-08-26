-- chunkname: @modules/logic/versionactivity3_9/racingcar/scene/comp/V3a9RacingCarSceneGraphicsComp.lua

module("modules.logic.versionactivity3_9.racingcar.scene.comp.V3a9RacingCarSceneGraphicsComp", package.seeall)

local V3a9RacingCarSceneGraphicsComp = class("V3a9RacingCarSceneGraphicsComp", BaseSceneComp)

function V3a9RacingCarSceneGraphicsComp:onInit()
	return
end

function V3a9RacingCarSceneGraphicsComp:onScenePrepared(sceneId, levelId)
	RenderPipelineSetting.useRenderOpaqueWithSceneColorPass = true

	local mainCamera = CameraMgr.instance:getMainCamera()

	self._oriFlag = mainCamera.clearFlags
	mainCamera.clearFlags = UnityEngine.CameraClearFlags.Skybox
	self._oriFarClip = mainCamera.farClipPlane
	self._oriNearClip = mainCamera.nearClipPlane
	mainCamera.nearClipPlane = 3
	mainCamera.layerCullSpherical = true
	self.LAYER_MASK_CullByDistance = LayerMask.GetMask("CullByDistance")
	self.LAYER_MASK_CullOnLowQuality = LayerMask.GetMask("CullOnLowQuality")
	self.LAYER_INDEX_CullByDistance = LayerMask.NameToLayer("CullByDistance")
	self.LAYER_INDEX_CullOnLowQuality = LayerMask.NameToLayer("CullOnLowQuality")

	PostProcessingMgr.setCameraLayerInt(mainCamera, self.LAYER_MASK_CullByDistance, true)
	PostProcessingMgr.setCameraLayerInt(mainCamera, self.LAYER_MASK_CullOnLowQuality, true)

	self._scene = GameSceneMgr.instance:getCurScene()

	local sceneGo = self._scene.level:getSceneGo()
	local directLight = gohelper.findChildComponent(sceneGo, "scene/lighting/Directional Light", typeof(UnityEngine.Light))

	directLight = directLight or gohelper.findChildComponent(sceneGo, "scene_night/lighting/Directional Light", typeof(UnityEngine.Light))

	local quality = GameGlobalMgr.instance:getScreenState():getLocalQuality()

	if quality == ModuleEnum.Performance.High then
		mainCamera.farClipPlane = 1000

		if directLight then
			directLight.shadows = UnityEngine.LightShadows.Soft
		end

		PostProcessingMgr.instance:setLayerCullDistance(self.LAYER_INDEX_CullByDistance, 400)
		PostProcessingMgr.instance:setLayerCullDistance(self.LAYER_INDEX_CullOnLowQuality, 500)
	elseif quality == ModuleEnum.Performance.Middle then
		mainCamera.farClipPlane = 800

		if directLight then
			directLight.shadows = UnityEngine.LightShadows.Hard
		end

		PostProcessingMgr.instance:setLayerCullDistance(self.LAYER_INDEX_CullByDistance, 400)
		PostProcessingMgr.instance:setLayerCullDistance(self.LAYER_INDEX_CullOnLowQuality, 500)
	else
		mainCamera.farClipPlane = 600

		if directLight then
			directLight.shadows = UnityEngine.LightShadows.None
		end

		PostProcessingMgr.instance:setLayerCullDistance(self.LAYER_INDEX_CullByDistance, 350)
		PostProcessingMgr.instance:setLayerCullDistance(self.LAYER_INDEX_CullOnLowQuality, 450)
	end
end

function V3a9RacingCarSceneGraphicsComp:onSceneClose()
	RenderPipelineSetting.useRenderOpaqueWithSceneColorPass = false

	local mainCamera = CameraMgr.instance:getMainCamera()

	mainCamera.clearFlags = self._oriFlag
	mainCamera.nearClipPlane = self._oriNearClip
	mainCamera.farClipPlane = self._oriFarClip

	PostProcessingMgr.setCameraLayerInt(mainCamera, self.LAYER_MASK_CullOnLowQuality, false)
	PostProcessingMgr.setCameraLayerInt(mainCamera, self.LAYER_MASK_CullByDistance, false)
	PostProcessingMgr.instance:setLayerCullDistance(self.LAYER_INDEX_CullByDistance, 0)
	PostProcessingMgr.instance:setLayerCullDistance(self.LAYER_INDEX_CullOnLowQuality, 0)

	mainCamera.layerCullSpherical = false

	PostProcessingMgr.instance:clearLayerCullDistance()
end

return V3a9RacingCarSceneGraphicsComp
