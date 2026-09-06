-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/controller/HandbookController.lua

module("logic.extensions.handbook.controller.HandbookController", package.seeall)

local HandbookController = class("HandbookController", BaseController)

function HandbookController:ctor()
	return
end

function HandbookController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.BagPetChanged, self.onMatChange, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self.onMatChange, self)
end

function HandbookController:_resetRedPoint()
	PetRankModel.instance:_resetRedPoint()
end

function HandbookController:onReset()
	self._isDataInit = false

	self:_resetRedPoint()
end

function HandbookController:getIsDataInit()
	return self._isDataInit == true
end

function HandbookController:onMatChange()
	local list = MaterialMgr.getModelList(MatType.Pet)

	for k, mo in pairs(list) do
		HandbookModel.instance:onPetMoChange(mo)
	end
end

function HandbookController:checkDataAndCall(handle, handleTarget)
	if self._isDataInit == true then
		GameUtil.callBack(handle, handleTarget)
	else
		PetManualAgent.instance:sendUserPetManualInfoReq(function(msg)
			forcePrint("=====RoleDataRequestor:_loadHandBookInfo===back")
			HandbookModel.instance:onUserPetManualInfoRes(msg)
			PetbookModel.instance:getPetDatas()

			self._isDataInit = true

			GameUtil.callBack(handle, handleTarget)
			GlobalDispatcher:dispatch(GlobalNotify.HandBookInit)
		end)
	end
end

function HandbookController:onTeamChange(msg, status)
	local changeInfos = msg.changeInfos

	BagModel.instance:addTeamInfo(changeInfos)
end

function HandbookController:getPetBasicInfo(skinId)
	local raceId = PetSkinConfig.instance:getPetSkinRaceId(skinId)
	local basic1 = CharacterConfig.instance:getPetCo(skinId) or CharacterConfig.instance:getPetCo(raceId)
	local basic2 = HandbookConfig.instance:getPetDetailsCfgById(skinId) or HandbookConfig.instance:getPetDetailsCfgById(raceId)
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if basic2 == nil then
		return {
			birthday = "未知",
			height = "未知",
			birthplace = "未知",
			weight = "未知",
			name = skinCfg.skinName,
			sex = skinCfg.genderId
		}
	else
		return {
			name = skinCfg.skinName,
			sex = skinCfg.genderId,
			birthday = basic2.birthday,
			height = basic2.height,
			weight = basic2.weight,
			birthplace = basic2.birthplace
		}
	end
end

function HandbookController:numberToChinese(number)
	if number == 1 then
		return "一"
	elseif number == 2 then
		return "二"
	elseif number == 3 then
		return "三"
	elseif number == 4 then
		return "四"
	elseif number == 5 then
		return "五"
	elseif number == 6 then
		return "六"
	elseif number == 7 then
		return "七"
	elseif number == 8 then
		return "八"
	elseif number == 9 then
		return "九"
	elseif number == 10 then
		return "十"
	else
		return ""
	end
end

function HandbookController:getPopWinPetRelationTipsViewAndDataList()
	local viewName = ViewName.PetRelationTipsView
	local wanPercentUp = checknumber(HandbookConfig.instance:getPetCommonCfgs("WAN_PERCENT_UP"))
	local dataList = {}
	local valuePerLimitStr = wanPercentUp / 100 .. "%"
	local txtCont_1 = langPara("HandBookAttrTips_1", valuePerLimitStr)

	if txtCont_1 ~= "HandBookAttrTips_1" then
		local data = {}

		data.txtCont = txtCont_1

		table.insert(dataList, data)
	end

	local txtCont_2 = lang("HandBookAttrTips_2")

	if txtCont_2 ~= "HandBookAttrTips_2" then
		local data = {}

		data.txtCont = txtCont_2

		table.insert(dataList, data)
	end

	return viewName, dataList
end

function HandbookController:isActivePet(raceId)
	local level = HandbookModel.instance:getAttributeLevel(raceId)
	local isHas = HandbookModel.instance:isHasPet(raceId)

	return isHas and level > -1
end

function HandbookController:activatePetBenefit(raceId, callback)
	PetManualAgent.instance:sendPetBenefitActivateReq(raceId, function()
		HandbookModel.instance:setAttributeLevel(raceId, 0)
		GameUtil.callBack(callback)
		GlobalDispatcher:dispatch(GlobalNotify.HandBookAttributeChange, raceId)
	end)
end

function HandbookController:upgradePetBenefit(raceId, callback)
	PetManualAgent.instance:sendPetBenefitUpgradeReq(raceId, function()
		local attLevel = HandbookModel.instance:getAttributeLevel(raceId)

		HandbookModel.instance:setAttributeLevel(raceId, attLevel + 1)
		GameUtil.callBack(callback)
		GlobalDispatcher:dispatch(GlobalNotify.HandBookAttributeChange, raceId)
	end)
end

function HandbookController:getIfCanActive(RaceId)
	if not RaceId or not RaceId then
		::label_18_0::

		local raceId = PetbookModel.instance:getSelectedPetRaceId()
		local attLevel = HandbookModel.instance:getAttributeLevel(raceId)
		local has = HandbookModel.instance:isHasPet(raceId)

		return attLevel == -1 and has
	end
end

function HandbookController:getIfCanActiveOrUpgrade(RaceId)
	if not RaceId or not RaceId then
		::label_19_0::

		local raceId = PetbookModel.instance:getSelectedPetRaceId()
		local highestLevel = checknumber(HandbookModel.instance:getAwakenNum(raceId))
		local attLevel = HandbookModel.instance:getAttributeLevel(raceId)
		local has = HandbookModel.instance:isHasPet(raceId)
		local cfg = HandbookConfig.instance:getPetDetailsCfgById(raceId)

		if cfg and checknumber(cfg.unproved) == 1 then
			return false
		end

		if has and attLevel < highestLevel then
			local canLvlUp = attLevel > -1

			return true, canLvlUp
		else
			return false
		end
	end
end

function HandbookController:calculateSumAttrOther(petMo)
	local lifeSum, attackSum, defendSum, magicSum = 0, 0, 0, 0

	if petMo and petMo.benefitInfoList and petMo.benefitInfoList.benefitInfo then
		for i, info in ipairs(petMo.benefitInfoList.benefitInfo) do
			local attLevel = info.benefitLv

			if attLevel >= 0 then
				local manualBenefitId = info.benefitId
				local cfg = HandbookConfig.instance:getBenefitCfg(manualBenefitId, attLevel)

				if cfg then
					local propertyParam = {
						cfg.formulaPropertyType
					}

					for k, v in pairs(propertyParam) do
						local tempStr = string.split(v, "#")
						local tempStr2 = string.split(cfg.formulaWanPercent, "#")
						local type = tempStr[1]

						if type == GameEnum.AttrTypeName[1] then
							lifeSum = lifeSum + checknumber(tempStr2[1]) * info.num
						elseif type == GameEnum.AttrTypeName[15] then
							attackSum = attackSum + checknumber(tempStr2[1]) * info.num
						elseif type == GameEnum.AttrTypeName[3] then
							defendSum = defendSum + checknumber(tempStr2[1]) * info.num
						elseif type == GameEnum.AttrTypeName[5] then
							magicSum = magicSum + checknumber(tempStr2[1]) * info.num
						end
					end
				end
			end
		end
	end

	local wanPercentUp = checknumber(HandbookConfig.instance:getPetCommonCfgs("WAN_PERCENT_UP"))

	lifeSum = Mathf.Clamp(lifeSum, 0, wanPercentUp)
	attackSum = Mathf.Clamp(attackSum, 0, wanPercentUp)
	defendSum = Mathf.Clamp(defendSum, 0, wanPercentUp)
	magicSum = Mathf.Clamp(magicSum, 0, wanPercentUp)

	return lifeSum / 100, attackSum / 100, defendSum / 100, magicSum / 100
end

function HandbookController:calculateSumFixAttrOther(petMo)
	local fixLifeSum, fixAttackSum, fixDefendSum, fixMagicSum = 0, 0, 0, 0

	if petMo == nil or petMo.benefitInfoList == nil or petMo.benefitInfoList.benefitInfo == nil then
		return
	end

	for _, info in pairs(petMo.benefitInfoList.benefitInfo) do
		local beneFitCfg
		local manualBenefitId = info.benefitId
		local benefitLv = info.benefitLv

		if benefitLv >= 0 then
			beneFitCfg = HandbookConfig.instance:getBenefitCfg(manualBenefitId, benefitLv)
		end

		if beneFitCfg then
			local propertyArr = string.split(beneFitCfg.propertyParam, "#")
			local tempArr
			local attrValue = 0

			for _, propertyStr in ipairs(propertyArr) do
				tempArr = string.split(propertyStr, "+")
				attrValue = checknumber(tempArr[2])

				if tempArr[1] == GameEnum.AttrTypeName[1] then
					fixLifeSum = fixLifeSum + attrValue * info.num
				elseif tempArr[1] == GameEnum.AttrTypeName[15] then
					fixAttackSum = fixAttackSum + attrValue * info.num
				elseif tempArr[1] == GameEnum.AttrTypeName[3] then
					fixDefendSum = fixDefendSum + attrValue * info.num
				elseif tempArr[1] == GameEnum.AttrTypeName[5] then
					fixMagicSum = fixMagicSum + attrValue * info.num
				end
			end
		end
	end

	return fixLifeSum, fixAttackSum, fixDefendSum, fixMagicSum
end

function HandbookController:calculateSumAttr()
	local lifeSum, attackSum, defendSum, magicSum = 0, 0, 0, 0
	local allPetCfgs = CharacterConfig.instance:getPetCfg()

	for k, v in pairs(allPetCfgs) do
		local raceId = v.raceId

		if checknumber(v.bookIds) ~= 0 and HandbookModel.instance:isHasPet(raceId) then
			local attLevel = HandbookModel.instance:getAttributeLevel(raceId)

			if attLevel >= 0 then
				local petCo = CharacterConfig.instance:getPetCo(raceId)
				local manualBenefitId = petCo.manualBenefitId
				local cfg = HandbookConfig.instance:getBenefitCfg(manualBenefitId, attLevel)

				if cfg then
					local propertyParam = {
						cfg.formulaPropertyType
					}

					for k, v in pairs(propertyParam) do
						local tempStr = string.split(v, "#")
						local tempStr2 = string.split(cfg.formulaWanPercent, "#")
						local type = tempStr[1]

						if type == GameEnum.AttrTypeName[1] then
							lifeSum = lifeSum + checknumber(tempStr2[1])
						elseif type == GameEnum.AttrTypeName[15] then
							attackSum = attackSum + checknumber(tempStr2[1])
						elseif type == GameEnum.AttrTypeName[3] then
							defendSum = defendSum + checknumber(tempStr2[1])
						elseif type == GameEnum.AttrTypeName[5] then
							magicSum = magicSum + checknumber(tempStr2[1])
						end
					end
				end
			end
		end
	end

	local wanPercentUp = checknumber(HandbookConfig.instance:getPetCommonCfgs("WAN_PERCENT_UP"))

	lifeSum = Mathf.Clamp(lifeSum, 0, wanPercentUp)
	attackSum = Mathf.Clamp(attackSum, 0, wanPercentUp)
	defendSum = Mathf.Clamp(defendSum, 0, wanPercentUp)
	magicSum = Mathf.Clamp(magicSum, 0, wanPercentUp)

	return lifeSum / 100, attackSum / 100, defendSum / 100, magicSum / 100
end

function HandbookController:calculateSumFixAttr()
	local fixLifeSum, fixAttackSum, fixDefendSum, fixMagicSum = 0, 0, 0, 0
	local allPetCfgs = CharacterConfig.instance:getPetCfg()

	for _, petData in pairs(allPetCfgs) do
		local raceId = petData.raceId
		local isHasBookId = checknumber(petData.bookIds) ~= 0
		local isBookHavePet = HandbookModel.instance:isHasPet(raceId)
		local beneFitCfg

		if isHasBookId and isBookHavePet then
			local benefitLv = HandbookModel.instance:getAttributeLevel(raceId)
			local petCo = CharacterConfig.instance:getPetCo(raceId)
			local manualBenefitId = petCo.manualBenefitId

			beneFitCfg = HandbookConfig.instance:getBenefitCfg(manualBenefitId, benefitLv)
		end

		if beneFitCfg then
			local propertyArr = string.split(beneFitCfg.propertyParam, "#")
			local tempArr
			local attrName = ""
			local attrValue = 0

			for _, propertyStr in ipairs(propertyArr) do
				tempArr = string.split(propertyStr, "+")
				attrName = tempArr[1]
				attrValue = checknumber(tempArr[2])

				if tempArr[1] == GameEnum.AttrTypeName[1] then
					fixLifeSum = fixLifeSum + attrValue
				elseif attrName == GameEnum.AttrTypeName[15] then
					fixAttackSum = fixAttackSum + attrValue
				elseif attrName == GameEnum.AttrTypeName[3] then
					fixDefendSum = fixDefendSum + attrValue
				elseif attrName == GameEnum.AttrTypeName[5] then
					fixMagicSum = fixMagicSum + attrValue
				end
			end
		end
	end

	return fixLifeSum, fixAttackSum, fixDefendSum, fixMagicSum
end

function HandbookController:getcalculateSumAttrTextByRaceId(raceId, startLv)
	local propertyStrList = {}
	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local isHasBookId = checknumber(petCo.bookIds) ~= 0
	local isBookHavePet = HandbookModel.instance:isHasPet(raceId)
	local beneFitCfg, startFitCfg

	if isHasBookId and isBookHavePet then
		local benefitLv = HandbookModel.instance:getAttributeLevel(raceId)
		local petCo = CharacterConfig.instance:getPetCo(raceId)
		local manualBenefitId = petCo.manualBenefitId

		beneFitCfg = HandbookConfig.instance:getBenefitCfg(manualBenefitId, benefitLv)
		startFitCfg = HandbookConfig.instance:getBenefitCfg(manualBenefitId, startLv >= 0 and startLv or 0) or {}
	end

	if beneFitCfg then
		local propertyArr = string.split(beneFitCfg.propertyParam, "#")
		local startPropertyArr = string.split(startFitCfg.propertyParam or "", "#")
		local formulaWanPercent1 = checknumber(string.split(beneFitCfg.formulaWanPercent, "#")[1])
		local startFormulaWanPercent = checknumber(string.split((not startFitCfg.formulaWanPercent or nil) and "", "#")[1])

		for i, propertyStr in ipairs(propertyArr) do
			local startPropertyStr = startPropertyArr[i]
			local list = {}
			local tempArr = string.split(propertyStr, "+")
			local tempStartArr = string.split(startPropertyStr, "+")

			if #tempArr > 1 and #tempStartArr > 1 then
				list.name = tempArr[1]
				list.startProperty = tempStartArr[2]
				list.property = tempArr[2]

				table.insert(propertyStrList, list)
			end
		end

		local strList = {}

		strList.name = string.split(beneFitCfg.formulaPropertyType, "#")[1]
		strList.startProperty = lang(startFormulaWanPercent / 100) .. "%"
		strList.property = lang(formulaWanPercent1 / 100) .. "%"

		table.insert(propertyStrList, strList)
	end

	return propertyStrList
end

HandbookController.instance = HandbookController.New()

return HandbookController
