-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/stage/GuardCitySceneStage.lua

module("logicscene.scene.component.stage.GuardCitySceneStage", package.seeall)

local GuardCitySceneStage = class("GuardCitySceneStage", SceneCityStage)

function GuardCitySceneStage:load(sceneId, loadListener, loadListenerObj)
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

function GuardCitySceneStage:_getBasicResourceList()
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

	return needLoadRes, preloadFlags
end

function GuardCitySceneStage:_preloadSceneResources(camSizeH, camSizeW, camDetSizeW, camDetSizeH)
	GuardCitySceneStage.super._preloadSceneResources(self, camSizeH, camSizeW, camDetSizeW, camDetSizeH)

	local sceneData = SceneDatasCacheMgr.instance:getSceneData(self._stageResUrls[1])

	for i = 1, #sceneData.elements do
		if string.find(sceneData.elements[i].assetPath, "_tile_") then
			self:_addNeedLoadResource(sceneData.elements[i].assetPath)
		end
	end
end

function GuardCitySceneStage:unload()
	if self._skyGo then
		goutil.destroy(self._skyGo)

		self._skyGo = nil
	end

	GuardCitySceneStage.super.unload(self)
end

function GuardCitySceneStage:_modifyBirthPoints()
	local x = self._scene:getBornX()
	local y = self._scene:getBornZ()

	if not self._scene:isPositionReachable(nil, x or 0, y or 0) then
		self._scene._curBornX = 5
		self._scene._curBornZ = 5

		self._scene:setUnderBridge(false)
	end
end

function GuardCitySceneStage:getBirthPos()
	local x = self._scene:getBornX()
	local y = self._scene:getBornZ()

	if not self._scene:isPositionReachable(nil, x or 0, y or 0) then
		return 5, 5
	end

	return x or 0, y or 0
end

function GuardCitySceneStage:_createWholeScele()
	SceneDatasCacheMgr.instance:getSceneData(self._stageResUrls[1])

	return GuardCitySceneStage.super._createWholeScele(self)
end

function GuardCitySceneStage:onEnterSceneFinished()
	self:_buildSky()
	GuardCitySceneStage.super.onEnterSceneFinished(self)
end

function GuardCitySceneStage:_buildSky()
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

return GuardCitySceneStage
