-- chunkname: @modules/logic/fight/model/FightCardModel.lua

module("modules.logic.fight.model.FightCardModel", package.seeall)

local FightCardModel = class("FightCardModel", BaseModel)

function FightCardModel:onInit()
	self._cardMO = FightCardMO.New()
	self._distributeQueue = {}
	self._cardOps = {}
	self.curSelectEntityId = 0
	self.nextRoundActPoint = nil
	self.nextRoundMoveNum = nil
	self._universalCardMO = nil
	self._beCombineCardMO = nil
	self.redealCardInfoList = nil
	self._dissolvingCard = nil
	self._changingCard = nil
	self.areaSize = 0
end

function FightCardModel:clear()
	self.redealCardInfoList = nil
	self._dissolvingCard = nil
	self._changingCard = nil
	self.areaSize = 0

	self:clearCardOps()

	if self._cardMO then
		self._cardMO:reset()
	end

	self:clearDistributeQueue()
end

function FightCardModel:setDissolving(flag)
	local version = FightModel.instance:getVersion()

	if version >= 1 then
		return
	end

	self._dissolvingCard = flag
end

function FightCardModel:setChanging(flag)
	self._changingCard = flag
end

function FightCardModel:isDissolving()
	return self._dissolvingCard
end

function FightCardModel:isChanging()
	return self._changingCard
end

function FightCardModel:setUniversalCombine(universalCardMO, beCombineCardMO)
	self._universalCardMO = universalCardMO
	self._beCombineCardMO = beCombineCardMO
end

function FightCardModel:getUniversalCardMO()
	return self._universalCardMO
end

function FightCardModel:getBeCombineCardMO()
	return self._beCombineCardMO
end

function FightCardModel:enqueueDistribute(beforeArr, newArr)
	local before = tabletool.copy(beforeArr)
	local new = tabletool.copy(newArr)

	if #new > 0 then
		while #new > 0 do
			local cards = tabletool.copy(before)

			while #new > 0 do
				table.insert(cards, table.remove(new, 1))

				local combineIndex = FightCardModel.getCombineIndexOnce(cards)

				if combineIndex then
					break
				end
			end

			local temp = {}

			for i = #before + 1, #cards do
				table.insert(temp, cards[i])
			end

			table.insert(self._distributeQueue, {
				before,
				temp
			})

			before = FightCardModel.calcCardsAfterCombine(cards)
		end
	else
		table.insert(self._distributeQueue, {
			before,
			new
		})
	end
end

function FightCardModel:dequeueDistribute()
	if #self._distributeQueue > 0 then
		local arrList = table.remove(self._distributeQueue, 1)

		return arrList[1], arrList[2]
	end
end

function FightCardModel:clearDistributeQueue()
	self._distributeQueue = {}
end

function FightCardModel:getDistributeQueueLen()
	return #self._distributeQueue
end

function FightCardModel:applyNextRoundActPoint()
	if self.nextRoundActPoint and self.nextRoundActPoint > 0 then
		self._cardMO.actPoint = self.nextRoundActPoint
		self._cardMO.moveNum = self.nextRoundMoveNum
		self.nextRoundActPoint = nil
		self.nextRoundMoveNum = nil
	end
end

function FightCardModel:getEntityOps(entityId, cardOpType)
	local opList = {}

	for _, op in ipairs(self._cardOps) do
		if op.belongToEntityId == entityId and (not cardOpType or op.operType == cardOpType) then
			table.insert(opList, op)
		end
	end

	return opList
end

function FightCardModel:setCurSelectEntityId(entityId)
	self.curSelectEntityId = entityId
end

function FightCardModel:resetCurSelectEntityIdDefault()
	if FightDataHelper.stateMgr:getIsAuto() then
		if FightHelper.canSelectEnemyEntity(self.curSelectEntityId) then
			self:setCurSelectEntityId(self.curSelectEntityId)
		else
			self:setCurSelectEntityId(0)
		end
	else
		local curSelectEntityMO = FightDataHelper.entityMgr:getById(self.curSelectEntityId)

		if curSelectEntityMO and curSelectEntityMO:isStatusDead() then
			curSelectEntityMO = nil
		end

		if curSelectEntityMO and curSelectEntityMO.side == FightEnum.EntitySide.MySide then
			self.curSelectEntityId = 0
			curSelectEntityMO = nil
		end

		local notDead = curSelectEntityMO ~= nil
		local cantSelect1 = curSelectEntityMO and curSelectEntityMO:hasBuffFeature(FightEnum.BuffType_CantSelect)
		local cantSelect2 = curSelectEntityMO and curSelectEntityMO:hasBuffFeature(FightEnum.BuffType_CantSelectEx)

		if self.curSelectEntityId ~= 0 and notDead and not cantSelect1 and not cantSelect2 then
			return
		end

		local enemyList = FightDataHelper.entityMgr:getEnemyNormalList()

		for i = #enemyList, 1, -1 do
			local enemyMO = enemyList[i]

			if enemyMO:hasBuffFeature(FightEnum.BuffType_CantSelect) or enemyMO:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
				table.remove(enemyList, i)
			end
		end

		if #enemyList > 0 then
			table.sort(enemyList, function(enemyMO1, enemyMO2)
				return enemyMO1.position < enemyMO2.position
			end)
			self:setCurSelectEntityId(enemyList[1].id)
		end
	end
end

function FightCardModel:getSelectEnemyPosLOrR(LorR)
	local enemyList = FightDataHelper.entityMgr:getEnemyNormalList()

	for i = #enemyList, 1, -1 do
		local enemyMO = enemyList[i]

		if enemyMO:hasBuffFeature(FightEnum.BuffType_CantSelect) or enemyMO:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
			table.remove(enemyList, i)
		end
	end

	if #enemyList > 0 then
		table.sort(enemyList, function(enemyMO1, enemyMO2)
			return enemyMO1.position < enemyMO2.position
		end)

		for i = 1, #enemyList do
			if enemyList[i].id == self.curSelectEntityId then
				if LorR == 1 and i < #enemyList then
					return enemyList[i + 1].id
				elseif LorR == 2 and i > 1 then
					return enemyList[i - 1].id
				end
			end
		end
	end
end

function FightCardModel:onStartRound()
	self:getCardMO():setExtraMoveAct(0)
end

function FightCardModel:onEndRound()
	return
end

function FightCardModel:getCardMO()
	return self._cardMO
end

function FightCardModel:getCardOps()
	return self._cardOps
end

function FightCardModel:resetCardOps()
	self._cardOps = {}

	local entityDataDic = FightDataHelper.entityMgr:getAllEntityData()

	for k, entityMO in pairs(entityDataDic) do
		entityMO:resetSimulateExPoint()
	end
end

function FightCardModel:clearCardOps()
	self._cardOps = {}
end

function FightCardModel:getShowOpActList()
	local list = {}

	for _, op in ipairs(self._cardOps) do
		if FightCardModel.instance:canShowOpAct(op) then
			table.insert(list, op)
		end
	end

	return list
end

function FightCardModel:canShowOpAct(op)
	if not op:isMoveUniversal() then
		local isUnlimitMoveCard = op:isMoveCard() and self._cardMO:isUnlimitMoveCard()

		if not isUnlimitMoveCard or op:isPlayCard() then
			return true
		end
	end
end

function FightCardModel:getPlayCardOpList()
	local list = {}

	for _, op in ipairs(self._cardOps) do
		if op:isPlayCard() then
			table.insert(list, op)
		end
	end

	return list
end

function FightCardModel:getMoveCardOpList()
	local list = {}

	for _, op in ipairs(self._cardOps) do
		if op:isMoveCard() then
			table.insert(list, op)
		end
	end

	return list
end

function FightCardModel:getMoveCardOpCostActList()
	local list = {}

	for _, op in ipairs(self._cardOps) do
		if op:isMoveCard() then
			table.insert(list, op)
		end
	end

	return list
end

function FightCardModel:updateCard(cardInfoPush)
	self:clearCardOps()
	self._cardMO:init(cardInfoPush)
end

function FightCardModel:coverCard(cards)
	if not cards then
		logError("覆盖卡牌序列,传入的数据为空")
	end

	self._cardMO:setCards(cards)
end

function FightCardModel:getHandCards()
	return self:getHandCardsByOps(self._cardOps)
end

function FightCardModel:getHandCardData()
	return self._cardMO and self._cardMO.cardGroup
end

function FightCardModel:getHandCardsByOps(ops)
	return self:tryGettingHandCardsByOps(ops) or {}
end

function FightCardModel:tryGettingHandCardsByOps(ops)
	if not self._cardMO then
		return nil
	end

	local universalCardMO, beCombineCardMO
	local cards = tabletool.copy(self._cardMO.cardGroup)

	for _, op in ipairs(ops) do
		local discard = false

		if op:isMoveCard() then
			universalCardMO = nil
			beCombineCardMO = nil

			if not cards[op.param1] then
				return nil
			end

			if not cards[op.param2] then
				return nil
			end

			FightCardModel.moveOnly(cards, op.param1, op.param2)
		elseif op:isPlayCard() then
			universalCardMO = nil
			beCombineCardMO = nil

			if not cards[op.param1] then
				return nil
			end

			table.remove(cards, op.param1)

			if op.param2 and op.params ~= 0 then
				discard = true
			end
		elseif op:isMoveUniversal() then
			universalCardMO = cards[op.param1]
			beCombineCardMO = cards[op.param2]

			if not cards[op.param1] then
				return nil
			end

			if not cards[op.param2] then
				return nil
			end

			FightCardModel.moveOnly(cards, op.param1, op.moveToIndex)
		elseif op:isSimulateDissolveCard() then
			table.remove(cards, op.dissolveIndex)
		end

		if discard then
			table.remove(cards, op.param2)

			local combineIndex = FightCardModel.getCombineIndexOnce(cards, universalCardMO, beCombineCardMO)

			while #cards >= 2 and combineIndex do
				cards[combineIndex] = FightCardModel.combineTwoCard(cards[combineIndex], cards[combineIndex + 1], beCombineCardMO)

				table.remove(cards, combineIndex + 1)

				universalCardMO = nil
				beCombineCardMO = nil
				combineIndex = FightCardModel.getCombineIndexOnce(cards)
			end
		end

		local combineIndex = FightCardModel.getCombineIndexOnce(cards, universalCardMO, beCombineCardMO)

		while #cards >= 2 and combineIndex do
			cards[combineIndex] = FightCardModel.combineTwoCard(cards[combineIndex], cards[combineIndex + 1], beCombineCardMO)

			table.remove(cards, combineIndex + 1)

			universalCardMO = nil
			beCombineCardMO = nil
			combineIndex = FightCardModel.getCombineIndexOnce(cards)
		end
	end

	return cards
end

function FightCardModel:isCardOpEnd()
	local cardMO = FightCardModel.instance:getCardMO()

	if not cardMO then
		return true
	end

	local handCards = FightCardModel.instance:getHandCards()
	local cardCount = #handCards

	if cardCount == 0 then
		return true
	end

	local ops = FightCardModel.instance:getCardOps()
	local costActPoint = 0
	local moveCount = 0

	for _, op in ipairs(ops) do
		if op:isPlayCard() then
			costActPoint = costActPoint + op.costActPoint
		elseif op:isMoveCard() then
			moveCount = moveCount + 1

			if not self._cardMO:isUnlimitMoveCard() and moveCount > self._cardMO.extraMoveAct then
				costActPoint = costActPoint + op.costActPoint
			end
		end
	end

	local canUsePoint = cardMO.actPoint

	if FightModel.instance:isSeason2() then
		canUsePoint = 1

		if #ops >= 1 then
			return true
		end
	end

	if canUsePoint <= costActPoint then
		return true
	end

	if FightCardDataHelper.allFrozenCard(handCards) then
		return true
	end

	return false
end

function FightCardModel.calcCardsAfterCombine(cards, combineCount)
	local cards = tabletool.copy(cards)
	local combineIndex = FightCardModel.getCombineIndexOnce(cards)
	local count = 0

	while combineIndex do
		cards[combineIndex] = FightCardModel.combineTwoCard(cards[combineIndex], cards[combineIndex + 1])

		table.remove(cards, combineIndex + 1)

		combineIndex = FightCardModel.getCombineIndexOnce(cards)
		count = count + 1

		if count == combineCount then
			break
		end
	end

	return cards, count
end

function FightCardModel.combineTwoCard(cardMO1, cardMO2, beCombineCardMO)
	local afterCombine = beCombineCardMO and beCombineCardMO:clone() or cardMO1:clone()

	afterCombine.skillId = FightCardModel.getCombineSkillId(cardMO1, cardMO2, beCombineCardMO)
	afterCombine.tempCard = false

	FightCardDataHelper.enchantsAfterCombine(afterCombine, cardMO2)

	if not afterCombine.uid or tonumber(afterCombine.uid) == 0 then
		afterCombine.uid = cardMO2.uid
		afterCombine.cardType = cardMO2.cardType
	end

	if afterCombine.heroId ~= cardMO2.heroId then
		afterCombine.heroId = cardMO2.heroId
	end

	afterCombine.energy = cardMO1.energy + cardMO2.energy

	if afterCombine.uid and afterCombine.uid ~= "0" then
		afterCombine.heatId = afterCombine.heatId or cardMO2.heatId
	end

	return afterCombine
end

function FightCardModel.getCombineSkillId(cardMO1, cardMO2, beCombineCardMO)
	local entityId = cardMO1.uid
	local skillId = cardMO1.skillId

	if beCombineCardMO then
		if cardMO1 == beCombineCardMO then
			skillId = cardMO1.skillId
			entityId = beCombineCardMO.uid
		elseif cardMO2 == beCombineCardMO then
			skillId = cardMO2.skillId
			entityId = beCombineCardMO.uid
		end
	end

	local nextSkillId = FightCardModel.instance:getSkillNextLvId(entityId, skillId)

	if (FightCardDataHelper.isSkill3(cardMO1) or FightCardDataHelper.isSkill3(cardMO2)) and false and not FightEnum.UniversalCard[cardMO1.skillId] and not FightEnum.UniversalCard[cardMO2.skillId] then
		local featureType = FightEnum.BuffFeature.ChangeComposeCardSkill
		local entityList = {}

		tabletool.addValues(entityList, FightDataHelper.entityMgr:getMyPlayerList())
		tabletool.addValues(entityList, FightDataHelper.entityMgr:getMyNormalList())
		tabletool.addValues(entityList, FightDataHelper.entityMgr:getMySpList())

		local offset = 0

		for i, entityMO in ipairs(entityList) do
			local buffDic = entityMO.buffDic

			for buffUid, buff in pairs(buffDic) do
				local param = FightConfig.instance:hasBuffFeature(buff.buffId, featureType)

				if param then
					local arr = string.splitToNumber(param.featureStr, "#")

					if arr[2] then
						offset = offset + arr[2]
					end
				end
			end
		end

		if offset == 0 then
			return nextSkillId
		elseif offset > 0 then
			for i = 1, offset do
				local tryGetSkill = FightCardModel.instance:getSkillNextLvId(entityId, nextSkillId)

				nextSkillId = tryGetSkill or nextSkillId
			end
		else
			for i = 1, math.abs(offset) do
				local tryGetSkill = FightCardModel.instance:getSkillPrevLvId(entityId, nextSkillId)

				nextSkillId = tryGetSkill or nextSkillId
			end
		end
	end

	return nextSkillId
end

function FightCardModel.moveOnly(cards, from, to)
	if to < from then
		local temp = cards[from]

		for i = from, to + 1, -1 do
			cards[i] = cards[i - 1]
		end

		cards[to] = temp
	elseif from < to then
		local temp = cards[from]

		for i = from, to - 1 do
			cards[i] = cards[i + 1]
		end

		cards[to] = temp
	end
end

function FightCardModel.getCombineIndexOnce(cards, universalCardMO, beCombineCardMO)
	if not cards then
		return
	end

	for i = 1, #cards - 1 do
		if universalCardMO and beCombineCardMO then
			if universalCardMO == cards[i] and beCombineCardMO == cards[i + 1] then
				return i
			elseif beCombineCardMO == cards[i] and universalCardMO == cards[i + 1] then
				return i
			end
		elseif FightCardDataHelper.canCombineCardForPerformance(cards[i], cards[i + 1]) then
			return i
		end
	end
end

function FightCardModel:revertOp()
	if #self._cardOps > 0 then
		return table.remove(self._cardOps, #self._cardOps)
	end
end

function FightCardModel:moveHandCardOp(from, to, skillId, belongToEntityId)
	if from ~= to then
		local op = FightBeginRoundOp.New()

		op:moveCard(from, to, skillId, belongToEntityId)
		table.insert(self._cardOps, op)

		return op
	end
end

function FightCardModel:moveUniversalCardOp(from, to, skillId, belongToEntityId, moveToIndex)
	if from ~= to then
		local op = FightBeginRoundOp.New()

		op:moveUniversalCard(from, to, skillId, belongToEntityId, moveToIndex)
		table.insert(self._cardOps, op)

		return op
	end
end

function FightCardModel:playHandCardOp(from, targetEntityId, skillId, belongToEntityId, cardInfoMO, param2)
	local op = FightBeginRoundOp.New()
	local toId = targetEntityId or self.curSelectEntityId

	if toId == 0 then
		local targetUids = FightHelper.getTargetLimits(FightEnum.EntitySide.MySide, skillId)

		if #targetUids > 0 then
			toId = targetUids[1]
		end
	end

	op:playCard(from, toId, skillId, belongToEntityId, cardInfoMO, param2)
	table.insert(self._cardOps, op)

	return op
end

function FightCardModel:playAssistBossHandCardOp(skillId, targetEntityId)
	local op = FightBeginRoundOp.New()
	local toId = targetEntityId or self.curSelectEntityId

	if toId == 0 then
		local targetUids = FightHelper.getTargetLimits(FightEnum.EntitySide.MySide, skillId)

		if #targetUids > 0 then
			toId = targetUids[1]
		end
	end

	op:playAssistBossHandCard(skillId, toId)
	table.insert(self._cardOps, op)

	return op
end

function FightCardModel:playPlayerFinisherSkill(skillId, toId)
	local op = FightBeginRoundOp.New()

	op:playPlayerFinisherSkill(skillId, toId)
	table.insert(self._cardOps, op)

	return op
end

function FightCardModel:playBloodPoolCardOp(skillId, toId)
	local op = FightBeginRoundOp.New()

	toId = toId or self.curSelectEntityId

	op:playBloodPoolCard(skillId, toId)
	table.insert(self._cardOps, op)

	return op
end

function FightCardModel:simulateDissolveCard(index)
	local op = FightBeginRoundOp.New()

	op:simulateDissolveCard(index)
	table.insert(self._cardOps, op)

	return op
end

local CardCountScale = {
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	0.9,
	0.8,
	0.73,
	0.67,
	0.62,
	0.57,
	0.53,
	0.5,
	0.47,
	0.44,
	0.42,
	0.4
}

function FightCardModel:getHandCardContainerScale(clothSkillExpand, cards)
	local handCards = cards or self:getHandCards()
	local count = #handCards

	if not CardCountScale[count] then
		local scale = 1

		if count > 20 then
			scale = 0.4
		end

		if clothSkillExpand and count >= 8 then
			scale = CardCountScale[count] * 0.9
		end

		return CardCountScale[count]
	end
end

function FightCardModel:getSkillLv(entityId, skillId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if entityMO then
		return entityMO:getSkillLv(skillId)
	end

	return FightConfig.instance:getSkillLv(skillId)
end

function FightCardModel:getSkillNextLvId(entityId, skillId)
	local skillNextConfig = lua_skill_next.configDict[skillId]

	if skillNextConfig and skillNextConfig.nextId ~= 0 then
		return skillNextConfig.nextId
	end

	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if entityMO then
		return entityMO:getSkillNextLvId(skillId)
	end

	return FightConfig.instance:getSkillNextLvId(skillId)
end

function FightCardModel:getSkillPrevLvId(entityId, skillId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if entityMO then
		return entityMO:getSkillPrevLvId(skillId)
	end

	return FightConfig.instance:getSkillPrevLvId(skillId)
end

function FightCardModel:isActiveSkill(entityId, skillId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if entityMO then
		return entityMO:isActiveSkill(skillId)
	end

	return FightConfig.instance:isActiveSkill(skillId)
end

function FightCardModel:isUnlimitMoveCard()
	return self._cardMO and self._cardMO:isUnlimitMoveCard()
end

FightCardModel.instance = FightCardModel.New()

return FightCardModel
