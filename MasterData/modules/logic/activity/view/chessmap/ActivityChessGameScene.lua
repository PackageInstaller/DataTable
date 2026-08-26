-- chunkname: @modules/logic/activity/view/chessmap/ActivityChessGameScene.lua

module("modules.logic.activity.view.chessmap.ActivityChessGameScene", package.seeall)

local ActivityChessGameScene = class("ActivityChessGameScene", BaseView)

function ActivityChessGameScene:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gochessboard = gohelper.findChild(self.viewGO, "scroll/viewport/#go_content/#go_chessboard")
	self._gotouch = gohelper.findChild(self.viewGO, "#go_touch")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityChessGameScene:addEvents()
	return
end

function ActivityChessGameScene:removeEvents()
	return
end

ActivityChessGameScene.BLOCK_KEY = "ActivityChessGameSceneLoading"

function ActivityChessGameScene:_editableInitView()
	self._tfTouch = self._gotouch.transform
	self._click = SLFramework.UGUI.UIClickListener.Get(self._gotouch)

	self._click:AddClickListener(self.onClickContainer, self)

	self._handler = ActivityChessGameHandler.New()

	self._handler:init(self)

	self._baseTiles = {}
	self._baseTilePool = {}
	self._dirItems = {}
	self._dirItemPool = {}
	self._alarmItems = {}
	self._alarmItemPool = {}
	self._avatars = {}
	self._fixedOrder = 0

	self:createSceneRoot()
	self:initCamera()
	ActivityChessGameController.instance:initSceneTree(self._gotouch, self._sceneOffsetY)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.onScreenResize, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.DestroyViewFinish, self.onDestroyOtherView, self)
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.InteractObjectCreated, self.createInteractObj, self)
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.DeleteInteractAvatar, self.deleteInteractObj, self)
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.ResetMapView, self.onResetMapView, self)
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.SetNeedChooseDirectionVisible, self.onSetDirectionVisible, self)
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.GameReset, self.onResetGame, self)
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.RefreshAlarmArea, self.onAlarmAreaRefresh, self)
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.GameMapDataUpdate, self.onGameDataUpdate, self)
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.GuideClickTile, self._guideClickTile, self)
	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.ResetGameByResultView, self.handleResetByResult, self)
	self:loadRes()
end

function ActivityChessGameScene:onDestroyView()
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

function ActivityChessGameScene:onOpen()
	return
end

function ActivityChessGameScene:onOpenFinish()
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.GameViewOpened, self.viewParam)
end

function ActivityChessGameScene:onClose()
	UIBlockMgr.instance:endBlock(ActivityChessGameScene.BLOCK_KEY)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.Stop)
end

function ActivityChessGameScene:playAudio()
	local actId = ActivityChessGameModel.instance:getActId()
	local mapId = ActivityChessGameModel.instance:getMapId()

	if actId and mapId then
		local mapCo = Activity109Config.instance:getMapCo(actId, mapId)

		if mapCo then
			AudioMgr.instance:trigger(mapCo.audioAmbient)
		end
	end
end

function ActivityChessGameScene:onDestroyOtherView(name)
	self:onScreenResize()
end

function ActivityChessGameScene:onScreenResize()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale(true)

	camera.orthographicSize = 7.5 * scale
end

function ActivityChessGameScene:initCamera()
	if self._isInitCamera then
		return
	end

	self._isInitCamera = true

	self:onScreenResize()
end

function ActivityChessGameScene:resetCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = 5
	camera.orthographic = false
end

function ActivityChessGameScene:loadRes()
	UIBlockMgr.instance:startBlock(ActivityChessGameScene.BLOCK_KEY)

	self._loader = MultiAbLoader.New()

	self._loader:addPath(self:getCurrentSceneUrl())
	self._loader:addPath(ActivityChessEnum.SceneResPath.GroundItem)
	self._loader:addPath(ActivityChessEnum.SceneResPath.DirItem)
	self._loader:addPath(ActivityChessEnum.SceneResPath.AlarmItem)
	self._loader:startLoad(self.onLoadResCompleted, self)
end

function ActivityChessGameScene:getCurrentSceneUrl()
	local mapId = ActivityChessGameModel.instance:getMapId()
	local actId = ActivityChessGameModel.instance:getActId()
	local mapCo = Activity109Config.instance:getMapCo(actId, mapId)

	if mapCo and not string.nilorempty(mapCo.bgPath) then
		return string.format(ActivityChessEnum.SceneResPath.SceneFormatPath, mapCo.bgPath)
	else
		return ActivityChessEnum.SceneResPath.DefaultScene
	end
end

function ActivityChessGameScene:onLoadResCompleted(loader)
	local assetItem = loader:getAssetItem(self:getCurrentSceneUrl())

	if assetItem then
		self._sceneGo = gohelper.clone(assetItem:GetResource(), self._sceneRoot, "scene")
		self._sceneAnim = self._sceneGo:GetComponent(typeof(UnityEngine.Animator))
		self._sceneBackground = UnityEngine.GameObject.New("background")
		self._sceneGround = UnityEngine.GameObject.New("ground")
		self._sceneContainer = UnityEngine.GameObject.New("container")

		self._sceneBackground.transform:SetParent(self._sceneGo.transform, false)
		self._sceneGround.transform:SetParent(self._sceneGo.transform, false)
		self._sceneContainer.transform:SetParent(self._sceneGo.transform, false)
		transformhelper.setLocalPos(self._sceneBackground.transform, 0, 0, -0.5)
		transformhelper.setLocalPos(self._sceneGround.transform, 0, 0, -1)
		transformhelper.setLocalPos(self._sceneContainer.transform, 0, 0, -1.5)
		self:fillChessBoardBase()
		self:createAllInteractObjs()

		if not ActivityChessGameController.instance:getSelectObj() then
			ActivityChessGameController.instance:autoSelectPlayer()
		end

		self:playEnterAnim()
		self:playAudio()
	end

	UIBlockMgr.instance:endBlock(ActivityChessGameScene.BLOCK_KEY)
end

function ActivityChessGameScene:releaseRes()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function ActivityChessGameScene:createSceneRoot()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("ChessMap")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)

	self._sceneOffsetY = y

	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function ActivityChessGameScene:disposeSceneRoot()
	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end
end

function ActivityChessGameScene:fillChessBoardBase()
	local w, h = ActivityChessGameModel.instance:getGameSize()

	logNormal("fill w = " .. tostring(w) .. ", h = " .. tostring(h))

	for x = 1, w do
		self._baseTiles[x] = self._baseTiles[x] or {}

		for y = 1, h do
			local tileItem = self:createTileBaseItem(x - 1, y - 1)

			self._baseTiles[x][y] = tileItem

			local tileData = ActivityChessGameModel.instance:getBaseTile(x - 1, y - 1)

			gohelper.setActive(tileItem.go, tileData == ActivityChessEnum.TileBaseType.Normal)
		end
	end
end

function ActivityChessGameScene:createTileBaseItem(x, y)
	local tileObj
	local poolLen = #self._baseTilePool

	if poolLen > 0 then
		tileObj = self._baseTilePool[poolLen]
		self._baseTilePool[poolLen] = nil
	end

	if not tileObj then
		tileObj = self:getUserDataTb_()

		local assetItem = self._loader:getAssetItem(ActivityChessEnum.SceneResPath.GroundItem)
		local itemGo = gohelper.clone(assetItem:GetResource(), self._sceneBackground, "tilebase_" .. x .. "_" .. y)

		tileObj.go = itemGo
		tileObj.sceneTf = itemGo.transform
	end

	self:setTileBasePosition(tileObj, x, y)

	return tileObj
end

function ActivityChessGameScene:setTileBasePosition(tileObj, x, y)
	local sceneX, sceneY, sceneZ = ActivityChessGameController.instance:calcTilePosInScene(x, y)

	transformhelper.setLocalPos(tileObj.sceneTf, sceneX, sceneY, sceneZ)
end

function ActivityChessGameScene:resetTiles()
	for x, yList in pairs(self._baseTiles) do
		for y, tileObj in pairs(yList) do
			table.insert(self._baseTilePool, self._baseTiles[x][y])
		end
	end

	self._baseTiles = {}

	self:fillChessBoardBase()
end

function ActivityChessGameScene:createAllInteractObjs()
	logNormal("createAllObjects")

	if not ActivityChessGameController.instance.interacts then
		return
	end

	local list = ActivityChessGameController.instance.interacts:getList()

	table.sort(list, ActivityChessInteractMgr.sortRenderOrder)

	for _, interactObj in ipairs(list) do
		self:createInteractObj(interactObj)
	end

	self.addEventCb(self, ActivityChessGameController.instance, ActivityChessEvent.AllObjectCreated, self.createAllInteractObjs, self)
end

function ActivityChessGameScene:createInteractObj(interactObj)
	local order = ActivityChessInteractMgr.getRenderOrder(interactObj)
	local avatarObj = self:getUserDataTb_()

	avatarObj.sceneGo = UnityEngine.GameObject.New("item_" .. interactObj.id)
	avatarObj.sceneTf = avatarObj.sceneGo.transform
	avatarObj.loader = PrefabInstantiate.Create(avatarObj.sceneGo)

	avatarObj.sceneTf:SetParent(self._sceneContainer.transform, false)

	avatarObj.order = order + self._fixedOrder
	self._fixedOrder = self._fixedOrder + 0.01

	interactObj:setAvatar(avatarObj)
	table.insert(self._avatars, avatarObj)
end

function ActivityChessGameScene:deleteInteractObj(avatarObj)
	tabletool.removeValue(self._avatars, avatarObj)
end

function ActivityChessGameScene:createDirItem()
	local itemObj
	local poolLen = #self._dirItemPool

	if poolLen > 0 then
		itemObj = self._dirItemPool[poolLen]
		self._dirItemPool[poolLen] = nil
	end

	if not itemObj then
		itemObj = self:getUserDataTb_()

		local assetItem = self._loader:getAssetItem(ActivityChessEnum.SceneResPath.DirItem)

		itemObj.go = gohelper.clone(assetItem:GetResource(), self._sceneGround, "dirItem")
		itemObj.sceneTf = itemObj.go.transform
		itemObj.goCenter = gohelper.findChild(itemObj.go, "#go_center")
		itemObj.goNormal = gohelper.findChild(itemObj.go, "#go_normal")
		itemObj.goItem = gohelper.findChild(itemObj.go, "#go_item")
	end

	table.insert(self._dirItems, itemObj)

	return itemObj
end

function ActivityChessGameScene:recycleAllDirItem()
	for k, v in pairs(self._dirItems) do
		gohelper.setActive(v.go, false)
		table.insert(self._dirItemPool, v)

		self._dirItems[k] = nil
	end
end

function ActivityChessGameScene:createAlarmItem()
	local itemObj
	local poolLen = #self._alarmItemPool

	if poolLen > 0 then
		itemObj = self._alarmItemPool[poolLen]
		self._alarmItemPool[poolLen] = nil
	end

	if not itemObj then
		itemObj = self:getUserDataTb_()

		local assetItem = self._loader:getAssetItem(ActivityChessEnum.SceneResPath.AlarmItem)

		itemObj.go = gohelper.clone(assetItem:GetResource(), self._sceneGround, "alarmItem")
		itemObj.sceneTf = itemObj.go.transform
	end

	table.insert(self._alarmItems, itemObj)

	return itemObj
end

function ActivityChessGameScene:recycleAllAlarmItem()
	for k, v in pairs(self._alarmItems) do
		gohelper.setActive(v.go, false)
		table.insert(self._alarmItemPool, v)

		self._alarmItems[k] = nil
	end
end

function ActivityChessGameScene:onResetMapView()
	self:resetTiles()
end

function ActivityChessGameScene:onResetGame()
	self._fixedOrder = 1

	self:playEnterAnim()
end

function ActivityChessGameScene:onGameDataUpdate()
	if not ActivityChessGameController.instance:getSelectObj() then
		ActivityChessGameController.instance:autoSelectPlayer()
	end
end

function ActivityChessGameScene:onSetDirectionVisible(value)
	self:recycleAllDirItem()

	if value and value.visible then
		if not value.selectType then
			local selectType = ActivityChessEnum.ChessSelectType.Normal

			for i = 1, #value.posXList do
				local itemObj = self:createDirItem()

				self:addDirectionItem(itemObj, value.posXList[i], value.posYList[i])
				gohelper.setActive(itemObj.goNormal, ActivityChessEnum.ChessSelectType.Normal == selectType)
				gohelper.setActive(itemObj.goItem, ActivityChessEnum.ChessSelectType.UseItem == selectType)
				gohelper.setActive(itemObj.goCenter, false)
			end

			if value.selfPosX ~= nil and value.selfPosY ~= nil then
				local itemObj = self:createDirItem()

				self:addDirectionItem(itemObj, value.selfPosX, value.selfPosY)
				gohelper.setActive(itemObj.goNormal, false)
				gohelper.setActive(itemObj.goItem, false)
				gohelper.setActive(itemObj.goCenter, true)
			end
		end
	end
end

function ActivityChessGameScene:addDirectionItem(itemObj, tileX, tileY)
	gohelper.setActive(itemObj.go, true)

	local x, y, z = ActivityChessGameController.instance:calcTilePosInScene(tileX, tileY)

	itemObj.tileX = tileX
	itemObj.tileY = tileY

	transformhelper.setLocalPos(itemObj.sceneTf, x, y, z)
end

function ActivityChessGameScene:onAlarmAreaRefresh()
	if self._isWaitingRefreshAlarm then
		return
	end

	self._isWaitingRefreshAlarm = true

	TaskDispatcher.runDelay(self.delayRefreshAlarmArea, self, 0.001)
end

function ActivityChessGameScene:delayRefreshAlarmArea()
	TaskDispatcher.cancelTask(self.delayRefreshAlarmArea, self)

	self._isWaitingRefreshAlarm = false

	self:recycleAllAlarmItem()

	if not ActivityChessGameController.instance.interacts then
		return
	end

	local objList = ActivityChessGameController.instance.interacts:getList()

	if not objList then
		return
	end

	local alarmMap = {}

	for _, interactObj in ipairs(objList) do
		local handler = interactObj:getHandler()

		handler:onDrawAlert(alarmMap)
	end

	for x, yDict in pairs(alarmMap) do
		for y, value in pairs(yDict) do
			local itemObj = self:createAlarmItem()

			gohelper.setActive(itemObj.go, true)

			local tmpX, tmpY, tmpZ = ActivityChessGameController.instance:calcTilePosInScene(x, y)

			itemObj.tileX = x
			itemObj.tileY = y

			transformhelper.setLocalPos(itemObj.sceneTf, tmpX, tmpY, tmpZ)
		end
	end
end

function ActivityChessGameScene:handleResetByResult()
	if self._sceneAnim then
		self._sceneAnim:Play("open", 0, 0)
	end
end

function ActivityChessGameScene:playEnterAnim()
	if self._sceneAnim then
		self._sceneAnim:Play(UIAnimationName.Open, 0, 0)
	end

	local episodeId = Activity109ChessModel.instance:getEpisodeId()

	Activity109ChessController.instance:dispatchEvent(ActivityChessEvent.GuideOnEnterMap, tostring(episodeId))
end

function ActivityChessGameScene:_guideClickTile(param)
	local list = string.splitToNumber(param, "_")
	local tileX = list[1]
	local tileY = list[2]

	self:onClickChessPos(tileX, tileY)
end

function ActivityChessGameScene:onClickContainer()
	local tempPos = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), self._tfTouch)
	local tileX, tileY = ActivityChessGameController.instance:getNearestScenePos(tempPos.x, tempPos.y)

	if tileX then
		logNormal("click Scene tileX, tileY : " .. tostring(tileX) .. ", " .. tostring(tileY))
		self:onClickChessPos(tileX, tileY)
	end
end

function ActivityChessGameScene:onClickChessPos(x, y)
	if not ActivityChessGameController.instance:checkInActivityDuration() then
		return
	end

	local evtMgr = ActivityChessGameController.instance.event

	if evtMgr and evtMgr:getCurEvent() then
		local evt = evtMgr:getCurEvent()

		if evt then
			evt:onClickPos(x, y, true)
		end
	end
end

function ActivityChessGameScene:getBaseTile(x, y)
	return self._baseTiles[x + 1][y + 1]
end

return ActivityChessGameScene
