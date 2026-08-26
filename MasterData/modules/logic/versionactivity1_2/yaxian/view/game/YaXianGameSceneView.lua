-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/game/YaXianGameSceneView.lua

module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameSceneView", package.seeall)

local YaXianGameSceneView = class("YaXianGameSceneView", BaseView)

function YaXianGameSceneView:onInitView()
	self._gotouch = gohelper.findChild(self.viewGO, "#go_touch")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function YaXianGameSceneView:addEvents()
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.InteractObjectCreated, self.createOrUpdateInteractObj, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.DeleteInteractObj, self.deleteInteractObj, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnUpdateEffectInfo, self.onUpdateEffectInfo, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnSelectInteract, self.onSelectInteract, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnCancelSelectInteract, self.onCancelSelectInteract, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnRevert, self.onRevert, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnResetView, self.resetMapView, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.UpdateRound, self.onUpdateRound, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnInteractLoadDone, self.checkAllInteractLoadDone, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.SetInteractObjActive, self.setInteractObjActive, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.GuideClickTile, self._guideClickTile, self)
end

function YaXianGameSceneView:removeEvents()
	return
end

YaXianGameSceneView.BLOCK_KEY = "YaXianGameSceneViewLoading"

function YaXianGameSceneView:_editableInitView()
	self._tfTouch = self._gotouch.transform
	self._click = SLFramework.UGUI.UIClickListener.Get(self._gotouch)

	self._click:AddClickListener(self.onClickContainer, self)

	self._baseTiles = {}
	self._baseTilePool = {}
	self._interactItemList = {}
	self._baffleItems = {}
	self._baffleItemPool = {}
	self.loadDoneInteractList = {}
	self.needLoadInteractIdList = {}

	MainCameraMgr.instance:addView(self.viewName, self.initCamera, nil, self)
	self:createSceneRoot()
	self:addEvents()
	self:initSceneTree()
	self:loadRes()
end

function YaXianGameSceneView:initSceneTree()
	YaXianGameController.instance:initSceneTree(self._gotouch, self._sceneOffsetY)
end

function YaXianGameSceneView:createSceneRoot()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("YaXianScene")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)

	self._sceneOffsetY = y

	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function YaXianGameSceneView:initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale(true)

	camera.orthographicSize = 7.5 * scale
end

function YaXianGameSceneView:loadRes()
	UIBlockMgr.instance:startBlock(YaXianGameSceneView.BLOCK_KEY)

	self._loader = MultiAbLoader.New()
	self.sceneUrl = self:getCurrentSceneUrl()

	self._loader:addPath(self.sceneUrl)
	self._loader:addPath(YaXianGameEnum.SceneResPath.GroundItem)
	self._loader:addPath(YaXianGameEnum.SceneResPath.DirItem)
	self._loader:addPath(YaXianGameEnum.SceneResPath.AlarmItem)
	self._loader:addPath(YaXianGameEnum.SceneResPath.TargetItem)
	self._loader:addPath(YaXianGameEnum.SceneResPath.GreenLine)
	self._loader:addPath(YaXianGameEnum.SceneResPath.RedLine)
	self._loader:addPath(YaXianGameEnum.SceneResPath.GreedLineHalf)
	self._loader:addPath(YaXianGameEnum.SceneResPath.RedLineHalf)
	self._loader:startLoad(self.onLoadResCompleted, self)
end

function YaXianGameSceneView:onUpdateParam()
	self:createAllMapElement()
end

function YaXianGameSceneView:onOpen()
	self:createAllMapElement()
end

function YaXianGameSceneView:getCurrentSceneUrl()
	local mapId = YaXianGameModel.instance:getMapId()
	local actId = YaXianGameModel.instance:getActId()
	local mapCo = YaXianConfig.instance:getMapConfig(actId, mapId)

	if mapCo and not string.nilorempty(mapCo.bgPath) then
		return string.format(YaXianGameEnum.SceneResPath.SceneFormatPath, mapCo.bgPath)
	else
		return YaXianGameEnum.SceneResPath.DefaultScene
	end
end

function YaXianGameSceneView:onLoadResCompleted(loader)
	local assetItem = loader:getAssetItem(self.sceneUrl)

	if assetItem then
		self._sceneGo = gohelper.clone(assetItem:GetResource(), self._sceneRoot, "scene")

		self.viewContainer:setRootSceneGo(self._sceneGo)

		self._sceneBackground = UnityEngine.GameObject.New("backgroundContainer")
		self._interactContainer = UnityEngine.GameObject.New("interactContainer")

		self._sceneBackground.transform:SetParent(self._sceneGo.transform, false)
		self._interactContainer.transform:SetParent(self._sceneGo.transform, false)
		transformhelper.setLocalPos(self._sceneBackground.transform, 0, 0, YaXianGameEnum.ContainerOffsetZ.Background)
		transformhelper.setLocalPos(self._interactContainer.transform, 0, 0, YaXianGameEnum.ContainerOffsetZ.Interact)

		self.groundPrefab = self._loader:getAssetItem(YaXianGameEnum.SceneResPath.GroundItem):GetResource()
		self.mainResLoadDone = true

		self:createAllMapElement()
	end

	UIBlockMgr.instance:endBlock(YaXianGameSceneView.BLOCK_KEY)
end

function YaXianGameSceneView:createAllMapElement()
	if self.mainResLoadDone and self.viewContainer._viewStatus >= BaseViewContainer.Status_Opening then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.MainResLoadDone, self._loader)
		self:fillChessBoardBase()
		self:createAllInteractObjs()
		self:createAllBaffleObjs()
		self:checkAllInteractLoadDone()
	end
end

function YaXianGameSceneView:checkAllInteractLoadDone(finishInteractId)
	if finishInteractId and not tabletool.indexOf(self.loadDoneInteractList, finishInteractId) then
		table.insert(self.loadDoneInteractList, finishInteractId)
	end

	if #self.loadDoneInteractList ~= #self.needLoadInteractIdList then
		return
	end

	local loadDoneDict = {}

	for _, interactId in ipairs(self.loadDoneInteractList) do
		loadDoneDict[interactId] = true
	end

	for _, interactId in ipairs(self.needLoadInteractIdList) do
		if not loadDoneDict[interactId] then
			return
		end
	end

	self.featureInteractMo = YaXianGameModel.instance:getNeedFeatureInteractMo()

	if self.featureInteractMo then
		TaskDispatcher.runDelay(self.playFeatureAnimation, self, 1)

		return
	end

	YaXianGameModel.instance:setGameLoadDone(true)
	YaXianGameController.instance:updateAllPosInteractActive()
	YaXianGameController.instance:autoSelectPlayer()

	local episodeId = YaXianGameModel.instance:getEpisodeId()

	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnGameLoadDone, tostring(episodeId))
end

function YaXianGameSceneView:playFeatureAnimation()
	self.featureInteractItem = self:findInteractItem(self.featureInteractMo.id)

	self.featureInteractItem:getHandler():moveTo(YaXianGameModel.instance.featurePrePosX, YaXianGameModel.instance.featurePrePosY, self.featureAnimationDone, self)
end

function YaXianGameSceneView:featureAnimationDone()
	self.featureInteractItem:getHandler():faceTo(YaXianGameModel.instance.featurePreDirection)
	YaXianGameModel.instance:clearFeatureInteract()
	YaXianGameController.instance:updateAllPosInteractActive()
	YaXianGameModel.instance:setGameLoadDone(true)
	YaXianGameController.instance:autoSelectPlayer()

	local episodeId = YaXianGameModel.instance:getEpisodeId()

	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnGameLoadDone, tostring(episodeId))
end

function YaXianGameSceneView:fillChessBoardBase()
	self:recycleBaseTiles()

	local w, h = 8, 8

	logNormal("fill w = " .. tostring(w) .. ", h = " .. tostring(h))

	for x = 1, w do
		self._baseTiles[x] = self._baseTiles[x] or {}

		for y = 1, h do
			local tileItem = self:createTileBaseItem(x - 1, y - 1)

			self._baseTiles[x][y] = tileItem

			local tileData = YaXianGameModel.instance:getBaseTile(x - 1, y - 1)

			gohelper.setActive(tileItem.go, tileData ~= 0)
		end
	end
end

function YaXianGameSceneView:createTileBaseItem(x, y)
	local tileObj
	local poolLen = #self._baseTilePool

	if poolLen > 0 then
		tileObj = self._baseTilePool[poolLen]
		self._baseTilePool[poolLen] = nil
	end

	if not tileObj then
		tileObj = self:getUserDataTb_()

		local itemGo = gohelper.clone(self.groundPrefab, self._sceneBackground, "tilebase_" .. x .. "_" .. y)

		tileObj.go = itemGo
		tileObj.sceneTf = itemGo.transform
	else
		tileObj.go.name = "tilebase_" .. x .. "_" .. y
	end

	self:setTileBasePosition(tileObj, x, y)

	return tileObj
end

function YaXianGameSceneView:setTileBasePosition(tileObj, x, y)
	local sceneX, sceneY, sceneZ = YaXianGameHelper.calcTilePosInScene(x, y)

	transformhelper.setLocalPos(tileObj.sceneTf, sceneX, sceneY, sceneZ)
end

function YaXianGameSceneView:createAllBaffleObjs()
	local baffleList = YaXianGameModel.instance:getBaffleList()

	for _, baffle in ipairs(baffleList) do
		self:createBaffleItem(baffle)
	end
end

function YaXianGameSceneView:createBaffleItem(baffle)
	local baffleItem
	local poolLen = #self._baffleItemPool

	if poolLen > 0 then
		baffleItem = self._baffleItemPool[poolLen]
		self._baffleItemPool[poolLen] = nil
	end

	if not baffleItem then
		baffleItem = YaXianBaffleObject.New(self._interactContainer.transform)

		baffleItem:init()
	end

	baffleItem:updatePos(baffle)
	table.insert(self._baffleItems, baffleItem)
end

function YaXianGameSceneView:createAllInteractObjs()
	local interactMoList = YaXianGameModel.instance:getInteractMoList()
	local playerInteractMo = YaXianGameModel.instance:getPlayerInteractMo()

	for _, interactMo in ipairs(interactMoList) do
		local interactItem = self:createOrUpdateInteractObj(interactMo)

		self:addNeedLoadInteractList(interactMo.id)

		if interactMo == playerInteractMo then
			self.playerInteractItem = interactItem
		end
	end

	YaXianGameController.instance:setInteractItemList(self._interactItemList)
	YaXianGameController.instance:setPlayerInteractItem(self.playerInteractItem)
end

function YaXianGameSceneView:createOrUpdateInteractObj(interactMo)
	local interactItem = self:findInteractItem(interactMo.id)

	if not interactItem then
		interactItem = YaXianInteractObject.New(self._interactContainer.transform)

		interactItem:init(interactMo)
		interactItem:loadAvatar()
		interactItem:updateInteractPos()
		table.insert(self._interactItemList, interactItem)
	else
		interactItem:renewSelf()
		interactItem:updateInteractMo(interactMo)
	end

	return interactItem
end

function YaXianGameSceneView:addNeedLoadInteractList(interactId)
	if not tabletool.indexOf(self.needLoadInteractIdList, interactId) then
		table.insert(self.needLoadInteractIdList, interactId)
	end
end

function YaXianGameSceneView:findInteractItem(interactId)
	for _, interactItem in ipairs(self._interactItemList) do
		if interactItem.id == interactId then
			return interactItem
		end
	end
end

function YaXianGameSceneView:getPlayerInteractItem()
	return self.playerInteractItem
end

function YaXianGameSceneView:deleteInteractObj(interactId)
	local interactItem = self:findInteractItem(interactId)

	if not interactItem then
		return
	end

	interactItem:deleteSelf()
	YaXianGameModel.instance:removeObjectById(interactId)
end

function YaXianGameSceneView:setInteractObjActive(params)
	local paramArr = string.split(params, "_")
	local interactId = tonumber(paramArr[1])
	local active = tonumber(paramArr[2]) == 1
	local interactItem = self:findInteractItem(interactId)

	if not interactItem then
		return
	end

	interactItem:setActive(active)
end

function YaXianGameSceneView:onClickContainer(param, clickPosition)
	if not YaXianGameController.instance:isSelectingPlayer() then
		return
	end

	local tempPos = recthelper.screenPosToAnchorPos(clickPosition, self._tfTouch)
	local tileX, tileY = YaXianGameController.instance:getNearestScenePos(tempPos.x, tempPos.y)

	if tileX then
		logNormal("click Scene tileX, tileY : " .. tostring(tileX) .. ", " .. tostring(tileY))
		self:onClickChessPos(tileX, tileY)
	end
end

function YaXianGameSceneView:onClickChessPos(x, y)
	if not YaXianGameController.instance:isSelectingPlayer() then
		return
	end

	self.playerInteractItem:getHandler():onSelectPos(x, y)
end

function YaXianGameSceneView:_guideClickTile(param)
	local list = string.splitToNumber(param, "_")
	local tileX = list[1]
	local tileY = list[2]

	self:onClickChessPos(tileX, tileY)
end

function YaXianGameSceneView:recycleBaseTiles()
	for x, yList in pairs(self._baseTiles) do
		for y, tileObj in pairs(yList) do
			table.insert(self._baseTilePool, self._baseTiles[x][y])
		end
	end

	self._baseTiles = {}
end

function YaXianGameSceneView:recycleAllBaffleItem()
	local baffleObj

	for i = 1, #self._baffleItems do
		self._baffleItems[i]:recycle()
		table.insert(self._baffleItemPool, self._baffleItems[i])

		self._baffleItems[i] = nil
	end
end

function YaXianGameSceneView:recycleAllInteract()
	for _, interactItem in ipairs(self._interactItemList) do
		interactItem:deleteSelf()
	end
end

function YaXianGameSceneView:disposeInteractItem()
	for _, interactItem in ipairs(self._interactItemList) do
		interactItem:dispose()
	end

	self._interactItemList = nil
end

function YaXianGameSceneView:disposeBaffle()
	local baffleObj

	for i = 1, #self._baffleItems do
		baffleObj = self._baffleItems[i]

		self._baffleItems[i]:dispose()
	end

	for i = 1, #self._baffleItemPool do
		self._baffleItemPool[i]:dispose()
	end

	self._baffleItems = nil
	self._baffleItemPool = nil
end

function YaXianGameSceneView:disposeSceneRoot()
	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end
end

function YaXianGameSceneView:releaseLoader()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function YaXianGameSceneView:resetMapView()
	YaXianGameModel.instance:setGameLoadDone(false)
	self:recycleBaseTiles()
	self:recycleAllInteract()
	self:recycleAllBaffleItem()
end

function YaXianGameSceneView:onUpdateEffectInfo()
	local hadInVisibleEffect = YaXianGameModel.instance:isShowVisibleStatus()
	local hadThroughWallEffect = YaXianGameModel.instance:isShowThroughStatus()

	if hadInVisibleEffect and hadThroughWallEffect then
		self.playerInteractItem:playAnimation(YaXianGameEnum.InteractAnimationName.TwoEffect)

		return
	end

	if hadInVisibleEffect then
		self.playerInteractItem:playAnimation(YaXianGameEnum.InteractAnimationName.InVisible)

		return
	end

	if hadThroughWallEffect then
		self.playerInteractItem:playAnimation(YaXianGameEnum.InteractAnimationName.ThroughWall)

		return
	end

	self.playerInteractItem:stopAnimation()
end

function YaXianGameSceneView:onSelectInteract(interactId)
	local interactItem = self:findInteractItem(interactId)

	if interactItem and not interactItem.delete and interactItem:getHandler() then
		interactItem:getHandler():onSelectCall()
	end
end

function YaXianGameSceneView:onCancelSelectInteract(interactId)
	local interactItem = self:findInteractItem(interactId)

	if interactItem and not interactItem.delete and interactItem:getHandler() then
		interactItem:getHandler():onCancelSelect()
	end
end

function YaXianGameSceneView:onUpdateRound()
	YaXianGameController.instance:updateAllPosInteractActive()
	YaXianGameController.instance:autoSelectPlayer()
end

function YaXianGameSceneView:onRevert()
	YaXianGameController.instance:setSelectObj()
	self:createAllInteractObjs()
	self:checkAllInteractLoadDone()
	YaXianGameController.instance:updateAllPosInteractActive()
end

function YaXianGameSceneView:onClose()
	TaskDispatcher.cancelTask(self.playFeatureAnimation, self)
end

function YaXianGameSceneView:onDestroyView()
	if self._click then
		self._click:RemoveClickListener()

		self._click = nil
	end

	self._baseTiles = nil

	self:disposeInteractItem()
	self:disposeBaffle()
	self:disposeSceneRoot()
	self:releaseLoader()
end

return YaXianGameSceneView
