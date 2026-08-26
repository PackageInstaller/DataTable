-- chunkname: @modules/logic/scene/shelter/comp/SurvivalShelterScenePreloader.lua

module("modules.logic.scene.shelter.comp.SurvivalShelterScenePreloader", package.seeall)

local SurvivalShelterScenePreloader = class("SurvivalShelterScenePreloader", BaseSceneComp)

function SurvivalShelterScenePreloader:init(sceneId, levelId)
	self._loader = MultiAbLoader.New()

	if not GameResMgr.IsFromEditorDir then
		local mapCo = SurvivalConfig.instance:getShelterMapCo()
		local list = tabletool.copy(mapCo.allBuildingPaths)

		self._loader:setPathList(list)
		self._loader:addPath(self:getMapBlockAbPath())
	else
		local mapCo = SurvivalConfig.instance:getShelterMapCo()
		local list = tabletool.copy(mapCo.allBlockPaths)

		tabletool.addValues(list, mapCo.allBuildingPaths)
		self._loader:setPathList(list)
	end

	self._loader:addPath(SurvivalShelterSceneFogComp.FogResPath)

	for k, v in pairs(SurvivalShelterScenePathComp.ResPaths) do
		self._loader:addPath(v)
	end

	self.monsterEffectPath = "survival/effects/prefab/v2a8_scene_smoke_02.prefab"
	self.monsterFightSuccessPath = "survival/effects/prefab/v2a8_scene_zhandou.prefab"

	self._loader:addPath(self.monsterEffectPath)
	self._loader:addPath(self.monsterFightSuccessPath)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function SurvivalShelterScenePreloader:_onPreloadFinish()
	self:dispatchEvent(SurvivalEvent.OnSurvivalPreloadFinish)
end

function SurvivalShelterScenePreloader:getRes(path)
	if not self._loader or self._loader.isLoading then
		return
	end

	local assetItem = not GameResMgr.IsFromEditorDir and string.find(path, "survival/scenes/") and self._loader:getAssetItem(self:getMapBlockAbPath()) or self._loader:getAssetItem(path)

	if not assetItem then
		return
	end

	return assetItem:GetResource(path)
end

function SurvivalShelterScenePreloader:getMonsterEffect(parent)
	local asset = self:getRes(self.monsterEffectPath)

	return (gohelper.clone(asset, parent))
end

function SurvivalShelterScenePreloader:getMonsterFightSuccessPath(parent)
	local asset = self:getRes(self.monsterFightSuccessPath)

	return (gohelper.clone(asset, parent))
end

function SurvivalShelterScenePreloader:getMapBlockAbPath()
	return "survival/scenes/map07"
end

function SurvivalShelterScenePreloader:onSceneClose(sceneId, levelId)
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return SurvivalShelterScenePreloader
