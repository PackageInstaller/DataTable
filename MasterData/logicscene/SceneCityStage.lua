-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/stage/SceneCityStage.lua

module("logicscene.scene.component.stage.SceneCityStage", package.seeall)

local SceneCityStage = class("SceneCityStage", SceneStageBase)

function SceneCityStage:ctor(scene)
	SceneCityStage.super.ctor(self, scene)

	self._stageResUrls = nil
	self._resLoader = nil
	self.wholeScene = nil
	self._resElementsLoader = nil
	self._resourcesList = {}
	self._uniqueRecord = {}
	self._preloadFlags = {}
	self._terrainResReady = nil
end

function SceneCityStage:onInit()
	self._unitFactory = self._scene.unitFactory
end

function SceneCityStage:onEnterScene(sceneId)
	self._isSceneEntering = true
end

function SceneCityStage:onExitScene()
	self._loadListener = nil
	self._loadListenerObj = nil
	self._isSceneEntering = nil
end

function SceneCityStage:onEnterSceneFinished()
	self:_createSceneScreenEff()
	self:_clearSceneResources()
	self:_showGM(true)

	if StoryController.instance.firstStoryId and not TaskController.instance:hasDoFirstTaskTarget() and not StoryController.instance:isPlaying(StoryController.instance.firstStoryId) then
		StoryController.instance:startStory(StoryController.instance.firstStoryId)
	end

	GameUtil.unloadMultiResLoaderResource(self._tempJumperUIResloader)

	self._tempJumperUIResloader = nil
end

function SceneCityStage:load(sceneId, loadListener, loadListenerObj)
	self._loadListener = loadListener
	self._loadListenerObj = loadListenerObj

	local resources = self:_getStageResources(sceneId)
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
	GlobalDispatcher:dispatch(GlobalNotify.SceneStartLoaded)
end

function SceneCityStage:_getStageResources(sceneId)
	return GameUrl.getScenCityStageResUrls(sceneId, self._scene:getFestival())
end

function SceneCityStage:_addNeedLoadResource(path)
	if not self._uniqueRecord[path] then
		self._uniqueRecord[path] = true

		table.insert(self._resourcesList, path)
		table.insert(self._preloadFlags, true)
	end
end

function SceneCityStage:_addSceneResource(path)
	self._sceneResRecord = self._sceneResRecord or {}
	self._sceneResRecord[path] = self._sceneResRecord[path] or true
end

function SceneCityStage:unload()
	ViewMgr.instance:close(ViewName.VirtualJoystick)
	self:_showGM(false)
	GameUtil.unloadMultiResLoaderResource(self._resLoader)
	GameUtil.unloadMultiResLoaderResource(self._resElementsLoader)
	GameUtil.unloadMultiResLoaderResource(self._resDyanimocLoader)
	GameUtil.unloadMultiResLoaderResource(self._tempJumperUIResloader)

	self._resLoader = nil
	self._resDyanimocLoader = nil
	self._resElementsLoader = nil
	self._tempJumperUIResloader = nil
	self._stageResUrls = nil
	self._terrainResReady = nil
	self._resourcesList = {}
	self._uniqueRecord = {}
	self._preloadFlags = {}

	self:_destroySceneScreenEff()
	AoSceneManager.Instance:DestroyScene(self.wholeScene)

	self.wholeScene = nil
end

function SceneCityStage:loadRes(path, callback, callbacktarget)
	self._resDyanimocLoader = self._resDyanimocLoader or MultiResLoader.New()

	local resource = self._resDyanimocLoader:getResource(path)

	if not resource then
		self._resDyanimocLoader._resTypeList = {}

		self._resDyanimocLoader:addResPath(path, true)

		self._resDyanimocLoader.loadedCount = 0

		self._resDyanimocLoader:load(nil, callback, callbacktarget)
	elseif callback then
		if callbacktarget then
			callback(callbacktarget, resource)
		else
			callback(resource)
		end
	end
end

function SceneCityStage:getRes(path)
	if self._resDyanimocLoader then
		return self._resDyanimocLoader:getResource(path)
	end
end

function SceneCityStage:unloadRes(path)
	if not self._scene.isReady or not self._resDyanimocLoader then
		return
	end

	local resource = self._resDyanimocLoader:getResource(path)

	if resource then
		self._resDyanimocLoader._loadedResDict[path] = nil

		if self._resDyanimocLoader._resPaths then
			table.removebyvalue(self._resDyanimocLoader._resPaths, path)
		end

		resource:Release()

		self._resDyanimocLoader.totalCount = self._resDyanimocLoader.totalCount - 1
		self._resDyanimocLoader.loadedCount = self._resDyanimocLoader.loadedCount - 1

		GameUtil.unloadResource(resource)
	end
end

function SceneCityStage:detectSceneResources(px, py, addtionalRes)
	local sceneData = SceneDatasCacheMgr.instance:getSceneData(self._stageResUrls[1])

	if not sceneData then
		return
	end

	local camSizeH, camSizeW, camDetSizeW, camDetSizeH = self:getCameraSize()

	px, py = self:getCameraInitPosByPosition(px, py, camDetSizeW, camDetSizeH)

	local boundsMinX = px - camDetSizeW * 0.5
	local boundsMaxX = px + camDetSizeW * 0.5
	local boundsMinY = py - camDetSizeH * 0.5
	local boundsMaxY = py + camDetSizeH * 0.5
	local resources = {}

	for i = 1, #sceneData.elements do
		local elements = sceneData.elements[i]
		local posx, posy = elements.trans[1], elements.trans[2] + elements.trans[10] * elements.center
		local sizex, sizey = elements.trans[9], elements.trans[10]
		local minx, miny, maxx, maxy = posx - sizex * 0.5, posy - sizey * 0.5, posx + sizex * 0.5, posy + sizey * 0.5

		if boundsMaxX >= minx and boundsMaxY >= miny and maxx >= boundsMinX and maxy >= boundsMinY then
			table.insert(resources, sceneData.elements[i].assetPath)
		end
	end

	local keysMap = {}
	local resourceList = {}

	for i = 1, #resources do
		if not keysMap[resources[i]] then
			keysMap[resources[i]] = true

			table.insert(resourceList, resources[i])
		end
	end

	if addtionalRes then
		for i = 1, #addtionalRes do
			if not keysMap[addtionalRes[i]] then
				keysMap[addtionalRes[i]] = true

				table.insert(resourceList, addtionalRes[i])
			end
		end
	end

	return resourceList
end

function SceneCityStage:detectSceneElemsResources(px, py)
	local camSizeH, camSizeW, camDetSizeW, camDetSizeH = self:getCameraSize()

	px, py = self:getCameraInitPosByPosition(px, py, camDetSizeW, camDetSizeH)

	local resources = self.wholeScene:GetTerrainElementsResourcesByDetector(px, py, camDetSizeW, camDetSizeH)
	local cnt = resources.Count - 1
	local keysMap = {}
	local resourceList = {}

	for i = 0, cnt do
		if not keysMap[resources[i]] then
			keysMap[resources[i]] = true

			table.insert(resourceList, resources[i])
		end
	end

	return resourceList
end

function SceneCityStage:_onStageResourceLoaded()
	self.wholeScene = self:_createWholeScele()

	self.wholeScene:RegisterOnPlayerHandler(self._scene._onPlayerVisible, self._scene._onPlayerCreate, self._scene._onPlayerDestroy, self._scene._onPlayerQualityCull, self._scene)
	self.wholeScene:RegisterMonsterHandler(self._scene._onMonsterVisible, self._scene._onMonsterCreate, self._scene._onMonsterDestroy, self._scene)
	self.wholeScene:RegisterObjectHandler(self._scene._onCommonObjVisible, self._scene._onCommonObjCreate, self._scene._onCommonObjDestroy, self._scene)
	self.wholeScene:RegisterElementsHandler(self._scene._onElementVisible, self._scene._onElementCreate, self._scene._onElementDestroy, self._scene)
	self.wholeScene:BuildScene()
	self:_modifyBirthPoints()

	local camSizeH, camSizeW, camDetSizeW, camDetSizeH = self:getCameraSize()

	self:_preloadSceneResources(camSizeH, camSizeW, camDetSizeW, camDetSizeH)
	self:_loadFirstEnter()

	self._terrainResReady = true

	self:_startJumperUIRes()
end

function SceneCityStage:_createWholeScele()
	self.wholeScene = AoSceneManager.Instance:CreateSceneNoLoadIfNotExists(self._stageResUrls, self._scene._onNpcVisible, self._scene._onNpcCreate, self._scene._onNpcDestroy, self._scene._onNpcModel, self._scene)

	return self.wholeScene
end

function SceneCityStage:getBirthPos()
	local x = self._scene:getBornX()
	local y = self._scene:getBornZ()

	if not self._scene:isPositionReachable(nil, x or 0, y or 0) then
		local hasPos, newX, newY = self.wholeScene:FindNotBerrierAround(nil, x, y, false, nil, nil)

		if not hasPos then
			newX, newY = SceneConfig.instance:getBornPoint(self._scene:getSceneId(), 0)
		end

		return newX or 0, newY or 0
	end

	return x or 0, y or 0
end

function SceneCityStage:_modifyBirthPoints()
	local x = self._scene:getBornX()
	local y = self._scene:getBornZ()

	if not self._scene:isPositionReachable(nil, x or 0, y or 0) then
		local hasPos, newX, newY = self.wholeScene:FindNotBerrierAround(nil, x, y, false, nil, nil)

		if not hasPos then
			newX, newY = SceneConfig.instance:getBornPoint(self._scene:getSceneId(), 0)
		end

		self._scene._curBornX = newX or 0
		self._scene._curBornZ = newY or 0

		self._scene:setUnderBridge(false)
	end
end

function SceneCityStage:_preloadSceneResources(camSizeH, camSizeW, camDetSizeW, camDetSizeH)
	self.wholeScene.preloadAll = false

	if self.wholeScene.preloadAll then
		self:_prepareTerrainResources()
		self:_prepareElementsResources()
		self:_prepareNpcsResources()
		self:_prepareTransmitPointsResources()
	else
		local px, py = self:_getCameraInitPos(camSizeW, camSizeH)

		self:_prepareTerrainResourcesByDetector(px, py, camDetSizeW, camDetSizeH)
		self:_prepareElementsResourcesByDetector(px, py, camDetSizeW, camDetSizeH)
		self:_prepareTransmitPointsResourcesByDetector(px, py, camDetSizeW, camDetSizeH)
	end
end

function SceneCityStage:_getCameraSizeScale()
	return 1.5
end

function SceneCityStage:updateDetectors()
	self:getCameraSize()
end

function SceneCityStage:getCameraSize()
	local scale = self:_getCameraSizeScale()
	local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCam = mainCamera:getCamera()
	local camSizeH = SceneMgr.instance:getSceneCameraParams(self._scene:getSceneId()) * 2
	local camSizeW = mainCam.aspect * camSizeH
	local camDetSizeW = camSizeW * scale
	local camDetSizeH = camSizeH * scale

	self.wholeScene:SetDetector(mainCam.gameObject, camDetSizeW, camDetSizeH)
	self.wholeScene:SetTerrainDetector(mainCam.gameObject, camDetSizeW * 2, camDetSizeH * 2, camDetSizeW, camDetSizeH)

	return camSizeH, camSizeW, camDetSizeW, camDetSizeH
end

function SceneCityStage:_getCameraInitPos(camSizeW, camSizeH)
	local px = self._scene:getBornX()
	local py = self._scene:getBornZ()

	return self:getCameraInitPosByPosition(px, py, camSizeW, camSizeH)
end

function SceneCityStage:getCameraInitPosByPosition(px, py, camSizeW, camSizeH)
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

function SceneCityStage:_prepareTerrainResources()
	local resources = self.wholeScene:GetTerrainResources()
	local cnt = resources.Count - 1

	for i = 0, cnt do
		self:_addSceneResource(resources[i])
		self:_addNeedLoadResource(resources[i])
	end
end

function SceneCityStage:_prepareTerrainResourcesByDetector(x, y, sz, sy)
	local resources = self.wholeScene:GetResourcesByDetector(x, y, sz, sy)
	local cnt = resources.Count - 1

	for i = 0, cnt do
		self:_addSceneResource(resources[i])
		self:_addNeedLoadResource(resources[i])
	end
end

function SceneCityStage:_prepareElementsResources()
	local eleResources = self.wholeScene:GetTerrainElementsResources()
	local cnt = eleResources.Count - 1

	for i = 0, cnt do
		self:_addSceneResource(eleResources[i])
		self:_addNeedLoadResource(eleResources[i])
	end
end

function SceneCityStage:_prepareElementsResourcesByDetector(x, y, sz, sy)
	local eleResources = self.wholeScene:GetTerrainElementsResourcesByDetector(x, y, sz, sy, 3)
	local cnt = eleResources.Count - 1

	for i = 0, cnt do
		self:_addSceneResource(eleResources[i])
		self:_addNeedLoadResource(eleResources[i])
	end
end

function SceneCityStage:_prepareNpcsResources()
	local npcResources = self.wholeScene:GetNpcsResources(false)
	local cnt = npcResources.Count - 1

	for i = 0, cnt do
		self:_addSceneResource(npcResources[i])
		self:_addNeedLoadResource(npcResources[i])
	end
end

function SceneCityStage:_prepareNpcsResourcesByDetector(x, y, sz, sy)
	local npcResources = self.wholeScene:GetNpcsResourcesByDetector(false, x, y, sz, sy)
	local cnt = npcResources.Count - 1

	for i = 0, cnt do
		self:_addSceneResource(npcResources[i])
		self:_addNeedLoadResource(npcResources[i])
	end
end

function SceneCityStage:_prepareTransmitPointsResources()
	local sceneIds = self.wholeScene:GetTransmitPointSceneId()

	if sceneIds then
		local cnt = sceneIds.Count - 1

		for i = 0, cnt do
			local sceneCo = SceneConfig.instance:getSceneCo(sceneIds[i])

			if sceneCo and sceneCo.showImage and #sceneCo.showImage > 0 then
				self:_addNeedLoadResource("scene/scene_icons/" .. sceneCo.showImage)
			end
		end
	end
end

function SceneCityStage:_prepareTransmitPointsResourcesByDetector(x, y, sz, sy)
	local sceneIds = self.wholeScene:GetTransmitPointByDetector(x, y, sz, sy)

	if sceneIds then
		local cnt = sceneIds.Count - 1

		for i = 0, cnt do
			local sceneCo = SceneConfig.instance:getSceneCo(sceneIds[i])

			if sceneCo and sceneCo.showImage and #sceneCo.showImage > 0 then
				self:_addNeedLoadResource("scene/scene_icons/" .. sceneCo.showImage)
			end
		end
	end
end

function SceneCityStage:_startLoadAllResources()
	if self._terrainResReady then
		self._resElementsLoader = MultiResLoader.New()

		self._resElementsLoader:setResPaths(self._resourcesList, self._preloadFlags)
		self._resElementsLoader:load(self._onAllResourceLoaded, self._onResourceLoaded, self)
	end
end

function SceneCityStage:_startJumperUIRes()
	if self._terrainResReady then
		local topState = UIJumper.instance:getTopState()

		if not topState then
			self:_startLoadAllResources()

			return
		end

		local resourceList = self:_getViewResourcesList(topState.state, topState.param)

		self._tempJumperUIResloader = MultiResLoader.New()

		self._tempJumperUIResloader:setResPaths(resourceList)
		self._tempJumperUIResloader:load(self._onJumperUIResLoaded, nil, self)
	end
end

function SceneCityStage:_onlyLoadDeaultUIRes()
	if self._terrainResReady then
		local topState = self._scene:getDefaultView()

		if not topState then
			self:_startLoadAllResources()

			return
		end

		local resourceList = self:_getViewResourcesList(topState)

		self._tempJumperUIResloader = MultiResLoader.New()

		self._tempJumperUIResloader:setResPaths(resourceList)
		self._tempJumperUIResloader:load(self._onJumperUIResLoaded, nil, self)
	end
end

function SceneCityStage:_getViewResourcesList(viewName, param)
	local presentorName = ViewSetting.instance:getPresentorName(viewName)
	local clsPath = module_paths[presentorName]
	local viewPresentor, cls

	viewPresentor = (clsPath and usingnow(clsPath, presentorName) or usingnow(presentorName)).New()
	viewPresentor.viewName = viewName
	viewPresentor._openParam = param

	local dependRes = viewPresentor:dependWhatResources()
	local tempRes = viewPresentor:getTempResources()
	local resourceList = {}

	if dependRes then
		table.merge(resourceList, dependRes)
	end

	if tempRes then
		for i = 1, #tempRes do
			table.insert(resourceList, tempRes[i])
		end
	end

	return resourceList
end

function SceneCityStage:_onJumperUIResLoaded()
	self:_startLoadAllResources()
end

function SceneCityStage:_onResourceLoaded()
	local progress = self._resElementsLoader.loadedCount / self._resElementsLoader.totalCount

	self:_notifyLoadingProgress(progress)
end

function SceneCityStage:_notifyLoadingProgress(progress, isFinished)
	if self._loadListener then
		if self._loadListenerObj then
			self._loadListener(self._loadListenerObj, progress, isFinished)
		else
			self._loadListener(progress, isFinished)
		end
	end
end

function SceneCityStage:_loadFirstEnter()
	if StoryController.instance.firstStoryId and not TaskController.instance:hasDoFirstTaskTarget() and StoryController.instance.isFirstltPlayStoryBg then
		local storyCos = StoryConfig.instance:getStories(StoryController.instance.firstStoryId)
		local storyCo = storyCos[1]

		if not StoryConst.isBgWithoutImage(storyCo.bgImg) then
			local texPath = StoryConst.StoryPath_BigImgBg .. storyCo.bgImg

			if not string.find(texPath, ".png") then
				texPath = texPath .. ".png"
			end

			self:_addNeedLoadResource(texPath)
		end
	end
end

function SceneCityStage:_clearSceneResources()
	if self._sceneResRecord and self._resElementsLoader then
		for k, v in pairs(self._sceneResRecord) do
			local resource = self._resElementsLoader:getResource(k)

			if resource then
				resource:Release()

				self._resElementsLoader._loadedResDict[k] = nil

				if self._resElementsLoader._resPaths then
					table.removebyvalue(self._resElementsLoader._resPaths, k)
				end

				self._resElementsLoader.totalCount = self._resElementsLoader.totalCount - 1
				self._resElementsLoader.loadedCount = self._resElementsLoader.loadedCount - 1
			end
		end
	end

	self._sceneResRecord = nil
end

function SceneCityStage:_onAllResourceLoaded()
	if not self._isSceneEntering then
		return
	end

	self._isSceneEntering = nil

	self:_notifyLoadingProgress(1, true)

	if not self._loadListener then
		self:loadingDone()
	end
end

function SceneCityStage:loadingDone()
	SceneMgr.instance:onEnterFinished()
	self:dispatch(SceneNotify.StageLoaded)
end

function SceneCityStage:_createSceneScreenEff()
	local screenEff = self:_getSceneScreenEffCo()

	if string.nilorempty(screenEff) == false then
		self._screenEffPathForScene = GameUrl.getSceneEffectUrl(screenEff)

		getres(self._screenEffPathForScene, self._onScreenEffResLoadedForScene, self, ResType.AssetBundle, true)
	end
end

function SceneCityStage:_getSceneScreenEffCo()
	local screenEff, fitFullScreen
	local currSceneId = self._scene:getSceneId()
	local festival = self._scene:getFestival()

	if festival then
		local festivalCo = SceneConfig.instance:getSceneFestivalCo(currSceneId, festival)

		if festivalCo then
			screenEff = festivalCo.screenEff
			fitFullScreen = festivalCo.fitFullScreen
		end
	else
		local sceneCo = SceneConfig.instance:getSceneCo(currSceneId)

		if sceneCo ~= nil then
			screenEff = sceneCo.screenEff
			fitFullScreen = sceneCo.fitFullScreen
		end
	end

	return screenEff, fitFullScreen
end

function SceneCityStage:_onScreenEffResLoadedForScene(res)
	if res and res.IsSuccess then
		self._resScreenEffForScene = res

		self._resScreenEffForScene:Retain()

		self._screenEffInstForScene = UnityEngine.GameObject.Instantiate(res:GetAsset(nil, nil))

		GameUtil.SetActive(self._screenEffInstForScene, true)
		goutil.addChildToParent(self._screenEffInstForScene, GlobalModel.instance.mainCamera.gameObject)
		Framework.TransformUtil.SetLocalPos(self._screenEffInstForScene.transform, 0, 0, 1)

		local _, fitFullScreen = self:_getSceneScreenEffCo()

		if fitFullScreen then
			local baseAspect = 1.7777777777777777
			local scale = self:_getCameraSizeScale()
			local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()
			local mainCam = mainCamera:getCamera()
			local scaleX = mainCam.aspect / baseAspect

			Framework.TransformUtil.SetLocalScale(self._screenEffInstForScene.transform, scaleX, 1, 1)
		end
	end
end

function SceneCityStage:_destroySceneScreenEff()
	if self._screenEffInstForScene ~= nil then
		GameUtil.SetActive(self._screenEffInstForScene, false)
		goutil.destroy(self._screenEffInstForScene)

		self._screenEffInstForScene = nil
	end

	if self._resScreenEffForScene ~= nil then
		self._resScreenEffForScene:Release()
	elseif string.nilorempty(self._screenEffPathForScene) == false then
		removeresl(self._screenEffPathForScene, self._onScreenEffResLoadedForScene, self)
	end

	self._resScreenEffForScene = nil
	self._screenEffPathForScene = nil
end

function SceneCityStage:_showGM(show)
	GMController.instance:showGM(show)
end

return SceneCityStage
