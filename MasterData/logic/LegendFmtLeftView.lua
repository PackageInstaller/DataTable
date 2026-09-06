-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/LegendFmtLeftView.lua

module("logic.extensions.legend.view.LegendFmtLeftView", package.seeall)

local LegendFmtLeftView = class("LegendFmtLeftView", FormationLeftView)

function LegendFmtLeftView:onEnter()
	LegendFmtLeftView.super.onEnter(self)
	self:_setActiveBtnFormation(false)
	self:_initVerify()
	self:_initSupportForm()

	self.challengeId, self.stageId = LegendModel.instance:getOpenChallengeIdAndStageId()
end

function LegendFmtLeftView:onExit()
	self:_onExitUnbindingEvent()
	self:_saveCurrFmt()
end

function LegendFmtLeftView:_initVerify()
	if checknumber(LegendModel.instance:getVerifyPlanId()) ~= 0 then
		local challengeId, stageId = LegendModel.instance:getOpenChallengeIdAndStageId()
		local cfg = LegendConfig.instance:getLegendChallengeCfg(challengeId)
		local param = {}

		if cfg then
			param.name = cfg.challengeName or ""
		end

		param.tipDesc = "传说挑战今日不再自动提示"

		ViewMgr.instance:openAt(self:getGo("extension"), ViewName.PetverifybtnView, self._viewPresentor, param, LegendModel.instance:getVerifyPlanId())
	end
end

function LegendFmtLeftView:_initSupportForm()
	local challengeId, stageId = LegendModel.instance:getOpenChallengeIdAndStageId()
	local cfgSupport = LegendConfig.instance:getSuportCfgByChallengeId(challengeId, stageId)

	if cfgSupport then
		local positions = {
			cfgSupport.posId
		}

		self:_setFixedPos(positions)
	end
end

function LegendFmtLeftView:_OnClickBtnHeroSkill()
	if LegendModel.instance:isExistSupportPet() then
		SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickSwitchHeroSkill)
		FloatWordMgr.instance:show(lang("当前挑战规则不可更改英雄技"))
	else
		LegendFmtLeftView.super._OnClickBtnHeroSkill(self)
	end
end

function LegendFmtLeftView:_SetHeroSkill(id)
	if LegendModel.instance:isExistSupportPet() then
		local challengeId, stageId = LegendModel.instance:getOpenChallengeIdAndStageId()
		local cfgSupport = LegendConfig.instance:getSuportCfgByChallengeId(challengeId, stageId)
		local heroSkillId = LegendController.instance:raceIdToHeroSkillId(cfgSupport.raceId)

		self._heroSkillIcon:SetActive(true)
		self._Btn_HeroSkill:ChangeStateNow(0)
		self:_setSkillBtnName(heroSkillId)
		self:_changeHeroSkillId(heroSkillId)
		self:_setHeroSkillEffect(heroSkillId)
	else
		LegendFmtLeftView.super._SetHeroSkill(self, id)
	end
end

function LegendFmtLeftView:_onClickClean()
	if LegendModel.instance:isExistSupportPet() then
		LegendFastFormation.instance:clean()
	else
		LegendFmtLeftView.super._onClickClean(self)
	end
end

function LegendFmtLeftView:_showFailedTips()
	if LegendModel.instance:isExistSupportPet() then
		FloatWordMgr.instance:show("最多上阵6只精灵哦！")
	else
		FloatWordMgr.instance:show("最多上阵5只精灵哦！")
	end
end

function LegendFmtLeftView:_getCurFormId()
	if LegendModel.instance:isExistSupportPet() then
		return LegendModel.instance:getCurFormationId()
	else
		return LegendFmtLeftView.super._getCurFormId(self)
	end
end

function LegendFmtLeftView:_getCurFormation()
	if LegendModel.instance:isExistSupportPet() then
		return (LegendModel.instance:getOriginalCurFormation())
	else
		return LegendModel.instance:_getCurFormation()
	end
end

function LegendFmtLeftView:_beforeUseFormationMo()
	if LegendModel.instance:isExistSupportPet() then
		-- block empty
	else
		local formationMo = LegendModel.instance:getOriginalCurFormation()

		PetHireModel.instance:copyFormationMoToHireFmo(PetHireModel.ID_TYPE_NORMAL, formationMo)
	end
end

function LegendFmtLeftView:onFmoSetDown()
	if LegendModel.instance:isExistSupportPet() then
		-- block empty
	else
		local formationMo = LegendModel.instance:getOriginalCurFormation()

		PetHireModel.instance:copyHireFmoToFormationMo(PetHireModel.ID_TYPE_NORMAL, formationMo)
	end
end

function LegendFmtLeftView:_getPetsHeroSkills()
	if LegendModel.instance:isExistSupportPet() then
		return LegendModel.instance:getFormPetsHeroSkills()
	else
		return LegendFmtLeftView.super._getPetsHeroSkills(self)
	end
end

function LegendFmtLeftView:_getHeroSkillId()
	if LegendModel.instance:isExistSupportPet() then
		return LegendModel.instance:getHeroSkillId()
	else
		return LegendFmtLeftView.super._getHeroSkillId(self)
	end
end

function LegendFmtLeftView:_changeHeroSkillId(id)
	local boo = self:_getHeroSkillId() ~= id

	if LegendModel.instance:isExistSupportPet() then
		LegendModel.instance:changeSkillId(id)
		self:onFmoSetDown()
	else
		LegendFmtLeftView.super._changeHeroSkillId(self, id)
	end
end

function LegendFmtLeftView:_getPet(petId)
	return (LegendModel.instance:getPetMoById(petId))
end

function LegendFmtLeftView:_changeTeamId(id)
	if LegendModel.instance:isExistSupportPet() then
		if id == self._getCurrTeamId() then
			return
		end

		local team = FormationNewModel.instance:GetTeam(id)
		local formation = team:GetCurFormation()
		local positions = formation:GetPositions()
		local currFmt = self:_getCurFormation()

		for i = 1, #positions do
			currFmt:SetPosition(i, positions[i])
		end

		LegendModel.instance:setTeamId(id)
		GlobalDispatcher:dispatch(GlobalNotify.TeamChanged)
	else
		LegendFmtLeftView.super._changeTeamId(self, id)
	end
end

function LegendFmtLeftView:_getCurrTeamId()
	if LegendModel.instance:isExistSupportPet() then
		return LegendModel.instance:getTeamId()
	else
		return LegendFmtLeftView.super._getCurrTeamId(self)
	end
end

function LegendFmtLeftView:_saveCurrFmt()
	if LegendModel.instance:isExistSupportPet() then
		LegendModel.instance:saveCurrFormation(self.challengeId, self.stageId)
	else
		LegendFmtLeftView.super._saveCurrFmt(self)
	end
end

function LegendFmtLeftView:_getItemSeatCls()
	if LegendModel.instance:isExistSupportPet() then
		return LegendItemSeat
	else
		return LegendFmtLeftView.super._getItemSeatCls(self)
	end
end

return LegendFmtLeftView
