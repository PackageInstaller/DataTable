-- chunkname: @modules/logic/fight/model/mo/FightBeginRoundOp.lua

module("modules.logic.fight.model.mo.FightBeginRoundOp", package.seeall)

local FightBeginRoundOp = pureTable("FightBeginRoundOp")

function FightBeginRoundOp:ctor()
	self.operType = nil
	self.param1 = nil
	self.param2 = nil
	self.toId = nil
	self.skillId = nil
	self.belongToEntityId = nil
	self.moveToIndex = nil
	self.costActPoint = 1
	self._needCopyCard = nil
	self.cardColor = FightEnum.CardColor.None
end

function FightBeginRoundOp:init(oper)
	self.operType = oper.operType
	self.param1 = oper.param1
	self.param2 = oper.param2
	self.toId = oper.toId
end

function FightBeginRoundOp:moveCard(fromIndex, toIndex, skillId, belongToEntityId)
	self.operType = FightEnum.CardOpType.MoveCard
	self.param1 = fromIndex
	self.param2 = toIndex
	self.skillId = skillId
	self.belongToEntityId = belongToEntityId
	self.moveToIndex = toIndex
end

function FightBeginRoundOp:moveUniversalCard(fromIndex, toIndex, skillId, belongToEntityId, moveToIndex)
	self.operType = FightEnum.CardOpType.MoveUniversal
	self.param1 = fromIndex
	self.param2 = toIndex
	self.skillId = skillId
	self.belongToEntityId = belongToEntityId
	self.moveToIndex = moveToIndex
	self.costActPoint = 0
end

function FightBeginRoundOp:playCard(cardIndex, uid, skillId, belongToEntityId, cardInfoMO, param2)
	self.operType = FightEnum.CardOpType.PlayCard
	self.param1 = cardIndex
	self.param2 = param2
	self.toId = uid
	self.skillId = skillId
	self.belongToEntityId = belongToEntityId
	self.costActPoint = FightCardDataHelper.playActCost(cardInfoMO)

	local entityMO = FightDataHelper.entityMgr:getById(self.belongToEntityId)
	local buffList = FightBuffHelper.simulateBuffList(entityMO)

	self.clientSimulateCanPlayCard = FightViewHandCardItemLock.canUseCardSkill(self.belongToEntityId, self.skillId, buffList)
	self.cardInfoMO = FightCardInfoMO.New()

	self.cardInfoMO:init(cardInfoMO)
end

function FightBeginRoundOp:playAssistBossHandCard(skillId, toId)
	self.operType = FightEnum.CardOpType.AssistBoss
	self.param1 = skillId
	self.toId = toId
	self.skillId = skillId

	local assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	self.belongToEntityId = assistBoss.id
	self.costActPoint = 0
end

function FightBeginRoundOp:playPlayerFinisherSkill(skillId, toId)
	self.operType = FightEnum.CardOpType.PlayerFinisherSkill
	self.param1 = skillId
	self.toId = toId
	self.skillId = skillId
	self.costActPoint = 0
end

function FightBeginRoundOp:playBloodPoolCard(skillId, toId)
	self.operType = FightEnum.CardOpType.BloodPool
	self.param1 = skillId
	self.toId = toId or 0
	self.skillId = skillId
	self.belongToEntityId = FightEntityScene.MySideId
	self.costActPoint = 0
end

function FightBeginRoundOp:simulateDissolveCard(index)
	self.operType = FightEnum.CardOpType.SimulateDissolveCard
	self.dissolveIndex = index
	self.costActPoint = 0
end

function FightBeginRoundOp:selectSkillTarget(uid)
	self.toId = uid
end

function FightBeginRoundOp:isMoveCard()
	return self.operType == FightEnum.CardOpType.MoveCard
end

function FightBeginRoundOp:isMoveUniversal()
	return self.operType == FightEnum.CardOpType.MoveUniversal
end

function FightBeginRoundOp:isPlayCard()
	return self.operType == FightEnum.CardOpType.PlayCard
end

function FightBeginRoundOp:isAssistBossPlayCard()
	return self.operType == FightEnum.CardOpType.AssistBoss
end

function FightBeginRoundOp:isPlayerFinisherSkill()
	return self.operType == FightEnum.CardOpType.PlayerFinisherSkill
end

function FightBeginRoundOp:isBloodPoolSkill()
	return self.operType == FightEnum.CardOpType.BloodPool
end

function FightBeginRoundOp:isSeason2ChangeHero()
	return self.operType == FightEnum.CardOpType.Season2ChangeHero
end

function FightBeginRoundOp:isSimulateDissolveCard()
	return self.operType == FightEnum.CardOpType.SimulateDissolveCard
end

function FightBeginRoundOp:copyCard()
	self._needCopyCard = 1
end

function FightBeginRoundOp:needCopyCard()
	return self._needCopyCard == 1
end

return FightBeginRoundOp
