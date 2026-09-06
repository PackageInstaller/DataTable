-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/stage/TilingSceneStage.lua

module("logicscene.scene.component.stage.TilingSceneStage", package.seeall)

local TilingSceneStage = class("TilingSceneStage", SceneCityStage)

function TilingSceneStage:load(sceneId, loadListener, loadListenerObj)
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

function TilingSceneStage:_getBasicResourceList()
	local tilingConfig = TilingSceneMgr.instance:getTilingMapConfig(self._sceneId)

	self._stageResUrls = tilingConfig.tilingMap

	local needLoadRes = {}
	local preloadFlags = {}

	if not SceneDatasCache.IsTilingDataLoaded(self._stageResUrls) then
		table.insert(needLoadRes, self._stageResUrls)
		table.insert(preloadFlags, false)
	end

	if not string.nilorempty(tilingConfig.airwall) then
		table.insert(needLoadRes, tilingConfig.airwall)
		table.insert(preloadFlags, true)
	end

	if not string.nilorempty(tilingConfig.sky) then
		table.insert(needLoadRes, tilingConfig.sky)
		table.insert(preloadFlags, true)
	end

	return needLoadRes, preloadFlags
end

function TilingSceneStage:unload()
	if self._skyGo then
		goutil.destroy(self._skyGo)

		self._skyGo = nil
	end

	TilingSceneStage.super.unload(self)
end

function TilingSceneStage:_modifyBirthPoints()
	local x = self._scene:getBornX()
	local y = self._scene:getBornZ()

	if not self._scene:isPositionReachable(nil, x or 0, y or 0) then
		local tilingMapConfig = TilingSceneMgr.instance:getTilingMapConfig(self._sceneId)

		self._scene._curBornX = tilingMapConfig.birthX
		self._scene._curBornZ = tilingMapConfig.birthY

		self._scene:setUnderBridge(false)
	end
end

function TilingSceneStage:getBirthPos()
	local x = self._scene:getBornX()
	local y = self._scene:getBornZ()

	if not self._scene:isPositionReachable(nil, x or 0, y or 0) then
		local tilingMapConfig = TilingSceneMgr.instance:getTilingMapConfig(self._sceneId)

		return tilingMapConfig.birthX or 0, tilingMapConfig.birthY or 0
	end

	return x or 0, y or 0
end

function TilingSceneStage:_getCameraSizeScale()
	return 3
end

function TilingSceneStage:_prepareElementsResourcesByDetector(x, y, sz, sy)
	local tilingMapConfig = TilingSceneMgr.instance:getTilingMapConfig(self._sceneId)
	local elems = SceneConfig.instance:getLanformTilingElems(tilingMapConfig.config.id)

	if elems then
		for i = 1, #elems do
			self:_addNeedLoadResource(elems[i].assetPath .. ".prefab")
		end
	end
end

function TilingSceneStage:_createWholeScele()
	local tilingMapConfig = TilingSceneMgr.instance:getTilingMapConfig(self._sceneId)

	tilingMapConfig:BuildQuadMap()
	TilingSceneMgr.instance:buildTilingMapElem(tilingMapConfig)

	self.wholeScene = AoSceneManager.Instance:CreateTilingSceneNoLoadIfNotExists(tilingMapConfig, self._scene._onNpcVisible, self._scene._onNpcCreate, self._scene._onNpcDestroy, self._scene._onNpcModel, self._scene)

	return self.wholeScene
end

function TilingSceneStage:onEnterSceneFinished()
	self:_buildSky()
	TilingSceneStage.super.onEnterSceneFinished(self)
end

function TilingSceneStage:_buildSky()
	local tilingMapConfig = TilingSceneMgr.instance:getTilingMapConfig(self._sceneId)

	if string.nilorempty(tilingMapConfig.sky) then
		return
	end

	local res = rescache:GetResourceNoLoadIfNotExists(tilingMapConfig.sky)
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

return TilingSceneStage
