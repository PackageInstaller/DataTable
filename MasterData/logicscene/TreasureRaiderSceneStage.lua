-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/stage/TreasureRaiderSceneStage.lua

module("logicscene.scene.component.stage.TreasureRaiderSceneStage", package.seeall)

local TreasureRaiderSceneStage = class("TreasureRaiderSceneStage", SceneCityStage)

function TreasureRaiderSceneStage:load(sceneId, loadListener, loadListenerObj)
	self._loadListener = loadListener
	self._loadListenerObj = loadListenerObj
	self._sceneId = sceneId

	local needLoadRes, preloadFlags = self:_getBasicResourceList()

	if #needLoadRes > 0 then
		self._resLoader = MultiResLoader.New()

		self._resLoader:setResPaths(needLoadRes, preloadFlags)
		self._resLoader:load(self._onStageResourceLoaded, nil, self)
	else
		self:_onStageResourceLoaded()
	end

	GlobalDispatcher:dispatch(GlobalNotify.SceneStartLoaded)
end

function TreasureRaiderSceneStage:_getBasicResourceList()
	local tilingSceneConfig = TilingSceneMgr.instance:getTilingSceneConfig(self._sceneId)

	self._stageResUrls = tilingSceneConfig.assetPath

	local needLoadRes = {}
	local preloadFlags = {}

	for i = 1, #self._stageResUrls do
		if not SceneDatasCache.IsLoaded(self._stageResUrls[i]) then
			table.insert(needLoadRes, self._stageResUrls[i])
			table.insert(preloadFlags, true)
		end
	end

	table.insert(needLoadRes, tilingSceneConfig.sky)
	table.insert(preloadFlags, true)
	table.insert(needLoadRes, UnitCompTreasureRaiderGridState.RoutePath)
	table.insert(preloadFlags, true)
	table.insert(needLoadRes, UnitCompTreasureRaiderBuildingState.FocusResPath)
	table.insert(preloadFlags, true)
	table.insert(needLoadRes, UnitCompTreasureRaiderBuilding.GainResourcePath)
	table.insert(preloadFlags, true)
	table.insert(needLoadRes, UnitCompTreasureRaiderBuilding.StopProduceResPath)
	table.insert(preloadFlags, true)
	table.insert(needLoadRes, SceneCompTreasureRaiderGridUnitsMgr.StageResPath)
	table.insert(preloadFlags, true)
	table.insert(needLoadRes, UnitTreasureRaiderPlayer.DefaultPlayerResPath)
	table.insert(preloadFlags, true)
	table.insert(needLoadRes, UnitTreasureRaiderProduce.ProduceResPath)
	table.insert(preloadFlags, true)

	local tool = self._scene:getTool()
	local buildingTypesMap = tool:getBuildingConfigMapByAllTypes()

	for _, array in pairs(buildingTypesMap) do
		for _, config in ipairs(array) do
			local url = string.format(UnitCompTreasureRaiderBuilding.BuildingPathFormat, config.scenePrefabPath)

			table.insert(needLoadRes, url)
			table.insert(preloadFlags, true)
		end
	end

	return needLoadRes, preloadFlags
end

function TreasureRaiderSceneStage:_preloadSceneResources(camSizeH, camSizeW, camDetSizeW, camDetSizeH)
	TreasureRaiderSceneStage.super._preloadSceneResources(self, camSizeH, camSizeW, camDetSizeW, camDetSizeH)

	local sceneData = SceneDatasCacheMgr.instance:getSceneData(self._stageResUrls[1])

	for i = 1, #sceneData.elements do
		if string.find(sceneData.elements[i].assetPath, "_tile_") then
			self:_addNeedLoadResource(sceneData.elements[i].assetPath)
		end
	end
end

function TreasureRaiderSceneStage:unload()
	if self._skyGo then
		goutil.destroy(self._skyGo)

		self._skyGo = nil
	end

	TreasureRaiderSceneStage.super.unload(self)
end

function TreasureRaiderSceneStage:_modifyBirthPoints()
	local x = self._scene:getBornX()
	local y = self._scene:getBornZ()

	if not self._scene:isPositionReachable(nil, x or 0, y or 0) then
		self._scene._curBornX = 5
		self._scene._curBornZ = 5

		self._scene:setUnderBridge(false)
	end
end

function TreasureRaiderSceneStage:getBirthPos()
	local x = self._scene:getBornX()
	local y = self._scene:getBornZ()

	if not self._scene:isPositionReachable(nil, x or 0, y or 0) then
		return 5, 5
	end

	return x or 0, y or 0
end

function TreasureRaiderSceneStage:_createWholeScele()
	SceneDatasCacheMgr.instance:getSceneData(self._stageResUrls[1])

	return TreasureRaiderSceneStage.super._createWholeScele(self)
end

function TreasureRaiderSceneStage:onEnterSceneFinished()
	self:_buildSky()
	TreasureRaiderSceneStage.super.onEnterSceneFinished(self)
end

function TreasureRaiderSceneStage:_buildSky()
	local tilingSceneConfig = TilingSceneMgr.instance:getTilingSceneConfig(self._sceneId)

	if string.nilorempty(tilingSceneConfig.sky) then
		return
	end

	local res = rescache:GetResourceNoLoadIfNotExists(tilingSceneConfig.sky)
	local mainAsset = res:GetMainAsset()

	if not mainAsset then
		return
	end

	self._skyGo = UnityEngine.GameObject.Instantiate(mainAsset)

	Framework.GameObjectUtil.SetLayerRecursively(self._skyGo, SceneLayer.Ground_Value)
	self._skyGo.transform:SetParent(self._scene:getContainer().transform)
	Framework.TransformUtil.SetLocalScale(self._skyGo.transform, 1.55, 1.55, 1)
	Framework.TransformUtil.SetLocalPos(self._skyGo.transform, 4.63, 7.97, 8.7)
end

return TreasureRaiderSceneStage
