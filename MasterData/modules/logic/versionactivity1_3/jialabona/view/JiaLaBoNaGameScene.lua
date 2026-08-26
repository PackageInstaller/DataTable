-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaGameScene.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaGameScene", package.seeall)

local JiaLaBoNaGameScene = class("JiaLaBoNaGameScene", Va3ChessGameScene)

function JiaLaBoNaGameScene:_editableInitView()
	self._posuiGroundTbList = {}

	JiaLaBoNaGameScene.super._editableInitView(self)
end

function JiaLaBoNaGameScene:addEvents()
	return
end

function JiaLaBoNaGameScene:resetCamera()
	if not ViewMgr.instance:isOpen(ViewName.JiaLaBoNaMapView) then
		JiaLaBoNaGameScene.super.resetCamera(self)
	end
end

function JiaLaBoNaGameScene:_getGroundItemUrlList()
	local mapId = Va3ChessGameModel.instance:getMapId()
	local actId = Va3ChessGameModel.instance:getActId()

	if self._groundItemUrlList and self._lastActId == actId and self._lastMapId == mapId then
		return self._groundItemUrlList
	end

	self._lastActId = actId
	self._lastMapId = mapId
	self._groundItemUrlList = {}

	local mapCo = Va3ChessConfig.instance:getMapCo(actId, mapId)

	if mapCo and mapCo.groundItems and not string.nilorempty(mapCo.groundItems) then
		local paths = string.split(mapCo.groundItems, "#")

		if paths and #paths > 0 then
			for _, path in ipairs(paths) do
				if not string.nilorempty(path) then
					table.insert(self._groundItemUrlList, string.format(Va3ChessEnum.SceneResPath.AvatarItemPath, path))
				end
			end
		end
	end

	if #self._groundItemUrlList < 1 then
		table.insert(self._groundItemUrlList, Va3ChessEnum.SceneResPath.GroundItem)
	end

	return self._groundItemUrlList
end

function JiaLaBoNaGameScene:onLoadRes()
	local urlList = self:_getGroundItemUrlList()

	for _, resPath in ipairs(urlList) do
		self._loader:addPath(resPath)
	end

	self._loader:addPath(JiaLaBoNaEnum.SceneResPath.GroundPoSui)
end

function JiaLaBoNaGameScene:getGroundItemUrl()
	local urlList = self:_getGroundItemUrlList()

	if urlList and #urlList > 0 then
		local index = math.random(1, #urlList)

		return urlList[index]
	end

	return Va3ChessEnum.SceneResPath.GroundItem
end

function JiaLaBoNaGameScene:_initEventCb()
	if self._isFinshInitEventCb then
		return
	end

	self._isFinshInitEventCb = true

	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, self._onEnterNextMap, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.TilePosuiTrigger, self._onTilePosuiTrigger, self)
	self.addEventCb(self, JiaLaBoNaController.instance, JiaLaBoNaEvent.GamePointReturn, self._onGamePointReturn, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, self.onGameDataUpdate, self)
	JiaLaBoNaGameScene.super.addEvents(self)
end

function JiaLaBoNaGameScene:_onEnterNextMap()
	self:_checkLoadMapScene()
	self:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer()
end

function JiaLaBoNaGameScene:_onGamePointReturn()
	self:_checkLoadMapScene()
	self:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer()
end

function JiaLaBoNaGameScene:_checkLoadMapScene()
	local newSceneUrl = self:getCurrentSceneUrl()

	if self._currentSceneResPath ~= newSceneUrl then
		UIBlockMgr.instance:startBlock(Va3ChessGameScene.BLOCK_KEY)
		self._loader:addPath(newSceneUrl)
		self._loader:startLoad(self.loadResCompleted, self)
	else
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Finish)
	end
end

function JiaLaBoNaGameScene:loadResCompleted(loader)
	local oldSceneGo = self._sceneGo

	self._currentSceneResPath = self:getCurrentSceneUrl()

	JiaLaBoNaGameScene.super.loadResCompleted(self, loader)

	if oldSceneGo then
		gohelper.destroy(oldSceneGo)
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Finish)
	self:_initEventCb()
end

function JiaLaBoNaGameScene:onResetGame()
	self:_resetMapId()
	self:_checkLoadMapScene()
	JiaLaBoNaGameScene.super.onResetGame(self)
end

function JiaLaBoNaGameScene:handleResetByResult()
	self:_resetMapId()
	self:_checkLoadMapScene()
	self:resetTiles()
	JiaLaBoNaGameScene.super.handleResetByResult(self)
end

function JiaLaBoNaGameScene:fillChessBoardBase()
	JiaLaBoNaGameScene.super.fillChessBoardBase(self)

	local tVa3ChessGameModel = Va3ChessGameModel.instance
	local w, h = tVa3ChessGameModel:getGameSize()
	local index = 0

	for x = 1, w do
		for y = 1, h do
			local tileMO = tVa3ChessGameModel:getTileMO(x - 1, y - 1)

			if tileMO and tileMO:isHasTrigger(Va3ChessEnum.TileTrigger.PoSui) then
				index = index + 1

				if index >= #self._posuiGroundTbList then
					table.insert(self._posuiGroundTbList, self:_cratePosuiItemTb())
				end

				local tileObj = self._posuiGroundTbList[index]

				tileObj.posX = x - 1
				tileObj.posY = y - 1

				self:setTileBasePosition(tileObj, tileObj.posX, tileObj.posY)
				self:_updatePosuiItemTb(tileObj, tileMO)

				local baseTileObj = self:getBaseTile(tileObj.posX, tileObj.posY)

				if baseTileObj then
					gohelper.setActive(baseTileObj.go, false)
				end
			end
		end
	end

	for i = index + 1, #self._posuiGroundTbList do
		local tileObj = self._posuiGroundTbList[i]

		tileObj.posX = -1
		tileObj.posY = -1

		self:_updatePosuiItemTb(tileObj)
	end
end

function JiaLaBoNaGameScene:_cratePosuiItemTb()
	local tileObj = self:getUserDataTb_()
	local assetItem = self._loader:getAssetItem(JiaLaBoNaEnum.SceneResPath.GroundPoSui)
	local itemGo = gohelper.clone(assetItem:GetResource(), self._sceneBackground, "posui")

	tileObj.go = itemGo
	tileObj.sceneTf = itemGo.transform
	tileObj.animName = nil
	tileObj.animator = itemGo:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)

	return tileObj
end

function JiaLaBoNaGameScene:getPosuiItem(x, y)
	for i = 1, #self._posuiGroundTbList do
		local tileObj = self._posuiGroundTbList[i]

		if tileObj.posX == x and tileObj.posY == y then
			return tileObj
		end
	end
end

function JiaLaBoNaGameScene:_onTilePosuiTrigger(x, y)
	local tileObj = self:getPosuiItem(x, y)
	local tileMO = Va3ChessGameModel.instance:getTileMO(x, y)

	self:_updatePosuiItemTb(tileObj, tileMO, true)
end

function JiaLaBoNaGameScene:_updatePosuiItemTb(tileObj, tileMO, isNeedAnim)
	if not tileObj then
		return
	end

	if tileMO and tileMO:isHasTrigger(Va3ChessEnum.TileTrigger.PoSui) then
		gohelper.setActive(tileObj.go, true)

		local isFinishTrigger = tileMO:isFinishTrigger(Va3ChessEnum.TileTrigger.PoSui)
		local animName = isFinishTrigger and "close" or "idle"

		if isNeedAnim or animName ~= tileObj.animName then
			tileObj.animName = animName

			tileObj.animator:Play(animName, 0, isNeedAnim and 0 or 1)
		end

		if isNeedAnim and isFinishTrigger then
			AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_glass_broken)
		end
	else
		tileObj.animName = nil

		gohelper.setActive(tileObj.go, false)
	end
end

function JiaLaBoNaGameScene:_resetMapId()
	Va3ChessGameModel.instance:initData(Va3ChessModel.instance:getActId(), Va3ChessModel.instance:getMapId())
end

function JiaLaBoNaGameScene:loadRes()
	UIBlockMgr.instance:startBlock(Va3ChessGameScene.BLOCK_KEY)

	self._loader = MultiAbLoader.New()

	self._loader:addPath(self:getCurrentSceneUrl())
	self._loader:addPath(self:getGroundItemUrl())
	self._loader:addPath(Va3ChessEnum.SceneResPath.DirItem)
	self._loader:addPath(Va3ChessEnum.SceneResPath.AlarmItem)
	self:onLoadRes()
	self._loader:startLoad(self.loadResCompleted, self)
end

return JiaLaBoNaGameScene
