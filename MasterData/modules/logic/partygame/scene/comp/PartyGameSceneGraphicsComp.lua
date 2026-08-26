-- chunkname: @modules/logic/partygame/scene/comp/PartyGameSceneGraphicsComp.lua

module("modules.logic.partygame.scene.comp.PartyGameSceneGraphicsComp", package.seeall)

local PartyGameSceneGraphicsComp = class("PartyGameSceneGraphicsComp", BaseSceneComp)
local Shader = UnityEngine.Shader
local RoleLightFactorId = Shader.PropertyToID("_PartyRoleLightFactor")
local NormalizeTopLightId = Shader.PropertyToID("_PartyRoleNormalizeTopLight")

function PartyGameSceneGraphicsComp:init()
	return
end

function PartyGameSceneGraphicsComp:_applyRoleLightFactor()
	local factor = PartyGameEnum.DefaultRoleLightFactor
	local normalizeTopLight = 0
	local game = PartyGameController.instance:getCurPartyGame()

	if game then
		local configuredFactor = PartyGameEnum.RoleLightFactor[game:getGameId()]

		if configuredFactor ~= nil then
			factor = configuredFactor
			normalizeTopLight = 1
		end
	end

	Shader.SetGlobalFloat(RoleLightFactorId, factor)
	Shader.SetGlobalFloat(NormalizeTopLightId, normalizeTopLight)
end

function PartyGameSceneGraphicsComp:onScenePrepared(sceneId, levelId)
	self:_applyRoleLightFactor()

	RenderPipelineSetting.useRenderOpaqueWithSceneColorPass = true

	local unitCamera = CameraMgr.instance:getUnitCamera()

	unitCamera.enabled = false
	self._cacheIgnoreUIBlur = PostProcessingMgr.instance:getIgnoreUIBlur()

	PostProcessingMgr.instance:setUnitActive(false)

	local mainCamera = CameraMgr.instance:getMainCamera()

	if UnityEngine.RenderSettings.skybox ~= nil and UnityEngine.RenderSettings.skybox.name ~= "Default-Skybox" then
		self._oriFlag = mainCamera.clearFlags
		mainCamera.clearFlags = UnityEngine.CameraClearFlags.Skybox
	end

	local quality = GameGlobalMgr.instance:getScreenState():getLocalQuality()

	if quality == ModuleEnum.Performance.Low then
		local mainCustomCameraData = mainCamera:GetComponent(PostProcessingMgr.PPCustomCamDataType)

		mainCustomCameraData.renderScale = 0.75

		PostProcessingMgr.instance:setRenderShadow(false)

		UnityEngine.QualitySettings.globalTextureMipmapLimit = 1
	end
end

function PartyGameSceneGraphicsComp:onSceneClose()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, self._refreshGraphics, self)
	Shader.SetGlobalFloat(RoleLightFactorId, PartyGameEnum.DefaultRoleLightFactor)
	Shader.SetGlobalFloat(NormalizeTopLightId, 0)

	RenderPipelineSetting.useRenderOpaqueWithSceneColorPass = false

	local unitCamera = CameraMgr.instance:getUnitCamera()

	unitCamera.enabled = true

	PostProcessingMgr.instance:setUnitActive(true)

	local mainCamera = CameraMgr.instance:getMainCamera()

	if self._oriFlag then
		mainCamera.clearFlags = self._oriFlag
	end

	PostProcessingMgr.instance:setRenderShadow(true)

	local mainCustomCameraData = mainCamera:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	mainCustomCameraData.renderScale = 1
	UnityEngine.QualitySettings.globalTextureMipmapLimit = 0
end

return PartyGameSceneGraphicsComp
