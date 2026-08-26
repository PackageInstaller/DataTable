-- chunkname: @modules/logic/fight/model/data/FightOperationItemData.lua

module("modules.logic.fight.model.data.FightOperationItemData", package.seeall)

local FightOperationItemData = FightDataClass("FightOperationItemData")

function FightOperationItemData:onConstructor()
	self.costActPoint = 0
	self.cardColor = FightEnum.CardColor.None
	self.isUnlimitMoveOrExtraMove = nil
end

function FightOperationItemData:setByProto(proto)
	self.operType = proto.operType
	self.toId = proto.toId
	self.param1 = proto.param1
	self.param2 = proto.param2
	self.param3 = proto.param3
	self.cardParam1 = proto.cardParam1
end

function FightOperationItemData:moveCard(fromIndex, toIndex, cardData)
	self.operType = FightEnum.CardOpType.MoveCard
	self.param1 = fromIndex
	self.param2 = toIndex
	self.cardData = FightDataUtil.copyData(cardData)
	self.costActPoint = FightCardDataHelper.moveActCost(cardData)
	self.skillId = cardData.skillId
	self.belongToEntityId = cardData.uid
	self.moveToIndex = toIndex
end

function FightOperationItemData:moveUniversalCard(fromIndex, toIndex, cardData)
	self.operType = FightEnum.CardOpType.MoveUniversal
	self.param1 = fromIndex
	self.param2 = toIndex
	self.cardData = FightDataUtil.copyData(cardData)
	self.costActPoint = FightCardDataHelper.moveActCost(cardData)
	self.skillId = cardData.skillId
	self.belongToEntityId = cardData.uid
	self.moveToIndex = toIndex
end

function FightOperationItemData:playCard(cardIndex, aimUid, cardData, param2, param3, cardParam1)
	self.operType = FightEnum.CardOpType.PlayCard
	self.toId = self:getTarget(aimUid, cardData.skillId)
	self.param1 = cardIndex
	self.param2 = param2
	self.param3 = param3
	self.cardParam1 = cardParam1

	local uid = cardData.uid
	local skillId = cardData.skillId

	self.cardData = FightDataUtil.copyData(cardData)
	self.costActPoint = FightCardDataHelper.playActCost(cardData)

	local entityMO = FightDataHelper.entityMgr:getById(uid)
	local buffList = FightBuffHelper.simulateBuffList(entityMO)

	self.clientSimulateCanPlayCard = FightViewHandCardItemLock.canUseCardSkill(uid, skillId, buffList)
	self.skillId = skillId
	self.belongToEntityId = uid
	self.cardInfoMO = self.cardData
end

function FightOperationItemData:setCardParam1(skillId, entityUid)
	self.cardParam1 = string.format("%s#%s", skillId, entityUid)
	self.cardParam1_skillId = skillId
	self.cardParam1_entityUid = entityUid
end

function FightOperationItemData:playAssistBossHandCard(skillId, toId)
	self.operType = FightEnum.CardOpType.AssistBoss
	self.param1 = skillId
	self.toId = self:getTarget(toId, skillId)
	self.skillId = skillId

	local assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	self.belongToEntityId = assistBoss.id
	self.costActPoint = 0

	local cardProto = FightDef_pb.CardInfo()

	cardProto.skillId = skillId
	cardProto.uid = self.belongToEntityId
	self.cardInfoMO = FightCardInfoData.New(cardProto)
end

function FightOperationItemData:playPlayerFinisherSkill(skillId, toId)
	self.operType = FightEnum.CardOpType.PlayerFinisherSkill
	self.param1 = skillId
	self.toId = toId
	self.skillId = skillId
	self.costActPoint = 0
	self.belongToEntityId = FightEntityScene.MySideId

	local cardProto = FightDef_pb.CardInfo()

	cardProto.skillId = skillId
	cardProto.uid = self.belongToEntityId
	self.cardInfoMO = FightCardInfoData.New(cardProto)
end

function FightOperationItemData:playBloodPoolCard(skillId, toId)
	self.operType = FightEnum.CardOpType.BloodPool
	self.param1 = skillId
	self.toId = self:getTarget(toId, skillId)
	self.skillId = skillId
	self.belongToEntityId = FightEntityScene.MySideId
	self.costActPoint = 0

	local cardProto = FightDef_pb.CardInfo()

	cardProto.skillId = skillId
	cardProto.uid = self.belongToEntityId
	self.cardInfoMO = FightCardInfoData.New(cardProto)
end

function FightOperationItemData:playRouge2MusicSkill(skillId, belongToEntityId)
	self.operType = FightEnum.CardOpType.Rouge2Music
	self.skillId = skillId
	self.costActPoint = 0
	self.belongToEntityId = belongToEntityId

	local cardProto = FightDef_pb.CardInfo()

	cardProto.skillId = skillId
	cardProto.uid = belongToEntityId
	self.cardInfoMO = FightCardInfoData.New(cardProto)
end

function FightOperationItemData:simulateDissolveCard(index)
	self.operType = FightEnum.CardOpType.SimulateDissolveCard
	self.dissolveIndex = index
	self.costActPoint = 0
end

function FightOperationItemData:selectSkillTarget(uid)
	self.toId = uid
end

function FightOperationItemData:isMoveCard()
	return self.operType == FightEnum.CardOpType.MoveCard
end

function FightOperationItemData:isMoveUniversal()
	return self.operType == FightEnum.CardOpType.MoveUniversal
end

function FightOperationItemData:isPlayCard()
	return self.operType == FightEnum.CardOpType.PlayCard
end

function FightOperationItemData:isAssistBossPlayCard()
	return self.operType == FightEnum.CardOpType.AssistBoss
end

function FightOperationItemData:isPlayerFinisherSkill()
	return self.operType == FightEnum.CardOpType.PlayerFinisherSkill
end

function FightOperationItemData:isBloodPoolSkill()
	return self.operType == FightEnum.CardOpType.BloodPool
end

function FightOperationItemData:isSeason2ChangeHero()
	return self.operType == FightEnum.CardOpType.Season2ChangeHero
end

function FightOperationItemData:isSimulateDissolveCard()
	return self.operType == FightEnum.CardOpType.SimulateDissolveCard
end

function FightOperationItemData:isRouge2MusicSkill()
	return self.operType == FightEnum.CardOpType.Rouge2Music
end

function FightOperationItemData:copyCard()
	self._needCopyCard = 1
end

function FightOperationItemData:needCopyCard()
	return self._needCopyCard == 1
end

function FightOperationItemData:getTarget(targetEntityId, skillId)
	local toId = targetEntityId or FightDataHelper.operationDataMgr.curSelectEntityId

	if toId == 0 then
		local targetUids = FightHelper.getTargetLimits(FightEnum.EntitySide.MySide, skillId)

		if #targetUids > 0 then
			toId = targetUids[1]
		end
	end

	return toId
end

return FightOperationItemData
