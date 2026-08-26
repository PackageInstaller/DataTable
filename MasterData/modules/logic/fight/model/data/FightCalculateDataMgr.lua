-- chunkname: @modules/logic/fight/model/data/FightCalculateDataMgr.lua

module("modules.logic.fight.model.data.FightCalculateDataMgr", package.seeall)

local FightCalculateDataMgr = FightDataClass("FightCalculateDataMgr", FightDataMgrBase)

function FightCalculateDataMgr:onConstructor()
	self.buffDict = {}
	self._type2FuncName = {}
end

function FightCalculateDataMgr:getBuffMo(buffUid)
	return self.buffDict[buffUid]
end

function FightCalculateDataMgr:updateFightData(fightData)
	if not fightData then
		return
	end

	for i, mgr in ipairs(self.dataMgr.mgrList) do
		mgr:updateData(fightData)
	end
end

function FightCalculateDataMgr:beforePlayRoundData(roundData)
	if not roundData then
		return
	end

	self.dataMgr.handCardMgr:cacheDistributeCard(roundData)
end

function FightCalculateDataMgr:afterPlayRoundData(roundData)
	if not roundData then
		return
	end

	if roundData.actPoint then
		self.dataMgr.operationDataMgr.actPoint = roundData.actPoint
	end

	if roundData.moveNum then
		self.dataMgr.operationDataMgr.moveNum = roundData.moveNum
	end
end

function FightCalculateDataMgr:processHurtInfo(actEffectData)
	if not actEffectData then
		return
	end

	local hurtInfo = actEffectData.hurtInfo

	if not hurtInfo then
		return
	end

	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO.toughnessValue = entityMO.toughnessValue - hurtInfo.toughnessValue
	entityMO.toughnessPoint = entityMO.toughnessPoint - hurtInfo.toughnessPoint

	if hurtInfo.broken then
		entityMO.isBroken = hurtInfo.broken

		self:com_sendMsg(FightMsgId.ToughnessBreakEffect)
	end

	entityMO:setHp(entityMO.currentHp + hurtInfo.reduceHp)

	hurtInfo.reduceShield = 0
	hurtInfo.reduceTeamShareShield = 0

	local absorbHurtParam = hurtInfo.absorbHurtParam

	if not string.nilorempty(absorbHurtParam) then
		hurtInfo.analysed = true
		absorbHurtParam = cjson.decode(absorbHurtParam)

		local reduceShieldBuffMap = absorbHurtParam.reduceShieldBuffMap

		if not string.nilorempty(reduceShieldBuffMap) then
			local arr = string.split(reduceShieldBuffMap, "|")

			for i = 1, #arr do
				local tab = string.split(arr[i], "#")
				local offset = tonumber((not tab[2] or nil) and 0)

				hurtInfo.reduceShield = hurtInfo.reduceShield + offset
				entityMO.shieldValue = entityMO.shieldValue - offset
			end
		end

		local reduceTeamShareShieldBuffMap = absorbHurtParam.reduceTeamShareShieldBuffMap

		if not string.nilorempty(reduceTeamShareShieldBuffMap) then
			local arr = string.split(reduceTeamShareShieldBuffMap, "|")

			for i = 1, #arr do
				local tab = string.split(arr[i], "#")
				local buff = self:getBuffMo(tab[1])

				if buff then
					local actInfo = buff.actInfo

					for _, data in ipairs(actInfo) do
						if data.actId == 1125 then
							local value = data.param[1]

							if value then
								local offset = tonumber((not tab[2] or nil) and 0)

								data.param[1] = value - offset
								hurtInfo.reduceTeamShareShield = hurtInfo.reduceTeamShareShield + offset
							end
						end
					end
				end
			end
		end
	end

	if hurtInfo.immunityFromType == FightHurtInfoData.ImmunityFromType.Narcissus and hurtInfo.damage == 0 then
		self:com_sendMsg(FightMsgId.NarcissusImmunityEffect, entityMO.uid)
	end
end

function FightCalculateDataMgr:playEffect2(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect3(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect4(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(entityMO.currentHp + actEffectData.effectNum)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect5(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local buff = actEffectData.buff

	if not buff then
		return
	end

	entityMO:addBuff(buff)

	self.buffDict[buff.uid] = entityMO.buffDic[buff.uid]
end

function FightCalculateDataMgr:playEffect6(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local buff = actEffectData.buff

	if not buff then
		return
	end

	local buffUid = buff.uid

	self.buffDict[buffUid] = nil

	entityMO:delBuff(buffUid)
end

function FightCalculateDataMgr:playEffect7(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local buff = actEffectData.buff

	if not buff then
		return
	end

	entityMO:updateBuff(buff)
end

function FightCalculateDataMgr:playEffect8(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect9(actEffectData)
	self.dataMgr.entityMgr:addDeadUid(actEffectData.targetId)

	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setDead()
end

function FightCalculateDataMgr:playEffect12(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(entityMO.currentHp + actEffectData.effectNum)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect13(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect14(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect15(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect16(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect17(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect18(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(entityMO.currentHp - actEffectData.effectNum)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect19(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect20(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect21(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect22(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect23(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect24(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect25(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setShield(actEffectData.effectNum)
end

function FightCalculateDataMgr:playEffect26(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect27(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect28(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect29(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect30(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect31(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect32(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect33(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect34(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect35(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect36(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect37(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect38(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(entityMO.currentHp - actEffectData.effectNum)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect39(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect40(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(actEffectData.effectNum)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect41(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(entityMO.currentHp + actEffectData.effectNum)
	entityMO:setShield(0)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect42(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect43(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect44(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect45(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect46(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect47(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect48(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect49(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect50(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect51(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect52(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect53(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect54(actEffectData)
	local handCard = self:getHandCard()
	local dealCard = self.dataMgr.handCardMgr:getRedealCard()

	FightDataUtil.coverData(dealCard, handCard)
	FightCardDataHelper.combineCardList(handCard, self.dataMgr.entityMgr)
end

function FightCalculateDataMgr:playEffect55(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect56(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local buff = actEffectData.buff

	if not buff then
		return
	end

	entityMO:delBuff(buff.uid)
end

function FightCalculateDataMgr:playEffect57(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(entityMO.currentHp + actEffectData.effectNum)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect58(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local cardProto = FightDef_pb.CardInfo()

	cardProto.uid = "0"
	cardProto.skillId = actEffectData.effectNum

	local cardData = FightCardInfoData.New(cardProto)
	local handCard = self:getHandCard()

	table.insert(handCard, cardData)
end

function FightCalculateDataMgr:playEffect59(actEffectData)
	self.dataMgr.handCardMgr:distribute(self.dataMgr.handCardMgr.beforeCards1, self.dataMgr.handCardMgr.teamACards1)
end

function FightCalculateDataMgr:playEffect60(actEffectData)
	self.dataMgr.handCardMgr:distribute(self.dataMgr.handCardMgr.beforeCards2, self.dataMgr.handCardMgr.teamACards2)
end

function FightCalculateDataMgr:playEffect61(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect62(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setShield(0)
end

function FightCalculateDataMgr:playEffect63(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect64(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect65(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect66(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect67(actEffectData)
	if not actEffectData.entity then
		return
	end

	local entityData = FightEntityMO.New()

	entityData:init(actEffectData.entity)
	FightHelper.setEffectEntitySide(actEffectData, entityData)
	self.dataMgr.entityMgr:replaceEntityMO(entityData)
end

function FightCalculateDataMgr:playEffect68(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect69(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect70(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect71(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect72(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect73(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect74(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect75(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	if actEffectData.entity then
		local entityId = actEffectData.entity.id

		if not entityId then
			return
		end

		local entityMO = self.dataMgr:getEntityById(entityId)

		if not entityMO then
			return
		end

		local version = FightModel.instance:getVersion()

		if version < 1 and entityMO.side ~= FightEnum.EntitySide.MySide then
			return
		end

		local handCard = self:getHandCard()
		local cardIndex = tonumber(actEffectData.targetId)
		local targetSkillId = actEffectData.effectNum

		if not handCard[cardIndex] then
			return
		end

		handCard[cardIndex].uid = entityId
		handCard[cardIndex].skillId = targetSkillId

		if version < 4 then
			FightCardDataHelper.combineCardList(handCard, self.dataMgr.entityMgr)
		end
	end
end

function FightCalculateDataMgr:playEffect76(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect77(actEffectData)
	self.dataMgr.operationDataMgr.extraMoveAct = actEffectData.effectNum
end

function FightCalculateDataMgr:playEffect78(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local cardProto = FightDef_pb.CardInfo()

	cardProto.uid = "0"
	cardProto.skillId = actEffectData.effectNum

	local cardData = FightCardInfoData.New(cardProto)
	local handCard = self:getHandCard()

	table.insert(handCard, cardData)
end

function FightCalculateDataMgr:playEffect79(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect80(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect81(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect82(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect83(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect84(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect85(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local indexs = string.splitToNumber(actEffectData.reserveStr, "#")
	local handCard = self:getHandCard()

	for i, v in ipairs(indexs) do
		local data = FightCardInfoData.New(actEffectData.cardInfoList[i])

		if handCard[v] then
			FightDataUtil.coverData(data, handCard[v])
		end
	end
end

function FightCalculateDataMgr:playEffect86(actEffectData)
	if not actEffectData.entity then
		return
	end

	local version = FightModel.instance:getVersion()
	local entityData = FightEntityMO.New()

	entityData:init(actEffectData.entity)

	if version >= 1 then
		local entityMO = self.dataMgr.entityMgr:addEntityMO(entityData)
		local list = self.dataMgr.entityMgr:getOriginNormalList(entityMO.side)

		table.insert(list, entityMO)
	else
		FightHelper.setEffectEntitySide(actEffectData, entityData)
		self.dataMgr.entityMgr:addEntityMO(entityData)
	end
end

function FightCalculateDataMgr:playEffect87(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect88(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect89(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect90(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect91(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	if entityMO:hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		return
	end

	if entityMO.exPointType ~= FightEnum.ExPointType.Common then
		return
	end

	entityMO:changeExpointMaxAdd(actEffectData.effectNum)
end

function FightCalculateDataMgr:playEffect92(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect93(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect94(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect95(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect96(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local handCard = self:getHandCard()

	for i = #handCard, 1, -1 do
		local cardData = handCard[i]

		if FightEnum.UniversalCard[cardData.skillId] then
			table.remove(handCard, i)
		end
	end

	local version = FightModel.instance:getVersion()

	if version < 4 then
		FightCardDataHelper.combineCardList(handCard, self.dataMgr.entityMgr)
	end
end

function FightCalculateDataMgr:playEffect97(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO.career = actEffectData.effectNum
end

function FightCalculateDataMgr:playEffect98(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect99(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect100(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect101(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect102(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect103(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect104(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect105(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect106(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect107(actEffectData)
	if not actEffectData.entity then
		return
	end

	local version = FightModel.instance:getVersion()

	if version >= 1 then
		local changeEntityMO = self.dataMgr:getEntityById(actEffectData.entity.id)
		local side = changeEntityMO.side
		local subList = self.dataMgr.entityMgr:getOriginSubList(side)
		local exitEntityMO = self:getTarEntityMO(actEffectData)

		if exitEntityMO and exitEntityMO.id ~= FightEntityScene.MySideId and exitEntityMO.id ~= FightEntityScene.EnemySideId then
			exitEntityMO.position = changeEntityMO.position or -1

			local sideList = self.dataMgr.entityMgr:getOriginListById(exitEntityMO.uid)

			for i, v in ipairs(sideList) do
				if v.uid == exitEntityMO.uid then
					table.remove(sideList, i)

					break
				end
			end

			table.insert(subList, exitEntityMO)
		end

		for i, v in ipairs(subList) do
			if v.uid == changeEntityMO.uid then
				table.remove(subList, i)

				break
			end
		end

		local entityData = FightEntityMO.New()

		entityData:init(actEffectData.entity)
		self.dataMgr.entityMgr:replaceEntityMO(entityData)

		local normalList = self.dataMgr.entityMgr:getOriginNormalList(side)

		table.insert(normalList, self.dataMgr.entityMgr:getById(changeEntityMO.uid))
	else
		local entityData = FightEntityMO.New()

		entityData:init(actEffectData.entity)
		FightHelper.setEffectEntitySide(actEffectData, entityData)
		self.dataMgr.entityMgr:replaceEntityMO(actEffectData.entity)
	end

	if actEffectData.entity.teamType == FightEnum.TeamType.MySide then
		self:playEffect372(actEffectData)
	end
end

function FightCalculateDataMgr:playEffect108(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO.attrMO.hp = actEffectData.effectNum
end

function FightCalculateDataMgr:playEffect109(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(actEffectData.effectNum)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect110(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(0)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect111(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local old_num = entityMO:getExPoint()
	local offset = actEffectData.effectNum
	local new_num = old_num + (offset or 0)

	entityMO:setExPoint(new_num)
end

function FightCalculateDataMgr:playEffect112(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect113(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	if entityMO.exPointType ~= FightEnum.ExPointType.Common then
		return
	end

	entityMO:changeServerUniqueCost(actEffectData.effectNum)
end

function FightCalculateDataMgr:playEffect114(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect115(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect116(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect117(actEffectData)
	local indicatorId = tonumber(actEffectData.targetId)
	local indicatorDict = self.dataMgr.fieldMgr.indicatorDict

	if actEffectData.configEffect == FightWorkIndicatorChange.ConfigEffect.AddIndicator then
		local indicatorInfo = indicatorDict[indicatorId]

		if not indicatorInfo then
			indicatorInfo = {
				num = 0,
				id = indicatorId
			}
			indicatorDict[indicatorId] = indicatorInfo
		end

		indicatorInfo.num = (indicatorId == FightEnum.IndicatorId.V1a4_BossRush_ig_ScoreTips or indicatorId == FightEnum.IndicatorId.ZongMaoTechniqueScore or indicatorId == FightEnum.IndicatorId.Rouge2Boss) and indicatorInfo.num + actEffectData.effectNum or actEffectData.effectNum
	elseif actEffectData.configEffect == FightWorkIndicatorChange.ConfigEffect.ClearIndicator then
		indicatorDict[indicatorId] = nil
	end
end

function FightCalculateDataMgr:playEffect118(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect119(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect120(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect121(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect122(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect123(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect124(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect125(actEffectData)
	if not actEffectData.entity then
		return
	end

	local version = FightModel.instance:getVersion()
	local entityData = FightEntityMO.New()

	entityData:init(actEffectData.entity)

	if version >= 1 then
		self.dataMgr.entityMgr:replaceEntityMO(entityData)
	else
		FightHelper.setEffectEntitySide(actEffectData)
		self.dataMgr.entityMgr:replaceEntityMO(entityData)
	end
end

function FightCalculateDataMgr:playEffect126(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect127(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local powerId = actEffectData.configEffect
	local powerData = entityMO:getPowerInfo(powerId)

	if powerData then
		entityMO:changePowerMax(powerId, actEffectData.effectNum)
	end
end

function FightCalculateDataMgr:playEffect128(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local powerId = actEffectData.configEffect
	local powerData = entityMO:getPowerInfo(powerId)

	if powerData then
		local old_num = powerData.num

		powerData.num = old_num + actEffectData.effectNum
	end
end

function FightCalculateDataMgr:playEffect129(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect130(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect131(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect132(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect133(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local removeIndexes = string.splitToNumber(actEffectData.reserveStr, "#")

	if #removeIndexes > 0 then
		local handCard = self:getHandCard()
		local signIndex = {}

		for i, v in ipairs(removeIndexes) do
			local cardData = handCard[v]

			if cardData then
				signIndex[v] = true
			end
		end

		for i = #handCard, 1, -1 do
			local cardData = handCard[i]

			if cardData and signIndex[i] then
				table.remove(handCard, i)
			end
		end

		local version = FightModel.instance:getVersion()

		if version < 4 then
			FightCardDataHelper.combineCardList(handCard, self.dataMgr.entityMgr)
		end
	end
end

function FightCalculateDataMgr:playEffect134(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	if not actEffectData.summoned then
		return
	end

	local summonedInfo = entityMO:getSummonedInfo()

	summonedInfo:addData(actEffectData.summoned)
end

function FightCalculateDataMgr:playEffect135(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local summonedInfo = entityMO:getSummonedInfo()
	local uid = actEffectData.reserveId
	local data = summonedInfo:getData(uid)

	if data then
		summonedInfo:removeData(uid)
	end
end

function FightCalculateDataMgr:playEffect136(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local summonedInfo = entityMO:getSummonedInfo()
	local uid = actEffectData.reserveId
	local data = summonedInfo:getData(uid)

	if data then
		data.level = data.level + actEffectData.effectNum
	end
end

function FightCalculateDataMgr:playEffect137(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect138(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect139(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect140(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect141(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local indexes = string.splitToNumber(actEffectData.reserveStr, "#")

	if #indexes > 0 then
		local handCard = self:getHandCard()

		for i, v in ipairs(indexes) do
			if handCard[v] then
				handCard[v].tempCard = true
			end
		end
	end
end

function FightCalculateDataMgr:playEffect142(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect143(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect144(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect145(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect146(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect147(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect148(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect149(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local cardData = FightCardInfoData.New(actEffectData.cardInfo)
	local handCard = self:getHandCard()

	table.insert(handCard, cardData)

	local version = FightModel.instance:getVersion()

	if version < 4 then
		FightCardDataHelper.combineCardList(handCard, self.dataMgr.entityMgr)
	end
end

function FightCalculateDataMgr:playEffect150(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect151(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect152(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local handCard = self:getHandCard()

	for i = #handCard, 1, -1 do
		local cardData = handCard[i]

		if cardData.uid == actEffectData.targetId then
			table.remove(handCard, i)
		end
	end

	local version = FightModel.instance:getVersion()

	if version < 4 then
		FightCardDataHelper.combineCardList(handCard, self.dataMgr.entityMgr)
	end
end

function FightCalculateDataMgr:playEffect153(actEffectData)
	local handCard = self:getHandCard()

	FightCardDataHelper.combineCardList(handCard, self.dataMgr.entityMgr)
end

function FightCalculateDataMgr:playEffect154(actEffectData)
	local handCard = self:getHandCard()
	local newCards = FightCardDataHelper.newCardList(actEffectData.cardInfoList)

	FightDataUtil.coverData(newCards, handCard)
end

function FightCalculateDataMgr:playEffect155(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local removeIndexes = string.splitToNumber(actEffectData.reserveStr, "#")

	if #removeIndexes > 0 then
		local handCard = self:getHandCard()
		local signIndex = {}

		for i, v in ipairs(removeIndexes) do
			local cardData = handCard[v]

			if cardData then
				signIndex[v] = true
			end
		end

		for i = #handCard, 1, -1 do
			local cardData = handCard[i]

			if cardData and signIndex[i] then
				table.remove(handCard, i)
			end
		end
	end
end

function FightCalculateDataMgr:playEffect156(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local handCard = self:getHandCard()
	local index = actEffectData.effectNum
	local cardData = handCard[index]

	if cardData then
		FightDataUtil.coverData(FightCardInfoData.New(actEffectData.cardInfo), cardData)
	end
end

function FightCalculateDataMgr:playEffect157(actEffectData)
	local version = FightModel.instance:getVersion()

	if version >= 1 and actEffectData.teamType ~= FightEnum.TeamType.MySide then
		return
	end

	local handCard = self:getHandCard()
	local index = actEffectData.effectNum
	local cardData = handCard[index]

	if cardData then
		table.remove(handCard, index)
	end
end

function FightCalculateDataMgr:playEffect158(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect159(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect160(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect161(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect162(actEffectData)
	if self:isPerformanceData() then
		return
	end

	self:playStepData(actEffectData.fightStep)
end

function FightCalculateDataMgr:playEffect163(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect164(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect165(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect166(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect167(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local buff = actEffectData.buff

	if not buff then
		return
	end

	entityMO:updateBuff(buff)
end

function FightCalculateDataMgr:playEffect168(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect169(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect170(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local handCard = self:getHandCard()
	local index = actEffectData.effectNum
	local cardData = handCard[index]

	if cardData then
		FightDataUtil.coverData(FightCardInfoData.New(actEffectData.cardInfo), cardData)
	end
end

function FightCalculateDataMgr:playEffect171(actEffectData)
	local targetEntityMO = self:getTarEntityMO(actEffectData)

	if not targetEntityMO then
		return
	end

	if not actEffectData.entity then
		return
	end

	local entityData = FightEntityMO.New()

	entityData:init(actEffectData.entity)

	local version = FightModel.instance:getVersion()

	if version >= 1 then
		self.dataMgr.entityMgr:replaceEntityMO(entityData)
	else
		FightHelper.setEffectEntitySide(actEffectData, entityData)
		self.dataMgr.entityMgr:replaceEntityMO(entityData)
	end
end

function FightCalculateDataMgr:playEffect172(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect173(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect174(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO.canUpgradeIds[actEffectData.effectNum] = actEffectData.effectNum
end

function FightCalculateDataMgr:setRougeExData(index, num)
	local exTeamStr = self.dataMgr.fieldMgr.exTeamStr
	local arr = string.splitToNumber(exTeamStr, "#")

	arr[1] = arr[1] or 0
	arr[2] = arr[2] or 0
	arr[3] = arr[3] or 0
	arr[index] = num
	self.dataMgr.fieldMgr.exTeamStr = string.format("%s#%s#%s", arr[1], arr[2], arr[3])
end

function FightCalculateDataMgr:getRougeExData(index)
	local arr = string.splitToNumber(self.dataMgr.fieldMgr.exTeamStr, "#")

	return arr[index] or 0
end

function FightCalculateDataMgr:playEffect188(actEffectData)
	local value = self:getRougeExData(FightEnum.ExIndexForRouge.MagicLimit)

	self:setRougeExData(FightEnum.ExIndexForRouge.MagicLimit, value + actEffectData.effectNum)
end

function FightCalculateDataMgr:playEffect189(actEffectData)
	local value = self:getRougeExData(FightEnum.ExIndexForRouge.Magic)

	self:setRougeExData(FightEnum.ExIndexForRouge.Magic, value + actEffectData.effectNum)
end

function FightCalculateDataMgr:playEffect190(actEffectData)
	local value = self:getRougeExData(FightEnum.ExIndexForRouge.Coin)

	self:setRougeExData(FightEnum.ExIndexForRouge.Coin, value + actEffectData.effectNum)
end

function FightCalculateDataMgr:playEffect191(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local cardProto = FightDef_pb.CardInfo()

	cardProto.uid = "0"
	cardProto.skillId = actEffectData.effectNum

	local cardData = FightCardInfoData.New(cardProto)
	local handCard = self:getHandCard()

	table.insert(handCard, cardData)
end

function FightCalculateDataMgr:playEffect192(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(entityMO.currentHp - actEffectData.effectNum)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect193(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(entityMO.currentHp - actEffectData.effectNum)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect195(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(entityMO.currentHp + actEffectData.effectNum)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect196(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local removeIndexes = string.splitToNumber(actEffectData.reserveStr, "#")

	if #removeIndexes > 0 then
		local handCard = self:getHandCard()
		local signIndex = {}

		for i, v in ipairs(removeIndexes) do
			local cardData = handCard[v]

			if cardData then
				signIndex[v] = true
			end
		end

		for i = #handCard, 1, -1 do
			local cardData = handCard[i]

			if cardData and signIndex[i] then
				table.remove(handCard, i)
			end
		end

		local version = FightModel.instance:getVersion()

		if version < 4 then
			FightCardDataHelper.combineCardList(handCard, self.dataMgr.entityMgr)
		end
	end
end

function FightCalculateDataMgr:playEffect197(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local cardData = FightCardInfoData.New(actEffectData.cardInfo)
	local handCard = self:getHandCard()

	table.insert(handCard, cardData)

	local version = FightModel.instance:getVersion()

	if version < 4 then
		FightCardDataHelper.combineCardList(handCard, self.dataMgr.entityMgr)
	end
end

function FightCalculateDataMgr:playEffect202(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(entityMO.currentHp - actEffectData.effectNum)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect206(actEffectData)
	local arr = FightStrUtil.instance:getSplitCache(actEffectData.reserveStr, "|")

	if #arr > 0 then
		for i, v in ipairs(arr) do
			local arr1 = FightStrUtil.instance:getSplitCache(v, "#")
			local entityId = arr1[1]
			local position = tonumber(arr1[2]) or 1
			local entityMO = self.dataMgr:getEntityById(entityId)

			if entityMO then
				entityMO.position = position
			end
		end
	end
end

function FightCalculateDataMgr:playEffect207(actEffectData)
	local tarEntityId = actEffectData.targetId
	local tarEntityMO = self.dataMgr:getEntityById(tarEntityId)

	if tarEntityMO then
		tarEntityMO.position = actEffectData.effectNum
	end

	local arr = FightStrUtil.instance:getSplitCache(actEffectData.reserveStr, "|")

	if #arr > 0 then
		for i, v in ipairs(arr) do
			local arr1 = FightStrUtil.instance:getSplitCache(v, "#")
			local entityId = arr1[1]
			local position = tonumber(arr1[2]) or 1
			local entityMO = self.dataMgr:getEntityById(entityId)

			if entityMO then
				entityMO.position = position
			end
		end
	end
end

function FightCalculateDataMgr:playEffect208(actEffectData)
	local tarEntityId = actEffectData.targetId
	local tarEntityMO = self.dataMgr:getEntityById(tarEntityId)

	if tarEntityMO then
		tarEntityMO.position = actEffectData.effectNum
	end

	local arr = FightStrUtil.instance:getSplitCache(actEffectData.reserveStr, "|")

	if #arr > 0 then
		for i, v in ipairs(arr) do
			local arr1 = FightStrUtil.instance:getSplitCache(v, "#")
			local entityId = arr1[1]
			local position = tonumber(arr1[2]) or 1
			local entityMO = self.dataMgr:getEntityById(entityId)

			if entityMO then
				entityMO.position = position
			end
		end
	end
end

function FightCalculateDataMgr:playEffect212(actEffectData)
	self.dataMgr.fieldMgr.curRound = (self.dataMgr.fieldMgr.curRound or 1) + 1

	local entityDic = self.dataMgr.entityMgr:getAllEntityMO()

	for k, v in pairs(entityDic) do
		v.subCd = 0
	end
end

function FightCalculateDataMgr:playEffect214(actEffectData)
	local tarEntityId = actEffectData.targetId
	local tarEntityMO = self.dataMgr:getEntityById(tarEntityId)

	if tarEntityMO then
		tarEntityMO:changeStoredExPoint(actEffectData.effectNum)

		if actEffectData.buff then
			tarEntityMO:updateBuff(actEffectData.buff)
		end
	end
end

function FightCalculateDataMgr:playEffect228(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setShield(actEffectData.effectNum)
end

function FightCalculateDataMgr:playEffect233(actEffectData)
	self.dataMgr.handCardMgr:distribute(self.dataMgr.handCardMgr.beforeCards1, self.dataMgr.handCardMgr.teamACards1)
end

function FightCalculateDataMgr:playEffect234(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local buff = actEffectData.buff

	if not buff then
		return
	end

	entityMO:updateBuff(buff)
end

function FightCalculateDataMgr:playEffect235(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO.currentHp = entityMO.currentHp + actEffectData.effectNum
end

function FightCalculateDataMgr:playEffect236(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO.guard = entityMO.guard + actEffectData.effectNum
end

function FightCalculateDataMgr:playEffect238(actEffectData)
	local entityData = FightEntityMO.New()

	entityData:init(actEffectData.entity)
	self.dataMgr.entityMgr:replaceEntityMO(entityData)
end

function FightCalculateDataMgr:playEffect244(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	if not entityMO:hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		return
	end

	if entityMO.exPointType ~= FightEnum.ExPointType.Common then
		return
	end

	local str = string.splitToNumber(actEffectData.reserveStr, "#")
	local exPointMaxAdd = str[1]
	local uniqueCost = str[2]
	local curExpointMaxAdd = entityMO:getExpointMaxAddNum()

	entityMO:changeExpointMaxAdd(exPointMaxAdd - curExpointMaxAdd)

	local oldOffset = entityMO:getExpointCostOffsetNum()

	entityMO:changeServerUniqueCost(uniqueCost - oldOffset)
end

function FightCalculateDataMgr:playEffect247(actEffectData)
	local cardInfoList = actEffectData.cardInfoList
	local len = cardInfoList and #cardInfoList

	self.dataMgr.fieldMgr:changeDeckNum(len)
end

function FightCalculateDataMgr:playEffect248(actEffectData)
	local cardInfoList = actEffectData.cardInfoList
	local len = cardInfoList and #cardInfoList

	self.dataMgr.fieldMgr:changeDeckNum(-len)
end

function FightCalculateDataMgr:playEffect251(actEffectData)
	local progressId = actEffectData.buffActId

	if progressId ~= 0 then
		local data = self.dataMgr.fieldMgr.progressDic[progressId]

		if not data then
			return
		end

		data.value = data.value + actEffectData.effectNum

		return
	end

	self.dataMgr.fieldMgr.progress = self.dataMgr.fieldMgr.progress + actEffectData.effectNum
end

function FightCalculateDataMgr:playEffect252(actEffectData)
	self.dataMgr.paTaMgr:setCurrCD(actEffectData.effectNum)
end

function FightCalculateDataMgr:playEffect253(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(entityMO.currentHp - actEffectData.effectNum)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect256(actEffectData)
	local progressId = actEffectData.buffActId

	if progressId ~= 0 then
		local tab = {}

		tab.id = progressId
		tab.max = actEffectData.effectNum
		tab.value = 0
		tab.showId = actEffectData.effectNum1
		tab.skillId = tonumber(actEffectData.reserveStr)

		local data = self.dataMgr.fieldMgr.progressDic[progressId]

		if not data then
			data = {}
			self.dataMgr.fieldMgr.progressDic[progressId] = data
		end

		FightDataUtil.coverData(tab, data)

		return
	end

	self.dataMgr.fieldMgr.progressMax = self.dataMgr.fieldMgr.progressMax + actEffectData.effectNum
	self.dataMgr.fieldMgr.param[FightParamData.ParamKey.ProgressSkill] = tonumber(actEffectData.reserveStr)
	self.dataMgr.fieldMgr.param[FightParamData.ParamKey.ProgressId] = actEffectData.effectNum1
end

function FightCalculateDataMgr:playEffect258(actEffectData)
	if actEffectData.teamType ~= FightEnum.TeamType.MySide then
		return
	end

	local handCard = self:getHandCard()
	local index = actEffectData.effectNum
	local cardData = handCard[index]

	if cardData then
		table.remove(handCard, index)
	end
end

function FightCalculateDataMgr:playEffect260(actEffectData)
	local entityData = FightEntityMO.New()

	entityData:init(actEffectData.entity)
	self.dataMgr.entityMgr:replaceEntityMO(entityData)
end

function FightCalculateDataMgr:playEffect263(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(entityMO.currentHp - actEffectData.effectNum)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect264(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(entityMO.currentHp - actEffectData.effectNum)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect265(actEffectData)
	self.dataMgr.paTaMgr:switchBossSkill(actEffectData.assistBossInfo)
end

function FightCalculateDataMgr:playEffect267(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect268(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect269(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect270(actEffectData)
	local handCard = self:getHandCard()
	local arr = string.splitToNumber(actEffectData.reserveStr, "#")

	for i = #handCard, 1, -1 do
		if tabletool.indexOf(arr, i) then
			table.remove(handCard, i)
		end
	end
end

function FightCalculateDataMgr:playEffect271(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setShield(entityMO.shieldValue + actEffectData.effectNum)
end

function FightCalculateDataMgr:playEffect272(actEffectData)
	local indicatorId = FightEnum.IndicatorId.PaTaScore
	local indicatorInfo = self.dataMgr.fieldMgr.indicatorDict[indicatorId]

	if not indicatorInfo then
		indicatorInfo = {
			num = 0,
			id = indicatorId
		}
		self.dataMgr.fieldMgr.indicatorDict[indicatorId] = indicatorInfo
	end

	local beforeScore = indicatorInfo.num

	indicatorInfo.num = beforeScore + actEffectData.effectNum
end

function FightCalculateDataMgr:playEffect273(actEffectData)
	self.dataMgr.playCardMgr:setAct174EnemyCard(actEffectData.cardInfoList)
end

function FightCalculateDataMgr:playEffect274(actEffectData)
	local handCard = self:getHandCard()
	local newCards = FightCardDataHelper.newCardList(actEffectData.cardInfoList)

	FightDataUtil.coverData(newCards, handCard)
end

function FightCalculateDataMgr:playEffect275(actEffectData)
	local side = actEffectData.effectNum

	self.dataMgr.ASFDDataMgr:changeEnergy(side, actEffectData.effectNum1)
end

function FightCalculateDataMgr:playEffect276(actEffectData)
	local handCard = self:getHandCard()
	local newCards = FightCardDataHelper.newCardList(actEffectData.cardInfoList)

	FightDataUtil.coverData(newCards, handCard)
end

function FightCalculateDataMgr:playEffect277(actEffectData)
	local side = actEffectData.effectNum

	self.dataMgr.ASFDDataMgr:changeEmitterEnergy(side, actEffectData.effectNum1)
end

function FightCalculateDataMgr:playEffect280(actEffectData)
	if not actEffectData.emitterInfo then
		return
	end

	local emitterInfo = FightASFDEmitterInfoMO.New()

	emitterInfo:init(actEffectData.emitterInfo)

	local entityData = FightEntityMO.New()

	entityData:init(actEffectData.entity)

	local entityMo = self.dataMgr.entityMgr:addEntityMO(entityData)
	local list = self.dataMgr.entityMgr:getOriginASFDEmitterList(entityMo.side)

	table.insert(list, entityMo)
	self.dataMgr.ASFDDataMgr:setEmitterInfo(entityMo.side, emitterInfo)
end

function FightCalculateDataMgr:playEffect282(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(entityMO.currentHp - actEffectData.effectNum)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect283(actEffectData)
	self.dataMgr.fieldMgr.playerFinisherInfo = FightDataUtil.coverData(actEffectData.playerFinisherInfo, self.dataMgr.fieldMgr.playerFinisherInfo)
end

function FightCalculateDataMgr:playEffect287(actEffectData)
	local side = actEffectData.effectNum
	local emitterMo = self.dataMgr.entityMgr:getASFDEntityMo(side)

	if emitterMo then
		self.dataMgr.entityMgr:removeEntity(emitterMo.id)
	end
end

function FightCalculateDataMgr:playEffect289(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect291(actEffectData)
	self.dataMgr.tempMgr.simplePolarizationLevel = actEffectData.effectNum
end

function FightCalculateDataMgr:playEffect293(actEffectData)
	local teamType = actEffectData.teamType

	if teamType == FightEnum.TeamType.MySide then
		if not FightEnum.EntitySide.MySide then
			local side = FightEnum.EntitySide.EnemySide
			local entityList = self.dataMgr.entityMgr:getOriginSubList(side)

			if not entityList then
				return
			end

			local entityData = FightEntityMO.New()

			entityData:init(actEffectData.entity)

			local entityMO = self.dataMgr.entityMgr:addEntityMO(entityData)

			table.insert(entityList, entityMO)
		end
	end
end

function FightCalculateDataMgr:playEffect294(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect295(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	if not actEffectData.powerInfo then
		return
	end

	entityMO:refreshPowerInfo(actEffectData.powerInfo)
end

function FightCalculateDataMgr:playEffect306(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local buff = actEffectData.buff

	if not buff then
		return
	end

	entityMO:updateBuff(buff)
end

function FightCalculateDataMgr:playEffect308(actEffectData)
	local sideData = self.dataMgr.teamDataMgr[actEffectData.teamType]
	local id = actEffectData.cardHeatValue.id
	local oldData = sideData.cardHeat.values[id]

	sideData.cardHeat.values[id] = FightDataUtil.coverData(FightDataCardHeatValue.New(actEffectData.cardHeatValue), oldData)
end

function FightCalculateDataMgr:playEffect309(actEffectData)
	local id = actEffectData.effectNum
	local sideData = self.dataMgr.teamDataMgr[actEffectData.teamType]
	local data = sideData.cardHeat.values[id]

	if not data then
		return
	end

	data.value = data.value + actEffectData.effectNum1
end

function FightCalculateDataMgr:playEffect310(actEffectData)
	local deckNum = actEffectData.effectNum

	self.dataMgr.fieldMgr:dirSetDeckNum(deckNum)
end

function FightCalculateDataMgr:playEffect314(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	entityMO:setHp(entityMO.currentHp - actEffectData.effectNum)
	self:processHurtInfo(actEffectData)
end

function FightCalculateDataMgr:playEffect316(actEffectData)
	if not actEffectData.entity then
		return
	end

	local entityData = FightEntityMO.New()

	entityData:init(actEffectData.entity)
	self.dataMgr.entityMgr:replaceEntityMO(entityData)
end

function FightCalculateDataMgr:playEffect320(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local cardData = FightCardInfoData.New(actEffectData.cardInfo)
	local handCard = self:getHandCard()

	table.insert(handCard, cardData)
end

function FightCalculateDataMgr:playEffect322(actEffectData)
	local entityMgr = self.dataMgr.entityMgr
	local list = entityMgr:getOriginSubList(actEffectData.teamType)

	if list then
		local removeUisList = string.split(actEffectData.reserveStr, "#")

		for i, v in ipairs(removeUisList) do
			for index = #list, 1, -1 do
				if list[index].uid == v then
					table.remove(list, index)

					entityMgr.entityDataDic[v] = nil

					break
				end
			end
		end
	end
end

function FightCalculateDataMgr:playEffect323(actEffectData)
	local fightTaskBox = self.dataMgr.fieldMgr.fightTaskBox
	local tasks = fightTaskBox.tasks

	for i, v in ipairs(actEffectData.fightTasks) do
		local taskId = v.taskId
		local data = FightTaskData.New(v)

		tasks[taskId] = FightDataUtil.coverData(data, tasks[taskId])
	end
end

function FightCalculateDataMgr:playEffect325(actEffectData)
	self.dataMgr.entityMgr:removeEntity(actEffectData.targetId)
end

function FightCalculateDataMgr:playEffect326(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local buff = actEffectData.buff

	if not buff then
		return
	end

	entityMO:updateBuff(buff)
end

function FightCalculateDataMgr:playEffect330(actEffectData)
	local param = self.dataMgr.fieldMgr.param

	if string.nilorempty(actEffectData.reserveStr) then
		return
	end

	local arr = GameUtil.splitString2(actEffectData.reserveStr, true)

	for i, v in ipairs(arr) do
		local id = v[1]
		local offset = v[2]

		param[id] = param[id] or param[id] + offset
	end
end

function FightCalculateDataMgr:playEffect337(actEffectData)
	local curRound = self.dataMgr.fieldMgr.curRound
	local param18OldValue = self.dataMgr.fieldMgr.param[FightParamData.ParamKey.CUR_EXTRA_ROUND_FLAG]

	self.dataMgr:updateFightData(actEffectData.fight)

	self.dataMgr.fieldMgr.curRound = curRound
	self.dataMgr.fieldMgr.param[FightParamData.ParamKey.CUR_EXTRA_ROUND_FLAG] = param18OldValue
end

function FightCalculateDataMgr:playEffect338(actEffectData)
	if string.nilorempty(actEffectData.reserveStr) then
		return
	end

	local handCard = self:getHandCard()
	local changeList = FightStrUtil.instance:getSplitString2Cache(actEffectData.reserveStr, true)

	for _, change in ipairs(changeList) do
		local index = change[1]
		local changeValue = change[2]

		for j, cardMo in ipairs(handCard) do
			if j == index then
				cardMo.energy = cardMo.energy + changeValue

				break
			end
		end
	end
end

function FightCalculateDataMgr:playEffect349(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local buff = actEffectData.buff

	if not buff then
		return
	end

	entityMO:updateBuff(buff)
end

function FightCalculateDataMgr:playEffect350(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local buffDic = entityMO.buffDic
	local buffUid = actEffectData.reserveId
	local buffMO = buffDic[buffUid]

	if not buffMO then
		return
	end

	local buffActInfo = actEffectData.buffActInfo

	if not buffActInfo then
		return
	end

	local actInfo = buffMO.actInfo
	local hasActId = false

	if buffActInfo.actId == 1131 then
		for i = 1, #actInfo do
			local actInfoData = actInfo[i]

			if actInfoData.actId == buffActInfo.actId then
				local attrId = string.split(actInfoData.strParam, "#")[1]
				local targetId = string.split(buffActInfo.strParam, "#")[1]

				if attrId == targetId then
					hasActId = true

					FightDataUtil.coverData(buffActInfo, actInfoData)

					break
				end
			end
		end
	else
		for i = 1, #actInfo do
			local actInfoData = actInfo[i]

			if actInfoData.actId == buffActInfo.actId then
				hasActId = true

				FightDataUtil.coverData(buffActInfo, actInfoData)

				break
			end
		end
	end

	if not hasActId then
		table.insert(actInfo, FightDataUtil.copyData(buffActInfo))
	end
end

function FightCalculateDataMgr:playEffect1002(actEffectData)
	local reserveStr = actEffectData.reserveStr
	local sideData = self.dataMgr.teamDataMgr[actEffectData.teamType]
	local itemSkillInfos = sideData.itemSkillInfos

	if not itemSkillInfos then
		return
	end

	local arr = string.splitToNumber(reserveStr, "#")
	local skillId = arr[1]
	local count = arr[2]
	local cd = arr[3]

	for i, data in ipairs(itemSkillInfos) do
		if data.skillId == skillId then
			data.count = count
			data.cd = cd

			break
		end
	end
end

function FightCalculateDataMgr:playEffect355(actEffectData)
	return
end

function FightCalculateDataMgr:playUndefineEffect()
	return
end

function FightCalculateDataMgr:dealExPointInfo(exPointInfo)
	for _, v in ipairs(exPointInfo) do
		local entityMO = self.dataMgr:getEntityById(v.uid)

		if entityMO then
			entityMO:setHp(v.currentHp)

			if not isDebugBuild then
				entityMO:setExPoint(v.exPoint)
				entityMO:setPowerInfos(v.powerInfos)
			end
		end
	end
end

function FightCalculateDataMgr:playChangeWave()
	local mgr = self.dataMgr.cacheFightMgr
	local fight = mgr:getAndRemove()

	if fight then
		self.dataMgr:updateFightData(fight)
	end
end

function FightCalculateDataMgr:playChangeHero(fightStepData)
	local toEntityMO = self.dataMgr:getEntityById(fightStepData.toId)
	local fromEntityMO = self.dataMgr:getEntityById(fightStepData.fromId)

	if not fromEntityMO then
		return
	end

	if toEntityMO and toEntityMO.id ~= FightEntityScene.MySideId then
		fromEntityMO.position = toEntityMO.position
		toEntityMO.position = -1
	end

	if fightStepData.actEffect then
		for i, v in ipairs(fightStepData.actEffect) do
			if v.effectType == FightEnum.EffectType.CHANGEHERO then
				local version = FightModel.instance:getVersion()

				if version >= 1 then
					if v.entity then
						local entityData = FightEntityMO.New()

						entityData:init(v.entity)
						self.dataMgr.entityMgr:replaceEntityMO(entityData)
					end
				elseif v.entity then
					local entityData = FightEntityMO.New()

					entityData:init(v.entity)
					FightHelper.setEffectEntitySide(v, entityData)
					self.dataMgr.entityMgr:replaceEntityMO(entityData)
				end
			end
		end
	end

	local side = fromEntityMO.side
	local sideList = self.dataMgr.entityMgr:getOriginListById(fightStepData.toId)

	for index, MO in ipairs(sideList) do
		if MO.uid == fightStepData.toId then
			table.remove(sideList, index)

			break
		end
	end

	sideList = self.dataMgr.entityMgr:getOriginSubList(side)

	for index, MO in ipairs(sideList) do
		if MO.uid == fightStepData.fromId then
			table.remove(sideList, index)

			break
		end
	end

	sideList = self.dataMgr.entityMgr:getOriginNormalList(side)

	table.insert(sideList, self.dataMgr.entityMgr:getById(fightStepData.fromId))
end

function FightCalculateDataMgr:getTarEntityMO(actEffectData)
	return self.dataMgr:getEntityById(actEffectData.targetId)
end

function FightCalculateDataMgr:getHandCard()
	return self.dataMgr.handCardMgr:getHandCard()
end

function FightCalculateDataMgr:needLogError()
	if self:isPerformanceData() then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	return true
end

function FightCalculateDataMgr:isLocalData()
	return self.dataMgr.__cname == FightLocalDataMgr.__cname
end

function FightCalculateDataMgr:isPerformanceData()
	return self.dataMgr.__cname == FightDataMgr.__cname
end

function FightCalculateDataMgr:playStepDataList(stepDataList)
	for i, step in ipairs(stepDataList) do
		self:playStepData(step)
	end
end

function FightCalculateDataMgr:playStepData(step)
	if step.actType == FightEnum.ActType.SKILL or step.actType == FightEnum.ActType.EFFECT or step.actType == FightEnum.ActType.DEVICE then
		for i, actEffectData in ipairs(step.actEffect) do
			self:playActEffectData(actEffectData)
		end
	elseif step.actType == FightEnum.ActType.CHANGEWAVE then
		self:playChangeWave()
	elseif step.actType == FightEnum.ActType.CHANGEHERO then
		self:playChangeHero(step)
	elseif step.actType == FightEnum.ActType.BUFF then
		-- block empty
	else
		logError("local data not handle type : " .. tostring(step.actType))
	end
end

function FightCalculateDataMgr:playActEffectData(actEffectData)
	local func = self._type2FuncName[actEffectData.effectType]

	if not func then
		func = self["playEffect" .. actEffectData.effectType] or self.playUndefineEffect
		self._type2FuncName[actEffectData.effectType] = func
	end

	if self:isPerformanceData() then
		actEffectData:setDone()
		xpcall(func, FightCalculateDataMgr.ingoreLogError, self, actEffectData)
	else
		xpcall(func, __G__TRACKBACK__, self, actEffectData)
	end
end

function FightCalculateDataMgr.ingoreLogError(msg)
	return
end

function FightCalculateDataMgr:playEffect345(actEffectData)
	if self.dataMgr.fieldMgr.customData then
		local customData = self.dataMgr.fieldMgr.customData[FightCustomData.CustomDataType.Survival]

		if not customData then
			return
		end

		if not customData.hero2Health then
			return
		end

		local modelId = actEffectData.effectNum1

		modelId = tostring(modelId)

		local value = customData.hero2Health[modelId]

		if not value then
			return
		end

		customData.hero2Health[modelId] = value + actEffectData.effectNum
	end
end

function FightCalculateDataMgr:playEffect354(actEffectData)
	local indicatorId = FightEnum.IndicatorId.TowerDeep
	local indicatorInfo = self.dataMgr.fieldMgr.indicatorDict[indicatorId]

	if not indicatorInfo then
		indicatorInfo = {
			num = 0,
			id = indicatorId
		}
		self.dataMgr.fieldMgr.indicatorDict[indicatorId] = indicatorInfo
	end

	local beforeScore = indicatorInfo.num

	indicatorInfo.num = beforeScore + actEffectData.effectNum
end

function FightCalculateDataMgr:playEffect358(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect359(actEffectData)
	self:playEffect149(actEffectData)
end

function FightCalculateDataMgr:playEffect360(actEffectData)
	self:playEffect154(actEffectData)
end

function FightCalculateDataMgr:playEffect361(actEffectData)
	local musicInfo = self.dataMgr.teamDataMgr:getRouge2MusicInfo(actEffectData.teamType)

	musicInfo:updateInfo(actEffectData.rouge2MusicInfo)
	self.dataMgr.rouge2MusicDataMgr:updateDataByMusicInfo(musicInfo)
end

function FightCalculateDataMgr:playEffect356(actEffectData)
	self.dataMgr.fieldMgr.maxRoundOffset = self.dataMgr.fieldMgr.maxRoundOffset + actEffectData.effectNum
end

function FightCalculateDataMgr:playEffect362(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect363(actEffectData)
	local indicatorId = tonumber(actEffectData.targetId)
	local indicatorDict = self.dataMgr.fieldMgr.indicatorDict
	local offsetNum = actEffectData.effectNum
	local indicatorInfo = indicatorDict[indicatorId]

	if not indicatorInfo then
		indicatorInfo = {
			num = 0,
			id = indicatorId
		}
		indicatorDict[indicatorId] = indicatorInfo
	end

	indicatorInfo.num = indicatorInfo.num + offsetNum
end

function FightCalculateDataMgr:playEffect364(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect366(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect371(actEffectData)
	self:playEffect149(actEffectData)
end

function FightCalculateDataMgr:playEffect372(actEffectData)
	local teamDataMgr = self.dataMgr.teamDataMgr

	teamDataMgr:setDeviceArea(actEffectData.deviceAreaInfo)
end

function FightCalculateDataMgr:playEffect368(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local arr = string.splitToNumber(actEffectData.reserveStr, ",")

	tabletool.clear(entityMO.weakCareers)

	for i, v in ipairs(arr) do
		table.insert(entityMO.weakCareers, v)
	end
end

function FightCalculateDataMgr:playEffect369(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local arr = string.splitToNumber(actEffectData.reserveStr, ",")

	entityMO.toughnessPoint = entityMO.toughnessPoint + arr[1]
	entityMO.toughnessValue = entityMO.toughnessValue + arr[2]
	entityMO.isBroken = false
end

function FightCalculateDataMgr:playEffect370(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	local arr = string.splitToNumber(actEffectData.reserveStr, ",")

	entityMO.toughnessPoint = entityMO.toughnessPoint + arr[1]
	entityMO.toughnessValue = entityMO.toughnessValue + arr[2]
end

function FightCalculateDataMgr:playEffect373(actEffectData)
	local teamDataMgr = self.dataMgr.teamDataMgr
	local teamType = actEffectData.teamType
	local teamData = teamDataMgr and teamDataMgr[teamType]
	local deviceArea = teamData and teamData.deviceArea

	if not deviceArea then
		return
	end

	local uid = actEffectData.targetId
	local index = actEffectData.effectNum
	local data = deviceArea:getServerDeviceInfo(uid)

	if data then
		data:actEffectSetIndex(index)
	end

	data = deviceArea:getClientDeviceInfo(uid)

	if data then
		data:actEffectSetIndex(index)
	end
end

function FightCalculateDataMgr:playEffect374(actEffectData)
	local teamDataMgr = self.dataMgr.teamDataMgr
	local teamType = actEffectData.teamType
	local teamData = teamDataMgr and teamDataMgr[teamType]
	local deviceArea = teamData and teamData.deviceArea

	if not deviceArea then
		return
	end

	deviceArea:changePower(actEffectData.reserveStr)
end

function FightCalculateDataMgr:playEffect376(actEffectData)
	local startIndex = actEffectData.effectNum
	local endIndex = actEffectData.effectNum1
	local handCard = self:getHandCard()

	if startIndex < endIndex then
		local tempCard = handCard[startIndex]

		for i = startIndex + 1, endIndex do
			handCard[i - 1] = handCard[i]
		end

		handCard[endIndex] = tempCard
	else
		local tempCard = handCard[endIndex]

		for i = startIndex - 1, endIndex, -1 do
			handCard[i + 1] = handCard[i]
		end

		handCard[endIndex] = tempCard
	end
end

function FightCalculateDataMgr:playEffect377(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local areaType = actEffectData.effectNum1

	if areaType == 0 then
		local cardIndex = actEffectData.effectNum
		local cardData = FightCardInfoData.New(actEffectData.cardInfo)
		local handCard = self:getHandCard()

		handCard[cardIndex] = cardData
	end
end

function FightCalculateDataMgr:playEffect378(actEffectData)
	if not FightCardDataHelper.cardChangeIsMySide(actEffectData) then
		return
	end

	local cardData = FightCardInfoData.New(actEffectData.cardInfo)
	local handCard = self:getHandCard()
	local insertIndex = actEffectData.effectNum

	table.insert(handCard, insertIndex, cardData)
end

function FightCalculateDataMgr:playEffect379(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect375(actEffectData)
	local entityMO = self:getTarEntityMO(actEffectData)

	if not entityMO then
		return
	end

	if string.nilorempty(actEffectData.reserveStr) then
		entityMO.toughnessPoint = 0
		entityMO.toughnessValue = 0
		entityMO.isBroken = false
	else
		local arr = string.split(actEffectData.reserveStr, "|")

		entityMO.isBroken = arr[3] == "1"
		arr = string.splitToNumber(arr[1], ",")
		entityMO.toughnessPoint = arr[1] or 0
		entityMO.toughnessValue = arr[2] or 0
	end
end

function FightCalculateDataMgr:playEffect380(actEffectData)
	return
end

function FightCalculateDataMgr:playEffect381(actEffectData)
	local counterId = actEffectData.effectNum
	local counterValue = actEffectData.reserveStr

	self.dataMgr.counterMgr:setCounter(counterId, counterValue)
end

function FightCalculateDataMgr:playEffect382(actEffectData)
	local teamDataMgr = self.dataMgr.teamDataMgr
	local teamType = actEffectData.teamType
	local teamData = teamDataMgr and teamDataMgr[teamType]
	local deviceArea = teamData and teamData.deviceArea

	if not deviceArea then
		return
	end

	deviceArea:clearPower()
end

function FightCalculateDataMgr:playEffect383(actEffectData)
	local teamDataMgr = self.dataMgr.teamDataMgr
	local teamType = actEffectData.teamType

	teamType = teamType ~= 0 and teamType or FightEnum.TeamType.MySide

	local teamData = teamDataMgr and teamDataMgr[teamType]
	local deviceArea = teamData and teamData.deviceArea

	if not deviceArea then
		return
	end

	local skillId = actEffectData.effectNum

	if skillId ~= 0 then
		deviceArea:stopSkill(actEffectData.targetId, actEffectData.effectNum)
	else
		deviceArea:restartDeviceAttr(actEffectData.targetId)
	end
end

return FightCalculateDataMgr
