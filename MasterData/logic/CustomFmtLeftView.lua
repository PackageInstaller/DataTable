-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/customfmt/view/CustomFmtLeftView.lua

module("logic.extensions.customfmt.view.CustomFmtLeftView", package.seeall)

local CustomFmtLeftView = class("CustomFmtLeftView", FormationLeftView)

function CustomFmtLeftView:onEnter()
	self.customFmtMo = self:getFirstParam()

	self.customFmtMo:autoCloneFormation()
	CustomFmtLeftView.super.onEnter(self)
	self:_setActiveBtnFormation(self.customFmtMo.isShowBtnFormation)
	self:_setActiveBtnFormationUse(self.customFmtMo.isShowBtnFormationUse)
	self:_setActiveBtnFormationEdit(self.customFmtMo.isShowBtnFormationEdit)
	self:setBtnContractActive(self.customFmtMo.isShowBtnContractPet)
	self:setBtnFormActive(self.customFmtMo.isShowBtnBuffForm)
	self:setBtnCutePetActive(self.customFmtMo.isShowBtnCutePet)
	GlobalDispatcher:addListener(GlobalNotify.ForceChangeCurFormTab, self._OnTeamChanged, self)
end

function CustomFmtLeftView:_initFixedPos()
	local fixedPosList = self.customFmtMo:getFixedPosList()

	self:_setFixedPos(fixedPosList)
end

function CustomFmtLeftView:_initFixedEffs()
	self:_setFixedEffs(self.customFmtMo.fixedEffMap)
end

function CustomFmtLeftView:onExit()
	CustomFmtLeftView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ForceChangeCurFormTab, self._OnTeamChanged, self)
end

function CustomFmtLeftView:_getCurFormation()
	return (self.customFmtMo:getCurFormation())
end

function CustomFmtLeftView:_OnClickBtnFormationEidt()
	self.customFmtMo:onBeforeEditFmt()
	UIStateManager.instance:push(ViewName.FormationgroupView, FormationgroupView.TYPE_EDITOR)
end

function CustomFmtLeftView:checkPetIsForbit(petId)
	local petMo = self:_getPet(petId)

	if petMo then
		if petMo:isExist() then
			return self.customFmtMo:checkPetIsForbit(petMo)
		else
			return true
		end
	end

	if petId > 0 and petMo == nil then
		return true
	end

	return false
end

function CustomFmtLeftView:_getPet(id)
	return (self.customFmtMo:getPetMoById(id))
end

function CustomFmtLeftView:_saveCurrFmt()
	FormationController.instance:SaveFormationEx()
	self.customFmtMo:autoExitFormation()
end

function CustomFmtLeftView:onCancelContractInfo(summonMasterId, summonedPetId)
	return
end

function CustomFmtLeftView:onSetContractInfo(summonMasterId, summonedPetId)
	return
end

function CustomFmtLeftView:getSummonPetLimitLvl()
	return self.customFmtMo:getSummonPetLimitLvl()
end

function CustomFmtLeftView:getSummonMasterPets()
	local masterMoList = {}
	local cusMasterMo
	local formationMo = self:_getCurFormation()
	local positions = self:_getCurPositions()
	local limitLv = self:getSummonPetLimitLvl()
	local masterId = formationMo:GetSummonMasterPetId()

	for i, v in ipairs(positions) do
		if v > 0 then
			local petMo = self:_getPet(v)

			if petMo then
				if petMo.petId == masterId then
					cusMasterMo = petMo
				end

				if PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Zhaohuanshi) then
					if petMo.isMyPackPet and limitLv <= petMo.level then
						table.insert(masterMoList, petMo)
					elseif self.customFmtMo:checkIsSummonMasterPetsNotInBag(petMo, limitLv) then
						if self.customFmtMo.checkPetIsInOtherTab ~= nil then
							if not self.customFmtMo:checkPetIsInOtherTab(petMo) then
								table.insert(masterMoList, petMo)
							end
						else
							table.insert(masterMoList, petMo)
						end
					end
				end
			end
		end
	end

	return masterMoList, cusMasterMo
end

function CustomFmtLeftView:getSummonPetList()
	if self.customFmtMo.checkPetIsInOtherTab ~= nil then
		local list = {}

		for i, petMo in ipairs(self.customFmtMo:getAllShowPetList() or {}) do
			if not self.customFmtMo:checkPetIsInOtherTab(petMo) then
				table.insert(list, petMo)
			end
		end

		return list
	else
		return self.customFmtMo:getAllShowPetList()
	end
end

function CustomFmtLeftView:isUseMaxStreng()
	return self.customFmtMo:isUseMaxStreng()
end

function CustomFmtLeftView:_beforeUseFormationMo()
	local teamId = self:_getCurFormId()

	self.customFmtMo:beforeUseFormationMo(teamId)
end

function CustomFmtLeftView:onFmoSetDown()
	self.customFmtMo:onFmoSetDown()
end

function CustomFmtLeftView:onSummonPosSetdown()
	self.customFmtMo:onSummonPosSetdown()
end

function CustomFmtLeftView:getCurAllFormStrengthInfo()
	if self:isUseMaxStreng() then
		return CustomFmtController.instance:getMaxStrengthInfo()
	else
		return FormationNewModel.instance:getAllFormStrengthInfo()
	end
end

function CustomFmtLeftView:GetFormStrengthIdAndLv()
	local fid, flvl = self.customFmtMo:GetFormStrengthIdAndLv()

	return fid, flvl
end

function CustomFmtLeftView:_getPowerAndSpeed(isUseCutePet)
	local team, formation, speed = self:getTeamAndFormation()
	local fid, flvl = self:GetFormStrengthIdAndLv()
	local heroSkill = self:_getHeroSkillId()
	local eleMap = self:_getCurElementMap()
	local fmtMo = self:_getCurFormation()
	local masterId = fmtMo:GetSummonMasterPetId()
	local summonId = fmtMo:GetSummonPetId()
	local cutePetRaceId, cutePetQuality = 0, 0

	if isUseCutePet == nil or isUseCutePet == true then
		cutePetRaceId, cutePetQuality = self:_getCutePetInfo()
	end

	return self.customFmtMo:getFmtPowerByParams(team, heroSkill, fid, flvl, eleMap, cutePetRaceId, cutePetQuality, masterId, summonId), speed
end

function CustomFmtLeftView:_filterFormationPosOnEnter()
	CustomFmtLeftView.super._filterFormationPosOnEnter(self, self.customFmtMo:getFormCondition())
end

function CustomFmtLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	return self.customFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
end

function CustomFmtLeftView:_onSelectBuffForm(formId, formLv)
	if self.customFmtMo.isShowMaxBuffFormLv then
		formLv = checknumber(formLv)
		formId = checknumber(formId)

		if formId > 0 then
			formLv = BattleConfig.instance:getFormStrengthMaxLv(formId)
		end
	end

	CustomFmtLeftView.super._onSelectBuffForm(self, formId, formLv)
end

function CustomFmtLeftView:_getCurBonds(isGetPetIdList)
	local positions = self:_getCurFormation():GetPositions()
	local petMoList = {}

	for i, petId in ipairs(positions) do
		if petId > 0 then
			local mo = self:_getPet(petId)

			if mo then
				table.insert(petMoList, mo)
			end
		end
	end

	return CustomFmtController.instance:getMatchBondCfgOnForm(petMoList, self.customFmtMo:getAllShowPetList())
end

function CustomFmtLeftView:_showFailedTips()
	local failedTips = self.customFmtMo:getFailedTips()

	if string.nilorempty(failedTips) then
		CustomFmtLeftView.super._showFailedTips(self)
	else
		FloatWordMgr.instance:show(failedTips)
	end
end

function CustomFmtLeftView:_showSetSummonPetTips()
	local tips = self.customFmtMo:getSetSummonPetTips()

	if string.nilorempty(tips) then
		CustomFmtLeftView.super._showSetSummonPetTips(self)
	else
		FloatWordMgr.instance:show(tips)
	end
end

function CustomFmtLeftView:_OnClickBtnContractPet()
	if self.customFmtMo:checkBlockClickBtn("ContractPet") then
		return
	end

	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickSwitchSummonerOrSummonMonster)

	local masterMoList, cusMasterMo = self:getSummonMasterPets()

	if masterMoList and #masterMoList > 0 then
		local formationMo = self:_getCurFormation()

		formationMo:trySaveMySelf()
		UIStateManager.instance:push(ViewName.CustomSummonPopSelectView, masterMoList, self:getSummonPetList(), cusMasterMo, self:getSummonPetLimitLvl(), formationMo:GetSummonPetId(), self:_getFixedPetsForContract())
	else
		FloatWordMgr.instance:show(lang("阵上没有符合条件的召唤师~"))
	end
end

function CustomFmtLeftView:_OnClickCutePet()
	if self.customFmtMo:checkBlockClickBtn("CutePet") then
		return
	end

	CustomFmtLeftView.super._OnClickCutePet(self)
end

function CustomFmtLeftView:_OnClickBtnHeroSkill()
	if self.customFmtMo:checkBlockClickBtn("HeroSkill") then
		return
	end

	if self.customFmtMo.isNeedOpenCustomFmtFeatureView then
		SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickSwitchHeroSkill)

		local skills = self:_getPetsHeroSkills()
		local curBonds, petIdList = self:_getCurBonds(true)
		local petMoMap = self:_getBagPetMoList(petIdList)
		local team, formation, speed = self:getTeamAndFormation()
		local curHeroSkillId = self:_getHeroSkillId()

		self.customFmtMo:openCustomFmtFeatureView(skills, curHeroSkillId, curBonds, petMoMap, formation)
	else
		CustomFmtLeftView.super._OnClickBtnHeroSkill(self)
	end
end

function CustomFmtLeftView:_onClickElementSkill()
	if self.customFmtMo:checkBlockClickBtn("ElementSkill") then
		return
	end

	CustomFmtLeftView.super._onClickElementSkill(self)
end

function CustomFmtLeftView:_onClickPsychicSkill()
	if self.customFmtMo:checkBlockClickBtn("PsychicSkill") then
		return
	end

	CustomFmtLeftView.super._onClickPsychicSkill(self)
end

function CustomFmtLeftView:_OnClickBtnFormation()
	if self.customFmtMo:checkBlockClickBtn("Formation") then
		return
	end

	CustomFmtLeftView.super._OnClickBtnFormation(self)
end

function CustomFmtLeftView:_onClickDomainSkill()
	if self.customFmtMo:checkBlockClickBtn("DomainSkill") then
		return
	end

	CustomFmtLeftView.super._onClickDomainSkill(self)
end

function CustomFmtLeftView:_OnClickBtnBuffForm()
	if self.customFmtMo:checkBlockClickBtn("BuffForm") then
		return
	end

	CustomFmtLeftView.super._OnClickBtnBuffForm(self)
end

function CustomFmtLeftView:_isPetUnableToLeve(oldPetId, newPetId)
	return self.customFmtMo:isPetUnableToLeve(oldPetId, newPetId)
end

function CustomFmtLeftView:_getPetsPsychics()
	local pets = self.customFmtMo:getPsychicsPets()

	if pets then
		return pets
	else
		local psychicSkillFaceIds = {}
		local pet_poisition = self:_getCurPositions()

		for i, v in ipairs(pet_poisition) do
			if v > 0 then
				local pet = self:_getPet(checknumber(v))

				if pet then
					local petCo = PetSkinConfig.instance:getPetSkinCfg(pet.curFaceId)

					if petCo.psychicSkillId ~= 0 then
						table.insert(psychicSkillFaceIds, pet)
					end
				end
			end
		end

		return psychicSkillFaceIds
	end
end

function CustomFmtLeftView:_getPetsHeroSkills()
	local skills = self.customFmtMo:getHeroSkills()

	if skills then
		return skills
	else
		return CustomFmtLeftView.super._getPetsHeroSkills(self)
	end
end

function CustomFmtLeftView:_OnHeroSkillChanged(id, exParmams)
	self.customFmtMo:_OnHeroSkillChanged(id, exParmams)
	self:_RefreshViewOnHeroSkillChanged(id)
	FormationController.instance:setRaceChange()
end

function CustomFmtLeftView:_onClickShowPetTips(petMo)
	if not self.customFmtMo:onClickShowPetTips(petMo) then
		CustomFmtLeftView.super._onClickShowPetTips(self, petMo)
	end
end

function CustomFmtLeftView:_onBagBeginDrag(bagPetMo)
	CustomFmtLeftView.super._onBagBeginDrag(self, bagPetMo)
	self.customFmtMo:beginDragBagPet(bagPetMo)
end

function CustomFmtLeftView:_onBagEndDrag()
	CustomFmtLeftView.super._onBagEndDrag(self)
	self.customFmtMo:endDragBagPet()
end

function CustomFmtLeftView:_onFormationBeginDragSeat(bagPetMo, startPosIndex)
	self.customFmtMo:beginDragFormationPet()
	CustomFmtLeftView.super._onFormationBeginDragSeat(self, bagPetMo, startPosIndex)
end

function CustomFmtLeftView:_onFormationEndDragSeat()
	self.customFmtMo:endDragFormationPet()
	CustomFmtLeftView.super._onFormationEndDragSeat(self)
end

return CustomFmtLeftView
