-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlecalculateeditor/scene/BattleCalculateEditorSceneStage.lua

module("logic.extensions.battlecalculateeditor.scene.BattleCalculateEditorSceneStage", package.seeall)

local M = class("BattleCalculateEditorSceneStage", SceneStageBase)
local kEmptySceneName = "sx-s112_space_c_01_run"
local kEmptyScenePath = "sx-s112_space/scene_run/sx-s112_space_c_01_run"

function M:onInit()
	self._resLoader = MultiResLoader.New()
	self._effectControlList = {}
	self._mainSceneName = false
	self._additionSceneName = false
	self._additionSceneCenterPosition = Vector3.New()
	self._activeSceneName = false
	self._goMainSceneBaseHeightMap = false
	self._worldStreamer = false
	self._targetScenes = {}
end

function M:onLeaveScene(isDeepClean)
	if isDeepClean then
		self:onExitScene()
		SpaceX.HeightMapProxy.SetActiveHeightMapProxy(nil)
	else
		SpaceX.SceneObjectCollection.SetSceneEnable(self._mainSceneName, false)
	end
end

function M:onReturnScene(isDeepClean)
	if isDeepClean then
		local sceneId = self._scene:getSceneId()

		self:onEnterScene(sceneId)
	else
		SpaceX.SceneObjectCollection.SetSceneEnable(self._mainSceneName, true)
	end
end

function M:onReturnSceneFinished(isDeepClean)
	if isDeepClean then
		SpaceX.HeightMapProxy.SetActiveHeightMapProxy(self:getBaseHeightMapGameObject())
	end
end

function M:onSetupSceneOptimization()
	SceneUtil.setupSceneOptimization(self._mainSceneName)
	SceneUtil.setupSceneOptimization(self._additionSceneName)
end

function M:load(sceneId)
	local flow = BattleMgr.instance:getActiveBattleFlow()
	local battleSceneResName = flow.model:getSceneName()
	local battleResPath = flow.model:getScenePath()

	self._mainSceneName = kEmptySceneName
	self._additionSceneName = battleSceneResName
	self._activeSceneName = false
	self._targetScenes = {
		GameUrl.getSceneUrl(kEmptyScenePath),
		GameUrl.getSceneUrl(battleResPath)
	}

	local resPath = table.remove(self._targetScenes, 1)

	self:_loadOneScene(resPath)
end

function M:getSceneName()
	return self._mainSceneName
end

function M:getAdditionSceneName()
	return self._additionSceneName
end

function M:_loadOneScene(resPath)
	if not resPath or not self._resLoader then
		return
	end

	self._resLoader:setResPaths({
		resPath
	})

	self._resLoader.successCount = 0

	self._resLoader:load(self._onAllResourceLoaded, nil, self)
end

function M:_onAllResourceLoaded()
	if not self._resLoader:isAllSuccess() and enableErrorLog then
		printError("load resource failed!")
	end

	if #self._targetScenes > 0 then
		local resPath = table.remove(self._targetScenes, 1)

		self:_loadOneScene(resPath)

		return
	end

	self:onSetupSceneOptimization()
	self:onSetupSceneOptimization()
	self:_parseSpecialSceneObjects()
	self:_onBuildEffectControl()
	self:_onAllLoaded()
	self:activeMainScene()
	BattleDispatcher:dispatchEvent(BattleEventType.OnBattleSceneEnterFinish)
end

function M:unload()
	self._targetScenes = {}

	self._resLoader:clear()
	BattleTableUtil.clearTable(self._effectControlList)
end

function M:isActiveMainScene()
	return self._activeSceneName == self._mainSceneName
end

function M:activeMainScene()
	if BattleTestUtil.isHideScene() then
		self:_debugHideScene()

		return
	end

	self._activeSceneName = self._mainSceneName

	SceneLoadUtils.SetActiveScene(self._mainSceneName)
	SpaceX.SceneObjectCollection.SetSceneEnable(self._mainSceneName, true)
	SpaceX.SceneObjectCollection.SetSceneEnable(self._additionSceneName, false)
end

function M:activeAdditionScene()
	self._activeSceneName = self._additionSceneName

	SceneLoadUtils.SetActiveScene(self._additionSceneName)
	SpaceX.SceneObjectCollection.SetSceneEnable(self._mainSceneName, false)
	SpaceX.SceneObjectCollection.SetSceneEnable(self._additionSceneName, true)
	SceneLoadUtils.SetSceneVisible(self._mainSceneName, false)
end

function M:setPlaySpeed(speed)
	for _, effectControl in pairs(self._effectControlList) do
		effectControl:SetPlaySpeed(speed)
	end
end

function M:getAdditionSceneCenterPosition()
	return self._additionSceneCenterPosition:Get()
end

function M:getBaseHeightMapGameObject()
	return self._goMainSceneBaseHeightMap
end

function M:_parseSpecialSceneObjects()
	local goAdditionalSceneCenter = GameObjectUtils.FindChildRecursivelyBySceneName(self._additionSceneName, 10, BattleScene.PerformancePositionName)

	if goAdditionalSceneCenter then
		self._additionSceneCenterPosition:Set(TransformUtils.GetPosition(goAdditionalSceneCenter.transform, 0, 0, 0))
	else
		self._additionSceneCenterPosition:Set(0, 0, 0)
	end

	self._goMainSceneBaseHeightMap = GameObjectUtils.FindChildRecursivelyBySceneName(self._mainSceneName, 5, BattleScene.BaseHeightMapProxyName)

	local goWorldStreamer = GameObjectUtils.FindChildRecursivelyBySceneName(self._mainSceneName, 5, BattleScene.WorldStreamerName)

	if goWorldStreamer then
		local cameraFollow = VirtualCameraMgr.instance:internal_getCameraFollow()

		self._worldStreamer = goutil.addComponentOnce(goWorldStreamer, ComponentType.WorldStreamer)
		self._worldStreamer.loadWaitFrames = 0
		self._worldStreamer.maxParallelLoading = 10

		self._worldStreamer:SetSplitLoadedCallback(self._onCellLoaded, self)
		self._worldStreamer:SetSplitUnloadCallback(self._onCellUnloaded, self)
		self._worldStreamer:ManualLoadLayer(BattleScene.HighImportanceLayerName)

		self._worldStreamer.Player = cameraFollow:internal_getTargetTransform()
		self._layerCullingSys = goutil.addComponentOnce(goWorldStreamer, ComponentType.LayerCullingSystem)
		self._layerCullingSys.MainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
	end
end

function M:_onCellLoaded(goCell)
	SpaceX.SceneObjectCollection.OnChildrenAdded(self._mainSceneName, goCell)
end

function M:_onCellUnloaded()
	SpaceX.SceneObjectCollection.OnChildrenUnloaded(self._mainSceneName, goCell)
end

function M:_onBuildEffectControl()
	local goList = {}

	GameObjectUtils.FindChildRecursivelyBySceneName(self._mainSceneName, 5, ".*(trigger|effect).*", goList)
	GameObjectUtils.FindChildRecursivelyBySceneName(self._additionSceneName, 5, ".*(trigger|effect).*", goList)

	for _, go in ipairs(goList) do
		local effectControl = EffectControl.Get(go)

		effectControl:SetPlaySpeed(BattleTime.timeScale)
		table.insert(self._effectControlList, effectControl)
	end
end

return M
