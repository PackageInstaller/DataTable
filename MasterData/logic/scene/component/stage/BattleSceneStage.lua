-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/component/stage/BattleSceneStage.lua

module("logic.scene.component.stage.BattleSceneStage", package.seeall)

local BattleSceneStage = class("BattleSceneStage", SceneStageBase)
local kEmptySceneName = "sx-s112_space_c_01_run"
local kEmptyScenePath = "sx-s112_space/scene_run/sx-s112_space_c_01_run"

function BattleSceneStage:onInit()
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

function BattleSceneStage:onLeaveScene(isDeepClean)
	if isDeepClean then
		self:onExitScene()
		SpaceX.HeightMapProxy.SetActiveHeightMapProxy(nil)
	else
		local resultMO = BattleMgr.instance:getModel():getResultMO()

		if resultMO:isRealEnd() then
			self:disactiveScene()
		else
			SpaceX.SceneObjectCollection.SetSceneEnable(self._mainSceneName, false)
		end
	end
end

function BattleSceneStage:onReturnScene(isDeepClean)
	if isDeepClean then
		local sceneId = self._scene:getSceneId()

		self:onEnterScene(sceneId)
	else
		local resultMO = BattleMgr.instance:getModel():getResultMO()

		if resultMO:isRealEnd() then
			self:activeCacheScene()
		else
			SpaceX.SceneObjectCollection.SetSceneEnable(self._mainSceneName, true)
		end
	end
end

function BattleSceneStage:onReturnSceneFinished(isDeepClean)
	if isDeepClean then
		SpaceX.HeightMapProxy.SetActiveHeightMapProxy(self:getBaseHeightMapGameObject())
	end
end

function BattleSceneStage:onSetupSceneOptimization()
	SceneUtil.setupSceneOptimization(self._mainSceneName)
	SceneUtil.setupSceneOptimization(self._additionSceneName)
end

function BattleSceneStage:load(sceneId)
	local checkerBoardCO = BattleConfig.instance:getCheckerBoardCO(sceneId)

	self._mainSceneName = checkerBoardCO.sceneResName
	self._additionSceneName = checkerBoardCO.battleSceneResName
	self._activeSceneName = false

	if checkerBoardCO.isProgramScene or BattleTestUtil.isUseProgramScene() then
		self._mainSceneName = kEmptySceneName
		self._targetScenes = {
			GameUrl.getSceneUrl(kEmptyScenePath),
			GameUrl.getSceneUrl(checkerBoardCO.battleSceneResPath)
		}
	else
		self._targetScenes = {
			GameUrl.getSceneUrl(checkerBoardCO.sceneResPath),
			GameUrl.getSceneUrl(checkerBoardCO.battleSceneResPath)
		}
	end

	local resPath = table.remove(self._targetScenes, 1)

	self:_loadOneScene(resPath)
end

function BattleSceneStage:getSceneName()
	return self._mainSceneName
end

function BattleSceneStage:getAdditionSceneName()
	return self._additionSceneName
end

function BattleSceneStage:_loadOneScene(resPath)
	if not resPath or not self._resLoader then
		return
	end

	self._resLoader:setResPaths({
		resPath
	})

	self._resLoader.successCount = 0

	self._resLoader:load(self._onAllResourceLoaded, nil, self)
end

function BattleSceneStage:_onAllResourceLoaded()
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
	self:_tryBuildEmptyScene()
	self:_onBuildEffectControl()
	self:_onAllLoaded()
	self:activeMainScene()
	BattleDispatcher:dispatchEvent(BattleEventType.OnBattleSceneEnterFinish)
end

function BattleSceneStage:unload()
	self._targetScenes = {}

	self._resLoader:clear()
	BattleTableUtil.clearTable(self._effectControlList)
end

function BattleSceneStage:isActiveMainScene()
	return self._activeSceneName == self._mainSceneName
end

function BattleSceneStage:activeMainScene()
	if BattleTestUtil.isHideScene() then
		self:_debugHideScene()

		return
	end

	self._activeSceneName = self._mainSceneName

	SceneLoadUtils.SetActiveScene(self._mainSceneName)
	SpaceX.SceneObjectCollection.SetSceneEnable(self._mainSceneName, true)
	SpaceX.SceneObjectCollection.SetSceneEnable(self._additionSceneName, false)
end

function BattleSceneStage:activeAdditionScene()
	if BattleTestUtil.isHideScene() then
		self:_debugHideScene()

		return
	end

	self._activeSceneName = self._additionSceneName

	SceneLoadUtils.SetActiveScene(self._additionSceneName)
	SpaceX.SceneObjectCollection.SetSceneEnable(self._mainSceneName, false)
	SpaceX.SceneObjectCollection.SetSceneEnable(self._additionSceneName, true)
end

function BattleSceneStage:disactiveScene()
	SpaceX.SceneObjectCollection.SetSceneEnable(self._mainSceneName, false)
	SpaceX.SceneObjectCollection.SetSceneEnable(self._additionSceneName, false)
end

function BattleSceneStage:activeCacheScene()
	SceneLoadUtils.SetActiveScene(self._activeSceneName)
	SpaceX.SceneObjectCollection.SetSceneEnable(self._mainSceneName, self._mainSceneName == self._activeSceneName)
	SpaceX.SceneObjectCollection.SetSceneEnable(self._additionSceneName, self._additionSceneName == self._activeSceneName)
end

function BattleSceneStage:setPlaySpeed(speed)
	for _, effectControl in pairs(self._effectControlList) do
		effectControl:SetPlaySpeed(speed)
	end
end

function BattleSceneStage:getAdditionSceneCenterPosition()
	return self._additionSceneCenterPosition:Get()
end

function BattleSceneStage:getBaseHeightMapGameObject()
	return self._goMainSceneBaseHeightMap
end

function BattleSceneStage:_parseSpecialSceneObjects()
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

function BattleSceneStage:_onCellLoaded(goCell)
	SpaceX.SceneObjectCollection.OnChildrenAdded(self._mainSceneName, goCell)
end

function BattleSceneStage:_onCellUnloaded()
	SpaceX.SceneObjectCollection.OnChildrenUnloaded(self._mainSceneName, goCell)
end

function BattleSceneStage:_onBuildEffectControl()
	local goList = {}

	GameObjectUtils.FindChildRecursivelyBySceneName(self._mainSceneName, 5, ".*(trigger|effect).*", goList)
	GameObjectUtils.FindChildRecursivelyBySceneName(self._additionSceneName, 5, ".*(trigger|effect).*", goList)

	for _, go in ipairs(goList) do
		local effectControl = EffectControl.Get(go)

		effectControl:SetPlaySpeed(BattleTime.timeScale)
		table.insert(self._effectControlList, effectControl)
	end
end

function BattleSceneStage:_tryBuildEmptyScene()
	if self._mainSceneName ~= kEmptySceneName then
		return
	end

	local terrainPrefabList = {}
	local goList = {}

	GameObjectUtils.FindChildRecursivelyBySceneName(self._mainSceneName, 5, "gridCells", goList)

	if #goList ~= 1 then
		printError("程序场景战斗找不到正确的gridCells")

		return
	end

	for i = 0, goList[1].transform.childCount - 1 do
		local terrainGo = goList[1].transform:GetChild(i)

		table.insert(terrainPrefabList, terrainGo)
	end

	local sceneId = self._scene:getSceneId()

	BattleEmptySceneBuilder.build(kEmptySceneName, sceneId, terrainPrefabList)
end

function BattleSceneStage:_debugHideScene()
	local goList = {}

	GameObjectUtils.FindChildRecursivelyBySceneName(self._mainSceneName, 1, ".*[^SceneLighting].*", goList)
	GameObjectUtils.FindChildRecursivelyBySceneName(self._additionSceneName, 1, ".*", goList)

	for _, go in ipairs(goList) do
		goutil.setActive(go, false)
	end
end

return BattleSceneStage
