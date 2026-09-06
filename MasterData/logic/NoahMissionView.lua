-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/noahchallenge/view/NoahMissionView.lua

module("logic.extensions.noahchallenge.view.NoahMissionView", package.seeall)

local NoahMissionView = class("NoahMissionView", MissionView)

function NoahMissionView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.NoahChallengeRes, self._onChallengeRes, self)
	self:onEnterInherit()
	self:procMid()
end

function NoahMissionView:onExit()
	NoahMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.NoahChallengeRes, self._onChallengeRes, self)
end

function NoahMissionView:_onChallengeRes(status, msg)
	self:_onMissionBattleResBack(status)
end

function NoahMissionView:procMid()
	local param = self:getOpenParam()

	self._challengeId = param[1]
	self._curStage = param[2]
	self._raceId = param[3]

	local cfgChallenge = NoahChallengeConfig.instance:getChallengeCfg(self._challengeId)
	local cfgStage = NoahChallengeConfig.instance:getChallengeStage(cfgChallenge.challengePlanId, self._curStage)

	if cfgStage then
		local titleStr = cfgStage.stageName

		self:_setDescStr(titleStr, nil, cfgStage.WinDesc)
		self:_setPureValidatorDesc(cfgStage.missionDesc)
	end
end

function NoahMissionView:_checkFormationValidator()
	local cfgChallenge = NoahChallengeConfig.instance:getChallengeCfg(self._challengeId)
	local cfgStage = NoahChallengeConfig.instance:getChallengeStage(cfgChallenge.challengePlanId, self._curStage)
	local formConditionId = checknumber(cfgStage and cfgStage.formCondition)

	return (formConditionId > 0 or nil) and FormationValidatorController.instance:isFormationValidatorMatchOnStart(formConditionId, self:_getCurFormation(), true), formConditionId
end

function NoahMissionView:_onFormationChangeFinish()
	NoahMissionView.super._onFormationChangeFinish(self)

	local isMatch, formConditionId = self:_checkFormationValidator()

	if formConditionId > 0 then
		local cfg = FormationValidatorConfig.instance:getFormationValidatorCfg(formConditionId)

		if cfg then
			goutil.setActive(self._topDesc.gameObject, true)
			goutil.setActive(self._txtValidatorDesc.gameObject, true)
			self._imgYes:SetActive(isMatch)
			self._imgNo:SetActive(not isMatch)
		end
	end
end

function NoahMissionView:_startClg()
	local isMatch = self:_checkFormationValidator()

	if not isMatch then
		FloatWordMgr.instance:show(lang("当前布阵不符合挑战要求，请重新布阵"))

		return
	end

	NoahMissionView.super._startClg(self)
end

function NoahMissionView:_enterBattle()
	local curFmt = FormationNewModel.instance:GetCurTeam():GetCurFormation()
	local simpleForm = curFmt:createFormPb()

	NoahChallengeAgent.instance:sendPM_NoahChallengeReq(self._challengeId, simpleForm)
	UIJumper.instance:pushOneStack(ViewName.DivineEvolveEnterView, true)
	UIJumper.instance:pushOneStack(ViewName.DivineEvolveMainView, true, self._raceId)

	local cfgChallenge = NoahChallengeConfig.instance:getChallengeCfg(self._challengeId)
	local evolveCfg = EvolveConfig.instance:getDivineEvolveCfg(cfgChallenge.raceId)

	if not evolveCfg then
		return
	end

	UIJumper.instance:pushOneStack(evolveCfg.challengeView, true, self._challengeId, self._raceId)
end

function NoahMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), GameUtil.handler(self.notFilterPet, self))
	MissionModel.instance:setForceResetOneKey(false)
end

function NoahMissionView:notFilterPet(petMo)
	local cfgChallenge = NoahChallengeConfig.instance:getChallengeCfg(self._challengeId)

	if cfgChallenge and cfgChallenge.lockPetSwitch and self:_isUsedPet(petMo.petId) then
		return false
	end

	return true
end

function NoahMissionView:_isUsedPet(petId)
	local param = self:getOpenParam()

	if param then
		local challengeId = param[1]

		return NoahChallengeModel.instance:isPetUsed(challengeId, petId)
	end

	return false
end

return NoahMissionView
