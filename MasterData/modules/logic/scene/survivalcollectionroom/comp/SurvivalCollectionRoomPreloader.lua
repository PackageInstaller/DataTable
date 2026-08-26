-- chunkname: @modules/logic/scene/survivalcollectionroom/comp/SurvivalCollectionRoomPreloader.lua

module("modules.logic.scene.survivalcollectionroom.comp.SurvivalCollectionRoomPreloader", package.seeall)

local SurvivalCollectionRoomPreloader = class("SurvivalCollectionRoomPreloader", SurvivalShelterScenePreloader)

function SurvivalCollectionRoomPreloader:init(sceneId, levelId)
	local mapCo = SurvivalConfig.instance:getShelterMapCo()

	self._loader = MultiAbLoader.New()

	if not GameResMgr.IsFromEditorDir then
		local list = tabletool.copy(mapCo.allBuildingPaths)

		self._loader:setPathList(list)
		self._loader:addPath(self:getMapBlockAbPath())
	else
		local list = tabletool.copy(mapCo.allBuildingPaths)

		tabletool.addValues(list, self:getBlock())
		self._loader:setPathList(list)
	end

	local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo
	local roleRes = survivalShelterRoleMo:getRoleModelRes()

	self._loader:addPath(roleRes)
	self._loader:addPath(SurvivalShelterSceneFogComp.FogResPath)

	for k, v in pairs(SurvivalShelterScenePathComp.ResPaths) do
		self._loader:addPath(v)
	end

	for i, v in ipairs(mapCo.allBuildings) do
		if v:isCollection() and self:isShowHandbookBuild(v.cfgId) then
			local mo = SurvivalHandbookModel.instance:getHandbookByCollectionBuild(v.cfgId)
			local itemMo = mo:getSurvivalBagItemMo()
			local path = ResUrl.getSurvivalItemIcon(itemMo.co.icon)

			self._loader:addPath(path)
		end
	end

	self._loader:startLoad(self._onPreloadFinish, self)
end

function SurvivalCollectionRoomPreloader:isShowHandbookBuild(id)
	local mo = SurvivalHandbookModel.instance:getHandbookByCollectionBuild(id)

	if mo then
		return mo.isUnlock
	end
end

function SurvivalCollectionRoomPreloader:getBlock()
	local mapCo_SummaryAct = SurvivalConfig.instance:getShelterMapCo()

	return (tabletool.copy(mapCo_SummaryAct.allBlockPaths))
end

function SurvivalCollectionRoomPreloader:getRes(path)
	if not self._loader or self._loader.isLoading then
		return
	end

	local assetItem = not GameResMgr.IsFromEditorDir and string.find(path, "survival/scenes/") and self._loader:getAssetItem(self:getMapBlockAbPath()) or self._loader:getAssetItem(path)

	if not assetItem then
		return
	end

	return assetItem:GetResource(path)
end

function SurvivalCollectionRoomPreloader:onSceneClose(sceneId, levelId)
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return SurvivalCollectionRoomPreloader
