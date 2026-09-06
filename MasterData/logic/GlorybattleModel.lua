-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/model/GlorybattleModel.lua

module("logic.extensions.glorybattle.view.GlorybattleModel", package.seeall)

local GlorybattleModel = class("GlorybattleModel", BaseModel)

function GlorybattleModel:ctor()
	return
end

function GlorybattleModel:onInit()
	self:onReset()
end

function GlorybattleModel:onReset()
	self._msgInfos = {}
	self._petMoMap = {}
	self._petCardMoMap = {}
	self._fmtMo = nil
	self._rankViewMsg = nil
end

function GlorybattleModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)

	self:_setDefultValue(msg.activityId)
	self:_loadGetPetOrder(msg.activityId, msg.challengeInfo.genreId)
	self:_updatePetsAwakenLevel(msg.activityId)
end

function GlorybattleModel:setCurrActivityId(activityId)
	self._currActivityId = activityId
end

function GlorybattleModel:getCurrActivityId()
	return self._currActivityId
end

function GlorybattleModel:_updatePetsAwakenLevel(activityId)
	if self._petMoMap[activityId] then
		local info = self:getInfo(activityId)
		local map = {}

		for i, v in ipairs(info.challengeInfo.creepsInfos) do
			map[v.creepsId] = v.awakenLevel
		end

		for k, petMo in pairs(self._petMoMap[activityId]) do
			if map[petMo.petId] and petMo.awakeLevel ~= map[petMo.petId] then
				petMo.awakeLevel = map[petMo.petId]
				petMo.awakenLv = map[petMo.petId]

				petMo:calcAllAttr()
			end
		end
	end
end

function GlorybattleModel:_loadGetPetOrder(activityId, genreId)
	if genreId > 0 then
		self._getPetOrderDatas = GameUtil.getUserData(GlorybattleController.Key_GetPetOrder)

		if not self._getPetOrderDatas or #self._getPetOrderDatas <= 0 then
			local genreCfg = GlorybattleConfig.instance:getGenreCfg(activityId, genreId)

			for i, creepsId in ipairs(genreCfg.petList) do
				self:_addToPetOrderList(creepsId)
			end

			if self._getPetOrderDatas then
				GameUtil.saveUserData(GlorybattleController.Key_GetPetOrder, self._getPetOrderDatas)
			end
		end
	end
end

function GlorybattleModel:_setDefultValue(activityId)
	self._msgInfos[activityId].challengeInfo.blockInfo = self._msgInfos[activityId].challengeInfo.blockInfo or {}
	self._msgInfos[activityId].challengeInfo.creepsInfos = self._msgInfos[activityId].challengeInfo.creepsInfos or {}
	self._msgInfos[activityId].challengeInfo.holyStripeInfos = self._msgInfos[activityId].challengeInfo.holyStripeInfos or {}
	self._msgInfos[activityId].challengeInfo.petCardInfos = self._msgInfos[activityId].challengeInfo.petCardInfos or {}
	self._msgInfos[activityId].challengeInfo.creepsInfos = self._msgInfos[activityId].challengeInfo.creepsInfos or {}

	for i, v in ipairs(self._msgInfos[activityId].challengeInfo.holyStripeInfos) do
		v.bindCreepsId = v.bindCreepsId or {}
	end
end

function GlorybattleModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function GlorybattleModel:getGetPetOrderDatas()
	return self._getPetOrderDatas
end

function GlorybattleModel:resetDatas()
	self:resetGainPetOrder()

	self._petMoMap = {}
	self._petCardMoMap = {}
end

function GlorybattleModel:resetGainPetOrder()
	self._getPetOrderDatas = {}

	GameUtil.saveUserData(GlorybattleController.Key_GetPetOrder, self._getPetOrderDatas)
end

function GlorybattleModel:getShopLevel(activityId)
	local info = self:getInfo(activityId)
	local defultLv = 1
	local challengeInfo = info.challengeInfo
	local genreId = challengeInfo.genreId

	if genreId <= 0 then
		return defultLv
	end

	local round = info.challengeInfo.curRound

	return GlorybattleConfig.instance:getShopLv(activityId, genreId, round)
end

function GlorybattleModel:getPetMo(activityId, creepsId)
	self._petMoMap = self._petMoMap or {}
	self._petMoMap[activityId] = self._petMoMap[activityId] or {}

	if not self._petMoMap[activityId][creepsId] then
		local awakenLevel, holyStripeId = self:_getCreepsInfoLevel(activityId, creepsId)
		local cutePetId, cutePetLv = self:_getCutePetInfoLevel(activityId)

		self._petMoMap[activityId][creepsId] = self:_createPetMo(activityId, creepsId, awakenLevel, holyStripeId, cutePetId, cutePetLv)
	end

	return self._petMoMap[activityId][creepsId]
end

function GlorybattleModel:getOpponentPetMo(activityId, creepsId)
	local awakenLevel = 0
	local holyStripeId = 0
	local info = self:getInfo(activityId)
	local opponent = info.opponent

	if opponent and opponent.creepsInfos then
		for i, v in ipairs(opponent.creepsInfos) do
			if v.creepsId == creepsId then
				awakenLevel = v.awakenLevel
				holyStripeId = v.holyStripeId

				break
			end
		end
	end

	if awakenLevel <= 0 and checknumber(opponent.headInfo.userId) > 0 then
		local creepCfg = GlorybattleConfig.instance:getBattlePetCfg(activityId, creepsId)

		awakenLevel = creepCfg.awakenLv
	end

	local cutePetId, cutePetLv = 0, 0

	if opponent.cutePetInfo then
		cutePetLv = opponent.cutePetInfo.level
		cutePetId = opponent.cutePetInfo.cutePetId
	end

	return self:_createPetMo(activityId, creepsId, awakenLevel, holyStripeId, cutePetId, cutePetLv, false)
end

function GlorybattleModel:_changeNewPetMoIfHad(activityId, creepsId, holyStripeSuitId, isAdd)
	if self._petMoMap[activityId] and self._petMoMap[activityId][creepsId] then
		local petMo = self._petMoMap[activityId][creepsId]

		if not isAdd then
			holyStripeSuitId = 0
		end

		local awakenLevel = self:_getCreepsInfoLevel(activityId, creepsId)
		local cutePetId, cutePetLv = self:_getCutePetInfoLevel(activityId)

		petMo.extpropertiesArr = self:_calcExtAttrs(activityId, creepsId, awakenLevel, holyStripeSuitId, cutePetId, cutePetLv)

		petMo:calcAllAttr()
	end
end

function GlorybattleModel:_onCutePetLevelUpCalZdl(activityId)
	if self._petMoMap[activityId] then
		for creepsId, petMo in pairs(self._petMoMap[activityId]) do
			local awakenLevel, holyStripeSuitId = self:_getCreepsInfoLevel(activityId, creepsId)
			local cutePetId, cutePetLv = self:_getCutePetInfoLevel(activityId)

			petMo.extpropertiesArr = self:_calcExtAttrs(activityId, creepsId, awakenLevel, holyStripeSuitId, cutePetId, cutePetLv)

			petMo:calcAllAttr()
		end
	end

	if self._petCardMoMap[activityId] then
		for petCardId, petMo in pairs(self._petCardMoMap[activityId]) do
			local cardCfg = GlorybattleConfig.instance:getPetCardCfg(activityId, petCardId)
			local cutePetId, cutePetLv = self:_getCutePetInfoLevel(activityId)
			local holyStripeSuitId = cardCfg.holyStripeSuitId

			petMo.extpropertiesArr = self:_calcExtAttrs(activityId, cardCfg.creepsId, cardCfg.awakenLevel, holyStripeSuitId, cutePetId, cutePetLv)

			petMo:calcAllAttr()
		end
	end
end

function GlorybattleModel:_onPetAwakenLevelUpCalZdl(activityId, creepsId)
	if self._petMoMap[activityId] and self._petMoMap[activityId][creepsId] then
		local petMo = self._petMoMap[activityId][creepsId]
		local awakenLevel, holyStripeSuitId = self:_getCreepsInfoLevel(activityId, creepsId)
		local cutePetId, cutePetLv = self:_getCutePetInfoLevel(activityId)

		petMo.extpropertiesArr = self:_calcExtAttrs(activityId, creepsId, awakenLevel, holyStripeSuitId, cutePetId, cutePetLv)
		petMo.awakeLevel = awakenLevel
		petMo.awakenLv = awakenLevel

		petMo:calcAllAttr()
	end
end

function GlorybattleModel:_calcExtAttrs(activityId, creepsId, awakenLevel, holyStripeSuitId, cutePetId, cutePetLv)
	local res = {}
	local cfg = GlorybattleConfig.instance:getBattlePetCfg(activityId, creepsId)
	local percent = 1

	if awakenLevel > 0 then
		local tempPercent = GlorybattleConfig.instance:getCommonValue("AWAKEN_LEVEL_PROPERTY_WAN_PERCENT", true)

		percent = percent + tempPercent / 10000 * awakenLevel
	end

	local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.extproperties) or {}

	res = AttrMo.addSameAttrs(attrs, res)
	awakenLevel = awakenLevel or 0

	if holyStripeSuitId and holyStripeSuitId > 0 then
		local suitCfg = GlorybattleConfig.instance:getHolyStripeSuitCfg(holyStripeSuitId)

		for i, hId in ipairs(suitCfg.holyStripeIds) do
			local holyStripeCfg = GlorybattleConfig.instance:getHolyStripeCfg(hId)
			local attrs = FightingPowerFormula.instance:parseAttrValues(holyStripeCfg.extproperties) or {}

			res = AttrMo.addSameAttrs(attrs, res)
		end
	end

	if cutePetId > 0 and cutePetLv >= 0 then
		local cutePetCfg = GlorybattleConfig.instance:getCutePetCfg(cutePetId, cutePetLv)
		local attrs = FightingPowerFormula.instance:parseAttrValues(cutePetCfg.extproperties) or {}

		res = AttrMo.addSameAttrs(attrs, res)
	end

	self:_callAttrsByPercent(res, percent)

	return res
end

function GlorybattleModel:calHolyStripeZdl(holyStripeSuitId)
	if holyStripeSuitId and holyStripeSuitId > 0 then
		local res = {}
		local suitCfg = GlorybattleConfig.instance:getHolyStripeSuitCfg(holyStripeSuitId)

		for i, hId in ipairs(suitCfg.holyStripeIds) do
			local holyStripeCfg = GlorybattleConfig.instance:getHolyStripeCfg(hId)
			local attrs = FightingPowerFormula.instance:parseAttrValues(holyStripeCfg.extproperties) or {}

			res = AttrMo.addSameAttrs(attrs, res)
		end

		return AttrMo.calcFightPowerByAttrs(res)
	end

	return 0
end

function GlorybattleModel:_callAttrsByPercent(attrs, percent)
	for k, v in pairs(attrs) do
		if k == GameEnum.AttrType.Hp or k == GameEnum.AttrType.Attack or k == GameEnum.AttrType.DefenseMagic or k == GameEnum.AttrType.DefensePhysical or k == GameEnum.AttrType.Speed then
			attrs[k] = attrs[k] * percent
		end
	end
end

function GlorybattleModel:getPetCardPetMo(activityId, petCardId)
	local petIdFake = self:_getPetCardIdChangePetIdFake(activityId, petCardId)

	self._petCardMoMap = self._petCardMoMap or {}
	self._petCardMoMap[activityId] = self._petCardMoMap[activityId] or {}

	local petMo = self._petCardMoMap[activityId][petCardId]

	if not petMo then
		local cardCfg = GlorybattleConfig.instance:getPetCardCfg(activityId, petCardId)
		local cutePetId, cutePetLv = self:_getCutePetInfoLevel(activityId)
		local holyStripeSuitId = cardCfg.holyStripeSuitId

		petMo = self:_createPetMo(activityId, cardCfg.creepsId, cardCfg.awakenLevel, holyStripeSuitId, cutePetId, cutePetLv)
		petMo.petId = petIdFake
		self._petCardMoMap[activityId][petCardId] = petMo
	end

	return petMo
end

function GlorybattleModel:getPetCardFakePetIdAddNum()
	return 100000
end

function GlorybattleModel:_getPetCardIdChangePetIdFake(activityId, petCardId)
	local cardCfg = GlorybattleConfig.instance:getPetCardCfg(activityId, petCardId)

	return self:getPetCardFakePetIdAddNum() * petCardId + cardCfg.creepsId
end

function GlorybattleModel:petIdFakeChangeRealPetId(petIdFake)
	return petIdFake % self:getPetCardFakePetIdAddNum()
end

function GlorybattleModel:petIdFakeChangeRealPetCardId(petIdFake)
	return (petIdFake - self:petIdFakeChangeRealPetId(petIdFake)) / self:getPetCardFakePetIdAddNum()
end

function GlorybattleModel:_createPetMo(activityId, creepsId, awakenLevel, holyStripeSuitId, cutePetId, cutePetLv, needToPetMo)
	local creepCfg = GlorybattleConfig.instance:getBattlePetCfg(activityId, creepsId)
	local fPowerPet = FightingPowerPetMo.New()

	fPowerPet.awakeLevel = awakenLevel or creepCfg.awakenLv

	fPowerPet:fromChallengeCreepCo(creepCfg)

	if needToPetMo == nil then
		needToPetMo = true
	end

	local petMo = needToPetMo and fPowerPet:toBaseBagPetMo() or fPowerPet

	petMo.extpropertiesArr = self:_calcExtAttrs(activityId, creepsId, awakenLevel, holyStripeSuitId, cutePetId, cutePetLv)

	petMo:calcAllAttr()

	return petMo
end

function GlorybattleModel:onRefreshShopRes(msg)
	local info = self:getInfo(msg.activityId)

	info.challengeInfo.blockInfo = GameUtil.pbToTable(msg.blockInfo)
	info.challengeInfo.currency = msg.currency
end

function GlorybattleModel:onMatchFightRes(msg)
	local info = self:getInfo(msg.activityId)

	info.opponent = GameUtil.pbToTable(msg.opponent)
end

function GlorybattleModel:getOpponent(activityId)
	local info = self:getInfo(activityId)

	return info.opponent
end

function GlorybattleModel:getFmtMo()
	self._fmtMo = self._fmtMo or GlorybattleFmtMo.New()

	return self._fmtMo
end

function GlorybattleModel:onGiveUpRes(msg)
	local info = self:getInfo(msg.activityId)

	info.totalScore = info.totalScore - msg.totalScore

	self:resetGainPetOrder()
end

function GlorybattleModel:isShopItemLock(activityId, blockId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.challengeInfo.blockInfo) do
		if v.blockId == blockId then
			return v.isLock
		end
	end
end

function GlorybattleModel:isShopItemBuy(activityId, blockId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.challengeInfo.blockInfo) do
		if v.blockId == blockId then
			return v.isBuy
		end
	end
end

function GlorybattleModel:onChangeLockStateRes(msg)
	local info = self:getInfo(msg.activityId)

	for i, v in ipairs(info.challengeInfo.blockInfo) do
		if v.blockId == msg.blockId then
			v.isLock = msg.changeType == GlorybattleController.LockType.Lock

			break
		end
	end
end

function GlorybattleModel:onGainPetRes(msg)
	local info = self:getInfo(msg.activityId)
	local map = {}
	local effectDataMap = {}

	for i, v in ipairs(info.challengeInfo.creepsInfos) do
		map[v.creepsId] = v
	end

	for i, creepsId in ipairs(msg.gainPetCreepsId) do
		if map[creepsId] then
			self:petAwakenLevelUp(msg.activityId, creepsId)

			effectDataMap[creepsId] = {
				isAwakenLevelUp = true,
				creepsId = creepsId
			}
		else
			local cInfo = {
				holyStripeId = 0,
				awakenLevel = 0,
				creepsId = creepsId
			}

			table.insert(info.challengeInfo.creepsInfos, cInfo)

			map[creepsId] = cInfo
			effectDataMap[creepsId] = {
				isNewGain = true,
				creepsId = creepsId
			}

			self:_addToPetOrderList(creepsId)
		end
	end

	if self._getPetOrderDatas then
		GameUtil.saveUserData(GlorybattleController.Key_GetPetOrder, self._getPetOrderDatas)
	end

	local num = table.nums(effectDataMap)

	if num > 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PetGainOrAwakenEfect, effectDataMap)
	end
end

function GlorybattleModel:isAllShopItemLock(activityId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.challengeInfo.blockInfo) do
		if not v.isLock then
			return false
		end
	end

	return true
end

function GlorybattleModel:onBuyTimesRes(msg)
	local info = self:getInfo(msg.activityId)

	info.todayBuyTimes = msg.todayBuyTimes
end

function GlorybattleModel:onNotifyFightRes(msg)
	local info = self:getInfo(msg.activityId)

	info.todayChallengeTimes = msg.todayChallengeTimes
	info.challengeInfo = GameUtil.pbToTable(msg.challengeInfo)
	info.opponent = nil

	self:_setDefultValue(msg.activityId)

	info.totalScore = msg.totalScore
end

function GlorybattleModel:getPetNum(activityId)
	local info = self:getInfo(activityId)

	return #info.challengeInfo.creepsInfos
end

function GlorybattleModel:getFightPetNum(activityId)
	local info = self:getInfo(activityId)
	local myNum = #info.challengeInfo.creepsInfos
	local petCardNum = 0

	for i, v in ipairs(info.challengeInfo.petCardInfos) do
		petCardNum = petCardNum + v.num
	end

	return myNum + petCardNum
end

function GlorybattleModel:onSalePetRes(msg)
	local info = self:getInfo(msg.activityId)

	info.challengeInfo.currency = msg.currency

	for i, v in ipairs(info.challengeInfo.creepsInfos) do
		if v.creepsId == msg.creepsId then
			if v.holyStripeId > 0 then
				GloryBattleAgent.instance:sendPM_GloryBattleInfoReq(msg.activityId)
			end

			table.remove(info.challengeInfo.creepsInfos, i)

			break
		end
	end
end

function GlorybattleModel:getHolyStripeInfo(activityId, creepsId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.challengeInfo.holyStripeInfos) do
		if #v.bindCreepsId ~= 0 and table.indexof(v.bindCreepsId, creepsId) then
			return v
		end
	end
end

function GlorybattleModel:onOperateHolyStripeRes(msg)
	local info = self:getInfo(msg.activityId)

	for i, v in ipairs(info.challengeInfo.holyStripeInfos) do
		if v.holyStripeId == msg.holyStripeId then
			local isAdd = msg.operateType == GlorybattleController.OperateType.Add

			if isAdd then
				table.insert(v.bindCreepsId, msg.creepsId)

				for j, creepsInfo in ipairs(info.challengeInfo.creepsInfos) do
					if creepsInfo.creepsId == msg.creepsId then
						creepsInfo.holyStripeId = msg.holyStripeId

						break
					end
				end
			else
				table.removebyvalue(v.bindCreepsId, msg.creepsId)
			end

			self:_changeNewPetMoIfHad(msg.activityId, msg.creepsId, msg.holyStripeId, isAdd)

			break
		end
	end
end

function GlorybattleModel:isLastPvpUse(activityId, creepsId)
	local info = self:getInfo(activityId)

	if not info.challengeInfo.lastPvpUseCreepsId then
		return false
	end

	if creepsId > self:getPetCardFakePetIdAddNum() then
		return true
	end

	for i, v in ipairs(info.challengeInfo.lastPvpUseCreepsId) do
		if creepsId == v then
			return true
		end
	end
end

function GlorybattleModel:petAwakenLevelUp(activityId, creepsId, num)
	creepsId = checknumber(creepsId)
	num = num or 1

	local info = self:getInfo(activityId)

	for i, v in ipairs(info.challengeInfo.creepsInfos) do
		if creepsId == v.creepsId then
			v.awakenLevel = v.awakenLevel + num

			self:_onPetAwakenLevelUpCalZdl(activityId, creepsId)

			local map = {}

			map[creepsId] = {
				isAwakenLevelUp = true,
				creepsId = creepsId
			}

			GlobalDispatcher:dispatch(GlobalNotify.PetGainOrAwakenEffect, map)

			break
		end
	end
end

function GlorybattleModel:cutepetAddCardExp(activityId)
	local info = self:getInfo(activityId)
	local exp = GlorybattleConfig.instance:getCommonValue("CUTE_PET_UPGRADE_CARD_EXPERIENCE", true)
	local cutePetInfo = info.challengeInfo.cutePetInfo
	local cutePetId = cutePetInfo.cutePetId
	local currExp = cutePetInfo.experience
	local level = cutePetInfo.level
	local cutepetCfg = GlorybattleConfig.instance:getCutePetCfg(cutePetId, level)

	currExp = currExp + exp

	if currExp >= cutepetCfg.upgradeNeedExperience then
		local nextLvCfg = GlorybattleConfig.instance:getCutePetCfg(cutePetId, level + 1)

		if nextLvCfg then
			level = level + 1
			cutePetInfo.level = level
			currExp = nextLvCfg.upgradeNeedExperience <= 0 and 0 or currExp - cutepetCfg.upgradeNeedExperience
			cutePetInfo.experience = currExp

			self:_onCutePetLevelUpCalZdl(activityId)
			GlobalDispatcher:dispatch(GlobalNotify.CutePetLevelUp)
		else
			cutePetInfo.experience = 0
		end
	else
		cutePetInfo.experience = currExp
	end
end

function GlorybattleModel:addPetCard(activityId, petCardId)
	local info = self:getInfo(activityId)
	local isHit = false
	local gainIdx = 0

	for i, v in ipairs(info.challengeInfo.petCardInfos) do
		if v.petCardId == petCardId then
			v.num = v.num + 1
			isHit = true
			gainIdx = v.num

			break
		end
	end

	if not isHit then
		table.insert(info.challengeInfo.petCardInfos, {
			num = 1,
			petCardId = petCardId
		})

		gainIdx = 1
	end

	GlobalDispatcher:dispatch(GlobalNotify.GainNewPetCard, petCardId, gainIdx)
end

function GlorybattleModel:addHolyStripe(activityId, suitId)
	local info = self:getInfo(activityId)
	local isHit = false

	for i, v in ipairs(info.challengeInfo.holyStripeInfos) do
		if v.holyStripeId == suitId then
			v.num = v.num + 1
			isHit = true

			break
		end
	end

	if not isHit then
		table.insert(info.challengeInfo.holyStripeInfos, {
			num = 1,
			holyStripeId = suitId,
			bindCreepsId = {}
		})
	end
end

function GlorybattleModel:_getCreepsInfoLevel(activityId, creepsId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.challengeInfo.creepsInfos) do
		if v.creepsId == creepsId then
			return v.awakenLevel, v.holyStripeId
		end
	end

	return 0, 0
end

function GlorybattleModel:_getCutePetInfoLevel(activityId)
	local info = self:getInfo(activityId)

	if not info.challengeInfo.cutePetInfo then
		return 0, 0
	end

	return info.challengeInfo.cutePetInfo.cutePetId, info.challengeInfo.cutePetInfo.level
end

function GlorybattleModel:_addToPetOrderList(creepsId)
	self._getPetOrderDatas = self._getPetOrderDatas or {}

	local idx = #self._getPetOrderDatas + 1

	table.insert(self._getPetOrderDatas, {
		creepsId = creepsId,
		idx = idx
	})
end

function GlorybattleModel:onBuyGoodsRes(msg)
	local info = self:getInfo(msg.activityId)

	for i, v in ipairs(info.challengeInfo.blockInfo) do
		if v.blockId == msg.blockId then
			local goodsCfg = GlorybattleConfig.instance:getBattleGoodsCfg(v.goodsId)

			if goodsCfg.goodsType == GlorybattleController.GoodsType.PetTryCard then
				local petCardId = goodsCfg.subKey

				self:addPetCard(msg.activityId, petCardId)
			elseif goodsCfg.goodsType == GlorybattleController.GoodsType.HolyStripe then
				local suitId = goodsCfg.subKey

				self:addHolyStripe(msg.activityId, suitId)
			elseif goodsCfg.goodsType == GlorybattleController.GoodsType.CutePetExpCard then
				self:cutepetAddCardExp(msg.activityId)
			end

			v.isBuy = true
			v.isLock = false

			break
		end
	end

	info.challengeInfo.currency = msg.currency
end

function GlorybattleModel:onRankViewRes(msg)
	self._rankViewMsg = msg
end

function GlorybattleModel:getRankViewMsg()
	self._rankViewMsg = nil

	return self._rankViewMsg
end

function GlorybattleModel:onSelectGenreRes(msg)
	local info = self:getInfo(msg.activityId)
	local genreCfg = GlorybattleConfig.instance:getGenreCfg(msg.activityId, msg.genreId)

	info.challengeInfo.cutePetInfo.cutePetId = genreCfg.cutePetId

	self:_onCutePetLevelUpCalZdl(msg.activityId)
end

function GlorybattleModel:isAllPetAwakeLevelMax(activityId)
	local info = self:getInfo(activityId)
	local maxLv = 6

	for i, v in ipairs(info.challengeInfo.creepsInfos) do
		if maxLv > v.awakenLevel then
			return false
		end
	end

	return true
end

GlorybattleModel.instance = GlorybattleModel.New()

return GlorybattleModel
