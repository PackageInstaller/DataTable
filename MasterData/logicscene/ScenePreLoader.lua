-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/transition/ScenePreLoader.lua

module("logicscene.scene.transition.ScenePreLoader", package.seeall)

local ScenePreLoader = class("ScenePreLoader")

function ScenePreLoader:ctor(sceneId, fromSceneId)
	self._sceneId = sceneId
	self._fromSceneId = fromSceneId
	self._stageResUrls = nil
	self._resLoader = nil
	self.wholeScene = nil
	self._resElementsLoader = nil
	self._resourcesList = {}
	self._uniqueRecord = {}
	self._preloadFlags = {}
	self._terrainResReady = nil
end

function ScenePreLoader:load(loadListener, loadListenerObj)
	self._loadListener = loadListener
	self._loadListenerObj = loadListenerObj

	local resources = GameUrl.getScenCityStageResUrls(self._sceneId)
	local preloadFlags = {}
	local needLoadRes = {}

	self._stageResUrls = resources

	for i = 1, #resources do
		if not SceneDatasCache.IsLoaded(resources[i]) then
			table.insert(needLoadRes, resources[i])
			table.insert(preloadFlags, true)
		end
	end

	self._resLoader = MultiResLoader.New()

	self._resLoader:setResPaths(needLoadRes, preloadFlags)
	self._resLoader:load(self._onStageResourceLoaded, nil, self)
end

function ScenePreLoader:_addNeedLoadResource(path)
	if not self._uniqueRecord[path] then
		self._uniqueRecord[path] = true

		table.insert(self._resourcesList, path)
		table.insert(self._preloadFlags, true)
	end
end

function ScenePreLoader:unload()
	GameUtil.unloadMultiResLoaderResource(self._resLoader)
	GameUtil.unloadMultiResLoaderResource(self._resElementsLoader)

	self._resLoader = nil
	self._resElementsLoader = nil
	self._stageResUrls = nil
	self._terrainResReady = nil
	self._resourcesList = nil
	self._uniqueRecord = nil
	self._preloadFlags = nil
	self.wholeScene = nil
end

function ScenePreLoader:_onStageResourceLoaded()
	self.wholeScene = AoSceneManager.Instance:CreateSceneOnlyNoLoadIfNotExists(self._stageResUrls, self._onNpcModel, self)

	local camSizeH, camSizeW, camDetSizeW, camDetSizeH = self:_getCameraSize()

	self:_preloadSceneResources(camSizeH, camSizeW, camDetSizeW, camDetSizeH)

	self._terrainResReady = true

	self:_startLoadAllResources()
end

function ScenePreLoader:_onNpcModel(npcId)
	return SceneConfig.instance:getNpcModelFromConfig(npcId)
end

function ScenePreLoader:_preloadSceneResources(camSizeH, camSizeW, camDetSizeW, camDetSizeH)
	self:_loadSceneScreenEff()

	local px, py = self:_getCameraInitPos(camSizeW, camSizeH)

	self:_prepareTerrainResourcesByDetector(px, py, camDetSizeW, camDetSizeH)
	self:_prepareElementsResourcesByDetector(px, py, camDetSizeW, camDetSizeH)
	self:_prepareNpcsResourcesByDetector(px, py, camDetSizeW, camDetSizeH)
end

function ScenePreLoader:_getCameraSize()
	local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCam = mainCamera:getCamera()
	local camSizeH = SceneMgr.instance:getSceneCameraParams(self._sceneId) * 2
	local camSizeW = mainCam.aspect * camSizeH
	local camDetSizeW = camSizeW * 1.5
	local camDetSizeH = camSizeH * 1.5

	return camSizeH, camSizeW, camDetSizeW, camDetSizeH
end

function ScenePreLoader:_getCameraInitPos(camSizeW, camSizeH)
	local px, py = SceneConfig.instance:getBornPoint(self._sceneId, self._fromSceneId)
	local minX, minY, maxX, maxY = self.wholeScene:GetCameraRange(nil, nil, nil, nil)

	minX = minX + camSizeW * 0.5
	minY = minY + camSizeH * 0.5
	maxX = maxX - camSizeW * 0.5
	maxY = maxY - camSizeH * 0.5
	px = math.max(px, minX)
	px = math.min(px, maxX)
	py = math.max(py, minY)
	py = math.min(py, maxY)

	return px, py
end

function ScenePreLoader:_prepareTerrainResourcesByDetector(x, y, sz, sy)
	local resources = self.wholeScene:GetResourcesByDetector(x, y, sz, sy)
	local cnt = resources.Count - 1

	for i = 0, cnt do
		self:_addNeedLoadResource(resources[i])
	end
end

function ScenePreLoader:_prepareElementsResourcesByDetector(x, y, sz, sy)
	local eleResources = self.wholeScene:GetTerrainElementsResourcesByDetector(x, y, sz, sy, 3)
	local cnt = eleResources.Count - 1

	for i = 0, cnt do
		self:_addNeedLoadResource(eleResources[i])
	end
end

function ScenePreLoader:_prepareNpcsResourcesByDetector(x, y, sz, sy)
	local npcResources = self.wholeScene:GetNpcsResourcesByDetector(false, x, y, sz, sy)
	local cnt = npcResources.Count - 1

	for i = 0, cnt do
		self:_addNeedLoadResource(npcResources[i])
	end
end

function ScenePreLoader:_prepareTransmitPointsResourcesByDetector(x, y, sz, sy)
	local sceneIds = self.wholeScene:GetTransmitPointByDetector(x, y, sz, sy)
	local cnt = sceneIds.Count - 1

	for i = 0, cnt do
		local sceneCo = SceneConfig.instance:getSceneCo(sceneIds[i])

		if sceneCo and sceneCo.showImage and #sceneCo.showImage > 0 then
			self:_addNeedLoadResource("scene/scene_icons/" .. sceneCo.showImage)
		end
	end
end

function ScenePreLoader:_loadSceneScreenEff()
	local sceneCo = SceneConfig.instance:getSceneCo(self._sceneId)

	if sceneCo ~= nil and string.nilorempty(sceneCo.screenEff) == false then
		self:_addNeedLoadResource(GameUrl.getSceneEffectUrl(sceneCo.screenEff))
	end
end

function ScenePreLoader:_startLoadAllResources()
	if self._terrainResReady then
		self._resElementsLoader = MultiResLoader.New()

		self._resElementsLoader:setResPaths(self._resourcesList, self._preloadFlags)
		self._resElementsLoader:load(self._onAllResourceLoaded, self._onResourceLoaded, self)
	end
end

function ScenePreLoader:_onResourceLoaded()
	local progress = self._resElementsLoader.loadedCount / self._resElementsLoader.totalCount

	self:_notifyLoadingProgress(progress)
end

function ScenePreLoader:_notifyLoadingProgress(progress)
	if self._loadListener then
		if self._loadListenerObj then
			self._loadListener(self._loadListenerObj, progress)
		else
			self._loadListener(progress)
		end
	end
end

function ScenePreLoader:_onAllResourceLoaded()
	self:_notifyLoadingProgress(1)
end

return ScenePreLoader
