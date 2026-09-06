-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodchallenge/controller/StarGodChallengeController.lua

module("logic.extensions.stargodchallenge.controller.StarGodChallengeController", package.seeall)

local StarGodChallengeController = class("StarGodChallengeController", BaseController)

function StarGodChallengeController:ctor()
	self._addSweepTimes = 0
	self._sweepCallback = nil
end

function StarGodChallengeController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.StarGodChallengeSweepRes, self._onSweepRes, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._updateByDay, self)
end

function StarGodChallengeController:onReset()
	self:_resetSweepParam()
end

function StarGodChallengeController:sendGetInfoReq()
	StarGodChallengeAgent.instance:sendPM_StarGodChallengeGetInfoReq()
end

function StarGodChallengeController:onStarGodChallengeGroupFightResultRes(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	StarGodChallengeModel.instance:setChangeSetId(msg.changeSetId)
	self:handleBattleResults(msg)
end

function StarGodChallengeController:_onSweepRes(msg)
	GameUtil.callBack(self._sweepCallback, msg)
	self:_resetSweepParam()
end

function StarGodChallengeController:_updateByDay()
	StarGodChallengeModel.instance:resetGameTimes()
end

function StarGodChallengeController:addTodayGameTimes(addSweepTimes)
	StarGodChallengeModel.instance:addTodayGameTimes(addSweepTimes)
	printInfo("test 更新挑战次数", self._addSweepTimes, StarGodChallengeModel.instance:getTodayGameTimes())
end

function StarGodChallengeController:addSweepParam(times, callback)
	self._addSweepTimes = times
	self._sweepCallback = callback
end

function StarGodChallengeController:_resetSweepParam()
	self._addSweepTimes = 0
	self._sweepCallback = nil
end

function StarGodChallengeController:handleBattleResults(msg)
	self._curBtlResultIdx = 1
	self._isTeamWin = msg.win
	self._btlResultList = msg.btlResults

	local btlResult = self._btlResultList[self._curBtlResultIdx]

	if self._isTeamWin then
		StarGodChallengeModel.instance:addTodayGameTime()
	end

	if btlResult == nil then
		FloatWordMgr.instance:show("后端返回战斗结果为空")
	else
		BattleFacade.instance:startStarGodChallengeBattle(msg.maxFetter)
		BattleController.instance:viewUserFightMonsterBtlResult(btlResult, false)
	end
end

function StarGodChallengeController:tryNextBattle()
	self._curBtlResultIdx = self._curBtlResultIdx + 1

	local btlResult = self._btlResultList[self._curBtlResultIdx]

	if btlResult ~= nil then
		BattleFacade.instance:startStarGodChallengeBattle(BattleModel.instance.maxFetter)
		BattleController.instance:onBattleContinue(btlResult)

		return true
	end

	return false
end

function StarGodChallengeController:getCurBattleResultIdx()
	return checknumber(self._curBtlResultIdx) - 1
end

function StarGodChallengeController:openBattleResultView()
	local num = #self._btlResultList

	self:setBattleResult(self._btlResultList[num])
	BattleSettlementModel.instance:setChangeSetId(StarGodChallengeModel.instance:getChangeSetId())

	if self.battleResult == GameEnum.BattleResult.ExpSuccess then
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	elseif self.battleResult == GameEnum.BattleResult.Success then
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	elseif self.battleResult == GameEnum.BattleResult.DogFall then
		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	elseif self.battleResult == GameEnum.BattleResult.Failed then
		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	end
end

function StarGodChallengeController:setBattleResult(rData)
	local battid = checknumber(rData.battleId)
	local winner = checknumber(rData.activityWinner)
	local leftTeamId = BattleModel.instance:getLeftTeamId()

	self.battleResult = winner == leftTeamId and GameEnum.BattleResult.Success or winner == -1 and GameEnum.BattleResult.DogFall or GameEnum.BattleResult.Failed

	if rData.expResult and rData.expResult.petGainExp and #rData.expResult.petGainExp > 0 then
		self.battleResult = GameEnum.BattleResult.ExpSuccess
	end
end

function StarGodChallengeController:dealFightError(reason)
	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, reason)
	FormTeamController.instance:onFightErrorForceLeaveCurTeam()
end

function StarGodChallengeController:dealEnterTeamFight()
	UIJumper.instance:pushOneStack(ViewName.FormTeamCurTeamView, true)
end

function StarGodChallengeController:openSingleMissionView(cfg)
	local customFmtMo = StarGodChallengeModel.instance:getCustomFmtMo()

	customFmtMo:initParams(cfg)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function StarGodChallengeController:openSaveFormationView()
	local customFmtMo = StarGodChallengeModel.instance:getSaveCustomFmtMo()

	customFmtMo:initParams()
	CustomFmtController.instance:showMissionFormationView(customFmtMo)
end

function StarGodChallengeController:pushOneStackView()
	UIJumper.instance:pushOneStack(ViewName.PlotCopyView, true)
	UIJumper.instance:pushOneStack(ViewName.ResCopyView, true)
	UIJumper.instance:pushOneStack(ViewName.MaterialChallengeView, true, StarGodChallengeModel.instance:getChapterId())
	UIJumper.instance:pushOneStack(ViewName.StarGodChallengeMainView, true)
end

function StarGodChallengeController:sendTeamForm()
	StarGodChallengeAgent.instance:sendPM_StarGodChallengeGetFormReq()
end

StarGodChallengeController.instance = StarGodChallengeController.New()

return StarGodChallengeController
