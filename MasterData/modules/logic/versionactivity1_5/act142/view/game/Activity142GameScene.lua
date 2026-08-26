-- chunkname: @modules/logic/versionactivity1_5/act142/view/game/Activity142GameScene.lua

module("modules.logic.versionactivity1_5.act142.view.game.Activity142GameScene", package.seeall)

local Activity142GameScene = class("Activity142GameScene", Va3ChessGameScene)

function Activity142GameScene:_editableInitView()
	self._baffleItems = {}
	self._baffleItemPools = {}

	Activity142GameScene.super._editableInitView(self)
end

function Activity142GameScene:addEvents()
	Activity142GameScene.super.addEvents(self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.TileTriggerUpdate, self._onTileTriggerUpdate, self)
	self.addEventCb(self, Activity142Controller.instance, Activity142Event.Back2CheckPoint, self._onMapChange, self)
	self.addEventCb(self, Activity142Controller.instance, Activity142Event.PlaySwitchPlayerEff, self.playSwitchPlayerEff, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, self._onMapChange, self)
end

function Activity142GameScene:removeEvents()
	Activity142GameScene.super.removeEvents(self)
	self.removeEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.TileTriggerUpdate, self._onTileTriggerUpdate, self)
	self.removeEventCb(self, Activity142Controller.instance, Activity142Event.Back2CheckPoint, self._onMapChange, self)
	self.removeEventCb(self, Activity142Controller.instance, Activity142Event.PlaySwitchPlayerEff, self.playSwitchPlayerEff, self)
	self.removeEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, self._onMapChange, self)
end

function Activity142GameScene:_onTileTriggerUpdate(x, y, triggerType)
	local tileMO = Va3ChessGameModel.instance:getTileMO(x, y)

	if not tileMO or not tileMO:isHasTrigger(triggerType) then
		return
	end

	local tileObj = self:getBaseTile(x, y)

	if triggerType == Va3ChessEnum.TileTrigger.Broken then
		self:updateBrokenTile(tileObj, tileMO, true)
	end
end

function Activity142GameScene:_onMapChange()
	self:resetTiles()
	self:resetBaffle()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer(true)
end

function Activity142GameScene:onResetMapView()
	self:resetBaffle()
	Activity142GameScene.super.onResetMapView(self)
end

function Activity142GameScene:onResetGame()
	self:resetBaffle()
	Activity142GameScene.super.onResetGame(self)
end

function Activity142GameScene:onLoadRes()
	local urlList = self:_getGroundItemUrlList()

	for _, resPath in ipairs(urlList) do
		self._loader:addPath(resPath)
	end

	self._loader:addPath(Activity142Enum.BrokenGroundItemPath)
	self._loader:addPath(Activity142Enum.SwitchPlayerEffPath)
end

function Activity142GameScene:_getGroundItemUrlList()
	local mapId = Va3ChessGameModel.instance:getMapId()
	local actId = Va3ChessGameModel.instance:getActId()
	local urlList = Activity142Config.instance:getGroundItemUrlList(actId, mapId)

	if not urlList or #urlList < 0 then
		urlList = {
			Va3ChessEnum.SceneResPath.GroundItem
		}
	end

	return urlList
end

function Activity142GameScene:getGroundItemUrl(x, y)
	local result
	local urlList = self:_getGroundItemUrlList()

	if x and y then
		local tileMO = Va3ChessGameModel.instance:getTileMO(x, y)

		if tileMO and tileMO:isHasTrigger(Va3ChessEnum.TileTrigger.Broken) then
			result = Activity142Enum.BrokenGroundItemPath
		end
	end

	if string.nilorempty(result) then
		local index = math.random(1, #urlList)

		result = urlList[index]
	end

	return result
end

function Activity142GameScene:onTileItemCreate(x, y, tileItem)
	tileItem.animator = tileItem.go:GetComponent(Va3ChessEnum.ComponentType.Animator)

	local tileMO = Va3ChessGameModel.instance:getTileMO(x, y)

	self:updateBrokenTile(tileItem, tileMO)
end

local BrokenAnim = "CtoD"
local BrokenTileAnima = {
	{
		idle = "xianjing_b",
		tween = "xianjing_b"
	},
	{
		idle = "xianjing_c",
		tween = "BtoC"
	},
	{
		idle = "xianjing_d",
		tween = BrokenAnim
	}
}

function Activity142GameScene:updateBrokenTile(tileItem, tileMO, isPlayTween)
	local triggerType = Va3ChessEnum.TileTrigger.Broken

	if not tileItem or not tileMO or not tileMO:isHasTrigger(triggerType) then
		return
	end

	local brokenStatus = tileMO:getTriggerBrokenStatus()
	local statusAnimaDict = BrokenTileAnima[brokenStatus]

	if not statusAnimaDict then
		return
	end

	local animName = isPlayTween and statusAnimaDict.tween or statusAnimaDict.idle

	if animName and tileItem.animator then
		tileItem.animator:Play(animName, 0, 0)

		if animName == BrokenAnim then
			AudioMgr.instance:trigger(AudioEnum.chess_activity142.TileBroken)
		end
	end
end

function Activity142GameScene:onloadResCompleted(loader)
	self:createAllBaffleObj()
end

function Activity142GameScene:createAllBaffleObj()
	for x, yList in pairs(self._baseTiles) do
		for y, _ in pairs(yList) do
			local tileData = Va3ChessGameModel.instance:getTileMO(x - 1, y - 1)
			local baffleDataList = tileData:getBaffleDataList()

			if baffleDataList and #baffleDataList >= 0 then
				self:createBaffleItem(x - 1, y - 1, baffleDataList)
			end
		end
	end
end

function Activity142GameScene:createBaffleItem(x, y, baffleDataList)
	if not baffleDataList or #baffleDataList <= 0 then
		return
	end

	for _, baffleData in ipairs(baffleDataList) do
		local baffleItem
		local resPath = Activity142Helper.getBaffleResPath(baffleData)

		if resPath then
			local pool = self._baffleItemPools[resPath]

			if pool then
				if not #pool then
					local poolLen = 0

					if poolLen > 0 then
						baffleItem = pool[poolLen]
						pool[poolLen] = nil
					end
				end
			end
		end

		if not baffleItem then
			baffleItem = Activity142BaffleObject.New(self._sceneContainer.transform)

			baffleItem:init()
		end

		baffleData.x = x
		baffleData.y = y

		baffleItem:updatePos(baffleData)
		table.insert(self._baffleItems, baffleItem)
	end
end

function Activity142GameScene:resetBaffle()
	self:recycleAllBaffleItem()
	self:createAllBaffleObj()
end

function Activity142GameScene:recycleAllBaffleItem()
	local baffleObj

	for i = 1, #self._baffleItems do
		baffleObj = self._baffleItems[i]

		self._baffleItems[i]:recycle()

		local resPath = baffleObj:getBaffleResPath()

		if resPath then
			local pool = self._baffleItemPools[resPath]

			if not pool then
				pool = {}
				self._baffleItemPools[resPath] = pool
			end

			table.insert(pool, baffleObj)
		else
			baffleObj:dispose()
		end

		self._baffleItems[i] = nil
	end
end

function Activity142GameScene:playSwitchPlayerEff(x, y)
	local effGO = self:getSwitchEffGO()

	if gohelper.isNil(effGO) or not x or not y then
		return
	end

	Activity142Helper.setAct142UIBlock(true, Activity142Enum.SWITCH_PLAYER)

	local sceneX, sceneY, sceneZ = Va3ChessGameController.instance:calcTilePosInScene(x, y)

	transformhelper.setLocalPos(effGO.transform, sceneX, sceneY, sceneZ)
	gohelper.setActive(effGO, false)
	gohelper.setActive(effGO, true)
	AudioMgr.instance:trigger(AudioEnum.chess_activity142.SwitchPlayer)
	TaskDispatcher.cancelTask(self.switchPlayerFinish, self)
	TaskDispatcher.runDelay(self.switchPlayerFinish, self, Activity142Enum.PLAYER_SWITCH_TIME)
end

function Activity142GameScene:getSwitchEffGO()
	if not self._switchEffGO then
		local assetItem = self._loader:getAssetItem(Activity142Enum.SwitchPlayerEffPath)

		if assetItem then
			self._switchEffGO = gohelper.clone(assetItem:GetResource(), self._sceneContainer, "switchEff")

			gohelper.setActive(self._switchEffGO, false)
		end
	end

	return self._switchEffGO
end

function Activity142GameScene:switchPlayerFinish()
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.SWITCH_PLAYER)
end

function Activity142GameScene:onDestroyView()
	TaskDispatcher.cancelTask(self.switchPlayerFinish, self)
	self:switchPlayerFinish()

	if self._switchEffGO then
		gohelper.destroy(self._switchEffGO)

		self._switchEffGO = nil
	end

	self:removeEvents()
	self:disposeBaffle()
	Activity142GameScene.super.onDestroyView(self)
end

function Activity142GameScene:disposeBaffle()
	for _, baffleObj in ipairs(self._baffleItems) do
		baffleObj:dispose()
	end

	for _, pool in pairs(self._baffleItemPools) do
		for _, baffleObj in ipairs(pool) do
			baffleObj:dispose()
		end
	end

	self._baffleItems = {}
	self._baffleItemPools = {}
end

return Activity142GameScene
