-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/timedpointracemode/mission/TimedPointRaceModeMissionView.lua

module("logic.extensions.timelimitedchallenge.view.timedpointracemode.mission.TimedPointRaceModeMissionView", package.seeall)

local TimedPointRaceModeMissionView = class("TimedPointRaceModeMissionView", MissionView)

function TimedPointRaceModeMissionView:onEnter()
	self:onEnterInherit()

	self.monsterCfg = self:_getMonsterCo()

	local ruleDesc = self.monsterCfg.WinDesc
	local titleStr = self.monsterCfg.name

	self:_setDescStr(titleStr, nil, ruleDesc)
	self:_setPureValidatorDesc(self.monsterCfg.missionDesc)
	GlobalDispatcher:addListener(GlobalNotify.TimedPointRaceModeError, self._onError, self)
end

function TimedPointRaceModeMissionView:onExit()
	CynthiaMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TimedPointRaceModeError, self._onError, self)
end

function TimedPointRaceModeMissionView:_getMonsterCo()
	local param = self._viewPresentor:getFirstParam()

	if param then
		return param
	end

	return {}
end

function TimedPointRaceModeMissionView:_enterBattle()
	local params = self:getOpenParam()
	local creepCfg = params[1]

	self._challengeId = params[2]
	self._buffChallengeCfg = params[3]
	self._commonCfg = TimedPointRaceModeConfig.instance:getCommonCfg(self._challengeId)

	if creepCfg then
		local isAble, isTimeAble, isDateAble = TimedPointRaceModeConfig.instance:isTimeAbleToChallenge(self._challengeId)

		if isAble then
			local cfg = self.monsterCfg
			local ruleDesc = cfg.WinDesc

			MissionModel.instance:setRuleDesc(ruleDesc, self._txtValidatorDesc.text)

			local ctrl = TimedPointRaceModeController.instance

			BattleFacade.instance:registerResultHandler(GameUtil.handler(ctrl.onBattleEnd, ctrl, self._challengeId, self._buffChallengeCfg))

			if self._buffChallengeCfg then
				TimedChallengeRankingScoreAgent.instance:sendPM_TimedChallengeRankingScoreBuffFightReq(self._challengeId, self._buffChallengeCfg.buffType)
			else
				TimedChallengeRankingScoreAgent.instance:sendPM_TimedChallengeRankingScoreFightReq(self._challengeId)
			end
		else
			if isDateAble then
				TipsFacade.instance:openCommonTips("当前挑战允许日期已过")
			else
				TipsFacade.instance:openCommonTips(langPara("%s不可挑战", self._commonCfg.openTimeRange))
			end

			self:_onClickClose()
		end
	end
end

function TimedPointRaceModeMissionView:_onError(status)
	self:_onClickClose()
end

return TimedPointRaceModeMissionView
