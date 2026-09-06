-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/controller/GlorybattleController.lua

module("logic.extensions.glorybattle.controller.GlorybattleController", package.seeall)

local GlorybattleController = class("GlorybattleController", BaseController)

GlorybattleController.CurrencyKey = "GlorybattleController_"
GlorybattleController.LockType = {
	Lock = 1,
	UnLock = 2
}
GlorybattleController.GoodsType = {
	CutePetExpCard = 5,
	PetLvUpCard = 6,
	RandomGenrePet = 3,
	PetTryCard = 1,
	RandomPet = 7,
	HolyStripe = 2,
	RandomAttrPet = 4
}
GlorybattleController.OperateType = {
	Add = 1,
	Delete = 2
}
GlorybattleController.ResultType = {
	GiveUp = 4,
	Single = 2,
	Report = 1,
	Total = 3
}
GlorybattleController.Step = {
	Two = 2,
	One = 1,
	Three = 3,
	None = 0
}
GlorybattleController.Key_GetPetOrder = "GlorybattleController.Key_GetPetOrder"

function GlorybattleController:ctor()
	return
end

function GlorybattleController:onInit()
	self:onReset()
end

function GlorybattleController:onReset()
	self._needAutoAddHolyStripeData = false
	self._lastSendFightReqTime = nil
end

function GlorybattleController:enterMission(activityId)
	local fmtMo = GlorybattleModel.instance:getFmtMo()

	fmtMo:initParams(activityId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function GlorybattleController:_getTryCreepsIds(activityId)
	local creepsIds = {}
	local info = GlorybattleModel.instance:getInfo(activityId)
	local petCardInfos = info.challengeInfo.petCardInfos

	for i, v in ipairs(petCardInfos) do
		local cfg = GlorybattleConfig.instance:getPetCardCfg(activityId, v.petCardId)

		table.insert(creepsIds, cfg.creepsId)
	end

	return creepsIds
end

function GlorybattleController:_getTryCreepsRealRaceIds(activityId)
	local raceIds = {}
	local info = GlorybattleModel.instance:getInfo(activityId)
	local petCardInfos = info.challengeInfo.petCardInfos

	for i, v in ipairs(petCardInfos) do
		local cfg = GlorybattleConfig.instance:getPetCardCfg(activityId, v.petCardId)
		local creepsId = cfg.creepsId
		local battlePetCfg = GlorybattleConfig.instance:getBattlePetCfg(activityId, creepsId)

		table.insert(raceIds, battlePetCfg.raceId)
	end

	return raceIds
end

function GlorybattleController:_getTotalFightCreesIds(activityId)
	local creepsIds = {}
	local info = GlorybattleModel.instance:getInfo(activityId)
	local creepsInfos = info.challengeInfo.creepsInfos
	local petCardInfos = info.challengeInfo.petCardInfos

	for i, v in ipairs(creepsInfos) do
		table.insert(creepsIds, v.creepsId)
	end

	for i, v in ipairs(petCardInfos) do
		local cfg = GlorybattleConfig.instance:getPetCardCfg(activityId, v.petCardId)

		table.insert(creepsIds, cfg.creepsId)
	end

	return creepsIds
end

function GlorybattleController:onGiveUpRes(msg)
	local info = GlorybattleModel.instance:getInfo(msg.activityId)
	local curRound = info.challengeInfo.curRound
	local cutePetExp = GlorybattleConfig.instance:getCommonValue("BATTLE_GAIN_CUTE_PET_EXPERIENCE", true) * curRound
	local maxHp = GlorybattleConfig.instance:getCommonValue("ORIGIN_BLOOD", true)
	local decBloodNum = info.challengeInfo.decBloodNum
	local winNum = curRound - decBloodNum
	local openParams = {
		isWin = false,
		winNum = winNum,
		decBloodNum = decBloodNum,
		cutePetLv = info.challengeInfo.cutePetInfo.level,
		cutePetId = info.challengeInfo.cutePetInfo.cutePetId,
		lastTotalScore = info.totalScore,
		currTotalScore = msg.totalScore,
		genreId = info.challengeInfo.genreId,
		creepsIds = self:_getTotalFightCreesIds(msg.activityId),
		petTryCreepsIds = self:_getTryCreepsIds(msg.activityId)
	}
	local resultType = GlorybattleController.ResultType.GiveUp

	UIStateManager.instance:push(ViewName.GlorybattleresultView, msg.activityId, resultType, openParams)
end

function GlorybattleController:onNotifyFightRes(msg)
	local info = GlorybattleModel.instance:getInfo(msg.activityId)
	local openParams, resultType
	local curRound = info.challengeInfo.curRound + 1
	local cutePetExp = GlorybattleConfig.instance:getCommonValue("BATTLE_GAIN_CUTE_PET_EXPERIENCE", true) * curRound

	if msg.challengeInfo.genreId == 0 then
		UIJumper.instance:removeTopState(ViewName.GlorybattleshopView)

		local maxHp = GlorybattleConfig.instance:getCommonValue("ORIGIN_BLOOD", true)
		local decBloodNum = info.challengeInfo.decBloodNum

		if not msg.isWin then
			decBloodNum = decBloodNum + 1
		end

		local winNum = curRound - decBloodNum

		openParams = {
			winNum = winNum,
			decBloodNum = decBloodNum,
			cutePetLv = GlorybattleConfig.instance:getCutePetLevel(info.challengeInfo.cutePetInfo.cutePetId, cutePetExp),
			cutePetId = info.challengeInfo.cutePetInfo.cutePetId,
			lastTotalScore = info.totalScore,
			genreId = info.challengeInfo.genreId,
			isWin = decBloodNum < maxHp,
			creepsIds = self:_getTotalFightCreesIds(msg.activityId),
			petTryCreepsIds = self:_getTryCreepsIds(msg.activityId)
		}
		resultType = GlorybattleController.ResultType.Total
	else
		local creepsIds = {}
		local positions = GlorybattleModel.instance:getFmtMo():getCurFormation():GetPositions()

		for i, petId in ipairs(positions) do
			if petId > 0 then
				local realPetId = GlorybattleModel.instance:petIdFakeChangeRealPetId(petId)

				table.insert(creepsIds, realPetId)
			end
		end

		openParams = {
			lastCurrency = info.challengeInfo.currency,
			cutePetExp = cutePetExp,
			isWin = msg.isWin,
			creepsIds = creepsIds,
			petTryCreepsIds = self:_getTryCreepsIds(msg.activityId)
		}
		resultType = GlorybattleController.ResultType.Single
	end

	GlorybattleModel.instance:onNotifyFightRes(msg)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)
		UIStateManager.instance:push(ViewName.GlorybattleresultView, msg.activityId, resultType, openParams)

		return true
	end)
end

function GlorybattleController:getShopLvTips(activityId, genreId, round)
	local tipsTable = {
		"等级越高，货物品质越高"
	}
	local genreCfg = GlorybattleConfig.instance:getGenreCfg(activityId, genreId)
	local planCfgs = GlorybattleConfig.instance:getShopPlanCfgs(genreCfg.shopPlan)

	for i = 1, #planCfgs - 1 do
		table.insert(tipsTable, string.format("完成%s局战斗后，提升至%s级", planCfgs[i].round + 1, planCfgs[i + 1].level))
	end

	return table.concat(tipsTable, "\n")
end

function GlorybattleController:calCutePetNextLvExpSliderValue(cutePetId, level, experience)
	local cutePetLvCfg = GlorybattleConfig.instance:getCutePetCfg(cutePetId, level)

	if experience >= cutePetLvCfg.upgradeNeedExperience then
		return 1
	else
		return experience / cutePetLvCfg.upgradeNeedExperience
	end

	return 1
end

function GlorybattleController:getShopItemIconUrl(activityId, goodsCfg, blockInfo)
	if goodsCfg.clientItemId > 0 and not goodsCfg.goodsType == GlorybattleController.GoodsType.RandomAttrPet then
		local fakeItemCfg = ItemConfig.instance:getFakeCfgById(goodsCfg.clientItemId)

		return GameUrl.getItemIconUrl(fakeItemCfg.icon)
	end

	if goodsCfg.goodsType == GlorybattleController.GoodsType.PetTryCard then
		local petCardCfg = GlorybattleConfig.instance:getPetCardCfg(activityId, goodsCfg.subKey)
		local petCfg = GlorybattleConfig.instance:getBattlePetCfg(activityId, petCardCfg.creepsId)
		local faceId = checknumber(petCfg.faceId)
		local modelCo = CharacterConfig.instance:getModelCo((faceId > 0 or nil) and faceId)

		return GameUrl.getCharacterIconUrl(modelCo.headName)
	elseif goodsCfg.goodsType == GlorybattleController.GoodsType.HolyStripe then
		local suitCfg = GlorybattleConfig.instance:getHolyStripeSuitCfg(goodsCfg.subKey)

		return string.format("%s.png", suitCfg.iconUrl)
	elseif goodsCfg.goodsType == GlorybattleController.GoodsType.RandomGenrePet then
		local creepsId = blockInfo.extParam
		local petCfg = GlorybattleConfig.instance:getBattlePetCfg(activityId, creepsId)
		local faceId = checknumber(petCfg.faceId)
		local modelCo = CharacterConfig.instance:getModelCo((faceId > 0 or nil) and faceId)

		return GameUrl.getCharacterIconUrl(modelCo.headName)
	elseif goodsCfg.goodsType == GlorybattleController.GoodsType.RandomAttrPet then
		local id = checknumber(blockInfo.extParam)

		if id > 0 then
			local cfg = GlorybattleConfig.instance:getAttributeCfg(id)

			return GameUrl.getItemIconUrl(cfg.iconName)
		else
			return GameUrl.getItemIconUrl("icon_chuanshuodaoju_cai")
		end
	elseif goodsCfg.goodsType == GlorybattleController.GoodsType.CutePetExpCard then
		return GameUrl.getItemIconUrl("icon_xingyunxing")
	elseif goodsCfg.goodsType == GlorybattleController.GoodsType.PetLvUpCard then
		return GameUrl.getItemIconUrl("icon_chuanshuoujuexinzhihun_0")
	elseif goodsCfg.goodsType == GlorybattleController.GoodsType.RandomPet then
		return GameUrl.getItemIconUrl("icon_chuanshuodaoju_cai")
	end

	return ""
end

function GlorybattleController:sendPM_GloryBattleFightReq(activityId, formationMo, isFinal)
	local simpleForm = GlorybattleController.instance:createFormPb(nil, formationMo)
	local positions = formationMo:GetPositions()
	local usePetCardIdList = {}
	local addNum = GlorybattleModel.instance:getPetCardFakePetIdAddNum()

	for i, v in ipairs(positions) do
		if addNum < v then
			local realPetId = GlorybattleModel:petIdFakeChangeRealPetCardId(v)

			table.insert(usePetCardIdList, realPetId)
		end
	end

	if isFinal then
		local nowTime = ServerTime.now()

		if self._lastSendFightReqTime and nowTime - self._lastSendFightReqTime < 3 then
			return
		end

		self._lastSendFightReqTime = nowTime

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		GloryBattleAgent.instance:sendPM_GloryBattleFightReq(activityId, simpleForm, usePetCardIdList)
	else
		GlorybattleController.instance:sendPM_GloryBattleSaveFormationReq(activityId, simpleForm, usePetCardIdList)
	end
end

function GlorybattleController:onFightRes(status)
	if status ~= 0 then
		self._lastSendFightReqTime = nil
	end
end

function GlorybattleController:sendPM_GloryBattleSaveFormationReq(activityId, simpleForm, usePetCardIdList)
	GloryBattleAgent.instance:sendPM_GloryBattleSaveFormationReq(activityId, simpleForm, usePetCardIdList)
end

function GlorybattleController:_getRealPetId(petId)
	if petId > GlorybattleModel.instance:getPetCardFakePetIdAddNum() then
		return GlorybattleModel.instance:petIdFakeChangeRealPetId(petId)
	end

	return petId
end

function GlorybattleController:createFormPb(formPb, formMo)
	if formPb == nil then
		formPb = FormationExtension_pb.PM_SimpleForm()
	end

	for i = 1, 9 do
		local petId = 0

		if formMo then
			petId = checknumber(formMo:GetPosition(i))
		end

		petId = self:_getRealPetId(petId)

		formPb.pos:append(petId)
	end

	if formMo then
		formPb.formId = formMo:GetId()
		formPb.extParams.heroSkillId = formMo:GetHeroSkillId()
		formPb.extParams.psychicSkillId = formMo:GetPsychicedSkillId()

		local info = formMo:GetFormStrengthInfo()

		if info then
			formPb.extParams.formStrengthId = checknumber(info.formStrengthId)
			formPb.extParams.formStrengthLv = checknumber(info.formStrengthLv)
		end

		formPb.extParams.elementalMasterId = self:_getRealPetId(formMo:GetElementalMasterId())
		formPb.extParams.elementalTargetId = self:_getRealPetId(formMo:GetElementalTargetId())
		formPb.extParams.cutePetId = formMo:GetCutePetId()
		formPb.extParams.cutePetRaceId = formMo:GetCutePetRaceId()
		formPb.extParams.cutePetQuality = formMo:GetCutePetQuality()
		formPb.extParams.heavenAwakenMasterId = self:_getRealPetId(formMo:GetHeavenAwakenMasterId())
		formPb.extParams.heavenAwakenSummonPetId = self:_getRealPetId(formMo:GetHeavenAwakenSummonPetId())
		formPb.extParams.summonMasterPetId = self:_getRealPetId(formMo:GetSummonMasterPetId())
		formPb.extParams.summonedPetId = self:_getRealPetId(formMo:GetSummonPetId())

		if formPb.extParams.summonMasterPetId <= 0 or formPb.extParams.summonedPetId <= 0 then
			formPb.extParams.summonMasterPetId = 0
			formPb.extParams.summonedPetId = 0
		end
	end

	GlorybattleController.instance:SetChangeRaceTypes(formPb, formMo)

	return formPb
end

function GlorybattleController:SetChangeRaceTypes(formPb, formMo)
	if formMo then
		local types = formMo:GetChangeRaceTypes()

		for i, v in ipairs(types or {}) do
			if not string.nilorempty(v.raceType) and GameEnum.Races[v.raceType] ~= GameEnum.RaceType.Yuan and formMo:HasPet(v.petId) then
				local petId = self:_getRealPetId(v.petId)
				local pb = formPb.extParams.changeRaceTypes:add()

				pb.petId = petId
				pb.raceType = v.raceType
			end
		end
	end
end

function GlorybattleController:sendPM_GloryBattleReplaceHolyStripeReq(activityId, creepsId, oldHolyStripeId, newHolyStripeId)
	self._needAutoAddHolyStripeData = {
		activityId = activityId,
		creepsId = creepsId,
		holyStripeId = newHolyStripeId
	}

	GloryBattleAgent.instance:sendPM_GloryBattleOperateHolyStripeReq(activityId, creepsId, oldHolyStripeId, GlorybattleController.OperateType.Delete)
end

function GlorybattleController:onOperateHolyStripeRes(msg)
	if self._needAutoAddHolyStripeData then
		local data = self._needAutoAddHolyStripeData

		self._needAutoAddHolyStripeData = false

		if msg.operateType == GlorybattleController.OperateType.Delete then
			GloryBattleAgent.instance:sendPM_GloryBattleOperateHolyStripeReq(data.activityId, data.creepsId, data.holyStripeId, GlorybattleController.OperateType.Add)
		end
	end
end

function GlorybattleController:getItemCost(activityId, blockId)
	local info = GlorybattleModel.instance:getInfo(activityId)
	local goodsId = 0

	for i, v in ipairs(info.challengeInfo.blockInfo) do
		if v.blockId == blockId then
			goodsId = v.goodsId
		end
	end

	local goodCfg = GlorybattleConfig.instance:getBattleGoodsCfg(goodsId)

	if goodCfg then
		return goodCfg.cost
	end

	return 0
end

function GlorybattleController:sendPM_GloryBattleBuyGoodsReq(activityId, blockId)
	local key = "GlorybattleController_" .. activityId
	local info = GlorybattleModel.instance:getInfo(activityId)
	local cost = self:getItemCost(activityId, blockId)
	local forecastCurrency = info.challengeInfo.currency - cost

	GameUtil.saveUserData(key, forecastCurrency)
	GloryBattleAgent.instance:sendPM_GloryBattleBuyGoodsReq(activityId, blockId)
end

GlorybattleController.instance = GlorybattleController.New()

return GlorybattleController
