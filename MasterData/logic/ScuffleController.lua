-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/controller/ScuffleController.lua

module("logic.extensions.scuffle.controller.ScuffleController", package.seeall)

local ScuffleController = class("ScuffleController", BaseController)

function ScuffleController:ctor()
	return
end

function ScuffleController:onInit()
	ScuffleAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.showChangeSet, self))
	GlobalDispatcher:addListener(ScuffleAgent.SF_ScuffleInfoRes, self._onInfoRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_StartMatchingRes, self._onStartMatchingRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_CancelMatchingRes, self._onCancelMatchingRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_LeaveGameRes, self._onLeaveGameRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_BanPetRes, self._onBanPetRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_SetFormRes, self._onSetFormRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_NotifyMatchingOverTimeRes, self._onNotifyMatchingOverTimeRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_NotifyMatchFailRes, self._onNotifyMatchFailRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_NotifyGameStartRes, self._onNotifyGameStartRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_NotfiyStartSetFormRes, self._onNotfiyStartSetFormRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_NotifiyOpReadyFightRes, self._onNotifiyOpReadyFightRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_NotifyGameEndRes, self._onNotifyGameEndRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_GetRankInfoRes, self._onGetRankInfoRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_GetBattleRecordRes, self._onGetBattleRecordRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_GetBattleVideoRes, self._onGetBattleVideoRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_GetAllSeasonInfoRes, self._onGetAllSeasonInfoRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_DailyTaskInfoRes, self._onDailyTaskInfoRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_GainDailyTaskRes, self._onGainDailyTaskRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_AchievePrizeInfoRes, self._onAchievePrizeInfoRes, self)
	GlobalDispatcher:addListener(ScuffleAgent.SF_GainAchievePrizeRes, self._onGainAchievePrizeRes, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._updateByDay, self)
end

function ScuffleController:onReset()
	return
end

function ScuffleController:_updateByDay()
	ScuffleModel.instance:resetDailyGainedScore()
	GlobalDispatcher:dispatch(GlobalNotify.SF_ScuffleInfoRes)
end

function ScuffleController:showChangeSet(changeSetId, msgName)
	if msgName == "handleSF_NotifyGameEndRes" then
		BattleSettlementModel.instance:setChangeSetId(changeSetId)
	else
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
	end
end

function ScuffleController:_onInfoRes(status, msg)
	if status == 0 then
		ScuffleModel.instance:onScuffleInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SF_ScuffleInfoRes, true)
	else
		GlobalDispatcher:dispatch(GlobalNotify.SF_ScuffleInfoRes, false)
	end
end

function ScuffleController:_onStartMatchingRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.SF_StartMatchingRes, msg)
	end
end

function ScuffleController:_onCancelMatchingRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.SF_CancelMatchingRes, true)
	else
		GlobalDispatcher:dispatch(GlobalNotify.SF_CancelMatchingRes, false)
	end
end

function ScuffleController:_onLeaveGameRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.SF_LeaveGameRes, msg)
	end
end

function ScuffleController:_onBanPetRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.SF_BanPetRes, msg)
	end
end

function ScuffleController:_onSetFormRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.SF_SetFormRes, msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function ScuffleController:_onGetRankInfoRes(status, msg)
	if status == 0 then
		ScuffleModel.instance:onGetRankInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SF_GetRankInfoRes, msg)
	end
end

function ScuffleController:_onGetBattleRecordRes(status, msg)
	if status == 0 then
		ScuffleModel.instance:onGetBattleRecordRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SF_GetBattleRecordRes)
	end
end

function ScuffleController:_onGetBattleVideoRes(status, msg)
	if status == 0 then
		ScuffleModel.instance:onGetBattleVideoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SF_GetBattleVideoRes, msg.battleResult)
	end
end

function ScuffleController:_onGetAllSeasonInfoRes(status, msg)
	if status == 0 then
		ScuffleModel.instance:onGetAllSeasonInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SF_GetAllSeasonInfoRes)
	end
end

function ScuffleController:_onDailyTaskInfoRes(status, msg)
	if status == 0 then
		ScuffleModel.instance:onDailyTaskInfoRes(msg, self:getCurSeasonId())
		GlobalDispatcher:dispatch(GlobalNotify.SF_DailyTaskInfoRes)
	end
end

function ScuffleController:_onGainDailyTaskRes(status, msg)
	if status == 0 then
		ScuffleModel.instance:updateTaskInfoPrizeGained(self._taskId, seasonId)

		self._taskId = nil

		GlobalDispatcher:dispatch(GlobalNotify.SF_GainDailyTaskRes)
	end
end

function ScuffleController:_onAchievePrizeInfoRes(status, msg)
	if status == 0 then
		ScuffleModel.instance:onAchievePrizeInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SF_AchievePrizeInfoRes)
	end
end

function ScuffleController:_onGainAchievePrizeRes(status, msg)
	if status == 0 then
		ScuffleModel.instance:updateAchievePrizeGainBit(msg.id)
		GlobalDispatcher:dispatch(GlobalNotify.SF_GainAchievePrizeRes, msg.id)
	end
end

function ScuffleController:_onNotifyMatchingOverTimeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.SF_NotifyMatchingOverTimeRes, msg)
	end
end

function ScuffleController:_onNotifyMatchFailRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.SF_NotifyMatchFailRes, msg)
	end
end

function ScuffleController:_onNotifyGameStartRes(status, msg)
	if status == 0 then
		ScuffleModel.instance:onGameStartRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SF_NotifyGameStartRes, msg)
	end
end

function ScuffleController:_onNotfiyStartSetFormRes(status, msg)
	if status == 0 then
		ScuffleModel.instance:onNofityStartSetFormRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SF_NotfiyStartSetFormRes, msg)
	end
end

function ScuffleController:_onNotifiyOpReadyFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.SF_NotifiyOpReadyFightRes, msg)
	end
end

function ScuffleController:_onNotifyGameEndRes(status, msg)
	if status == 0 then
		ScuffleModel.instance:onGameEndRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SF_NotifyGameEndRes, msg)
	end
end

function ScuffleController:sendSF_BanPetReq()
	ScuffleAgent.instance:sendSF_BanPetReq(ScuffleModel.instance:getMyBanList())
end

function ScuffleController:sendSF_GainDailyTaskReq(taskId)
	self._taskId = taskId

	ScuffleAgent.instance:sendSF_GainDailyTaskReq(taskId)
end

function ScuffleController:isExistCfgInActivityTime()
	return (ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.Scuffle))
end

function ScuffleController:getStartTimeAndEndTime(activityId)
	return ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Scuffle, activityId)
end

function ScuffleController:getSeasonCountDownTxt()
	local cfg = ScuffleController.instance:isExistCfgInActivityTime()

	if cfg then
		local startTimestamp, endTimestamp = ScuffleController.instance:getStartTimeAndEndTime(cfg.activityId)
		local curTimestamp = ServerTime.now()

		if curTimestamp < endTimestamp then
			return GameUtil.FormatTimeSymbol(endTimestamp - curTimestamp)
		else
			return GameUtil.FormatTimeSymbol(0)
		end
	else
		return GameUtil.FormatTimeSymbol(0)
	end
end

function ScuffleController:getCurSeasonId()
	local seasonId = 0
	local cfg = ScuffleController.instance:isExistCfgInActivityTime()

	if cfg then
		local cfgSeason = ScuffleConfig.instance:getSeasonCfg(cfg.activityId)

		seasonId = cfgSeason and cfgSeason.seasonId or 0
	end

	return seasonId
end

function ScuffleController:getCurLevelCfg()
	local score = ScuffleModel.instance:getScore()

	return ScuffleConfig.instance:getLevelCfgByScore(score)
end

function ScuffleController:getScoreDisctanceOnNextLevel()
	local curScore = ScuffleModel.instance:getScore()
	local cfgs = ScuffleConfig.instance:getLevelCfgs()
	local curCfg = self:getCurLevelCfg()

	if curCfg.level + 1 > #cfgs then
		return 0
	else
		local nextLevel = cfgs[curCfg.level + 1].baseScore

		return nextLevel - curScore
	end
end

function ScuffleController:_isInTime(key)
	local value = ScuffleConfig.instance:getCommonValueByKey(key)
	local array = string.split(value, ",")

	for i, v in ipairs(array) do
		local times = string.split(v, "#")

		if GameUtil.checkIsInTimePeriod(times[1], times[2], true) then
			return true
		end
	end

	return false
end

function ScuffleController:isInOpenTimeInStandardMode()
	return self:_isInTime("OPEN_TIME")
end

function ScuffleController:isInOpenTimeInRelaxMode()
	return self:_isInTime("FUN_OPEN_TIME")
end

function ScuffleController:isCoinMaxLimit()
	local value = ScuffleConfig.instance:getCommonValueByKey("CHALLENGE_REWARD_CEILING")
	local maxCoin = checknumber(value)
	local curCoin = ScuffleModel.instance:getCoinToday()

	return maxCoin <= curCoin
end

function ScuffleController:openExchangeView()
	local activityType = checknumber(ScuffleConfig.instance:getCommonValueByKey("SHOP_ACTIVITYTYPE"))
	local activityId = checknumber(ScuffleConfig.instance:getCommonValueByKey("SHOP_ACTIVITYID"))

	FuncOpenController.instance:openFunc(191, activityType, activityId)
end

function ScuffleController:onGameEndRes(callback)
	if ScuffleModel.instance:isNormalBattle() then
		local attackResult = ScuffleModel.instance:getBattleResult()

		BattleFacade.instance:startFightingByBtlResult(attackResult, GameEnum.BattleRecordEntry.Scuffle)
		BattleFacade.instance:startScuffle()
		printInfo("test 我的teamId", ScuffleModel.instance:getMyTeamId())
		BattleModel.instance:setLeftTeamId(ScuffleModel.instance:getMyTeamId())
		UIJumper.instance:pushOneStack(ViewName.ScuffleMainView, true)
	else
		local state = ScuffleModel.instance:getResultState()

		if state == 2 then
			FloatWordMgr.instance:show(lang("scuffleTip1"))
		elseif state == 3 then
			FloatWordMgr.instance:show(lang("scuffleTip2"))
		else
			FloatWordMgr.instance:show(lang("scuffleTip3"))
		end

		GameUtil.callBack(callback)
	end
end

function ScuffleController:getBuffDesc(cfgActivityDefine)
	if not cfgActivityDefine then
		printInfo("test ScuffleController:getBuffDesc 配置不存在")

		return ""
	end

	local startTimestamp = self:getStartTimeAndEndTime(cfgActivityDefine.activityId)
	local curTimestamp = ServerTime.now()

	if curTimestamp < startTimestamp then
		return ""
	else
		local id = checknumber(ScuffleConfig.instance:getCommonValueByKey("DAY_BUFFS"))
		local maxDay = #ScuffleConfig.instance:getDailyBuffList(id)
		local day = GameUtil.getDaysByTimestamp(startTimestamp, curTimestamp)

		day = Mathf.Clamp(day, 1, maxDay)

		local cfg = ScuffleConfig.instance:getDailyBuff(id, day)

		return (cfg or nil) and (cfg.desc or "")
	end
end

ScuffleController.instance = ScuffleController.New()

return ScuffleController
