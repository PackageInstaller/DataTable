-- chunkname: @modules/logic/scene/shelter/comp/SurvivalShelterSceneLevel.lua

module("modules.logic.scene.shelter.comp.SurvivalShelterSceneLevel", package.seeall)

local SurvivalShelterSceneLevel = class("SurvivalShelterSceneLevel", CommonSceneLevelComp)
local Shader = UnityEngine.Shader

function SurvivalShelterSceneLevel:init(sceneId, levelId)
	self:loadLevel(levelId)
end

function SurvivalShelterSceneLevel:onSceneStart(sceneId, levelId)
	self._sceneId = sceneId
	self._levelId = levelId
end

function SurvivalShelterSceneLevel:loadLevel(levelId)
	if self._isLoadingRes then
		logError("is loading scene level res, cur id = " .. (self._levelId or "nil") .. ", try to load id = " .. (levelId or "nil"))

		return
	end

	if self._assetItem then
		gohelper.destroy(self._instGO)
		self._assetItem:Release()

		self._assetItem = nil
		self._instGO = nil
	end

	self._isLoadingRes = true
	self._levelId = levelId

	self:getCurScene():setCurLevelId(self._levelId)

	self._resPath = ResUrl.getSurvivalSceneLevelUrl(levelId)

	loadAbAsset(self._resPath, false, self._onLoadCallback, self)
end

function SurvivalShelterSceneLevel:_onLoadCallback(assetItem)
	SurvivalShelterSceneLevel.super._onLoadCallback(self, assetItem)

	if not self._instGO then
		return
	end

	self:loadLightGo()
end

function SurvivalShelterSceneLevel:getLightName()
	return "light3"
end

function SurvivalShelterSceneLevel:loadLightGo()
	local name = self:getLightName()

	if not name then
		return
	end

	local assetPath = "survival/common/light/" .. name .. ".prefab"

	if not self._lightLoader then
		local go = gohelper.create3d(self._instGO, "Light")

		self._lightLoader = PrefabInstantiate.Create(go)
	end

	self._lightLoader:dispose()
	self._lightLoader:startLoad(assetPath, self._onLoadedLight, self)
end

function SurvivalShelterSceneLevel:_onLoadedLight()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.SceneLightLoaded, self._lightLoader:getInstGO())
end

function SurvivalShelterSceneLevel:onSceneClose()
	if self._lightLoader then
		self._lightLoader:dispose()

		self._lightLoader = nil
	end

	Shader.DisableKeyword("_SURVIAL_SCENE")
	Shader.DisableKeyword("_ENABLE_SURVIVAL_RAIN_DISTORTION")
	Shader.DisableKeyword("_ENABLE_SURVIVAL_RAIN_GLITCH")
	SurvivalShelterSceneLevel.super.onSceneClose(self)
end

return SurvivalShelterSceneLevel
