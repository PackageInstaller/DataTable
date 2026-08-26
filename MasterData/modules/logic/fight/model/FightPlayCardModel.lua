-- chunkname: @modules/logic/fight/model/FightPlayCardModel.lua

module("modules.logic.fight.model.FightPlayCardModel", package.seeall)

local FightPlayCardModel = class("FightPlayCardModel", BaseModel)

function FightPlayCardModel:onInit()
	self._clientSkillOpAll = {}
	self._clientSkillOpList = {}
	self._serverSkillOpList = {}
	self._usedCards = {}
	self._curIndex = 0
end

function FightPlayCardModel:getCurIndex()
	return self._curIndex
end

function FightPlayCardModel:playCard(cardIndex)
	self._curIndex = cardIndex
end

function FightPlayCardModel:getRemainCardCount()
	if self._usedCards then
		if not #self._usedCards then
			local cardCount = 0
			local remainCount = cardCount - self._curIndex

			return math.max(remainCount, 0)
		end
	end
end

function FightPlayCardModel:clearUsedCards()
	self._usedCards = {}
	self._curIndex = 0
end

function FightPlayCardModel:setUsedCard(cardInfos)
	self:clearUsedCards()

	for _, cardInfo in ipairs(cardInfos) do
		local fightCardInfoMO = FightCardInfoData.New(cardInfo)

		table.insert(self._usedCards, fightCardInfoMO)
	end
end

function FightPlayCardModel:addUseCard(index, cardInfo, skillId)
	if self._usedCards then
		local fightCardInfoMO = FightCardInfoData.New(cardInfo)

		fightCardInfoMO.clientData.custom_fromSkillId = skillId or 0

		table.insert(self._usedCards, index, fightCardInfoMO)
	end
end

function FightPlayCardModel:getUsedCards()
	return self._usedCards
end

function FightPlayCardModel:getDeviceIndex()
	local deviceCardType = FightEnum.CardType.DEVICE

	for i = #self._usedCards, 1, -1 do
		local cardInfo = self._usedCards[i]

		if cardInfo.cardType == deviceCardType then
			return i
		end
	end
end

function FightPlayCardModel:updateClientOps()
	self._clientSkillOpAll = {}
	self._clientSkillOpList = {}

	local ops = FightDataHelper.operationDataMgr:getOpList()

	for _, op in ipairs(ops) do
		if op:isPlayCard() then
			self:buildDisplayMOByOp(op)

			if op:needCopyCard() then
				self:buildDisplayMOByOp(op).isCopyCard = true
			end
		end
	end
end

function FightPlayCardModel:buildDisplayMOByOp(fightBeginRoundOp)
	local displayMO = FightSkillDisplayMO.New()

	displayMO.entityId = fightBeginRoundOp.belongToEntityId
	displayMO.skillId = fightBeginRoundOp.skillId
	displayMO.targetId = fightBeginRoundOp.toId

	table.insert(self._clientSkillOpAll, 1, displayMO)
	table.insert(self._clientSkillOpList, 1, displayMO)

	return displayMO
end

function FightPlayCardModel:updateFightRound(roundData)
	self._serverSkillOpList = {}

	for _, fightStepData in ipairs(roundData.fightStep) do
		local entityMO = FightDataHelper.entityMgr:getById(fightStepData.fromId)
		local isMySide = entityMO and entityMO.side == FightEnum.EntitySide.MySide
		local isSkill = fightStepData.actType == FightEnum.ActType.SKILL
		local isActiveSkill = isSkill and FightCardDataHelper.isActiveSkill(fightStepData.fromId, fightStepData.actId) or false

		if isMySide and isSkill and isActiveSkill then
			local displayMO = FightSkillDisplayMO.New()

			displayMO.entityId = fightStepData.fromId
			displayMO.skillId = fightStepData.actId
			displayMO.targetId = fightStepData.toId

			table.insert(self._serverSkillOpList, 1, displayMO)
		end
	end
end

function FightPlayCardModel:onEndRound()
	self._clientSkillOpAll = {}
	self._clientSkillOpList = {}
	self._serverSkillOpList = {}
end

function FightPlayCardModel:checkClientSkillMatch(entityId, serverSkillId)
	local clientFirst = self._clientSkillOpList[#self._clientSkillOpList]

	if clientFirst and clientFirst.entityId == entityId and clientFirst.skillId == serverSkillId then
		return true
	end

	return false
end

function FightPlayCardModel:removeClientSkillOnce()
	return table.remove(self._clientSkillOpList, #self._clientSkillOpList)
end

function FightPlayCardModel:onPlayOneSkillId(entityId, skillId)
	if self:checkClientSkillMatch(entityId, skillId) then
		table.remove(self._clientSkillOpList, #self._clientSkillOpList)
	else
		local clientFirst = self._clientSkillOpList[#self._clientSkillOpList]

		logError("Play skill card not match: " .. skillId .. " " .. ((clientFirst or nil) and (clientFirst.skillId or "nil")))
	end

	table.remove(self._serverSkillOpList, #self._serverSkillOpList)
end

function FightPlayCardModel:getClientSkillOpAll()
	return self._clientSkillOpAll
end

function FightPlayCardModel:getClientLeftSkillOpList()
	return self._clientSkillOpList
end

function FightPlayCardModel:clearClientLeftSkillOpList()
	self._clientSkillOpList = {}
end

function FightPlayCardModel:getServerLeftSkillOpList()
	return self._serverSkillOpList
end

function FightPlayCardModel:isPlayerHasSkillToPlay(entityId)
	local version = FightModel.instance:getVersion()

	if version >= 1 then
		for i = self._curIndex + 1, #self._usedCards do
			local cardInfo = self._usedCards[i]

			if cardInfo.uid == entityId then
				return true
			end
		end

		return
	end

	for _, op in ipairs(self._serverSkillOpList) do
		if op.entityId == entityId then
			return true
		end
	end
end

FightPlayCardModel.instance = FightPlayCardModel.New()

return FightPlayCardModel
