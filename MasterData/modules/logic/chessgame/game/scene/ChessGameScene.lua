-- chunkname: @modules/logic/chessgame/game/scene/ChessGameScene.lua

module("modules.logic.chessgame.game.scene.ChessGameScene", package.seeall)

local ChessGameScene = class("ChessGameScene", BaseViewExtended)

function ChessGameScene:onInitView()
	self._gotouch = gohelper.findChild(self.viewGO, "#go_touch")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ChessGameScene:_editableInitView()
	self._tfTouch = self._gotouch.transform
	self._click = SLFramework.UGUI.UIClickListener.Get(self._gotouch)

	self._click:AddClickListener(self.onClickContainer, self)

	self._baseTiles = {}
	self._baseTilePool = {}
	self._dirItems = {}
	self._dirItemPool = {}
	self._alarmItems = {}
	self._alarmItemPool = {}
	self._interactItemList = {}
	self._baffleItems = {}
	self._baffleItemPool = {}
	self._avatarMap = {}
	self.loadDoneInteractList = {}
	self.needLoadInteractIdList = {}
	self._fixedOrder = 0

	MainCameraMgr.instance:addView(self.viewName, self.initCamera, nil, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.DeleteInteractAvatar, self.deleteInteractObj, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.AddInteractObj, self.createOrUpdateInteractItem, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.ChangeMap, self.changeMap, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.GamePointReturn, self._onGamePointReturn, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.SetAlarmAreaVisible, self.onSetAlarmAreaVisible, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.SetNeedChooseDirectionVisible, self.onSetDirectionVisible, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.GameReset, self.onResetGame, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.GameMapDataUpdate, self.onGameDataUpdate, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.GameResultQuit, self.onResultQuit, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.PlayStoryFinish, self._onPlayStoryFinish, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.onScreenResize, self)
	self:createSceneRoot()
	self:loadRes()
end

function ChessGameScene:createSceneRoot()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("ChessGameScene")
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

function ChessGameScene:initCamera()
	if self._isInitCamera then
		return
	end

	self._isInitCamera = true

	self:onScreenResize()
end

function ChessGameScene:onScreenResize()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale(true)

	camera.orthographicSize = 7.5 * scale
end

function ChessGameScene:_onPlayStoryFinish()
	ChessGameController.instance:setSceneCamera(true)
end

function ChessGameScene:loadRes()
	UIBlockMgr.instance:startBlock(ChessGameScene.BLOCK_KEY)

	self._loader = MultiAbLoader.New()

	self._loader:addPath(self:getCurrentSceneUrl())
	self._loader:addPath(self:getGroundItemUrl())
	self._loader:addPath(ChessGameEnum.SceneResPath.DirItem)
	self._loader:addPath(ChessGameEnum.SceneResPath.AlarmItem)
	self:onLoadRes()
	self._loader:startLoad(self.loadResCompleted, self)
end

function ChessGameScene:onLoadRes()
	return
end

function ChessGameScene:onloadResCompleted(loader)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Finish, true)
end

function ChessGameScene:getGroundItemUrl()
	return ChessGameEnum.NodePath
end

function ChessGameScene:getCurrentSceneUrl()
	return ChessGameModel.instance:getNowMapResPath()
end

function ChessGameScene:onOpen()
	return
end

function ChessGameScene:loadResCompleted(loader)
	local assetItem = loader:getAssetItem(ChessGameModel.instance:getNowMapResPath())

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
		ChessGameController.instance:autoSelectPlayer()
	end

	UIBlockMgr.instance:endBlock(ChessGameScene.BLOCK_KEY)

	local episodeId = ChessModel.instance:getEpisodeId()

	ChessController.instance:dispatchEvent(ChessGameEvent.GuideOnEnterEpisode, tostring(episodeId))
end

function ChessGameScene:changeMap(newMapUrl)
	if not newMapUrl then
		return
	end

	if not self._oldLoader then
		self._oldLoader = self._loader
		self._oldSceneGo = self._sceneGo
	elseif self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	local url = newMapUrl

	ChessGameModel.instance:setNowMapResPath(url)
	self:loadRes()
end

function ChessGameScene:playEnterAnim()
	if self._sceneAnim then
		self._sceneAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function ChessGameScene:playAudio()
	local actId = ChessGameModel.instance:getActId()

	if actId then
		local mapCo = ChessGameConfig.instance:getMapCo(actId)

		self:stopAudio()

		if mapCo and mapCo.audioAmbient ~= 0 then
			self._triggerAmbientId = AudioMgr.instance:trigger(mapCo.audioAmbient)
		end
	end
end

function ChessGameScene:fillChessBoardBase()
	self:resetTiles()

	local nodeList = ChessGameNodeModel.instance:getAllNodes()

	for x, xlist in pairs(nodeList) do
		self._baseTiles[x] = self._baseTiles[x] or {}

		for y, node in pairs(xlist) do
			local tileItem = self:createTileBaseItem(x, y)

			self._baseTiles[x][y] = tileItem

			self:onTileItemCreate(x, y, tileItem)
		end
	end
end

function ChessGameScene:onTileItemCreate(x, y, tileItem)
	return
end

function ChessGameScene:createTileBaseItem(x, y)
	local tileObj = self._baseTiles[x][y]

	if not self._baseTiles[x][y] then
		tileObj = self:getUserDataTb_()

		local resPath = self:getGroundItemUrl(x, y)
		local assetItem = self._loader:getAssetItem(resPath)
		local itemGo = gohelper.clone(assetItem:GetResource(), self._sceneBackground, "tilebase_" .. x .. "_" .. y)

		tileObj.go = itemGo
		tileObj.sceneTf = itemGo.transform
		tileObj.pos = {
			x = x,
			y = y
		}
	end

	gohelper.setActive(tileObj.go, true)

	tileObj.sceneTf.position = Vector3(x, y, 0)

	self:setTileBasePosition(tileObj.sceneTf)

	return tileObj
end

function ChessGameScene:setTileBasePosition(transform)
	local v3 = ChessGameHelper.nodePosToWorldPos(transform.position)

	transformhelper.setLocalPos(transform, v3.x, v3.y, v3.z)
end

function ChessGameScene:createAllInteractObjs()
	if not ChessGameController.instance.interactsMgr then
		return
	end

	local list = ChessGameController.instance.interactsMgr:getList()

	for _, interactcomp in ipairs(list) do
		if interactcomp:isShow() then
			self:createOrUpdateInteractItem(interactcomp)
		end
	end

	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.AllObjectCreated, self.createAllInteractObjs, self)
end

function ChessGameScene:createOrUpdateInteractItem(interactcomp)
	if gohelper.isNil(self._sceneContainer) then
		logNormal("ChessGameScene: game is already end")

		return
	end

	local avatarObj = self._avatarMap[interactcomp.id]

	if not avatarObj then
		avatarObj = self:getUserDataTb_()
		avatarObj.sceneGo = UnityEngine.GameObject.New("item_" .. interactcomp.id)
		avatarObj.sceneTf = avatarObj.sceneGo.transform
		avatarObj.loader = PrefabInstantiate.Create(avatarObj.sceneGo)

		avatarObj.sceneTf:SetParent(self._sceneContainer.transform, false)

		self._avatarMap[interactcomp.id] = avatarObj
	end

	interactcomp:setAvatar(avatarObj)
end

function ChessGameScene:deleteInteractObj(id)
	self._avatarMap[id] = nil
end

function ChessGameScene:onSetDirectionVisible(value)
	self:recycleAllDirItem()

	if not value then
		return
	end

	if value.visible then
		if not value.selectType then
			local selectType = ChessGameEnum.ChessSelectType.Normal

			for i = 1, #value.posXList do
				local itemObj = self:createDirItem()

				self:addDirectionItem(itemObj, value.posXList[i], value.posYList[i])

				local targetdir = value.dirList[i]

				for _, dir in pairs(ChessGameEnum.Direction) do
					gohelper.setActive(itemObj["goDir" .. dir], dir == targetdir)
				end

				gohelper.setActive(itemObj.goNormal, ChessGameEnum.ChessSelectType.Normal == selectType)
				gohelper.setActive(itemObj.goItem, ChessGameEnum.ChessSelectType.CatchObj == selectType)
				gohelper.setActive(itemObj.goCenter, false)
			end

			if value.selfPosX ~= nil and value.selfPosY ~= nil then
				local itemObj = self:createDirItem()

				self:addDirectionItem(itemObj, value.selfPosX, value.selfPosY)
				gohelper.setActive(itemObj.goNormal, false)
				gohelper.setActive(itemObj.goItem, false)
				gohelper.setActive(itemObj.goCenter, true)
			end

			if ChessGameEnum.ChessSelectType.Normal == selectType then
				local posXList = {
					value.selfPosX + 1,
					value.selfPosX - 1,
					value.selfPosX,
					value.selfPosX
				}
				local posYList = {
					value.selfPosY,
					value.selfPosY,
					value.selfPosY + 1,
					value.selfPosY - 1
				}

				ChessGameController.instance:checkInteractCanUse(posXList, posYList)
			end
		end
	end
end

function ChessGameScene:recycleAllDirItem()
	for k, v in pairs(self._dirItems) do
		gohelper.setActive(v.go, false)
		table.insert(self._dirItemPool, v)

		self._dirItems[k] = nil
	end
end

function ChessGameScene:createDirItem()
	local itemObj
	local poolLen = #self._dirItemPool

	if poolLen > 0 then
		itemObj = self._dirItemPool[poolLen]
		self._dirItemPool[poolLen] = nil
	end

	if not itemObj then
		itemObj = self:getUserDataTb_()

		local assetItem = self._loader:getAssetItem(ChessGameEnum.SceneResPath.DirItem)

		itemObj.go = gohelper.clone(assetItem:GetResource(), self._sceneGround, "dirItem")
		itemObj.sceneTf = itemObj.go.transform
		itemObj.goCenter = gohelper.findChild(itemObj.go, "#go_center")
		itemObj.goNormal = gohelper.findChild(itemObj.go, "#go_normal")
		itemObj.goItem = gohelper.findChild(itemObj.go, "#go_item")

		for _, dir in pairs(ChessGameEnum.Direction) do
			itemObj["goDir" .. dir] = gohelper.findChild(itemObj.goItem, "jiantou_" .. dir)
		end
	end

	table.insert(self._dirItems, itemObj)

	return itemObj
end

function ChessGameScene:addDirectionItem(itemObj, tileX, tileY)
	gohelper.setActive(itemObj.go, true)

	local pos = {
		z = 0,
		x = tileX,
		y = tileY
	}
	local v3 = ChessGameHelper.nodePosToWorldPos(pos)

	itemObj.tileX = tileX
	itemObj.tileY = tileY

	transformhelper.setLocalPos(itemObj.sceneTf, v3.x, v3.y, v3.z)
end

function ChessGameScene:onSetAlarmAreaVisible(value)
	self:recycleAllAlarmItem()

	if not value then
		return
	end

	if value.visible then
		self:refreshAlarmArea()
	end
end

function ChessGameScene:refreshAlarmArea()
	self._isWaitingRefreshAlarm = false

	if not ChessGameController.instance.interactsMgr then
		return
	end

	local objList = ChessGameController.instance.interactsMgr:getList()

	if not objList then
		return
	end

	local alarmMap = {}

	for _, interactObj in ipairs(objList) do
		if interactObj.objType == ChessGameEnum.InteractType.Hunter then
			local handler = interactObj:getHandler()

			handler:onDrawAlert(alarmMap)
		end
	end

	for x, yDict in pairs(alarmMap) do
		for y, paramList in pairs(yDict) do
			for _, param in pairs(paramList) do
				self:createAlarmItem(x, y, nil, param)
			end
		end
	end
end

function ChessGameScene:recycleAllAlarmItem(recycleStaticAlarmItem)
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

function ChessGameScene:createAlarmItem(x, y, isManual, param)
	local isStatic = false
	local resPath = ChessGameEnum.SceneResPath.AlarmItem

	resPath = type(param) == "table" and param.resPath or resPath

	local tileIndex = ChessGameHelper.calPosIndex(x, y)
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

		assetItem = assetItem or self._loader:getAssetItem(ChessGameEnum.SceneResPath.AlarmItem)
		itemObj.go = gohelper.clone(assetItem:GetResource(), self._sceneGround, "alarmItem")
		itemObj.sceneTf = itemObj.go.transform
	end

	gohelper.setActive(itemObj.go, true)

	local pos = {
		z = 0,
		x = x,
		y = y
	}
	local v3 = ChessGameHelper.nodePosToWorldPos(pos)

	itemObj.tileX = x
	itemObj.tileY = y
	itemObj.isManual = isManual
	itemObj.isStatic = isStatic
	itemObj.resPath = resPath

	transformhelper.setLocalPos(itemObj.sceneTf, v3.x, v3.y, v3.z)

	if not tileList then
		tileList = {}
		self._alarmItems[tileIndex] = tileList
	end

	tileList[#tileList + 1] = itemObj

	return itemObj
end

function ChessGameScene:addNeedLoadInteractList(interactId)
	if not tabletool.indexOf(self.needLoadInteractIdList, interactId) then
		table.insert(self.needLoadInteractIdList, interactId)
	end
end

function ChessGameScene:findInteractItem(interactId)
	for _, interactItem in ipairs(self._interactItemList) do
		if interactItem.id == interactId then
			return interactItem
		end
	end
end

function ChessGameScene:getPlayerInteractItem()
	return self.playerInteractItem
end

function ChessGameScene:setInteractObjActive(interactId, active)
	local interactItem = self:findInteractItem(interactId)

	if not interactItem then
		return
	end

	interactItem:setActive(active)
end

function ChessGameScene:onClickContainer(param, clickPosition)
	if ChessGameController.instance:isNeedBlock() then
		return
	end

	local mainCamera = CameraMgr.instance:getMainCamera()
	local worldpos = recthelper.screenPosToWorldPos(GamepadController.instance:getMousePosition(), mainCamera, self._sceneBackground.transform.position)

	logNormal("click Scene wolrdX, worldY : " .. tostring(worldpos.x) .. ", " .. tostring(worldpos.y))

	local pos = {
		x = worldpos.x,
		y = worldpos.y - self._sceneOffsetY,
		z = worldpos.z
	}
	local nodeXY = ChessGameHelper.worldPosToNodePos(pos)

	logNormal("click Scene X, Y : " .. tostring(nodeXY.x) .. ", " .. tostring(nodeXY.y))

	if nodeXY then
		self:onClickChessPos(nodeXY.x, nodeXY.y)
	end
end

function ChessGameScene:onClickChessPos(x, y)
	local evtMgr = ChessGameController.instance.eventMgr

	if evtMgr and evtMgr:getCurEvent() then
		local evt = evtMgr:getCurEvent()

		if evt then
			evt:onClickPos(x, y, true)
		end
	end
end

function ChessGameScene:_guideClickTile(param)
	local list = string.splitToNumber(param, "_")
	local tileX = list[1]
	local tileY = list[2]

	self:onClickChessPos(tileX, tileY)
end

function ChessGameScene:recycleAllInteract()
	for _, interactItem in ipairs(self._interactItemList) do
		interactItem:deleteSelf()
	end
end

function ChessGameScene:disposeInteractItem()
	for _, interactItem in ipairs(self._interactItemList) do
		interactItem:dispose()
	end

	self._interactItemList = nil
end

function ChessGameScene:disposeBaffle()
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

function ChessGameScene:disposeSceneRoot()
	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end
end

function ChessGameScene:releaseLoader()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function ChessGameScene:refreshNearInteractIcon()
	local player = ChessGameController.instance.interactsMgr:getMainPlayer()

	player:getHandler():calCanWalkArea()
end

function ChessGameScene:onCancelSelectInteract(interactId)
	local interactItem = self:findInteractItem(interactId)

	if interactItem and not interactItem.delete and interactItem:getHandler() then
		interactItem:getHandler():onCancelSelect()
	end
end

function ChessGameScene:onGameDataUpdate()
	if not ChessGameController.instance:getSelectObj() then
		ChessGameController.instance:autoSelectPlayer(true)
	end
end

function ChessGameScene:onResetGame()
	self:fillChessBoardBase()
	ChessGameController.instance:setSelectObj(nil)
	ChessGameController.instance:autoSelectPlayer(true)
end

function ChessGameScene:resetTiles()
	for _, yList in pairs(self._baseTiles) do
		for _, tileObj in pairs(yList) do
			gohelper.setActive(tileObj.go, false)
		end
	end
end

function ChessGameScene:onClose()
	if not ChessGameModel.instance:getGameState() then
		ChessStatController.instance:statAbort()
	end
end

function ChessGameScene:resetCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = 5
	camera.orthographic = false
end

function ChessGameScene:onResultQuit()
	self:closeThis()
end

function ChessGameScene:onDestroyView()
	if self._click then
		self._click:RemoveClickListener()

		self._click = nil
	end

	self._baseTiles = nil
	self._alarmItemPool = {}

	self:resetCamera()
	self:disposeSceneRoot()
	self:releaseLoader()
end

return ChessGameScene
