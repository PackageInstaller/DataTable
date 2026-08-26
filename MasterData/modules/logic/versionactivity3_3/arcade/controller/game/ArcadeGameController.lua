-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/ArcadeGameController.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.ArcadeGameController", package.seeall)

local ArcadeGameController = class("ArcadeGameController", BaseController)

function ArcadeGameController:onInit()
	return
end

function ArcadeGameController:onInitFinish()
	return
end

function ArcadeGameController:addConstEvents()
	self.registerCallback(self, ArcadeEvent.OnSkillKillDeathSettle, self._enterDeathSettleFlow, self)
end

function ArcadeGameController:reInit()
	return
end

function ArcadeGameController:getGameScene()
	return self._gameScene
end

function ArcadeGameController:getCurRoom()
	if self._gameScene and self._gameScene.roomMgr then
		return self._gameScene.roomMgr:getCurRoom()
	end
end

function ArcadeGameController:getArcadeInSideInfo()
	local isOpen = ArcadeModel.instance:isAct222Open(true)

	if not isOpen then
		return
	end

	ArcadeInSideRpc.instance:sendArcadeGetInSideInfoRequest(self._onGetInsideInfo, self)
end

function ArcadeGameController:_onGetInsideInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.hasSaveGame then
		self._tmpInsideInfo = msg.info

		local prop = msg.info.prop
		local difficulty = prop.difficulty
		local isInGuide = ArcadeGameModel.instance:getIsInGuideLevel(difficulty)

		if isInGuide then
			self:_restartGame()
		else
			GameFacade.showMessageBox(MessageBoxIdDefine.ContinueArcadeGame, MsgBoxEnum.BoxType.Yes_No, self._restartGame, self._abandonGame, nil, self, self, nil)
		end
	else
		ArcadeController.instance:openHallView()
	end
end

function ArcadeGameController:_restartGame()
	if not self._tmpInsideInfo then
		ArcadeController.instance:openHallView()

		return
	end

	ArcadeGameModel.instance:onRestartArcadeGame(self._tmpInsideInfo)

	self._gameScene = ArcadeGameScene.New()

	self._gameScene:onEnterArcadeGame(true)
	ViewMgr.instance:openView(ViewName.ArcadeGameView)

	self._tmpInsideInfo = nil
end

function ArcadeGameController:_abandonGame()
	ArcadeController.instance:openHallView()
	self:endGame(ArcadeGameEnum.SettleType.Abandon, false, false, self._tmpInsideInfo)

	self._tmpInsideInfo = nil
end

function ArcadeGameController:enterGame(difficulty)
	local isFinishGuide = ArcadeGameModel.instance:isFinishGameGuide()

	if not isFinishGuide then
		difficulty = ArcadeGameEnum.Const.GuideDifficulty
	end

	if not difficulty then
		return
	end

	ArcadeGameModel.instance:setDifficulty(difficulty)
	ArcadeOutSideRpc.instance:sendArcadeGetOutSideInfoRequest(self._enterGameAfterGetOutsideInfo, self)
end

function ArcadeGameController:_enterGameAfterGetOutsideInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ArcadeGameModel.instance:onEnterArcadeGame()

	self._gameScene = ArcadeGameScene.New()

	self._gameScene:onEnterArcadeGame()
	ViewMgr.instance:openView(ViewName.ArcadeGameView)
end

function ArcadeGameController:resetGame()
	ArcadeOutSideRpc.instance:sendArcadeGetOutSideInfoRequest(self._resetGameAfterGetOutsideInfo, self)
end

function ArcadeGameController:_resetGameAfterGetOutsideInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local removeBuffIdList = {}
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if characterMO then
		local buffSetMO = characterMO:getBuffSetMO()
		local buffList = buffSetMO and buffSetMO:getBuffList()

		if buffList then
			for i, buffMO in ipairs(buffList) do
				removeBuffIdList[i] = buffMO:getId()
			end
		end
	end

	self:removeEntityBuffs(removeBuffIdList, ArcadeGameEnum.EntityType.Character)
	ArcadeGameModel.instance:onResetArcadeGame()
	self:startGame()
	self:dispatchEvent(ArcadeEvent.OnResetArcadeGame)
end

function ArcadeGameController:pauseGame()
	ArcadeGameModel.instance:setIsPauseGame(true)
end

function ArcadeGameController:resumeGame()
	ArcadeGameModel.instance:setIsPauseGame(false)
end

function ArcadeGameController:saveGame()
	local info = ArcadeGameHelper.getServerArcadeInsideInfo()

	ArcadeInSideRpc.instance:sendArcadeSaveGameRequest(info)
end

function ArcadeGameController:endGame(settleType, isWin, isReset, serverInfo)
	local isEnd = ArcadeGameModel.instance:getIsEndGame()

	if isEnd then
		return
	end

	UIBlockMgr.instance:endBlock(ArcadeEnum.BlockKey.ChangingRoom)
	ArcadeGameModel.instance:setGameIsEnd(true)

	self._resultViewInfo = ArcadeGameHelper.getResultViewInfo(isWin, isReset, serverInfo)
	self._resultViewInfo.settleType = settleType

	local settleInfo

	if serverInfo then
		settleInfo = serverInfo
		self._resultViewInfo.serverInfo = serverInfo
	else
		settleInfo = ArcadeGameHelper.getServerArcadeInsideInfo(isWin, true)

		local characterMO = ArcadeGameModel.instance:getCharacterMO()

		if characterMO then
			local diamondResMO = characterMO:getResourceMO(ArcadeGameEnum.CharacterResource.Diamond)

			if diamondResMO then
				diamondResMO:setCount(0)
			end

			local cassetteResMO = characterMO:getResourceMO(ArcadeGameEnum.CharacterResource.Cassette)

			if cassetteResMO then
				cassetteResMO:setCount(0)
			end
		end
	end

	ArcadeInSideRpc.instance:sendArcadeSettleGameRequest(settleType, settleInfo, self._openResultViewAfterSettle, self)
end

function ArcadeGameController:_openResultViewAfterSettle(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg then
		self._resultViewInfo.bookAddScore = msg.bookAddScore or 0
	end

	self._resultViewInfo.hasUnlockCharacter = false

	if msg and msg.unlockRoleIds then
		self._resultViewInfo.hasUnlockCharacter = #msg.unlockRoleIds > 0
	end

	ViewMgr.instance:openView(ViewName.ArcadeGameResultView, self._resultViewInfo)

	if not self._resultViewInfo.attrDict[ArcadeGameEnum.CharacterResource.Cassette] then
		local gameCassetteCount = 0
		local totalCassetteCount = gameCassetteCount + self._resultViewInfo.bookAddScore

		ArcadeStatHelper.instance:sendEndGame(self._resultViewInfo.settleType, totalCassetteCount, self._resultViewInfo.serverInfo)

		self._resultViewInfo = nil
	end
end

function ArcadeGameController:closeGameView()
	ViewMgr.instance:closeView(ViewName.ArcadeGameView)
end

function ArcadeGameController:exitGame()
	if self._gameScene then
		self._gameScene:onExitArcadeGame()
	end

	self._gameScene = nil
	self._resultViewInfo = nil

	ArcadeGameModel.instance:onExitArcadeGame()
	UIBlockMgr.instance:endBlock(ArcadeEnum.BlockKey.ChangingRoom)
end

function ArcadeGameController:startGame(isRestart)
	ArcadeStatHelper.instance:sendStartGame()

	if isRestart then
		local curRoomId = ArcadeGameModel.instance:getCurRoomId()

		self:change2Room(curRoomId)
	else
		local characterMO = ArcadeGameModel.instance:getCharacterMO()

		ArcadeGameTriggerController.instance:triggerTarget(ArcadeGameEnum.TriggerPoint.GameStart, characterMO)
		self:enterNextArea()
	end
end

function ArcadeGameController:checkCharacterNearUnit(isCharacterMove)
	local eventEntityType, eventEntityUid
	local curRoom = self:getCurRoom()

	if not curRoom then
		return
	end

	local scene = self:getGameScene()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local curEventEntityType, curEventEntityUid = ArcadeGameModel.instance:getNearEventEntity()
	local borderGridList = characterMO:getBorderGridList()

	for _, gridData in ipairs(borderGridList) do
		local borderGridX = gridData.gridX
		local borderGridY = gridData.gridY
		local adjEntityData = curRoom:getEntityDataInTargetGrid(borderGridX, borderGridY)
		local adjEntityType = adjEntityData and adjEntityData.entityType
		local adjUid = adjEntityData and adjEntityData.uid
		local adjMO = ArcadeGameModel.instance:getMOWithType(adjEntityType, adjUid)

		if adjMO and adjMO.getEventOptionList then
			local isDead = adjMO:getIsDead()

			if not isDead then
				if eventEntityType and eventEntityUid then
					if curEventEntityType and curEventEntityUid and curEventEntityType == adjEntityType and curEventEntityUid == adjUid then
						eventEntityType = adjEntityType
						eventEntityUid = adjUid
					end
				else
					eventEntityType = adjEntityType
					eventEntityUid = adjUid
				end
			end
		end

		if scene then
			::label_23_0::

			local entity = scene.entityMgr:getEntityWithType(adjEntityType, adjUid)

			if entity then
				entity:refreshShowHpBar()
			end
		end
	end

	self:changeNearEventEntity(eventEntityType, eventEntityUid, isCharacterMove)
end

function ArcadeGameController:changeNearEventEntity(eventEntityType, eventEntityUid, isCharacterMove)
	local curEventEntityType, curEventEntityUid = ArcadeGameModel.instance:getNearEventEntity()

	if eventEntityType == curEventEntityType and eventEntityUid == curEventEntityUid then
		return
	end

	ArcadeGameModel.instance:setNearEventEntity(eventEntityType, eventEntityUid)
	self:dispatchEvent(ArcadeEvent.RefreshGameEventTip, eventEntityType, eventEntityUid, isCharacterMove)
end

function ArcadeGameController:triggerEventOption(entityType, entityId, uid, eventOptionId, eventOptionParam, noCanInteractCheck, noConditionCheck, extraParam)
	local isChangingRoom = ArcadeGameModel.instance:getIsChangingRoom()
	local isGamePause = ArcadeGameModel.instance:getIsPauseGame()
	local isGameEnd = ArcadeGameModel.instance:getIsEndGame()

	if not eventOptionId or isChangingRoom or isGamePause or isGameEnd then
		return
	end

	local canInteract = false
	local eventEntityMO = ArcadeGameModel.instance:getMOWithType(entityType, uid)

	if noCanInteractCheck then
		canInteract = true
	elseif eventEntityMO and eventEntityMO.isCanInteract then
		canInteract = eventEntityMO:isCanInteract()
	end

	local checkResult = true

	if not noConditionCheck then
		local checkCondition = ArcadeConfig.instance:getEventOptionCondition(eventOptionId)

		if not string.nilorempty(checkCondition) then
			checkResult = false

			local arr = string.split(checkCondition, "#")
			local conditionType = arr[1]
			local checkHandler = ArcadeGameHelper.getEventOptionConditionCheckFunc(conditionType)

			if checkHandler then
				checkResult = checkHandler(eventOptionId, arr)
			end
		end
	end

	if not checkResult or not canInteract then
		GameFacade.showToast(ToastEnum.NotSatisfy)

		return
	end

	local eventOptionType = ArcadeConfig.instance:getEventOptionType(eventOptionId)
	local handler = ArcadeGameHelper.getEventOptionHandleFunc(eventOptionType)

	if handler then
		local result = handler(entityType, entityId, uid, eventOptionParam, extraParam)

		if result and eventEntityMO then
			eventEntityMO:addTriggerEventOptionId(eventOptionId)

			local scene = self:getGameScene()

			if scene then
				::label_25_0::

				local entity = scene.entityMgr:getEntityWithType(entityType, uid)

				if entity then
					entity:playActionShow(ArcadeGameEnum.ActionShowId.Interactive, nil, entityId)
				end
			end
		end

		return result
	end
end

function ArcadeGameController:enterNextArea(playExcessive)
	local difficulty = ArcadeGameModel.instance:getDifficulty()
	local curAreaIndex = ArcadeGameModel.instance:getCurAreaIndex()
	local nextAreaIndex = curAreaIndex + 1
	local nextAreaId = ArcadeConfig.instance:getDifficultyAreaIdByIndex(difficulty, nextAreaIndex)

	if not nextAreaId then
		logError(string.format("ArcadeGameController:enterNextArea error, no next Area, difficulty:%s, curAreaIndex:%s", difficulty, curAreaIndex))

		return
	end

	ArcadeGameModel.instance:setCurAreaIndex(nextAreaIndex)
	ArcadeGameModel.instance:setTransferNodeIndex()

	local firstRoom = ArcadeConfig.instance:getAreaFirstRoom(nextAreaId)

	self:change2Room(firstRoom, playExcessive)
end

function ArcadeGameController:change2Room(roomId, playExcessive)
	if not roomId then
		return
	end

	logNormal(string.format("ArcadeGame change to room :%s", roomId))
	ArcadeGameModel.instance:setChangingRoom(true)
	ArcadeGameModel.instance:setCurRoomId(roomId)

	if playExcessive then
		local isOpenGameView = ViewMgr.instance:isOpen(ViewName.ArcadeGameView)

		if isOpenGameView then
			UIBlockMgr.instance:startBlock(ArcadeEnum.BlockKey.ChangingRoom)
		end

		self:dispatchEvent(ArcadeEvent.PlayChangeRoomExcessive)
	elseif self._gameScene then
		UIBlockMgr.instance:startBlock(ArcadeEnum.BlockKey.ChangingRoom)
		self._gameScene.roomMgr:switchRoom()
	end
end

function ArcadeGameController:changeRoomFinish()
	UIBlockMgr.instance:endBlock(ArcadeEnum.BlockKey.ChangingRoom)
	ArcadeGameModel.instance:setChangingRoom(false)

	local roomId = ArcadeGameModel.instance:getCurRoomId()

	self:checkCharacterNearUnit()
	self:dispatchEvent(ArcadeEvent.OnChangeArcadeRoomFinish, roomId)
end

function ArcadeGameController:_collectFloorTriggerTargetList(floorMOList, includeFloor)
	local curRoom = self:getCurRoom()

	if not curRoom or not floorMOList or #floorMOList <= 0 then
		return
	end

	local resultList = {}
	local repeatDict = {}

	local function _tryAddTarget(targetMO)
		if not targetMO then
			return
		end

		local key = string.format("%s_%s", targetMO:getEntityType(), targetMO:getUid())

		if repeatDict[key] then
			return
		end

		repeatDict[key] = true
		resultList[#resultList + 1] = targetMO
	end

	for _, floorMO in ipairs(floorMOList) do
		if includeFloor then
			_tryAddTarget(floorMO)
		end

		local gridX, gridY = floorMO:getGridPos()
		local sizeX, sizeY = floorMO:getSize()

		for x = gridX, gridX + sizeX - 1 do
			for y = gridY, gridY + sizeY - 1 do
				local entityData = curRoom:getEntityDataInTargetGrid(x, y)

				if entityData and entityData.entityType and entityData.uid then
					local entityMO = ArcadeGameModel.instance:getMOWithType(entityData.entityType, entityData.uid)

					_tryAddTarget(entityMO)
				end
			end
		end
	end

	return resultList
end

function ArcadeGameController:tryAddEntityList(entityDataList, needGenUid, canOverY, cb, cbObj)
	local curRoom = self:getCurRoom()

	if not entityDataList or not curRoom then
		ArcadeGameHelper.callCallbackFunc(cb, cbObj)

		return
	end

	local canPlaceDataList = curRoom:filterCanPlaceEntityList(entityDataList, canOverY)
	local moList = ArcadeGameModel.instance:addEntityMOByList(canPlaceDataList, needGenUid)

	if self._gameScene then
		self._gameScene.entityMgr:addEntityByList(moList, canOverY, cb, cbObj)
	end

	local addFloorMOList = {}

	if moList then
		for _, mo in ipairs(moList) do
			if mo:getEntityType() == ArcadeGameEnum.EntityType.Floor then
				addFloorMOList[#addFloorMOList + 1] = mo
			end
		end
	end

	local addFloorTriggerMOList = self:_collectFloorTriggerTargetList(addFloorMOList, true)

	ArcadeGameTriggerController.instance:triggerTargetList(ArcadeGameEnum.TriggerPoint.AfterAddFloor721, addFloorTriggerMOList)
	self:checkCharacterNearUnit()
	self:dispatchEvent(ArcadeEvent.OnAddEntities, moList)

	return moList
end

function ArcadeGameController:removeEntityListByType(entityType)
	local moList = ArcadeGameModel.instance:getEntityMOList(entityType)

	if not moList or #moList <= 0 then
		return
	end

	local isFloor = entityType == ArcadeGameEnum.EntityType.Floor
	local removeFloorTriggerMOList

	if isFloor then
		removeFloorTriggerMOList = self:_collectFloorTriggerTargetList(moList)

		ArcadeGameTriggerController.instance:triggerTargetList(ArcadeGameEnum.TriggerPoint.BeforeRemoveFloor722, moList)
	end

	local uidList = {}

	if self._gameScene then
		for _, mo in ipairs(moList) do
			local uid = mo:getUid()

			self._gameScene.entityMgr:removeEntityWithType(entityType, uid)

			uidList[#uidList + 1] = uid
		end
	end

	ArcadeGameModel.instance:removeEntityMOByType(entityType)

	if isFloor then
		ArcadeGameTriggerController.instance:triggerTargetList(ArcadeGameEnum.TriggerPoint.AfterRemoveFloor723, removeFloorTriggerMOList)
	end

	self:checkCharacterNearUnit()
	self:dispatchEvent(ArcadeEvent.OnRemoveEntity, entityType, uidList)
end

function ArcadeGameController:removeEntity(entityType, uid, needWaitRemoveAnim)
	local isFloor = entityType == ArcadeGameEnum.EntityType.Floor
	local removeFloorTriggerMOList

	if isFloor then
		local floorMO = ArcadeGameModel.instance:getMOWithType(entityType, uid)

		if floorMO then
			removeFloorTriggerMOList = self:_collectFloorTriggerTargetList({
				floorMO
			})

			ArcadeGameTriggerController.instance:triggerTarget(ArcadeGameEnum.TriggerPoint.BeforeRemoveFloor722, floorMO)
		end
	end

	if self._gameScene then
		self._gameScene.entityMgr:removeEntityWithType(entityType, uid, needWaitRemoveAnim)
	end

	ArcadeGameModel.instance:removeEntityMO(entityType, uid)

	if isFloor then
		ArcadeGameTriggerController.instance:triggerTargetList(ArcadeGameEnum.TriggerPoint.AfterRemoveFloor723, removeFloorTriggerMOList)
	end

	self:checkCharacterNearUnit()
	self:dispatchEvent(ArcadeEvent.OnRemoveEntity, entityType, {
		uid
	})
end

function ArcadeGameController:removeDeadEntityAndDrop(mo, isPlay)
	local isDead = mo and mo:getIsDead()

	if not isDead then
		return
	end

	local isRemoving = mo:getIsRemoving()

	if isRemoving then
		return
	end

	local gridX, gridY = mo:getGridPos()
	local dropList = mo:getDropList()

	if dropList then
		for _, dropId in ipairs(dropList) do
			self:gainDropItemById(dropId, gridX, gridY)
		end
	end

	self:directRemoveEntity(mo, isPlay and ArcadeGameEnum.ActionShowId.Remove)
end

function ArcadeGameController:directRemoveEntity(mo, actionShowId)
	local isRemoving = mo:getIsRemoving()

	if isRemoving then
		return
	end

	local entityType = mo:getEntityType()
	local uid = mo:getUid()
	local scene = self:getGameScene()

	if scene then
		::label_35_0::

		local entity = scene.entityMgr:getEntityWithType(entityType, uid)

		if actionShowId and entity then
			entity:playActionShow(actionShowId, nil, nil, self._destroyEntityAfterPlayAnim, self, {
				entity = entity
			})
			mo:setIsRemoving(true)
			self:removeEntity(entityType, uid, true)
		else
			self:removeEntity(entityType, uid)
		end
	end
end

function ArcadeGameController:_destroyEntityAfterPlayAnim(param)
	if param and param.entity then
		param.entity:destroy()
	end
end

function ArcadeGameController:gainDropItemById(dropId, gridX, gridY)
	local x, y, z = ArcadeGameHelper.getGridWorldPos(gridX, gridY)
	local gainPos = {
		x = x,
		y = y,
		z = z
	}
	local dropItem = ArcadeGameHelper.getDropItem(dropId)

	if dropItem then
		local type = dropItem.dropItemType
		local id = dropItem.id
		local count = dropItem.count

		if type == ArcadeGameEnum.DropItemType.Resource then
			local scene = self:getGameScene()

			if id == ArcadeGameEnum.CharacterResource.GameCoin and scene then
				local dropCoinEffectIdList = ArcadeGameHelper.getActionShowEffect(ArcadeGameEnum.ActionShowId.DropCoin)
				local dropCoinEffId = dropCoinEffectIdList and dropCoinEffectIdList[1]

				scene.effectMgr:playEffect2Grid(dropCoinEffId, gridX, gridY)
			end

			self:changeResCount(id, count, gainPos)
		elseif type == ArcadeGameEnum.DropItemType.Collection then
			self:gainCollection(id, gainPos)
		elseif type == ArcadeGameEnum.DropItemType.Character then
			ArcadeGameModel.instance:addUnlockCharacter(id)
		end
	end

	return dropItem
end

function ArcadeGameController:gainCollection(collectionId, gainPos)
	local isUnique = ArcadeConfig.instance:getCollectionIsUnique(collectionId)
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local collectionMO

	if characterMO then
		local characterHas = characterMO:getHasCollection(collectionId)

		if isUnique and characterHas then
			return
		end

		local type = ArcadeConfig.instance:getCollectionType(collectionId)

		if type == ArcadeGameEnum.CollectionType.Weapon then
			local typeUidList = characterMO:getCollectionUidListWithType(type)
			local curWeaponCount = #typeUidList
			local canCarryWeaponNum = characterMO:getCanCarryWeaponNum()

			if canCarryWeaponNum <= curWeaponCount then
				self:lossCollection(typeUidList[1])
			end
		end

		collectionMO = characterMO:addCollection(collectionId)

		if collectionMO then
			local name = ArcadeConfig.instance:getCollectionName(collectionId)

			GameFacade.showToast(ToastEnum.V3a3ArcadeGainCollection, name)
			ArcadeGameTriggerController.instance:triggerTarget(ArcadeGameEnum.TriggerPoint.AfterGainCollection501, characterMO, {
				collectionMO = collectionMO
			})
			ArcadeGameModel.instance:addUnlockHandBookItem(ArcadeGameEnum.HandBookType.Collection, collectionId)
		end
	end

	local weaponGainPosList = {}
	local collectionGainPosList = {}
	local type = ArcadeConfig.instance:getCollectionType(collectionId)

	if type == ArcadeGameEnum.CollectionType.Weapon then
		table.insert(weaponGainPosList, gainPos)
	elseif type == ArcadeGameEnum.CollectionType.Jewelry then
		table.insert(collectionGainPosList, gainPos)
	end

	self:dispatchEvent(ArcadeEvent.OnCollectionChange, weaponGainPosList, collectionGainPosList)

	return collectionMO
end

function ArcadeGameController:tryUseCollection(uid, useTime)
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local collectionMO = characterMO and characterMO:getCollectionMO(uid)

	if not collectionMO then
		return
	end

	local function _isNeedRemoveByDurability(targetCollectionMO)
		local remainDurability = targetCollectionMO and targetCollectionMO:getRemainDurability()

		return remainDurability and remainDurability <= 0
	end

	collectionMO:addUsedTimes(useTime)

	if not _isNeedRemoveByDurability(collectionMO) then
		self:dispatchEvent(ArcadeEvent.OnWeaponDurabilityChange)

		return
	end

	ArcadeGameTriggerController.instance:triggerTarget(ArcadeGameEnum.TriggerPoint.BeforeRemoveCollection503, characterMO, {
		collectionMO = collectionMO
	})

	local latestCollectionMO = characterMO:getCollectionMO(uid)

	if not latestCollectionMO then
		return
	end

	if _isNeedRemoveByDurability(latestCollectionMO) then
		self:lossCollection(uid)
	else
		self:dispatchEvent(ArcadeEvent.OnWeaponDurabilityChange)
	end
end

function ArcadeGameController:lossCollection(uid)
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if characterMO then
		local collectionMO = characterMO:removeCollection(uid)

		ArcadeGameTriggerController.instance:triggerTarget(ArcadeGameEnum.TriggerPoint.AfterRemoveCollection504, characterMO, {
			collectionMO = collectionMO
		})
	end

	self:dispatchEvent(ArcadeEvent.OnCollectionChange)
end

function ArcadeGameController:addBuff2Entity(buffId, entityType, uid)
	local result = false
	local buffEntityTypeDict = ArcadeConfig.instance:getArcadeBuffEntityTypeDict(buffId)

	if not entityType or not buffEntityTypeDict[entityType] then
		return result
	end

	local entityMO = ArcadeGameModel.instance:getMOWithType(entityType, uid)
	local buffSetMO = entityMO and entityMO:getBuffSetMO()

	if buffSetMO then
		buffSetMO:addBuffById(buffId)

		result = true
	end

	local scene = self:getGameScene()

	if scene then
		::label_42_0::

		local entity = scene.entityMgr:getEntityWithType(entityType, uid)

		if entity then
			entity:playActionShow(ArcadeGameEnum.ActionShowId.GainBuff, nil, buffId)
		end

		self:dispatchEvent(ArcadeEvent.OnBuffChange, entityType, uid)

		return result
	end
end

function ArcadeGameController:removeEntityBuffs(buffIdList, entityType, uid)
	if not buffIdList or #buffIdList <= 0 then
		return
	end

	local entityMO = ArcadeGameModel.instance:getMOWithType(entityType, uid)
	local buffSetMO = entityMO and entityMO:getBuffSetMO()

	if buffSetMO then
		local scene = self:getGameScene()

		if scene then
			::label_43_0::

			local entity = scene.entityMgr:getEntityWithType(entityType, uid)

			for _, buffId in ipairs(buffIdList) do
				buffSetMO:removeBuffById(buffId)

				if entity then
					local loopBuffEffect = ArcadeConfig.instance:getArcadeBuffLoopEffect(buffId)

					if loopBuffEffect and loopBuffEffect ~= 0 then
						entity:stopStateLoopEffect(loopBuffEffect)
					end
				end
			end
		end
	end

	self:dispatchEvent(ArcadeEvent.OnBuffChange, entityType, uid)
end

function ArcadeGameController:changeEntityHp(entityMO, changValue)
	if not entityMO or not changValue or changValue == 0 then
		return
	end

	local realChangeVal = entityMO:addHp(changValue)

	if changValue > 0 then
		local scene = self:getGameScene()
		local uid = entityMO:getUid()
		local entityType = entityMO:getEntityType()

		if scene then
			::label_44_0::

			local entity = scene.entityMgr:getEntityWithType(entityType, uid)

			if entity then
				entity:playActionShow(ArcadeGameEnum.ActionShowId.AddHp)
			end
		end
	end

	self:dispatchEvent(ArcadeEvent.OnChangeEntityHp, entityMO, realChangeVal)
end

function ArcadeGameController:changeResCount(resId, changeValue, gainPos)
	if not changeValue or changeValue == 0 then
		return
	end

	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local resMO = characterMO and characterMO:getResourceMO(resId)

	if not resMO then
		return
	end

	if changeValue < 0 then
		resMO:subCount(math.abs(changeValue))
	elseif changeValue > 0 then
		resMO:addCount(changeValue)
	end

	if resId == ArcadeGameEnum.CharacterResource.Score then
		ArcadeGameModel.instance:refreshMaxScore()

		local curScore = resMO:getCount()
		local addCoinRate = ArcadeConfig.instance:getGradeAddCoinRate(curScore)
		local coinResMO = characterMO:getResourceMO(ArcadeGameEnum.CharacterResource.GameCoin)

		if coinResMO then
			coinResMO:setGainRate(addCoinRate)
		end
	end

	self:dispatchEvent(ArcadeEvent.OnCharacterResourceCountUpdate, resId, {
		gainPos
	})
end

function ArcadeGameController:setAllEntityVisibility(isShow)
	local scene = self:getGameScene()

	if scene then
		scene.entityMgr:setAllEntityIsShow(isShow)
	end

	self:dispatchEvent(ArcadeEvent.OnSetAllEntityIsShow, isShow)
end

function ArcadeGameController:changeEntityAttackAttr(entityMO, attackAttrId)
	if not entityMO then
		return
	end

	local oldAttackAttr = entityMO:getAttackAttrId()

	if oldAttackAttr and oldAttackAttr ~= 0 then
		local oldSkillList = ArcadeConfig.instance:getAttackAttrSkillList(oldAttackAttr)

		if oldSkillList then
			for _, oldSkillId in ipairs(oldSkillList) do
				entityMO:removeSkillById(oldSkillId)
			end
		end
	end

	entityMO:setAttackAttr(attackAttrId)

	if attackAttrId and attackAttrId ~= 0 then
		local skillList = ArcadeConfig.instance:getAttackAttrSkillList(attackAttrId)

		if skillList then
			for _, skillId in ipairs(skillList) do
				entityMO:addSkillById(skillId)
			end
		end
	end
end

function ArcadeGameController:enterAttackFlow(attackType, attackerMO, targetMOList, attackDirection, skillId, notTriggerAtkPoint)
	if not attackerMO then
		return
	end

	local validTargetMOList = self:_filterTargetMOList(targetMOList)

	if notTriggerAtkPoint ~= true then
		ArcadeGameTriggerController.instance:atkTriggerTarget(ArcadeGameEnum.TriggerPoint.AtkBefore201, attackType, attackerMO, validTargetMOList)
		ArcadeGameTriggerController.instance:hitTriggerTargetList(ArcadeGameEnum.TriggerPoint.HitBefore202, attackType, attackerMO, validTargetMOList)
	end

	ArcadeGameTriggerController.instance:hitTriggerTargetList(ArcadeGameEnum.TriggerPoint.HitBefore251, attackType, attackerMO, validTargetMOList)

	local attackActionShowId, hitActionShowId, actionShowParam = self:_getAttackAndHitShow(attackerMO, attackType, skillId)
	local scene = self:getGameScene()
	local attackerUid = attackerMO:getUid()
	local attackerEntityType = attackerMO:getEntityType()

	if scene then
		::label_48_0::

		local attackerEntity = scene.entityMgr:getEntityWithType(attackerEntityType, attackerUid)

		if attackerEntity and attackActionShowId then
			attackerEntity:playActionShow(attackActionShowId, attackDirection, actionShowParam)
		end

		self:_calAttackDamage(attackerMO, attackType, validTargetMOList, attackDirection, hitActionShowId, actionShowParam, skillId)

		local isBasicAttack = attackType == ArcadeGameEnum.AttackType.Normal or attackType == ArcadeGameEnum.AttackType.Link

		if isBasicAttack then
			ArcadeGameModel.instance:triggerEntityCounterRecord(attackerEntityType, attackerUid, ArcadeGameEnum.GameCounter.AttackTimesSinceAddSkill)
		end

		self:_updateScoreAndSkillEnergy(attackerMO, attackType, validTargetMOList, skillId)

		if notTriggerAtkPoint ~= true then
			ArcadeGameTriggerController.instance:atkTriggerTarget(ArcadeGameEnum.TriggerPoint.Atk203, attackType, attackerMO, validTargetMOList)
			ArcadeGameTriggerController.instance:clearTargetTempAttr(attackerMO)
			ArcadeGameTriggerController.instance:hitTriggerTargetList(ArcadeGameEnum.TriggerPoint.Hit204, attackType, attackerMO, validTargetMOList)
			ArcadeGameTriggerController.instance:clearTargetListTempAttr(validTargetMOList)
			ArcadeGameModel.instance:clearGameTempAttribute()
		end

		self:_enterDeathSettleFlow(attackerMO)

		if validTargetMOList then
			for _, targetMO in ipairs(validTargetMOList) do
				self:_enterDeathSettleFlow(targetMO, attackerMO)
			end
		end
	end
end

function ArcadeGameController:_filterTargetMOList(targetMOList)
	if not targetMOList then
		return
	end

	local result = {}

	for _, targetMO in ipairs(targetMOList) do
		local isAlive = targetMO:getIsAlive()
		local isRespawning = targetMO:getIsRespawning()

		if isAlive and not isRespawning then
			result[#result + 1] = targetMO
		end
	end

	return result
end

function ArcadeGameController:_getAttackAndHitShow(attackerMO, attackType, skillId)
	local attackActionShowId, hitActionShowId, actionShowParam
	local isBasicAttack = attackType == ArcadeGameEnum.AttackType.Normal or attackType == ArcadeGameEnum.AttackType.Link

	if isBasicAttack then
		attackActionShowId = ArcadeGameEnum.ActionShowId.BaseAttack
		hitActionShowId = ArcadeGameEnum.ActionShowId.BaseHit

		local attackAttrId = attackerMO:getAttackAttrId()

		if attackAttrId and attackAttrId ~= 0 then
			local attrHitShowId = ArcadeConfig.instance:getAttackAttrHitActionShow(attackAttrId)

			if attrHitShowId and attrHitShowId ~= 0 then
				hitActionShowId = attrHitShowId
			end
		end
	elseif attackType == ArcadeGameEnum.AttackType.Bomb then
		attackActionShowId = ArcadeGameEnum.ActionShowId.BombAttack
		hitActionShowId = ArcadeGameEnum.ActionShowId.BombHit
	elseif attackType == ArcadeGameEnum.AttackType.Skill then
		if not skillId then
			local characterId = attackerMO:getId()

			skillId = ArcadeConfig.instance:getCharacterSkill(characterId)
		end

		attackActionShowId = ArcadeGameEnum.ActionShowId.ActiveSkill
		hitActionShowId = ArcadeGameEnum.ActionShowId.ActiveSkillHit
		actionShowParam = skillId
	end

	return attackActionShowId, hitActionShowId, actionShowParam
end

function ArcadeGameController:_calAttackDamage(attackerMO, attackType, targetMOList, attackDirection, hitActionShowId, actionShowParam, skillId)
	if not targetMOList or #targetMOList <= 0 then
		return
	end

	local attackDamage = 0
	local attackerId = attackerMO:getId()
	local attackerEntityType = attackerMO:getEntityType()
	local isCharacterAttack = attackerEntityType == ArcadeGameEnum.EntityType.Character
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local characterId = characterMO and characterMO:getId()
	local isCharacterBomb = false

	if attackType == ArcadeGameEnum.AttackType.Bomb then
		isCharacterBomb = attackerMO:getIsCharacterBomb()
		attackDamage = ArcadeConfig.instance:getBombDamage(attackerId) + ((isCharacterBomb or nil) and ArcadeGameModel.instance:getGameAttribute(ArcadeGameEnum.GameAttribute.AddBombDamage))
	elseif attackType == ArcadeGameEnum.AttackType.Skill then
		local addSkillDamage = 0

		if isCharacterAttack then
			local characterSkillId = ArcadeConfig.instance:getCharacterSkill(characterId)

			skillId = skillId or characterSkillId

			if skillId == characterSkillId then
				addSkillDamage = ArcadeGameModel.instance:getGameAttribute(ArcadeGameEnum.GameAttribute.AddSkillDamage)
			end
		end

		attackDamage = ArcadeConfig.instance:getActiveSkillDamage(skillId) + addSkillDamage
	end

	local defenseGridX, defenseGridY, defenseTargetMO
	local isBasicAttack = attackType == ArcadeGameEnum.AttackType.Normal or attackType == ArcadeGameEnum.AttackType.Link
	local attackAttrId = attackerMO:getAttackAttrId()
	local attackerX, attackerY = attackerMO:getGridPos()

	if attackDirection then
		defenseGridX = attackerX + (ArcadeEnum.DirChangeGridX[attackDirection] or 0)
		defenseGridY = attackerY + (ArcadeEnum.DirChangeGridY[attackDirection] or 0)
	end

	for _, targetMO in ipairs(targetMOList) do
		local targetEntityType = targetMO:getEntityType()
		local targetUid = targetMO:getUid()
		local targetX, targetY = targetMO:getGridPos()
		local targetSizeX, targetSizeY = targetMO:getSize()
		local hitDirection = ArcadeGameHelper.getDirection(targetX, targetY, targetSizeX, targetSizeY, attackerX, attackerY)
		local canBeAttacked = true
		local needPlayActionShow = true

		if isBasicAttack then
			local buffSetMO = targetMO:getBuffSetMO()
			local strHitDirection = tostring(hitDirection)
			local notBeAttackEffect = ArcadeGameEnum.BuffEffectName.NotBeAttack
			local onlySpecAttackEffect = ArcadeGameEnum.BuffEffectName.OnlySpecAttack
			local haveNotBeAttackBuff = buffSetMO:hasEffectParamBuff(notBeAttackEffect, strHitDirection)
			local refuseThisAttackAttr = false
			local onlySpecAttackBuffDict = buffSetMO:getBuffDictByEffectParam(onlySpecAttackEffect)

			if onlySpecAttackBuffDict and next(onlySpecAttackBuffDict) then
				refuseThisAttackAttr = true

				for _, buff in pairs(onlySpecAttackBuffDict) do
					local param = buff:getEffectNameParam(onlySpecAttackEffect)

					if tonumber(param) == attackAttrId then
						refuseThisAttackAttr = false

						break
					end
				end
			end

			if haveNotBeAttackBuff or refuseThisAttackAttr then
				canBeAttacked = false
				needPlayActionShow = false

				local removeBuffList = buffSetMO:reduceBuffRoundByEffectParam(notBeAttackEffect, strHitDirection)

				self:removeEntityBuffs(removeBuffList, targetEntityType, targetUid)
			else
				local damageFactor = 1
				local specAttackDamageFactorEffect = ArcadeGameEnum.BuffEffectName.SpecAttackDamageFactor
				local specAttackDamageFactorBuffDict = buffSetMO:getBuffDictByEffectParam(specAttackDamageFactorEffect)

				if specAttackDamageFactorBuffDict then
					for _, buff in pairs(specAttackDamageFactorBuffDict) do
						local param = buff:getEffectNameParam(specAttackDamageFactorEffect)
						local paramArr = string.splitToNumber(param, "#")

						if paramArr[1] == attackAttrId then
							damageFactor = paramArr[2]
						end
					end
				end

				local attackValue = attackerMO:getAttributeValue(ArcadeGameEnum.BaseAttr.attack)
				local defenseValue = targetMO:getAttributeValue(ArcadeGameEnum.BaseAttr.defense)

				attackDamage = math.max(0, attackValue - defenseValue) * damageFactor
			end

			if isCharacterAttack and targetX <= defenseGridX and defenseGridX <= targetX + targetSizeX - 1 and targetY <= defenseGridY and defenseGridY <= targetY + targetSizeY - 1 then
				defenseTargetMO = targetMO
			end
		elseif attackType == ArcadeGameEnum.AttackType.Bomb then
			local isBombNotAttackSelf = ArcadeGameModel.instance:getGameSwitchIsOn(ArcadeGameEnum.GameSwitch.BombNotAttackSelf)

			if isCharacterBomb and targetEntityType == ArcadeGameEnum.EntityType.Character and isBombNotAttackSelf then
				canBeAttacked = false
				needPlayActionShow = false
			elseif targetEntityType == ArcadeGameEnum.EntityType.BaseInteractive then
				canBeAttacked = false

				self:_onBombAttackInteractive(targetMO)
			end
		end

		if needPlayActionShow and hitActionShowId then
			local scene = self:getGameScene()

			if scene then
				::label_51_0::

				local targetEntity = scene.entityMgr:getEntityWithType(targetEntityType, targetUid)

				if targetEntity then
					targetEntity:playActionShow(hitActionShowId, hitDirection, actionShowParam)
				end
			end
		end

		if canBeAttacked then
			self:changeEntityHp(targetMO, -attackDamage)
		end
	end

	if isCharacterAttack and defenseTargetMO then
		local buffSetMO = attackerMO:getBuffSetMO()
		local haveNotBeCounteredBuff = buffSetMO:hasEffectParamBuff(ArcadeGameEnum.BuffEffectName.NotBeCountered)

		if not haveNotBeCounteredBuff then
			local curHP = defenseTargetMO:getHp()

			if isBasicAttack and curHP > 0 then
				local targetAttackValue = defenseTargetMO:getAttributeValue(ArcadeGameEnum.BaseAttr.attack)
				local attackerDefenseValue = attackerMO:getAttributeValue(ArcadeGameEnum.BaseAttr.defense)
				local counterDamage = math.max(0, targetAttackValue - attackerDefenseValue)

				self:changeEntityHp(attackerMO, -counterDamage)
			end
		end
	end
end

function ArcadeGameController:_onBombAttackInteractive(mo)
	if not mo then
		return
	end

	local entityType = mo:getEntityType()
	local uid = mo:getUid()
	local id = mo:getId()
	local bombAttackEventList = ArcadeConfig.instance:getInteractiveBombAttackEventIdList(id)

	if bombAttackEventList and #bombAttackEventList > 0 then
		for _, eventOptionId in ipairs(bombAttackEventList) do
			local eventOptionParam = ArcadeConfig.instance:getEventOptionParam(eventOptionId)
			local result = self:triggerEventOption(entityType, id, uid, eventOptionId, eventOptionParam, true, true)

			if result then
				mo:setIsDead(true)
			end
		end

		self:removeDeadEntityAndDrop(mo)
	else
		self:dispatchEvent(ArcadeEvent.CheckEntityTalk, entityType, uid, ArcadeGameEnum.TalkTriggerType.BeBombAttack)
	end
end

function ArcadeGameController:_updateScoreAndSkillEnergy(attackerMO, attackType, targetMOList, skillId)
	local targetCountExceptCharacter = 0

	if targetMOList then
		for _, targetMO in ipairs(targetMOList) do
			local targetEntityType = targetMO:getEntityType()

			if targetEntityType ~= ArcadeGameEnum.EntityType.Character then
				targetCountExceptCharacter = targetCountExceptCharacter + 1
			end
		end
	end

	local isAddScore = false
	local attackerEntityType = attackerMO:getEntityType()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local characterId = characterMO and characterMO:getId()
	local isCharacterAttack = attackerEntityType == ArcadeGameEnum.EntityType.Character

	if isCharacterAttack then
		isAddScore = true
	elseif attackerEntityType == ArcadeGameEnum.EntityType.Bomb then
		local bombId = ArcadeConfig.instance:getCharacterBomb(characterId)
		local attackBombId = attackerMO:getId()

		isAddScore = bombId == attackBombId
	end

	if isAddScore then
		local targetAddScore = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.TargetAddScore, true)
		local addScore = targetCountExceptCharacter * targetAddScore

		self:changeResCount(ArcadeGameEnum.CharacterResource.Score, addScore)
	end

	local changeEnergy = 0
	local isBasicAttack = attackType == ArcadeGameEnum.AttackType.Normal or attackType == ArcadeGameEnum.AttackType.Link

	if isCharacterAttack and attackType == ArcadeGameEnum.AttackType.Skill then
		local characterSkillId = ArcadeConfig.instance:getCharacterSkill(characterId)

		if skillId and characterSkillId == skillId then
			local curEnergy = characterMO and characterMO:getResourceCount(ArcadeGameEnum.CharacterResource.SkillEnergy) or 0

			changeEnergy = -curEnergy
		end
	elseif isBasicAttack and targetCountExceptCharacter and targetCountExceptCharacter > 0 then
		local targetAddEnergy = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.TargetAddSkillEnergy, true)

		changeEnergy = targetCountExceptCharacter * targetAddEnergy
	end

	self:changeResCount(ArcadeGameEnum.CharacterResource.SkillEnergy, changeEnergy)
end

function ArcadeGameController:_enterDeathSettleFlow(entityMO, attackerMO)
	local isCanDead = entityMO and entityMO:getIsCanDead()

	if not isCanDead then
		return
	end

	local alreadyDead = entityMO:getIsDead()
	local curHP = entityMO:getHp()
	local isDead = curHP <= 0

	if alreadyDead or not isDead then
		return
	end

	ArcadeGameTriggerController.instance:deathTriggerTarget(ArcadeGameEnum.TriggerPoint.Death701, entityMO, attackerMO)
	entityMO:setIsDead(true)
	ArcadeGameTriggerController.instance:deathTriggerTarget(ArcadeGameEnum.TriggerPoint.Death702, entityMO, attackerMO)

	local entityType = entityMO:getEntityType()
	local uid = entityMO:getUid()

	if attackerMO and entityType == ArcadeGameEnum.EntityType.Monster then
		ArcadeGameModel.instance:addKillMonsterNum()

		local buffSetMO = entityMO:getBuffSetMO()
		local buffList = buffSetMO and buffSetMO:getBuffList()

		if buffList then
			for _, buffMO in ipairs(buffList) do
				local buffId = buffMO:getId()
				local attackerEntityType = attackerMO:getEntityType()
				local attackerUid = attackerMO:getUid()

				ArcadeGameModel.instance:triggerEntityCounterRecord(attackerEntityType, attackerUid, ArcadeGameEnum.GameCounter.SpecBuffMonsterKillsSinceAddSkill, buffId)
			end
		end
	end

	local isCanRespawn = entityMO:getIsCanRespawn()

	if isCanRespawn then
		self:_enterRespawnFlow(entityMO, attackerMO)
	elseif entityType == ArcadeGameEnum.EntityType.Character then
		self:endGame(ArcadeGameEnum.SettleType.Fail, false)
	else
		local scene = self:getGameScene()

		if scene then
			::label_54_0::

			local entity = scene.entityMgr:getEntityWithType(entityType, uid)
			local hasCorpse = entityMO:getHasCorpse()

			if hasCorpse and entity then
				entity:playActionShow(ArcadeGameEnum.ActionShowId.EnterDead)
			else
				self:removeDeadEntityAndDrop(entityMO, true)
			end

			ArcadeGameTriggerController.instance:deathTriggerTarget(ArcadeGameEnum.TriggerPoint.DeathAfter712, entityMO, attackerMO)

			local characterMO = ArcadeGameModel.instance:getCharacterMO()

			ArcadeGameTriggerController.instance:triggerTarget(ArcadeGameEnum.TriggerPoint.DeathAfter724, characterMO, {
				specTargetEntityMO = entityMO
			})
		end
	end
end

local RESPAWN_COST = 1

function ArcadeGameController:_enterRespawnFlow(entityMO, attackerMO)
	if not entityMO then
		return
	end

	local entityType = entityMO:getEntityType()
	local attackerEntityType = attackerMO and attackerMO:getEntityType()
	local attackerUid = attackerMO and attackerMO:getEntityType()
	local uid = entityMO:getUid()
	local hpCap = entityMO:getAttributeValue(ArcadeGameEnum.BaseAttr.hpCap)

	entityMO:setHp(hpCap)
	entityMO:setIsDead(false)

	local isCharacter = entityType == ArcadeGameEnum.EntityType.Character
	local scene = self:getGameScene()

	if scene then
		::label_55_0::

		local entity = scene.entityMgr:getEntityWithType(entityType, uid)

		if isCharacter then
			self:changeResCount(ArcadeGameEnum.CharacterResource.RespawnTimes, -RESPAWN_COST)
			ArcadeStatHelper.instance:AddUseRebornTimes()
		end

		local param = {
			entityType = entityType,
			uid = uid,
			attackerEntityType = attackerEntityType,
			attackerUid = attackerUid,
			hpCap = hpCap
		}

		if not entity then
			self:_afterRespawnEff(param)

			return
		end

		if isCharacter then
			self:pauseGame()
			entity:playActionShow(ArcadeGameEnum.ActionShowId.Respawn, nil, nil, self._afterRespawnEff, self, param)
			entityMO:setIsRespawning(true)
		else
			entity:playActionShow(ArcadeGameEnum.ActionShowId.Respawn)
			self:_afterRespawnEff(param)
		end
	end
end

function ArcadeGameController:_afterRespawnEff(param)
	self:resumeGame()

	if not param then
		return
	end

	local entityType = param.entityType
	local uid = param.uid
	local entityMO = ArcadeGameModel.instance:getMOWithType(entityType, uid)

	if entityMO then
		entityMO:setIsRespawning(false)
	end

	local attackerEntityType = param.attackerEntityType
	local attackerUid = param.attackerUid
	local attackerMO = ArcadeGameModel.instance:getMOWithType(attackerEntityType, attackerUid)

	ArcadeGameTriggerController.instance:deathTriggerTarget(ArcadeGameEnum.TriggerPoint.DeathAfter720, entityMO, attackerMO)
	self:dispatchEvent(ArcadeEvent.OnChangeEntityHp, entityMO, param.hpCap)
end

function ArcadeGameController:resetGoods()
	local isCanReset = ArcadeGameModel.instance:getIsCanResetGoods()

	if not isCanReset then
		return
	end

	local curRoom = self:getCurRoom()

	if not curRoom or not curRoom.resetGoods then
		return
	end

	curRoom:resetGoods()

	local resetCost = ArcadeGameModel.instance:getGameAttribute(ArcadeGameEnum.GameAttribute.ResetStoreCost)

	self:changeResCount(ArcadeGameEnum.CharacterResource.GameCoin, -resetCost)
	ArcadeGameModel.instance:addGoodsHasResetTimes()
end

function ArcadeGameController:isPlayerCanAct()
	local curRoom = self:getCurRoom()
	local isPlayerTurn = ArcadeGameModel.instance:getIsPlayerTurn()
	local isChangingRoom = ArcadeGameModel.instance:getIsChangingRoom()
	local isGamePause = ArcadeGameModel.instance:getIsPauseGame()
	local isGameEnd = ArcadeGameModel.instance:getIsEndGame()

	return (not curRoom or not isPlayerTurn or isChangingRoom or isGamePause or isGameEnd) and false
end

function ArcadeGameController:beginPlayerTurn()
	ArcadeGameModel.instance:setIsPlayerTurn(true)
end

function ArcadeGameController:playerActOnDirection(direction)
	if not direction then
		return
	end

	local isPlayerCanAct = self:isPlayerCanAct()

	if not isPlayerCanAct then
		return
	end

	local targetGridEntityUid, targetGridEntityType, targetGridEntityMO
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local curGridX, curGridY = characterMO:getGridPos()
	local targetGridX = curGridX + (ArcadeEnum.DirChangeGridX[direction] or 0)
	local targetGridY = curGridY + (ArcadeEnum.DirChangeGridY[direction] or 0)

	if ArcadeGameHelper.isOutSideRoom(targetGridX, targetGridY) then
		return
	end

	local curRoom = self:getCurRoom()
	local entityData = curRoom:getEntityDataInTargetGrid(targetGridX, targetGridY)

	if entityData then
		targetGridEntityUid = entityData.uid
		targetGridEntityType = entityData.entityType
		targetGridEntityMO = ArcadeGameModel.instance:getMOWithType(entityData.entityType, entityData.uid)
	end

	if targetGridEntityType == ArcadeGameEnum.EntityType.Monster then
		local isDead = targetGridEntityMO and targetGridEntityMO:getIsDead()

		if isDead then
			self:removeDeadEntityAndDrop(targetGridEntityMO)
			self:dispatchEvent(ArcadeEvent.PlayerTryDoAction, ArcadeGameEnum.PlayerActType.Move, {
				targetGridX = targetGridX,
				targetGridY = targetGridY,
				direction = direction
			})
		else
			self:dispatchEvent(ArcadeEvent.PlayerTryDoAction, ArcadeGameEnum.PlayerActType.Attack, {
				entityType = targetGridEntityType,
				uid = targetGridEntityUid,
				direction = direction
			})
		end
	else
		self:dispatchEvent(ArcadeEvent.PlayerTryDoAction, ArcadeGameEnum.PlayerActType.Move, {
			targetGridX = targetGridX,
			targetGridY = targetGridY,
			direction = direction
		})
	end
end

function ArcadeGameController:playerTryPlaceBomb()
	local isPlayerCanAct = self:isPlayerCanAct()

	if not isPlayerCanAct then
		return
	end

	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local bombCount = characterMO and characterMO:getResourceCount(ArcadeGameEnum.CharacterResource.Bomb) or 0

	if bombCount <= 0 then
		GameFacade.showToast(ToastEnum.V3a3ArcadeGameNoBomb)

		return
	end

	local gridX, gridY = characterMO:getGridPos()

	self:dispatchEvent(ArcadeEvent.PlayerTryDoAction, ArcadeGameEnum.PlayerActType.UseBomb, {
		targetGridX = gridX,
		targetGridY = gridY
	})
end

local PLACE_BOMB_COST = 1

function ArcadeGameController:playerPlaceBomb(bombId, targetGridX, targetGridY, extraParam)
	local cfg = ArcadeConfig.instance:getBombCfg(bombId, true)

	if not cfg then
		return
	end

	self:changeResCount(ArcadeGameEnum.CharacterResource.Bomb, -PLACE_BOMB_COST)
	self:directPlaceBomb(bombId, targetGridX, targetGridY, extraParam)
end

function ArcadeGameController:directPlaceBomb(bombId, targetGridX, targetGridY, extraParam)
	local cfg = ArcadeConfig.instance:getBombCfg(bombId, true)

	if not cfg then
		return
	end

	local sizeX, sizeY = ArcadeConfig.instance:getBombSize(bombId)
	local bombData = {
		entityType = ArcadeGameEnum.EntityType.Bomb,
		id = bombId,
		x = targetGridX,
		y = targetGridY,
		sizeX = sizeX,
		sizeY = sizeY,
		extraParam = extraParam
	}
	local moList = self:tryAddEntityList({
		bombData
	}, true)
	local bombMO = moList and moList[1]

	ArcadeGameTriggerController.instance:triggerTarget(ArcadeGameEnum.TriggerPoint.AfterPlaceBomb502, bombMO)

	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	ArcadeGameTriggerController.instance:triggerTarget(ArcadeGameEnum.TriggerPoint.AfterPlaceBomb502, characterMO, {
		bombMO = bombMO
	})

	return bombMO
end

function ArcadeGameController:playerTryUseSkill()
	local isPlayerCanAct = self:isPlayerCanAct()

	if not isPlayerCanAct then
		return
	end

	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if not characterMO then
		return
	end

	local curSkillEnergy = characterMO:getResourceCount(ArcadeGameEnum.CharacterResource.SkillEnergy) or 0
	local characterId = characterMO:getId()
	local needEnergy = ArcadeConfig.instance:getCharacterSkillCost(characterId) or 0

	if needEnergy <= 0 or curSkillEnergy < needEnergy then
		GameFacade.showToast(ToastEnum.V3a3ArcadeGameNoSkillEnergy)

		return
	end

	local gridX, gridY = characterMO:getGridPos()

	self:dispatchEvent(ArcadeEvent.PlayerTryDoAction, ArcadeGameEnum.PlayerActType.UseSkill, {
		targetGridX = gridX,
		targetGridY = gridY
	})
end

function ArcadeGameController:endPlayerTurn()
	ArcadeGameModel.instance:setIsPlayerTurn(false)
end

ArcadeGameController.instance = ArcadeGameController.New()

return ArcadeGameController
