-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/stage/SeasonTilingSceneStage.lua

module("logicscene.scene.component.stage.SeasonTilingSceneStage", package.seeall)

local SeasonTilingSceneStage = class("SeasonTilingSceneStage", SceneCityStage)

function SeasonTilingSceneStage:load(sceneId, loadListener, loadListenerObj)
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

function SeasonTilingSceneStage:_getBasicResourceList()
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
	table.insert(needLoadRes, tilingSceneConfig.pathFindingAsset)
	table.insert(preloadFlags, true)
	table.insert(needLoadRes, UnitCompSeasonState.selectResPath)
	table.insert(preloadFlags, true)
	table.insert(needLoadRes, UnitCompSeasonState.signResPath)
	table.insert(preloadFlags, true)
	table.insert(needLoadRes, UnitCompSeasonState.placedResPath)
	table.insert(preloadFlags, true)
	table.insert(needLoadRes, UnitCompSeasonOccupied.occupiedResPath)
	table.insert(preloadFlags, true)
	table.insert(needLoadRes, SceneCompNavigatePath.navigateResPath)
	table.insert(preloadFlags, true)
	table.insert(needLoadRes, "scene/season/season_player_head.prefab")
	table.insert(preloadFlags, true)

	return needLoadRes, preloadFlags
end

function SeasonTilingSceneStage:_preloadSceneResources(camSizeH, camSizeW, camDetSizeW, camDetSizeH)
	SeasonTilingSceneStage.super._preloadSceneResources(self, camSizeH, camSizeW, camDetSizeW, camDetSizeH)

	local sceneData = SceneDatasCacheMgr.instance:getSceneData(self._stageResUrls[1])

	for i = 1, #sceneData.elements do
		if string.find(sceneData.elements[i].assetPath, "_tile_") then
			self:_addNeedLoadResource(sceneData.elements[i].assetPath)
		end
	end
end

function SeasonTilingSceneStage:unload()
	if self._skyGo then
		goutil.destroy(self._skyGo)

		self._skyGo = nil
	end

	SeasonTilingSceneStage.super.unload(self)
end

function SeasonTilingSceneStage:_modifyBirthPoints()
	local x = self._scene:getBornX()
	local y = self._scene:getBornZ()

	if not self._scene:isPositionReachable(nil, x or 0, y or 0) then
		self._scene._curBornX = 5
		self._scene._curBornZ = 5

		self._scene:setUnderBridge(false)
	end
end

function SeasonTilingSceneStage:getBirthPos()
	local x = self._scene:getBornX()
	local y = self._scene:getBornZ()

	if not self._scene:isPositionReachable(nil, x or 0, y or 0) then
		return 5, 5
	end

	return x or 0, y or 0
end

function SeasonTilingSceneStage:_createWholeScele()
	SceneDatasCacheMgr.instance:getSceneData(self._stageResUrls[1])

	return SeasonTilingSceneStage.super._createWholeScele(self)
end

function SeasonTilingSceneStage:onEnterSceneFinished()
	self:_buildSky()
	SeasonTilingSceneStage.super.onEnterSceneFinished(self)
end

function SeasonTilingSceneStage:_buildSky()
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

	Framework.GameObjectUtil.SetLayerRecursively(self._skyGo, SceneLayer.Ground3D_Value)
	self._skyGo.transform:SetParent(GlobalModel.instance.groundCamera.transform)
	Framework.TransformUtil.SetLocalScale(self._skyGo.transform, 1, 1, 1)
	Framework.TransformUtil.SetLocalPos(self._skyGo.transform, 0, 0, 8.7)
end

return SeasonTilingSceneStage
