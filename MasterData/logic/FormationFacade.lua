-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/facade/FormationFacade.lua

module("logic.extensions.formation.facade.FormationFacade", package.seeall)

local FormationFacade = class("FormationFacade", BaseFacade)

function FormationFacade:loadFormations()
	FormationAgent.instance:sendPM_LoadUserAllFormsReq()
end

function FormationFacade:setTabNameReq(tabId, newTabName, handler, handlerObj, errHandler)
	FormationAgent.instance:sendPM_SetTabNameReq(tabId, newTabName, handler, handlerObj, errHandler)
end

function FormationFacade:upgradeNinePlaceForm(formId)
	FormationAgent.instance:sendPM_UpgradeFormStrengthReq(formId)
end

function FormationFacade:getCurFormation()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation()
end

function FormationFacade:getCurPositions()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation():GetPositions()
end

function FormationFacade:isCurFormationEmpty()
	return FormationModel.instance:isCurFormationEmpty()
end

function FormationFacade:getHeroSkill()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation():GetHeroSkillId()
end

function FormationFacade:checkFormationEmpty()
	if self:isCurFormationEmpty() then
		TipsFacade.instance:openTipWindow(lang("tip"), lang("fight_unformation"), function()
			return
		end, lang("fight_goto_fmt"))

		return true
	end
end

function FormationFacade:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack, formationMo, petsNum)
	local numPos, otherNum = self:curFormationPetNum(formationMo)
	local curFormId = FormationModel.instance:getCurFormId()
	local formationCo = BattleConfig.instance:getFormationCo(curFormId)
	local totalPos = MissionModel.instance:getMaxPetNum()

	if petsNum == nil then
		petsNum = BagModel.instance:diffRacePetCount()
	end

	local showNum = -1
	local boo = false

	if totalPos <= petsNum and numPos < totalPos then
		boo = true
		showNum = totalPos

		if numPos + otherNum == 9 then
			boo = false
			showNum = -1
		end
	elseif petsNum < totalPos and petsNum > 0 and numPos < petsNum then
		boo = true
		showNum = petsNum
	end

	if showNum > 0 then
		if hasOneKey then
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), posLimitCallback, onekeyCallBack, lang("确定"), lang("一键布阵"))
		else
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), posLimitCallback)
		end
	end

	return boo
end

function FormationFacade:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if self:checkFormationEmpty() then
		return true
	end

	return self:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack)
end

function FormationFacade:checkFormationEmptyAndPosNumLimitByFmo(formationMo, posLimitCallback, hasOneKey, onekeyCallBack)
	if self:checkFormationEmptyByFmo(formationMo) then
		return true
	end

	return self:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack, formationMo)
end

function FormationFacade:checkFormationEmptyByFmo(formation)
	if not formation then
		return true
	end

	return formation:isEmpty()
end

function FormationFacade:curFormationPetNum(formationMo, isNeedSummonPet)
	local number = 0
	local otherNum = 0

	if formationMo then
		number, otherNum = formationMo:getCurExistPetNumber(isNeedSummonPet)
	else
		local fmo = FormationNewModel.instance:GetCurTeam():GetCurFormation()

		if fmo then
			number, otherNum = fmo:getCurExistPetNumber(isNeedSummonPet)
		end
	end

	return number, otherNum
end

function FormationFacade.createFormPb(formPb, formMo)
	if formPb == nil then
		formPb = FormationExtension_pb.PM_SimpleForm()
	end

	for i = 1, 9 do
		formPb.pos:append((formMo or nil) and checknumber(formMo:GetPosition(i)))
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

		formPb.extParams.elementalMasterId = formMo:GetElementalMasterId()
		formPb.extParams.elementalTargetId = formMo:GetElementalTargetId()
		formPb.extParams.cutePetId = formMo:GetCutePetId()
		formPb.extParams.cutePetRaceId = formMo:GetCutePetRaceId()
		formPb.extParams.cutePetQuality = formMo:GetCutePetQuality()
		formPb.extParams.heavenAwakenMasterId = formMo:GetHeavenAwakenMasterId()
		formPb.extParams.heavenAwakenSummonPetId = formMo:GetHeavenAwakenSummonPetId()
		formPb.extParams.summonMasterPetId = formMo:GetSummonMasterPetId()
		formPb.extParams.summonedPetId = formMo:GetSummonPetId()
		formPb.extParams.spiritInvocationPetId = formMo:GetSpiritInvocationPetId()

		if formPb.extParams.summonMasterPetId <= 0 or formPb.extParams.summonedPetId <= 0 then
			formPb.extParams.summonMasterPetId = 0
			formPb.extParams.summonedPetId = 0
		end
	end

	FormationFacade.SetChangeRaceTypes(formPb, formMo)

	return formPb
end

function FormationFacade.SetChangeRaceTypes(formPb, formMo)
	if formMo then
		local types = formMo:GetChangeRaceTypes()

		for i, v in ipairs(types or {}) do
			if not string.nilorempty(v.raceType) and GameEnum.Races[v.raceType] ~= GameEnum.RaceType.Yuan and formMo:HasPet(v.petId) then
				local pb = formPb.extParams.changeRaceTypes:add()

				pb.petId = v.petId
				pb.raceType = v.raceType
			end
		end
	end
end

FormationFacade.instance = FormationFacade.New()

return FormationFacade
