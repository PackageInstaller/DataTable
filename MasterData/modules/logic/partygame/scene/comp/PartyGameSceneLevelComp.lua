-- chunkname: @modules/logic/partygame/scene/comp/PartyGameSceneLevelComp.lua

module("modules.logic.partygame.scene.comp.PartyGameSceneLevelComp", package.seeall)

local PartyGameSceneLevelComp = class("PartyGameSceneLevelComp", CommonSceneLevelComp)
local NotBakedLightmapIndex = 65534

function PartyGameSceneLevelComp:loadLevel(levelId)
	if self._isLoadingRes then
		return
	end

	if self._assetItem then
		gohelper.destroy(self._instGO)
		self._assetItem:Release()

		self._assetItem = nil
		self._instGO = nil

		self:releaseSceneEffectsLoader()
	end

	self._isLoadingRes = true
	self._levelId = levelId

	logNormal("PartyGameSceneLevelComp:_onLoadCallback load party game config start")
	PartyGame.Runtime.Configs.PGConfigLoader.Init(self._onLoadConfigEnd, self)
end

function PartyGameSceneLevelComp:_onLoadConfigEnd(isSuccess)
	if not isSuccess then
		logError("PartyGameSceneLevelComp:_onLoadConfig 失败")

		return
	end

	logNormal("PartyGameSceneLevelComp:LoadAsset start")
	self:getCurScene():setCurLevelId(self._levelId)

	self._resPath = PartyGameModel.instance:getCurGameResPath()

	loadAbAsset(self._resPath, false, self._onLoadCallback, self)
end

function PartyGameSceneLevelComp:_disableBakedShadowCasters(sceneGo)
	local renderers = sceneGo:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	for i = 0, renderers.Length - 1 do
		local renderer = renderers[i]

		if not gohelper.isNil(renderer) then
			local lightmapIndex = renderer.lightmapIndex

			if lightmapIndex >= 0 and lightmapIndex < NotBakedLightmapIndex then
				renderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off
			end
		end
	end
end

function PartyGameSceneLevelComp:_onLoadCallback(assetItem)
	PartyGameSceneLevelComp.super._onLoadCallback(self, assetItem)

	local sceneGo = self:getSceneGo()

	if not sceneGo then
		return
	end

	self:_disableBakedShadowCasters(sceneGo)

	local joltPhysicsWorldAdapter = sceneGo:GetComponent(typeof(PartyGame.Runtime.Games.Common.JoltPhysicsWorldAdapter))
	local curGame = PartyGameController.instance:getCurPartyGame()

	joltPhysicsWorldAdapter.connectNet = not curGame:getIsLocal()

	local mainPlayerUid = curGame:getMainPlayerUid()

	if curGame:getIsTrial() then
		PartyGameTrialController.instance:setGameTrial(true)
		PartyGameTrialController.instance:initPlayerCard()
	end

	joltPhysicsWorldAdapter:Init(mainPlayerUid)
end

return PartyGameSceneLevelComp
