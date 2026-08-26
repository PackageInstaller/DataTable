-- chunkname: @modules/logic/scene/survival/comp/SurvivalScenePreloader.lua

module("modules.logic.scene.survival.comp.SurvivalScenePreloader", package.seeall)

local SurvivalScenePreloader = class("SurvivalScenePreloader", BaseSceneComp)

function SurvivalScenePreloader:init(sceneId, levelId)
	self._mapGroupId = nil

	self:initMapGroupId()

	self._loader = MultiAbLoader.New()

	if not GameResMgr.IsFromEditorDir then
		self._loader:addPath(self:getMapBlockAbPath())
		self._loader:addPath(self:getMapBlockCommonAbPath())
	else
		local mapCo = SurvivalMapModel.instance:getCurMapCo()

		self._loader:setPathList(tabletool.copy(mapCo.allPaths))

		for i, v in ipairs(lua_survival_block.configList) do
			local group = tonumber(v.copyIds) or 0

			if group == 0 or group == self._mapGroupId then
				self._loader:addPath(self:getBlockResPath(group, v.resource))
			end
		end

		self._loader:addPath(self:getBlockResPath(0, "survival_cloud"))
		self._loader:addPath(self:getBlockResPath(0, "survival_kengdong"))
	end

	self:addPlayerRes()
	self._loader:addPath(SurvivalSceneFogComp.FogResPath)
	self._loader:addPath(SurvivalSceneMapSpBlock.EdgeResPath)

	for k, v in pairs(SurvivalSceneMapPath.ResPaths) do
		self._loader:addPath(v)
	end

	for k, v in pairs(SurvivalPointEffectComp.ResPaths) do
		self._loader:addPath(v)
	end

	self._loader:startLoad(self._onPreloadFinish, self)
end

function SurvivalScenePreloader:addPlayerRes()
	local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo
	local roleRes = survivalShelterRoleMo:getRoleModelRes()

	self._loader:addPath(roleRes)
	self._loader:addPath(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.Vehicle_Miasma))
	self._loader:addPath(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.Vehicle_Morass))
	self._loader:addPath(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.Vehicle_Magma))
	self._loader:addPath(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.Vehicle_Ice))
	self._loader:addPath(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.Vehicle_Water))
	self._loader:addPath(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.Vehicle_WaterNormal))
end

function SurvivalScenePreloader:_onPreloadFinish()
	self:dispatchEvent(SurvivalEvent.OnSurvivalPreloadFinish)
end

function SurvivalScenePreloader:getRes(path)
	if not self._loader or self._loader.isLoading then
		return
	end

	local assetItem = not GameResMgr.IsFromEditorDir and string.find(path, "survival/scenes/") and self._loader:getAssetItem(self:getMapBlockAbPath()) or self._loader:getAssetItem(path)

	if not assetItem then
		return
	end

	return assetItem:GetResource(path)
end

function SurvivalScenePreloader:getBlockRes(group, prefabName)
	if not group then
		return
	end

	if not self._loader or self._loader.isLoading then
		return
	end

	local assetItem
	local abPath = group == 0 and self:getMapBlockCommonAbPath() or self:getMapBlockAbPath()
	local resPath = self:getBlockResPath(group, prefabName)

	assetItem = not GameResMgr.IsFromEditorDir and string.find(resPath, "survival/scenes/") and self._loader:getAssetItem(abPath) or self._loader:getAssetItem(resPath)

	if not assetItem then
		return
	end

	return assetItem:GetResource(resPath)
end

function SurvivalScenePreloader:getBlockResPath(group, prefabName)
	local abPath = group == 0 and self:getMapBlockCommonAbPath() or self:getMapBlockAbPath()

	return (string.format("%s/prefab/%s.prefab", abPath, prefabName))
end

function SurvivalScenePreloader:getMapBlockAbPath()
	return "survival/scenes/map0" .. (self._mapGroupId or 1)
end

function SurvivalScenePreloader:initMapGroupId()
	if not self._mapGroupId then
		local mapId = SurvivalMapModel.instance:getCurMapId()
		local groupId = lua_survival_map_group_mapping.configDict[mapId].id
		local co = lua_survival_map_group.configDict[groupId]

		self._mapGroupId = co.type
	end
end

function SurvivalScenePreloader:getMapBlockCommonAbPath()
	return "survival/scenes/map_common"
end

function SurvivalScenePreloader:onSceneClose(sceneId, levelId)
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._mapGroupId = nil
end

return SurvivalScenePreloader
