-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mission/TLCMissionView.lua

module("logic.extensions.timelimitedchallenge.view.TLCMissionView", package.seeall)

local TLCMissionView = class("TLCMissionView", MissionView)
local tlcMissionPrefix = "TIME_LIMITED_CHALLENGE_MISSION_"

function TLCMissionView:buildUI()
	TLCMissionView.super.buildUI(self)

	self._txtLeftCount = goutil.findChildTextComponent(self.mainGO, "txtLeftCount")
	self._txtRule = goutil.findChildTextComponent(self._btnRule.gameObject, "Text")
end

function TLCMissionView:bindEvents()
	TLCMissionView.super.bindEvents(self)
end

function TLCMissionView:unbindEvents()
	TLCMissionView.super.unbindEvents(self)
end

function TLCMissionView:onEnter()
	self:onEnterInherit()
	self._videoButton.gameObject:SetActive(false)
	MissionModel.instance:setForceResetOneKey(true)

	self._fmtChanged = false
	self._info = TLChallengeController.instance:getMissionParams()
	self._formCondition = self._info.monsterCfg.formCondition
	self._challengeId = self._info.challengeId
	self._missionName = self._info.monsterCfg.name

	if self._info.monsterCfg.levelRuleDesc ~= "" then
		if not self._info.monsterCfg.levelRuleDesc then
			local ruleDesc

			self:_setDescStr(self._missionName)
			self:_setTitleName()
			self:setRuleDesc()
			self:_openCheatsView()
			BattleModel.instance:setBattleName(self._missionName)

			if self._info.showStrategy then
				local cfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

				if cfg.strategyId <= 0 then
					self._info.showStrategy = false
				end
			end

			self._txtRule.text = self._info.showStrategy and lang("挑战秘籍") or lang("规则说明")
		end
	end
end

function TLCMissionView:_openCheatsView()
	local key = tlcMissionPrefix .. self._challengeId
	local lastOpenTime = checknumber(GameUtil.getUserDayData(key))
	local now = ServerTime.now()

	if now - lastOpenTime > 86400 then
		GameUtil.saveUserDayData(key, tostring(now))
		self:_onClickRule()
	end
end

function TLCMissionView:setRuleDesc()
	MissionModel.instance:setRuleDesc(self._info.monsterCfg.levelRuleDesc, self._perfectRuleDesc)
	MissionModel.instance:setRuleParam(nil)
end

function TLCMissionView:_enterBattle()
	local cfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)
	local funcCfg = FuncOpenConfig.instance:getFunctionOpenById(cfg.openFuncId)

	UIJumper.instance:pushOneStack(funcCfg.view, true)
	BattleFacade.instance:startTimeLimitedChallenge(self._info.monsterCfg)
	TLChallengeController.instance:startChallenge(self._challengeId)
	TLChallengeController.instance:reqFight(self._challengeId, self._onErrorMsg, self)
end

function TLCMissionView:_onErrorMsg()
	self:_setMaskBlock(false)
end

function TLCMissionView:_onClickRule()
	if self._info.showStrategy then
		local uiFlyParam = UIFlyTweenParam.New()

		uiFlyParam.endPosition = self._btnRule.transform.position

		UIStateManager.instance:push(ViewName.TimelinitedcheatsView, self._challengeId, uiFlyParam)
	else
		TLCMissionView.super._onClickRule(self)
	end
end

function TLCMissionView:_isFormationValidatorMatchOnStart()
	return FormationValidatorController.instance:isFormationValidatorMatchOnStart(self._formCondition, self:_getCurFormation())
end

function TLCMissionView:_onFormationChangeFinish()
	TLCMissionView.super._onFormationChangeFinish(self)
	self:_setValidatorDesc(self._formCondition)
end

return TLCMissionView
