-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/work/ArcadeRoundBeginWork.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.work.ArcadeRoundBeginWork", package.seeall)

local ArcadeRoundBeginWork = class("ArcadeRoundBeginWork", BaseWork)

function ArcadeRoundBeginWork:onStart(room)
	self._isNeedWait = false

	TaskDispatcher.cancelTask(self._delayDone, self)
	ArcadeGameTriggerController.instance:resetTriggerCount()

	local gridMOList = ArcadeGameModel.instance:getGridMOList()

	ArcadeGameTriggerController.instance:triggerTargetList(ArcadeGameEnum.TriggerPoint.RoundBegin815, gridMOList)
	ArcadeGameHelper.tryCallFunc(self.updateFloorCountdown, self)
	ArcadeGameHelper.tryCallFunc(self.reduceBuffsRound, self)
	self:reduceScoreBeginRound()
	self:updateCorpseCountdown()
	self:updateBombCountdown()
	self:_roundBeginFinish()
end

function ArcadeRoundBeginWork:updateFloorCountdown()
	local entityType = ArcadeGameEnum.EntityType.Floor
	local floorMOList = ArcadeGameModel.instance:getEntityMOList(entityType)

	if not floorMOList or #floorMOList < 1 then
		return
	end

	local removeUidList

	for _, floorMO in ipairs(floorMOList) do
		local cdRound = floorMO:getCdRound() + 1
		local limitRound = floorMO:getLimitRound()

		floorMO:setCdRound(cdRound)

		if limitRound <= cdRound and limitRound ~= -1 then
			removeUidList = removeUidList or {}

			table.insert(removeUidList, floorMO:getUid())
		end
	end

	if removeUidList and #removeUidList > 0 then
		for _, floorUid in ipairs(removeUidList) do
			ArcadeGameController.instance:removeEntity(entityType, floorUid)
		end
	end
end

function ArcadeRoundBeginWork:reduceBuffsRound()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	self:_reduceEntityBuffs(characterMO)

	local monsterMOList = ArcadeGameModel.instance:getMonsterList()

	if monsterMOList then
		for _, monsterMO in ipairs(monsterMOList) do
			self:_reduceEntityBuffs(monsterMO)
		end
	end

	local gridMOList = ArcadeGameModel.instance:getGridMOList()

	if gridMOList then
		for _, gridMO in ipairs(gridMOList) do
			self:_reduceEntityBuffs(gridMO)
		end
	end
end

function ArcadeRoundBeginWork:_reduceEntityBuffs(entityMO)
	local buffSetMO = entityMO and entityMO:getBuffSetMO()

	if buffSetMO then
		local entityType = entityMO:getEntityType()
		local uid = entityMO:getUid()
		local removeBuffList = buffSetMO:checkBuffsReduceInRoundBegin()

		ArcadeGameController.instance:removeEntityBuffs(removeBuffList, entityType, uid)
	end
end

function ArcadeRoundBeginWork:reduceScoreBeginRound()
	local negativeRoundLimit = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.NegativeRoundLimit, true)
	local curNegativeRound = ArcadeGameModel.instance:getNegativeOperationRound()

	if negativeRoundLimit < curNegativeRound then
		local subCount = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.SubScoreInRound, true)

		ArcadeGameController.instance:changeResCount(ArcadeGameEnum.CharacterResource.Score, subCount)
	end
end

function ArcadeRoundBeginWork:updateCorpseCountdown()
	local monsterList = ArcadeGameModel.instance:getMonsterList()

	if not monsterList or #monsterList <= 0 then
		return
	end

	local removeList = {}
	local corpseKeepTime = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.CorpseKeepTime, true)

	for _, monsterMO in ipairs(monsterList) do
		local isDead = monsterMO:getIsDead()
		local hasCorpse = monsterMO:getHasCorpse()

		if isDead and hasCorpse then
			local curCorpseTime = monsterMO:getCorpseTime()

			if corpseKeepTime <= curCorpseTime then
				removeList[#removeList + 1] = monsterMO
			else
				monsterMO:addCorpseTime()
			end
		end
	end

	for _, monsterMO in ipairs(removeList) do
		ArcadeGameController.instance:removeDeadEntityAndDrop(monsterMO, true)
	end
end

function ArcadeRoundBeginWork:updateBombCountdown()
	local bombUidList = ArcadeGameModel.instance:getEntityUidList(ArcadeGameEnum.EntityType.Bomb)

	if not bombUidList or #bombUidList <= 0 then
		return
	end

	local playEffectDict = {}
	local removeEffectDict = {}
	local checkDict = {}

	for _, bombUid in ipairs(bombUidList) do
		local bombMO = ArcadeGameModel.instance:getMOWithType(ArcadeGameEnum.EntityType.Bomb, bombUid)

		if bombMO then
			bombMO:addLiveRound()
		end

		self:_updateBomb(bombUid, playEffectDict, removeEffectDict)

		checkDict[bombUid] = true
	end

	local lastedBombUidList = ArcadeGameModel.instance:getEntityUidList(ArcadeGameEnum.EntityType.Bomb)

	if lastedBombUidList then
		for _, bombUid in ipairs(lastedBombUidList) do
			if not checkDict[bombUid] then
				self:_updateBomb(bombUid, playEffectDict, removeEffectDict)
			end
		end
	end

	local scene = ArcadeGameController.instance:getGameScene()

	if not scene then
		return
	end

	for effId, gridPosDict in pairs(removeEffectDict) do
		local playGridPosDict = playEffectDict[effId]

		for gridId, gridPos in pairs(gridPosDict) do
			if not playGridPosDict or not playGridPosDict[gridId] then
				scene.effectMgr:removeEffect(effId, gridPos.x, gridPos.y, true)
			end
		end
	end

	for effId, gridPosDict in pairs(playEffectDict) do
		for _, gridPos in pairs(gridPosDict) do
			scene.effectMgr:playEffect2Grid(effId, gridPos.x, gridPos.y)
		end
	end
end

function ArcadeRoundBeginWork:_updateBomb(bombUid, refPlayEffDict, refRemoveEffDict)
	local bombMO = ArcadeGameModel.instance:getMOWithType(ArcadeGameEnum.EntityType.Bomb, bombUid)

	if not bombMO then
		return
	end

	local bombId = bombMO:getId()
	local warnEffectIdList = ArcadeGameHelper.getActionShowEffect(ArcadeGameEnum.ActionShowId.BombWarn, bombId)
	local warnEffId = warnEffectIdList and warnEffectIdList[1]
	local isCharacterBomb = bombMO:getIsCharacterBomb()
	local gridX, gridY = bombMO:getGridPos()
	local targetMOList, gridMOList = ArcadeGameHelper.getBombExplodeTargetList(bombId, gridX, gridY, isCharacterBomb)
	local liveRound = bombMO:getLiveRound()
	local countdown = ArcadeConfig.instance:getBombCountdown(bombId)

	if countdown <= liveRound then
		self:_onBombExploded(bombMO, targetMOList, gridMOList, isCharacterBomb)

		local explodedEffectIdList = ArcadeGameHelper.getActionShowEffect(ArcadeGameEnum.ActionShowId.BombExposeRange)
		local explodedEffId = explodedEffectIdList and explodedEffectIdList[1]

		self:_fillEffectPosDict(refPlayEffDict, explodedEffId, gridMOList)
		self:_fillEffectPosDict(refRemoveEffDict, warnEffId, gridMOList)
	else
		self:_fillEffectPosDict(refPlayEffDict, warnEffId, gridMOList)
	end
end

function ArcadeRoundBeginWork:_fillEffectPosDict(refEffectDict, effectId, gridMOList)
	if not gridMOList then
		return
	end

	local gridPosDict = ArcadeGameHelper.checkDictTable(refEffectDict, effectId)

	for _, gridMO in ipairs(gridMOList) do
		local x, y = gridMO:getGridPos()
		local gridId = ArcadeGameHelper.getGridId(x, y)

		gridPosDict[gridId] = {
			x = x,
			y = y
		}
	end
end

function ArcadeRoundBeginWork:_onBombExploded(bombMO, targetMOList, gridMOList, isCharacterBomb)
	ArcadeGameController.instance:enterAttackFlow(ArcadeGameEnum.AttackType.Bomb, bombMO, targetMOList)

	local isBombAddFloor = ArcadeGameModel.instance:getGameSwitchIsOn(ArcadeGameEnum.GameSwitch.BombAddFloor)
	local bombId = bombMO:getId()
	local addFloorId = ArcadeConfig.instance:getBombAddFloor(bombId)

	if gridMOList and isBombAddFloor and addFloorId and addFloorId ~= 0 then
		local floorDataList = {}

		for i, gridMO in ipairs(gridMOList) do
			local x, y = gridMO:getGridPos()

			floorDataList[i] = {
				id = addFloorId,
				x = x,
				y = y
			}
		end

		ArcadeGameFloorController.instance:tryAddFloorByList(floorDataList)
	end

	local newBounceCount = bombMO:getBounceCount() + 1

	ArcadeGameTriggerController.instance:triggerTarget(ArcadeGameEnum.TriggerPoint.AfterBombExplode505, bombMO, {
		extraParam = {
			isCharacterBomb = isCharacterBomb,
			bounceCount = newBounceCount
		},
		beJudgedNum = newBounceCount
	})
	ArcadeGameController.instance:removeEntity(ArcadeGameEnum.EntityType.Bomb, bombMO:getUid())

	self._isNeedWait = true
end

function ArcadeRoundBeginWork:_roundBeginFinish()
	local waitTime = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.RoundBeginWaitTime, true) or 0

	if self._isNeedWait and waitTime > 0 then
		TaskDispatcher.cancelTask(self._delayDone, self)
		TaskDispatcher.runDelay(self._delayDone, self, waitTime)
	else
		self:_delayDone()
	end

	self._isNeedWait = false
end

function ArcadeRoundBeginWork:_delayDone()
	TaskDispatcher.cancelTask(self._delayDone, self)
	self:onDone(true)
end

function ArcadeRoundBeginWork:clearWork()
	self._isNeedWait = false

	TaskDispatcher.cancelTask(self._delayDone, self)
end

return ArcadeRoundBeginWork
