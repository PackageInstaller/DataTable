-- chunkname: @modules/logic/fight/model/datahelper/FightCardDataHelper.lua

module("modules.logic.fight.model.datahelper.FightCardDataHelper", package.seeall)

local FightCardDataHelper = {}

function FightCardDataHelper.combineCardListForLocal(list)
	return FightCardDataHelper.combineCardList(list, FightLocalDataMgr.instance.entityMgr)
end

function FightCardDataHelper.combineCardListForPerformance(list)
	return FightCardDataHelper.combineCardList(list, FightDataMgr.instance.entityMgr)
end

function FightCardDataHelper.combineCardList(list, entityDataMgr)
	if not entityDataMgr then
		logError("调用list合牌方法,但是没有传入entityDataMgr,请检查代码")

		entityDataMgr = FightLocalDataMgr.instance.entityMgr
	end

	local index = 1
	local combineFinish = false

	while not combineFinish do
		local combined = false

		repeat
			if FightCardDataHelper.canCombineCard(list[index], list[index + 1], entityDataMgr) then
				local removeCard = table.remove(list, index + 1)
				local cardInfo = list[index]

				FightCardDataHelper.combineCard(cardInfo, removeCard, entityDataMgr)

				combined = true
			else
				index = index + 1
			end
		until index >= #list

		if not combined then
			combineFinish = true
		else
			index = 1
		end
	end

	return list
end

function FightCardDataHelper.combineCardForLocal(cardInfo1, cardInfo2)
	return FightCardDataHelper.combineCard(cardInfo1, cardInfo2, FightLocalDataMgr.instance.entityMgr)
end

function FightCardDataHelper.combineCardForPerformance(cardInfo1, cardInfo2)
	return FightCardDataHelper.combineCard(cardInfo1, cardInfo2, FightDataMgr.instance.entityMgr)
end

function FightCardDataHelper.combineCard(cardInfo1, cardInfo2, entityDataMgr)
	if FightEnum.UniversalCard[cardInfo1.skillId] then
		cardInfo1 = cardInfo2
		cardInfo2 = cardInfo1
	end

	if not entityDataMgr then
		logError("调用合牌方法,但是没有传入entityDataMgr,请检查代码")

		entityDataMgr = FightLocalDataMgr.instance.entityMgr
	end

	cardInfo1.skillId = FightCardDataHelper.getSkillNextLvId(cardInfo1.uid, cardInfo1.skillId)
	cardInfo1.tempCard = false
	cardInfo1.energy = cardInfo1.energy + cardInfo2.energy

	FightCardDataHelper.combineMusicType(cardInfo1, cardInfo2)
	FightCardDataHelper.enchantsAfterCombine(cardInfo1, cardInfo2)

	return cardInfo1
end

function FightCardDataHelper.combineMusicType(cardInfo1, cardInfo2)
	if cardInfo1 and cardInfo1.musicNote then
		if not cardInfo1.musicNote.type then
			local type1 = FightEnum.Rouge2MusicType.None

			if cardInfo2 and cardInfo2.musicNote then
				if not cardInfo2.musicNote.type then
					local type2 = FightEnum.Rouge2MusicType.None

					cardInfo1.musicNote.blueValue = cardInfo1.musicNote.blueValue + cardInfo2.musicNote.blueValue
					cardInfo1.musicNote.type = FightEnum.Rouge2MusicTypeCombineDict[type1][type2]

					return (FightRouge2MusicNote.New())
				end
			end
		end
	end
end

function FightCardDataHelper.getCombineCardSkillId(cardData1, cardData2)
	local entityId = cardData1.uid
	local skillId = cardData1.skillId
	local nextSkillId = FightCardDataHelper.getSkillNextLvId()(entityId, skillId)

	if (FightCardDataHelper.isSkill3(cardData1) or FightCardDataHelper.isSkill3(cardData2)) and false and not FightEnum.UniversalCard[cardData1.skillId] and not FightEnum.UniversalCard[cardData2.skillId] then
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
				local tryGetSkill = FightCardDataHelper.getSkillNextLvId(entityId, nextSkillId)

				nextSkillId = tryGetSkill or nextSkillId
			end
		else
			for i = 1, math.abs(offset) do
				local tryGetSkill = FightCardDataHelper.getSkillPrevLvId(entityId, nextSkillId)

				nextSkillId = tryGetSkill or nextSkillId
			end
		end
	end

	return nextSkillId
end

function FightCardDataHelper.canCombineCardForLocal(cardInfo1, cardInfo2)
	return FightCardDataHelper.canCombineCard(cardInfo1, cardInfo2, FightLocalDataMgr.instance.entityMgr)
end

function FightCardDataHelper.canCombineCardForPerformance(cardInfo1, cardInfo2)
	return FightCardDataHelper.canCombineCard(cardInfo1, cardInfo2, FightDataMgr.instance.entityMgr)
end

function FightCardDataHelper.canCombineCardListForPerformance(cardList)
	for i = 1, #cardList - 1 do
		if FightCardDataHelper.canCombineCardForPerformance(cardList[i], cardList[i + 1]) then
			return i
		end
	end
end

function FightCardDataHelper.canCombineCard(cardInfo1, cardInfo2, entityDataMgr)
	if not entityDataMgr then
		logError("调用检测是否可以合牌方法,但是没有传入entityDataMgr,请检查代码")

		entityDataMgr = FightLocalDataMgr.instance.entityMgr
	end

	if not cardInfo1 or not cardInfo2 then
		return false
	end

	local skillId1 = cardInfo1.skillId
	local skillId2 = cardInfo2.skillId

	if skillId1 ~= skillId2 then
		return false
	end

	if FightEnum.UniversalCard[skillId1] or FightEnum.UniversalCard[skillId2] then
		return false
	end

	if FightCardDataHelper.isSpecialCard(cardInfo1) or FightCardDataHelper.isSpecialCard(cardInfo2) then
		return false
	end

	if cardInfo1.uid ~= cardInfo2.uid then
		return false
	end

	if FightCardDataHelper.hadNotCombineEnchant(cardInfo1) or FightCardDataHelper.hadNotCombineEnchant(cardInfo2) then
		return false
	end

	local skillConfig1 = lua_skill.configDict[skillId1]
	local skillConfig2 = lua_skill.configDict[skillId2]

	if not skillConfig1 or not skillConfig2 then
		return false
	end

	if not FightCardDataHelper.isSkill3(cardInfo1) and not FightCardDataHelper.isSkill3(cardInfo2) and (skillConfig1.isBigSkill == 1 or skillConfig2.isBigSkill == 1) then
		return false
	end

	local skillNextConfig = lua_skill_next.configDict[skillId1]

	if skillNextConfig then
		return skillNextConfig.nextId ~= 0
	end

	local nextSkill = FightCardDataHelper.getSkillNextLvId(cardInfo1.uid, skillId1)

	if not nextSkill then
		return false
	end

	return true
end

function FightCardDataHelper.canCombineWithUniversalForLocal(universal_card_info, target_card_info)
	return FightCardDataHelper.canCombineWithUniversal(universal_card_info, target_card_info, FightLocalDataMgr.instance.entityMgr)
end

function FightCardDataHelper.canCombineWithUniversalForPerformance(universal_card_info, target_card_info)
	return FightCardDataHelper.canCombineWithUniversal(universal_card_info, target_card_info, FightDataMgr.instance.entityMgr)
end

function FightCardDataHelper.canCombineWithUniversal(universal_card_info, target_card_info, entityDataMgr)
	if not entityDataMgr then
		logError("调用检测是否可以和万能牌合牌,但是没有传入entityDataMgr,请检查代码")

		entityDataMgr = FightLocalDataMgr.instance.entityMgr
	end

	if not universal_card_info or not target_card_info then
		return false
	end

	if FightHelper.checkIsDevicePowerCard(target_card_info.skillId) then
		return false
	end

	if FightCardDataHelper.isSkill3(target_card_info) then
		return false
	end

	if FightCardDataHelper.isSpecialCard(target_card_info) then
		return false
	end

	local target_skill_id = target_card_info.skillId

	if target_skill_id == FightEnum.UniversalCard1 or target_skill_id == FightEnum.UniversalCard2 then
		return false
	end

	if FightCardDataHelper.hadNotCombineEnchant(target_card_info) then
		return false
	end

	local target_skill_lv = FightCardDataHelper.getSkillLv(target_card_info.uid, target_skill_id)

	if universal_card_info.skillId == FightEnum.UniversalCard1 then
		if target_skill_lv ~= 1 then
			return false
		end
	elseif universal_card_info.skillId == FightEnum.UniversalCard2 and target_skill_lv ~= 1 and target_skill_lv ~= 2 then
		return false
	end

	local nextSkill = FightCardDataHelper.getSkillNextLvId(target_card_info.uid, target_skill_id)

	if not nextSkill then
		return false
	end

	return true
end

function FightCardDataHelper.enchantsAfterCombine(cardInfo1, cardInfo2)
	if not cardInfo1.enchants then
		for i, v in ipairs(cardInfo2.enchants) do
			if FightCardDataHelper.canAddEnchant(cardInfo1, v.enchantId) then
				FightCardDataHelper.addEnchant(cardInfo1.enchants, v)
			end
		end
	end
end

function FightCardDataHelper.canAddEnchant(cardInfo1, tarEnchantId)
	if not cardInfo1.enchants then
		local excludeDic = FightCardDataHelper.excludeEnchants(tarEnchantId)
		local checkLimit = true

		for i, v in ipairs(cardInfo1.enchants) do
			if v.enchantId == tarEnchantId then
				return true
			end

			if FightCardDataHelper.rejectEnchant(v, tarEnchantId) then
				return false
			end

			if excludeDic[v.enchantId] then
				checkLimit = false
			end
		end

		if checkLimit then
			return #cardInfo1.enchants < FightEnum.EnchantNumLimit
		end

		return true
	end
end

function FightCardDataHelper.addEnchant(list, tarEnchant)
	local tarEnchantId = tarEnchant.enchantId
	local excludeDic = FightCardDataHelper.excludeEnchants(tarEnchantId)

	for i = #list, 1, -1 do
		local enchant = list[i]

		if excludeDic[enchant.enchantId] then
			table.remove(list, i)
		end
	end

	local isCovered = false

	for i, v in ipairs(list) do
		if v.enchantId == tarEnchantId then
			isCovered = true
			v.duration = (v.duration == -1 or tarEnchant.duration == -1) and -1 or math.max(v.duration, tarEnchant.duration)
		end
	end

	if not isCovered then
		table.insert(list, tarEnchant)
	end
end

function FightCardDataHelper.excludeEnchants(tarEnchantId)
	local tarConfig = lua_card_enchant.configDict[tarEnchantId]
	local excludeDic = {}

	if not string.nilorempty(tarConfig.excludeTypes) then
		local arr = string.splitToNumber(tarConfig.excludeTypes, "#")

		for i, v in ipairs(arr) do
			excludeDic[v] = true
		end
	end

	return excludeDic
end

function FightCardDataHelper.rejectEnchant(enchant, tarEnchantId)
	local config = lua_card_enchant.configDict[enchant.enchantId]
	local tarConfig = lua_card_enchant.configDict[tarEnchantId]
	local reject = string.splitToNumber(config.rejectTypes, "#")

	for index, rejectId in ipairs(reject) do
		if rejectId == tarConfig.id then
			return true
		end
	end
end

function FightCardDataHelper.isFrozenCard(card_info)
	if not card_info.enchants then
		for i, v in ipairs(card_info.enchants) do
			if v.enchantId == FightEnum.EnchantedType.Frozen then
				return true
			end
		end
	end
end

function FightCardDataHelper.isBurnCard(card_info)
	if not card_info.enchants then
		for i, v in ipairs(card_info.enchants) do
			if v.enchantId == FightEnum.EnchantedType.Burn then
				return true
			end
		end
	end
end

function FightCardDataHelper.isChaosCard(card_info)
	if not card_info.enchants then
		for i, v in ipairs(card_info.enchants) do
			if v.enchantId == FightEnum.EnchantedType.Chaos then
				return true
			end
		end
	end
end

function FightCardDataHelper.isDiscard(card_info)
	if not card_info.enchants then
		for i, v in ipairs(card_info.enchants) do
			if v.enchantId == FightEnum.EnchantedType.Discard then
				return true
			end
		end
	end
end

function FightCardDataHelper.isBlockade(card_info)
	if not card_info.enchants then
		for i, v in ipairs(card_info.enchants) do
			if v.enchantId == FightEnum.EnchantedType.Blockade then
				return true
			end
		end
	end
end

function FightCardDataHelper.isPrecision(card_info)
	if not card_info.enchants then
		for i, v in ipairs(card_info.enchants) do
			if v.enchantId == FightEnum.EnchantedType.Precision then
				return true
			end
		end
	end
end

function FightCardDataHelper.isSkill3(card_info)
	if not card_info then
		return
	end

	return card_info.cardType == FightEnum.CardType.SKILL3
end

function FightCardDataHelper.hadNotCombineEnchant(cardInfo)
	if not cardInfo then
		return false
	end

	local enchants = cardInfo.enchants

	if not enchants then
		return false
	end

	for _, enchant in ipairs(enchants) do
		if FightCardDataHelper.checkIsNotCombineEnchant(enchant.enchantId) then
			return true
		end
	end

	return false
end

local NotCombineEnchantsList = {
	FightEnum.EnchantedType.Lorenz
}

function FightCardDataHelper.checkIsNotCombineEnchant(enchantId)
	return tabletool.indexOf(NotCombineEnchantsList, enchantId)
end

function FightCardDataHelper.isSpecialCard(card_info)
	if not card_info then
		return
	end

	return FightCardDataHelper.isSpecialCardById(card_info.uid, card_info.skillId)
end

function FightCardDataHelper.isSpecialCardById(entityId, skillId)
	if (entityId == FightEntityScene.MySideId or entityId == FightEntityScene.EnemySideId) and not FightEnum.UniversalCard[skillId] then
		return true
	end
end

function FightCardDataHelper.isNoCostSpecialCard(card_info)
	if not card_info then
		return
	end

	if FightCardDataHelper.isSpecialCard(card_info) and card_info.cardType ~= FightEnum.CardType.ROUGE_SP and card_info.cardType ~= FightEnum.CardType.USE_ACT_POINT then
		return true
	end
end

function FightCardDataHelper.checkIsBigSkillCostActPoint(belongToEntityId, skillId)
	local entityMo = FightDataHelper.entityMgr:getById(belongToEntityId)

	if not entityMo then
		return true
	end

	local skillCo = lua_skill.configDict[skillId]

	if not skillCo then
		return true
	end

	if skillCo.isBigSkill ~= 1 then
		return true
	end

	if entityMo:hasBuffFeature(FightEnum.BuffType_BigSkillNoUseActPoint) then
		return false
	end

	return true
end

function FightCardDataHelper.checkIsSmallSkillCostActPoint(belongToEntityId, skillId)
	local entityMo = FightDataHelper.entityMgr:getById(belongToEntityId)

	if not entityMo then
		return true
	end

	local skillCo = lua_skill.configDict[skillId]

	if not skillCo then
		return true
	end

	if skillCo.isBigSkill == 1 then
		return true
	end

	if entityMo:hasBuffFeature(FightEnum.BuffType_NotBigSkillNoUseActPoint) then
		return false
	end

	return true
end

function FightCardDataHelper.moveActCost(cardData)
	if FightEnum.UniversalCard[cardData.skillId] then
		return 0
	end

	return 1
end

function FightCardDataHelper.playActCost(cardData)
	local costPoint = 1
	local uid = cardData.uid
	local entityData = FightDataHelper.entityMgr:getById(uid)
	local skillId = cardData.skillId
	local cardType = cardData.cardType

	if FightCardDataHelper.isSpecialCardById(uid, skillId) then
		costPoint = (cardType == FightEnum.CardType.ROUGE_SP or cardType == FightEnum.CardType.USE_ACT_POINT) and 1 or 0

		return costPoint
	end

	if cardData:checkHasExtraInfo(FightCardExtraInfoData.ExtraKey.NotUseActPoint) then
		costPoint = 0

		return 0
	end

	if FightCardDataHelper.isSkill3(cardData) then
		costPoint = 0

		return 0
	end

	if FightCardDataHelper.hadNotCostPointEnchant(cardData) then
		costPoint = 0

		return 0
	end

	if entityData and entityData:hasBuffFeature(FightEnum.BuffFeature.SkillNoUseActPoint) then
		costPoint = 0
	end

	local skillCo = lua_skill.configDict[skillId]
	local isBigSkill = skillCo and skillCo.isBigSkill == 1

	costPoint = isBigSkill and (FightCardDataHelper.checkIsBigSkillCostActPoint(uid, skillId) or 0) or FightCardDataHelper.checkIsSmallSkillCostActPoint(uid, skillId) or 0

	return costPoint
end

local NotCostPointEnchantsList = {
	FightEnum.EnchantedType.Lorenz
}

function FightCardDataHelper.hadNotCostPointEnchant(cardData)
	if not cardData then
		return
	end

	local enchantList = cardData.enchants

	if not enchantList then
		return
	end

	for _, enchant in pairs(enchantList) do
		if tabletool.indexOf(NotCostPointEnchantsList, enchant.enchantId) then
			return true
		end
	end
end

local NotAddExPointEnchantsList = {
	FightEnum.EnchantedType.Lorenz
}

function FightCardDataHelper.hadNotAddExPointEnchant(cardData)
	if not cardData then
		return
	end

	local enchantList = cardData.enchants

	if not enchantList then
		return
	end

	for _, enchant in pairs(enchantList) do
		if tabletool.indexOf(NotAddExPointEnchantsList, enchant.enchantId) then
			return true
		end
	end
end

function FightCardDataHelper.canPlayCard(card_info)
	if not card_info then
		return false
	end

	if card_info:checkHasExtraInfo(FightCardExtraInfoData.ExtraKey.NotUse) then
		return false
	end

	if FightCardDataHelper.isFrozenCard(card_info) then
		return false
	end

	if FightCardDataHelper.isBlockade(card_info) then
		local handCard = FightDataHelper.handCardMgr:getHandCard()
		local handCardIndex = tabletool.indexOf(handCard, card_info)

		if handCardIndex then
			local handcards = handCard

			return handCardIndex == 1 or handCardIndex == #handcards
		end
	end

	if FightCardDataHelper.hasUnnamedLockState(card_info) then
		return false
	end

	return true
end

function FightCardDataHelper.checkCanPlayCard(card_info, cardDataList)
	if not card_info then
		return false
	end

	if FightCardDataHelper.isFrozenCard(card_info) then
		return false
	end

	if FightCardDataHelper.isBlockade(card_info) then
		local handCardIndex = tabletool.indexOf(cardDataList, card_info)

		if handCardIndex then
			return handCardIndex == 1 or handCardIndex == #cardDataList
		end
	end

	return true
end

function FightCardDataHelper.hasUnnamedLockState(cardInfo)
	if not cardInfo then
		return false
	end

	local cardData = cardInfo:getCardData(FightCardInfo_CardData.CardDataKey.Unnamed)

	return cardData and cardData.jsonValue.lock
end

function FightCardDataHelper.canMoveCard(card_info)
	if not card_info then
		return false
	end

	if card_info:checkHasExtraInfo(FightCardExtraInfoData.ExtraKey.NotMove) then
		return false
	end

	if FightCardDataHelper.isSpecialCard(card_info) then
		return false
	end

	if FightCardDataHelper.isFrozenCard(card_info) then
		return false
	end

	if FightCardDataHelper.isSkill3(card_info) then
		return false
	end

	return true
end

function FightCardDataHelper.playCanAddExpoint(card_list, card_info)
	if not card_info then
		return false
	end

	if FightCardDataHelper.isSpecialCard(card_info) then
		return false
	end

	if FightCardDataHelper.isSkill3(card_info) then
		return false
	end

	local entityMO = FightDataHelper.entityMgr:getById(card_info.uid)

	if entityMO then
		local tab = FightEnum.ExPointTypeFeature[entityMO.exPointType]

		if tab then
			return tab.playAddExpoint
		end
	end

	return true
end

function FightCardDataHelper.moveCanAddExpoint(card_list, card_info)
	if not card_info then
		return false
	end

	if FightCardDataHelper.isSkill3(card_info) then
		return false
	end

	if FightEnum.UniversalCard[card_info.skillId] then
		return false
	end

	if FightDataHelper.operationDataMgr:isUnlimitMoveCard() then
		return false, true
	end

	local extraMoveAct = FightDataHelper.operationDataMgr.extraMoveAct

	if extraMoveAct > 0 then
		local ops = FightDataHelper.operationDataMgr:getMoveCardOpCostActList()

		if extraMoveAct > #ops then
			return false, true
		end
	end

	local entityMO = FightDataHelper.entityMgr:getById(card_info.uid)

	if entityMO then
		local tab = FightEnum.ExPointTypeFeature[entityMO.exPointType]

		if tab then
			return tab.moveAddExpoint
		end
	end

	return true
end

function FightCardDataHelper.combineCanAddExpoint(card_list, card_info1, card_info2)
	if not card_info1 or not card_info2 then
		return false
	end

	if FightCardDataHelper.isSkill3(card_info1) or FightCardDataHelper.isSkill3(card_info2) then
		do return false end

		if FightEnum.UniversalCard[card_info1.skillId] then
			local entityMO = FightDataHelper.entityMgr:getById(card_info2.uid or card_info1.uid)

			if entityMO then
				local tab = FightEnum.ExPointTypeFeature[entityMO.exPointType]

				if tab then
					return tab.combineAddExpoint
				end
			end

			return true
		end
	end
end

function FightCardDataHelper.allFrozenCard(handCards)
	local lock_coun = 0

	for i, v in ipairs(handCards) do
		if FightCardDataHelper.isFrozenCard(v) then
			lock_coun = lock_coun + 1
		end
	end

	return lock_coun == #handCards
end

function FightCardDataHelper.allPlayCardCantUse(handCards)
	for i, v in ipairs(handCards) do
		if FightCardDataHelper.canPlayCard(v) then
			return false
		end
	end

	return true
end

function FightCardDataHelper.calcRemoveCardTime(beforeCards, removeIndexes, removeTime)
	local dt = 0.033
	local time = removeTime or 1.2
	local count = #beforeCards
	local removeCount = #removeIndexes

	for i, index in ipairs(removeIndexes) do
		if index < count then
			time = time + dt * 7
			time = time + 3 * dt * (count - removeIndexes[removeCount] - removeCount)

			break
		end
	end

	return time
end

function FightCardDataHelper.calcRemoveCardTime2(beforeCards, removeIndexes, removeTime)
	local dt = 0.033
	local time = removeTime or 1.2
	local cards = tabletool.copy(beforeCards)

	for i, v in ipairs(removeIndexes) do
		table.remove(cards, v)
	end

	for i, v in ipairs(cards) do
		if v ~= beforeCards[i] then
			time = time + dt * 7
			time = time + 3 * dt * (#cards - i)

			break
		end
	end

	return time
end

function FightCardDataHelper.cardChangeIsMySide(actEffectData)
	local version = FightModel.instance:getVersion()

	if version >= 1 then
		if not actEffectData then
			return false
		end

		if actEffectData and actEffectData.teamType ~= FightEnum.TeamType.MySide then
			return false
		end
	end

	return true
end

function FightCardDataHelper.newCardList(proto)
	local list = {}

	for i, v in ipairs(proto) do
		table.insert(list, FightCardInfoData.New(v))
	end

	return list
end

function FightCardDataHelper.newPlayCardList(proto)
	local list = {}

	for i, v in ipairs(proto) do
		table.insert(list, FightClientPlayCardData.New(v, i))
	end

	return list
end

function FightCardDataHelper.remainedAfterCombine(cardItem1, cardItem2)
	local cardData1 = cardItem1.cardData
	local cardData2 = cardItem2.cardData

	if FightEnum.UniversalCard[cardData1.skillId] or FightEnum.UniversalCard[cardData2.skillId] then
		local remainedCard = FightEnum.UniversalCard[cardItem1.cardData.skillId] and cardItem2 or cardItem1
		local beCombinedCard = remainedCard == cardItem1 and cardItem2 or cardItem1

		return remainedCard, beCombinedCard
	end

	local index1 = cardItem1:getItemIndex()
	local index2 = cardItem2:getItemIndex()

	if index1 < index2 then
		return cardItem1, cardItem2
	else
		return cardItem2, cardItem1
	end
end

function FightCardDataHelper.isBigSkill(skillId)
	local skillConfig = lua_skill.configDict[skillId]

	if not skillConfig then
		return false
	end

	return skillConfig.isBigSkill == 1
end

function FightCardDataHelper.getSkillLv(entityId, skillId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if entityMO then
		return entityMO:getSkillLv(skillId)
	end

	return FightConfig.instance:getSkillLv(skillId)
end

function FightCardDataHelper.getSkillNextLvId(entityId, skillId)
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

function FightCardDataHelper.getSkillPrevLvId(entityId, skillId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if entityMO then
		return entityMO:getSkillPrevLvId(skillId)
	end

	return FightConfig.instance:getSkillPrevLvId(skillId)
end

function FightCardDataHelper.isActiveSkill(entityId, skillId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if entityMO then
		return entityMO:isActiveSkill(skillId)
	end

	return FightConfig.instance:isActiveSkill(skillId)
end

function FightCardDataHelper.calcCardsAfterCombine(cardList)
	cardList = FightDataUtil.copyData(cardList)

	FightCardDataHelper.combineCardListForPerformance(cardList)

	return cardList
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

function FightCardDataHelper.getHandCardContainerScale(clothSkillExpand, cards)
	local handCards = cards or FightDataHelper.handCardMgr.handCard
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

function FightCardDataHelper.moveOnly(cards, from, to)
	local card = table.remove(cards, from)

	table.insert(cards, to, card)
end

function FightCardDataHelper.checkOpAsPlayCardHandle(op)
	if not op then
		return false
	end

	if op:isPlayCard() then
		return true
	end

	if op:isAssistBossPlayCard() then
		return true
	end

	if op:isBloodPoolSkill() then
		return true
	end

	if op:isPlayerFinisherSkill() then
		return true
	end

	if op:isRouge2MusicSkill() then
		return true
	end

	return false
end

function FightCardDataHelper.getCardSkin()
	local cardStyleId = FightUISwitchModel.instance:getCurUseFightUICardStyleId()
	local config = lua_fight_ui_style.configDict[cardStyleId]

	if not config then
		return nil
	end

	if config.itemId == 672800 then
		return nil
	end

	return config.itemId
end

function FightCardDataHelper.hasTargetEnchantId(cardInfo, enchantId)
	if not cardInfo then
		return
	end

	local enchantList = cardInfo.enchants

	if not enchantList then
		return
	end

	for _, v in ipairs(enchantList) do
		if v.enchantId == enchantId then
			return true
		end
	end
end

return FightCardDataHelper
