-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/scene/Va3ChessGameScene.lua

module("modules.logic.versionactivity1_3.va3chess.game.scene.Va3ChessGameScene", package.seeall)

local Va3ChessGameScene = class("Va3ChessGameScene", BaseViewExtended)

function Va3ChessGameScene:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gotouch = gohelper.findChild(self.viewGO, "#go_touch")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Va3ChessGameScene:addEvents()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.onScreenResize, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.AddInteractObj, self.createInteractObj, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.DeleteInteractAvatar, self.deleteInteractObj, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.ResetMapView, self.onResetMapView, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.SetNeedChooseDirectionVisible, self.onSetDirectionVisible, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameReset, self.onResetGame, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.RefreshAlarmArea, self.onAlarmAreaRefresh, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.RefreshAlarmAreaOnXY, self.refreshAlarmAreaOnXY, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, self.onGameDataUpdate, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GuideClickTile, self._guideClickTile, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.ResetGameByResultView, self.handleResetByResult, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameResultQuit, self.onResultQuit, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.EventStart, self.onChessStateUpdate, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.StoryFrontViewDestroy, self._afterPlayStory, self)
end

function Va3ChessGameScene:removeEvents()
	return
end

Va3ChessGameScene.BLOCK_KEY = "Va3ChessGameSceneLoading"

function Va3ChessGameScene:_editableInitView()
	self._tfTouch = self._gotouch.transform
	self._click = SLFramework.UGUI.UIClickListener.Get(self._gotouch)

	self._click:AddClickListener(self.onClickContainer, self)

	self._handler = Va3ChessGameHandler.New()

	self._handler:init(self)

	self._baseTiles = {}
	self._baseTilePool = {}
	self._dirItems = {}
	self._dirItemPool = {}
	self._alarmItems = {}
	self._alarmItemPool = {}
	self._avatarMap = {}
	self._fixedOrder = 0

	self:createSceneRoot()
	self:initCamera()
	Va3ChessGameController.instance:initSceneTree(self._gotouch, self._sceneOffsetY)
	self:loadRes()
end

function Va3ChessGameScene:onDestroyView()
	if self._click then
		self._click:RemoveClickListener()

		self._click = nil
	end

	if self._handler then
		self._handler:dispose()

		self._handler = nil
	end

	self._baseTiles = nil

	self:resetCamera()
	self:releaseRes()
	self:disposeSceneRoot()
	TaskDispatcher.cancelTask(self.delayRefreshAlarmArea, self)

	self._isWaitingRefreshAlarm = false
end

function Va3ChessGameScene:onOpen()
	return
end

function Va3ChessGameScene:onOpenFinish()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameViewOpened, self.viewParam)
end

function Va3ChessGameScene:onClose()
	UIBlockMgr.instance:endBlock(Va3ChessGameScene.BLOCK_KEY)
	self:stopAudio()
end

function Va3ChessGameScene:playAudio()
	local actId = Va3ChessGameModel.instance:getActId()
	local mapId = Va3ChessGameModel.instance:getMapId()

	if actId and mapId then
		local mapCo = Va3ChessConfig.instance:getMapCo(actId, mapId)

		self:stopAudio()

		if mapCo and mapCo.audioAmbient ~= 0 then
			self._triggerAmbientId = AudioMgr.instance:trigger(mapCo.audioAmbient)
		end
	end
end

function Va3ChessGameScene:stopAudio()
	if self._triggerAmbientId then
		AudioMgr.instance:stopPlayingID(self._triggerAmbientId)

		self._triggerAmbientId = nil
	end
end

function Va3ChessGameScene:onScreenResize()
	if self._sceneGo then
		local camera = CameraMgr.instance:getMainCamera()
		local scale = GameUtil.getAdapterScale(true)

		camera.orthographicSize = 7.5 * scale
	end
end

function Va3ChessGameScene:initCamera()
	if self._isInitCamera then
		return
	end

	self._isInitCamera = true

	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale(true)

	camera.orthographicSize = 7.5 * scale
end

function Va3ChessGameScene:resetCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = 5
	camera.orthographic = false
end

function Va3ChessGameScene:loadRes()
	UIBlockMgr.instance:startBlock(Va3ChessGameScene.BLOCK_KEY)

	self._loader = MultiAbLoader.New()

	self._loader:addPath(self:getCurrentSceneUrl())
	self._loader:addPath(self:getGroundItemUrl())
	self._loader:addPath(Va3ChessEnum.SceneResPath.DirItem)
	self._loader:addPath(Va3ChessEnum.SceneResPath.AlarmItem)
	self._loader:addPath(Va3ChessEnum.SceneResPath.AlarmItem2)
	self._loader:addPath(Va3ChessEnum.SceneResPath.AlarmItem3)
	self:onLoadRes()
	self._loader:startLoad(self.loadResCompleted, self)
end

function Va3ChessGameScene:onLoadRes()
	return
end

function Va3ChessGameScene:getGroundItemUrl()
	return Va3ChessEnum.SceneResPath.GroundItem
end

function Va3ChessGameScene:getCurrentSceneUrl()
	local mapId = Va3ChessGameModel.instance:getMapId()
	local actId = Va3ChessGameModel.instance:getActId()
	local mapCo = Va3ChessConfig.instance:getMapCo(actId, mapId)

	if mapCo and not string.nilorempty(mapCo.bgPath) then
		return string.format(Va3ChessEnum.SceneResPath.SceneFormatPath, mapCo.bgPath)
	else
		return Va3ChessEnum.SceneResPath.DefaultScene
	end
end

function Va3ChessGameScene:loadResCompleted(loader)
	local assetItem = loader:getAssetItem(self:getCurrentSceneUrl())

	if assetItem then
		self._sceneGo = gohelper.clone(assetItem:GetResource(), self._sceneRoot, "scene")
		self._sceneAnim = self._sceneGo:GetComponent(typeof(UnityEngine.Animator))

		self._sceneBackground.transform:SetParent(self._sceneGo.transform, false)
		self._sceneGround.transform:SetParent(self._sceneGo.transform, false)
		self._sceneContainer.transform:SetParent(self._sceneGo.transform, false)
		transformhelper.setLocalPos(self._sceneBackground.transform, 0, 0, -0.5)
		transformhelper.setLocalPos(self._sceneGround.transform, 0, 0, -1)
		transformhelper.setLocalPos(self._sceneContainer.transform, 0, 0, -1.5)
		self:fillChessBoardBase()
		self:createAllInteractObjs()
		self:onloadResCompleted(loader)
		self:playEnterAnim()
		self:playAudio()

		if not Va3ChessGameController.instance:getSelectObj() then
			Va3ChessGameController.instance:autoSelectPlayer(true)
		end
	end

	UIBlockMgr.instance:endBlock(Va3ChessGameScene.BLOCK_KEY)

	local episodeId = tostring(Va3ChessModel.instance:getEpisodeId())
	local actId = tostring(Va3ChessModel.instance:getActId())

	Va3ChessController.instance:dispatchEvent(Va3ChessEvent.GuideOnEnterEpisode, actId .. "_" .. episodeId)
end

function Va3ChessGameScene:onloadResCompleted(loader)
	return
end

function Va3ChessGameScene:releaseRes()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function Va3ChessGameScene:createSceneRoot()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("ChessMap")
	self._sceneBackground = UnityEngine.GameObject.New("background")
	self._sceneGround = UnityEngine.GameObject.New("ground")
	self._sceneContainer = UnityEngine.GameObject.New("container")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)

	self._sceneOffsetY = y

	gohelper.addChild(sceneRoot, self._sceneRoot)
	gohelper.addChild(self._sceneRoot, self._sceneBackground)
	gohelper.addChild(self._sceneRoot, self._sceneGround)
	gohelper.addChild(self._sceneRoot, self._sceneContainer)
end

function Va3ChessGameScene:disposeSceneRoot()
	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end
end

function Va3ChessGameScene:fillChessBoardBase()
	local w, h = Va3ChessGameModel.instance:getGameSize()

	logNormal("fill w = " .. tostring(w) .. ", h = " .. tostring(h))

	for x = 1, w do
		self._baseTiles[x] = self._baseTiles[x] or {}

		for y = 1, h do
			local tileItem = self:createTileBaseItem(x - 1, y - 1)

			self._baseTiles[x][y] = tileItem

			local tileData = Va3ChessGameModel.instance:getBaseTile(x - 1, y - 1)

			self:onTileItemCreate(x - 1, y - 1, tileItem)
			gohelper.setActive(tileItem.go, tileData == Va3ChessEnum.TileBaseType.Normal)
		end
	end
end

function Va3ChessGameScene:createTileBaseItem(x, y)
	local tileObj
	local poolLen = #self._baseTilePool

	if poolLen > 0 then
		tileObj = self._baseTilePool[1]

		table.remove(self._baseTilePool, 1)
	end

	if not tileObj then
		tileObj = self:getUserDataTb_()

		local resPath = self:getGroundItemUrl(x, y)
		local assetItem = self._loader:getAssetItem(resPath)
		local itemGo = gohelper.clone(assetItem:GetResource(), self._sceneBackground, "tilebase_" .. x .. "_" .. y)

		tileObj.go = itemGo
		tileObj.sceneTf = itemGo.transform
	end

	self:setTileBasePosition(tileObj, x, y)

	return tileObj
end

function Va3ChessGameScene:setTileBasePosition(tileObj, x, y)
	local sceneX, sceneY, sceneZ = Va3ChessGameController.instance:calcTilePosInScene(x, y)

	transformhelper.setLocalPos(tileObj.sceneTf, sceneX, sceneY, sceneZ)
end

function Va3ChessGameScene:onTileItemCreate(x, y, tileItem)
	return
end

function Va3ChessGameScene:resetTiles()
	for _, yList in pairs(self._baseTiles) do
		for _, tileObj in pairs(yList) do
			table.insert(self._baseTilePool, tileObj)
		end
	end

	self._baseTiles = {}

	self:fillChessBoardBase()
end

function Va3ChessGameScene:createAllInteractObjs()
	logNormal("createAllObjects")

	if not Va3ChessGameController.instance.interacts then
		return
	end

	local list = Va3ChessGameController.instance.interacts:getList()

	table.sort(list, Va3ChessInteractMgr.sortRenderOrder)

	for _, interactObj in ipairs(list) do
		self:createInteractObj(interactObj)
	end

	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.AllObjectCreated, self.createAllInteractObjs, self)
end

function Va3ChessGameScene:createInteractObj(interactObj)
	if gohelper.isNil(self._sceneContainer) then
		logNormal("Va3ChessGameScene: game is already end")

		return
	end

	local order = Va3ChessInteractMgr.getRenderOrder(interactObj)
	local avatarObj = self:getUserDataTb_()

	avatarObj.sceneGo = UnityEngine.GameObject.New("item_" .. interactObj.id)
	avatarObj.sceneTf = avatarObj.sceneGo.transform
	avatarObj.loader = PrefabInstantiate.Create(avatarObj.sceneGo)

	avatarObj.sceneTf:SetParent(self._sceneContainer.transform, false)

	avatarObj.order = order + self._fixedOrder
	self._fixedOrder = self._fixedOrder + 0.01

	interactObj:setAvatar(avatarObj)

	self._avatarMap[interactObj.id] = avatarObj

	local actId = Va3ChessGameModel.instance:getActId()

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SceneInteractObjCreated, actId .. "_" .. interactObj.id)
end

function Va3ChessGameScene:deleteInteractObj(id)
	self._avatarMap[id] = nil
end

function Va3ChessGameScene:createDirItem()
	local itemObj
	local poolLen = #self._dirItemPool

	if poolLen > 0 then
		itemObj = self._dirItemPool[poolLen]
		self._dirItemPool[poolLen] = nil
	end

	if not itemObj then
		itemObj = self:getUserDataTb_()

		local assetItem = self._loader:getAssetItem(Va3ChessEnum.SceneResPath.DirItem)

		itemObj.go = gohelper.clone(assetItem:GetResource(), self._sceneGround, "dirItem")
		itemObj.sceneTf = itemObj.go.transform
		itemObj.goCenter = gohelper.findChild(itemObj.go, "#go_center")
		itemObj.goNormal = gohelper.findChild(itemObj.go, "#go_normal")
		itemObj.goItem = gohelper.findChild(itemObj.go, "#go_item")
	end

	table.insert(self._dirItems, itemObj)

	return itemObj
end

function Va3ChessGameScene:recycleAllDirItem()
	for k, v in pairs(self._dirItems) do
		gohelper.setActive(v.go, false)
		table.insert(self._dirItemPool, v)

		self._dirItems[k] = nil
	end
end

function Va3ChessGameScene:onResetMapView()
	self:resetTiles()
end

function Va3ChessGameScene:onResetGame()
	self._fixedOrder = 1

	self:playEnterAnim()
	self:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer(true)
end

function Va3ChessGameScene:onGameDataUpdate()
	if not Va3ChessGameController.instance:getSelectObj() then
		Va3ChessGameController.instance:autoSelectPlayer(true)
	end
end

function Va3ChessGameScene:onChessStateUpdate(state)
	if state == Va3ChessEnum.GameEventType.Normal then
		local interactMgr = Va3ChessGameController.instance.interacts
		local mainPlayer = interactMgr:getMainPlayer(true)
		local posIndex = mainPlayer:getObjPosIndex()
		local mapId = Va3ChessGameModel.instance:getMapId()

		if mapId then
			Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GuideRoundStartCheckPlayerPos, mapId .. "_" .. posIndex)
		end

		local x, y = mainPlayer.originData.posX, mainPlayer.originData.posY

		self:updatePlayerInteractState(mainPlayer, x + 1, y)
		self:updatePlayerInteractState(mainPlayer, x - 1, y)
		self:updatePlayerInteractState(mainPlayer, x, y + 1)
		self:updatePlayerInteractState(mainPlayer, x, y - 1)
	end
end

function Va3ChessGameScene:updatePlayerInteractState(playerObj, targetX, targetY)
	local curX, curY = playerObj.originData.posX, playerObj.originData.posY
	local dir = Va3ChessMapUtils.ToDirection(curX, curY, targetX, targetY)

	Va3ChessGameController.instance:posCanWalk(targetX, targetY, dir, playerObj.objType)
end

function Va3ChessGameScene:onSetDirectionVisible(value)
	self:recycleAllDirItem()

	if not value then
		return
	end

	if value.visible then
		if not value.selectType then
			local selectType = Va3ChessEnum.ChessSelectType.Normal

			for i = 1, #value.posXList do
				local itemObj = self:createDirItem()

				self:addDirectionItem(itemObj, value.posXList[i], value.posYList[i])
				gohelper.setActive(itemObj.goNormal, Va3ChessEnum.ChessSelectType.Normal == selectType)
				gohelper.setActive(itemObj.goItem, Va3ChessEnum.ChessSelectType.UseItem == selectType)
				gohelper.setActive(itemObj.goCenter, false)
			end

			if value.selfPosX ~= nil and value.selfPosY ~= nil then
				local itemObj = self:createDirItem()

				self:addDirectionItem(itemObj, value.selfPosX, value.selfPosY)
				gohelper.setActive(itemObj.goNormal, false)
				gohelper.setActive(itemObj.goItem, false)
				gohelper.setActive(itemObj.goCenter, true)
			end

			self:delayRefreshAlarmArea()
		end
	else
		self:recycleAllAlarmItem()
	end
end

function Va3ChessGameScene:addDirectionItem(itemObj, tileX, tileY)
	gohelper.setActive(itemObj.go, true)

	local x, y, z = Va3ChessGameController.instance:calcTilePosInScene(tileX, tileY, Va3ChessEnum.AlarmOrder.DirItem)

	itemObj.tileX = tileX
	itemObj.tileY = tileY

	transformhelper.setLocalPos(itemObj.sceneTf, x, y, z)
end

function Va3ChessGameScene:_afterPlayStory()
	self:playAudio()
end

function Va3ChessGameScene:createAlarmItem(x, y, isManual, param)
	local isStatic = false
	local resPath = Va3ChessEnum.SceneResPath.AlarmItem3
	local showDirLine = {}
	local showOrangeStyle = false

	if type(param) == "table" then
		isStatic = param.isStatic or isStatic
		resPath = param.resPath or resPath
		showDirLine = param.showDirLine or showDirLine
		showOrangeStyle = param.showOrangeStyle or showOrangeStyle
	end

	local tileIndex = Va3ChessMapUtils.calPosIndex(x, y)
	local tileList = self._alarmItems[tileIndex]

	if tileList then
		for _, tileItem in ipairs(tileList) do
			if tileItem.resPath == resPath then
				return
			end
		end
	end

	local itemObj
	local pool = self._alarmItemPool[resPath]

	if pool then
		local poolLen = #pool

		if poolLen > 0 then
			itemObj = pool[poolLen]
			pool[poolLen] = nil
		end
	end

	if not itemObj then
		itemObj = self:getUserDataTb_()

		local assetItem = self._loader:getAssetItem(resPath)

		assetItem = assetItem or self._loader:getAssetItem(Va3ChessEnum.SceneResPath.AlarmItem)
		itemObj.go = gohelper.clone(assetItem:GetResource(), self._sceneGround, "alarmItem")
		itemObj.dir2GO = {}

		for _, tmpDir in pairs(Va3ChessEnum.Direction) do
			itemObj.dir2GO[tmpDir] = gohelper.findChild(itemObj.go, string.format("dir_%s", tmpDir))
		end

		itemObj.sceneTf = itemObj.go.transform
		itemObj.redStyle = gohelper.findChild(itemObj.go, "diban_red")
		itemObj.orangeStyle = gohelper.findChild(itemObj.go, "diban_orange")
	end

	for _, dirGO in pairs(itemObj.dir2GO) do
		if not gohelper.isNil(dirGO) then
			gohelper.setActive(dirGO, false)
		end
	end

	for _, dir in pairs(showDirLine) do
		local dirGO = itemObj.dir2GO[dir]

		if not gohelper.isNil(dirGO) then
			gohelper.setActive(dirGO, true)
		end
	end

	gohelper.setActive(itemObj.orangeStyle, showOrangeStyle)
	gohelper.setActive(itemObj.redStyle, not showOrangeStyle)
	gohelper.setActive(itemObj.go, true)

	local tmpX, tmpY, tmpZ = Va3ChessGameController.instance:calcTilePosInScene(x, y, Va3ChessEnum.AlarmOrder.AlarmItem)

	itemObj.tileX = x
	itemObj.tileY = y
	itemObj.isManual = isManual
	itemObj.isStatic = isStatic
	itemObj.resPath = resPath

	transformhelper.setLocalPos(itemObj.sceneTf, tmpX, tmpY, tmpZ)

	if not tileList then
		tileList = {}
		self._alarmItems[tileIndex] = tileList
	end

	tileList[#tileList + 1] = itemObj

	return itemObj
end

function Va3ChessGameScene:recycleAlarmItem(x, y, isManual)
	local tileIndex = Va3ChessMapUtils.calPosIndex(x, y)
	local alarmItemList = self._alarmItems[tileIndex]

	if not alarmItemList then
		return
	end

	for index, alarmItem in ipairs(alarmItemList) do
		gohelper.setActive(alarmItem.go, false)

		alarmItem.tileX = nil
		alarmItem.tileY = nil
		alarmItem.isManual = nil
		alarmItem.isStatic = nil

		local pool = self._alarmItemPool[alarmItem.resPath]

		if not pool then
			pool = {}
			self._alarmItemPool[alarmItem.resPath] = pool
		end

		table.insert(pool, alarmItem)

		alarmItemList[index] = nil
	end
end

function Va3ChessGameScene:recycleAllAlarmItem(recycleStaticAlarmItem)
	for _, alarmItemList in pairs(self._alarmItems) do
		for index, alarmItem in pairs(alarmItemList) do
			local notManual = not alarmItem.isManual
			local isStaticCanRecycle = recycleStaticAlarmItem or not alarmItem.isStatic

			if notManual and isStaticCanRecycle then
				gohelper.setActive(alarmItem.go, false)

				local pool = self._alarmItemPool[alarmItem.resPath]

				if not pool then
					pool = {}
					self._alarmItemPool[alarmItem.resPath] = pool
				end

				table.insert(pool, alarmItem)

				alarmItemList[index] = nil
			end
		end
	end
end

function Va3ChessGameScene:onAlarmAreaRefresh()
	if self._isWaitingRefreshAlarm then
		return
	end

	self._isWaitingRefreshAlarm = true

	TaskDispatcher.runDelay(self.delayRefreshAlarmArea, self, 0.001)
end

function Va3ChessGameScene:delayRefreshAlarmArea()
	TaskDispatcher.cancelTask(self.delayRefreshAlarmArea, self)

	self._isWaitingRefreshAlarm = false

	self:recycleAllAlarmItem(true)

	if not Va3ChessGameController.instance.interacts then
		return
	end

	local objList = Va3ChessGameController.instance.interacts:getList()

	if not objList then
		return
	end

	local alarmMap = {}

	for _, interactObj in ipairs(objList) do
		local handler = interactObj:getHandler()

		handler:onDrawAlert(alarmMap)
	end

	for x, yDict in pairs(alarmMap) do
		for y, paramList in pairs(yDict) do
			for _, param in pairs(paramList) do
				self:createAlarmItem(x, y, nil, param)
			end
		end
	end
end

function Va3ChessGameScene:refreshAlarmAreaOnXY(x, y, show)
	if show then
		self:createAlarmItem(x, y, true)
	else
		self:recycleAlarmItem(x, y)
	end
end

function Va3ChessGameScene:onResultQuit()
	self:closeThis()
end

function Va3ChessGameScene:handleResetByResult()
	if self._sceneAnim then
		self._sceneAnim:Play("open", 0, 0)
	end
end

function Va3ChessGameScene:playEnterAnim()
	if self._sceneAnim then
		self._sceneAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function Va3ChessGameScene:_guideClickTile(param)
	local list = string.splitToNumber(param, "_")
	local tileX = list[1]
	local tileY = list[2]

	self:onClickChessPos(tileX, tileY)
end

function Va3ChessGameScene:onClickContainer()
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	local tempPos = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), self._tfTouch)
	local tileX, tileY = Va3ChessGameController.instance:getNearestScenePos(tempPos.x, tempPos.y)

	if tileX then
		local tileIndex = Va3ChessMapUtils.calPosIndex(tileX, tileY)

		logNormal("click Scene tileX, tileY : " .. tostring(tileX) .. ", " .. tostring(tileY) .. " index: " .. tileIndex)
		self:onClickChessPos(tileX, tileY)
	end
end

function Va3ChessGameScene:onClickChessPos(x, y)
	local evtMgr = Va3ChessGameController.instance.event

	if evtMgr and evtMgr:getCurEvent() then
		local evt = evtMgr:getCurEvent()

		if evt then
			evt:onClickPos(x, y, true)
		end
	end
end

function Va3ChessGameScene:getBaseTile(x, y)
	return self._baseTiles[x + 1][y + 1]
end

return Va3ChessGameScene
