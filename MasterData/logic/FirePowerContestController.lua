-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/controller/FirePowerContestController.lua

module("logic.extensions.firepowercontest.controller.FirePowerContestController", package.seeall)

local FirePowerContestController = class("FirePowerContestController", BaseController)

FirePowerContestController.AfterGetInfoResponse = "FirePowerContestController.AfterGetInfoResponse"
FirePowerContestController.AfterGainPrizeResponse = "FirePowerContestController.AfterGainPrizeResponse"
FirePowerContestController.AfterMatchResponse = "FirePowerContestController.AfterMatchResponse"
FirePowerContestController.AfterCancelMatchResponse = "FirePowerContestController.AfterCancelMatchResponse"
FirePowerContestController.AfterGetRecord = "FirePowerContestController.AfterGetRecord"
FirePowerContestController.AfterLeaveGameResponse = "FirePowerContestController.AfterLeaveGameResponse"
FirePowerContestController.NotifyGameStart = "FirePowerContestController.NotifyGameStart"
FirePowerContestController.NotifyGameNext = "FirePowerContestController.NotifyGameNext"
FirePowerContestController.NotifyAbort = "FirePowerContestController.NotifyAbort"
FirePowerContestController.NotifyMatchFinish = "FirePowerContestController.NotifyMatchFinish"
FirePowerContestController.NotifyGameEnd = "FirePowerContestController.NotifyGameEnd"
FirePowerContestController.NotifyLaunch = "FirePowerContestController.NotifyLaunch"
FirePowerContestController.NotifyHit = "FirePowerContestController.NotifyHit"
FirePowerContestController.NotifyLeaveGame = "FirePowerContestController.NotifyLeaveGame"

function FirePowerContestController:ctor()
	return
end

function FirePowerContestController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._TickDailyRefreshData, self)
	GlobalDispatcher:addListener(GlobalNotify.RoleLogined, self._resetRedPoint, self)
	self:_resetRedPoint()
end

function FirePowerContestController:onReset()
	return
end

function FirePowerContestController:_TickDailyRefreshData()
	self:_resetRedPoint()
end

function FirePowerContestController:_resetRedPoint()
	local activityId = FirePowerContestConfig.instance:getActId()
	local activityConf = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.FIRE_POWER_CONTEST, activityId)

	if activityConf and GameUtil.checkIsInTimePeriod(activityConf.startTime, activityConf.endTime) then
		RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_FIRE_POWER)
	end
end

function FirePowerContestController:handleGetInfo(status, msg)
	if status == 0 then
		FirePowerContestModel.instance:handleGetInfo(msg)
		self:localNotify(FirePowerContestController.AfterGetInfoResponse)
	end
end

function FirePowerContestController:handleGainPrize(status, msg)
	FirePowerContestModel.instance:handleGainPrize(status, msg)
	self:localNotify(FirePowerContestController.AfterGainPrizeResponse)
	GlobalDispatcher:dispatch(GlobalNotify.DarknessSpringGainStage1PrizeRes)
end

function FirePowerContestController:sendGainPrize(activityId, index)
	FirePowerContestModel.instance:beforeGainPrize(index)
	FirePowerContestAgent.instance:sendPM_FPCGainScorePrizeReq(activityId, index)
end

function FirePowerContestController:reqStartGame()
	FirePowerContestModel.instance:reqStartGame()
	UIStateManager.instance:push(ViewName.FirePowerContestMatchView)
end

function FirePowerContestController:reqDisposeGame()
	FirePowerContestModel.instance:reqDisposeGame()
end

function FirePowerContestController:handleMatching(status, msg)
	self:localNotify(FirePowerContestController.AfterMatchResponse, status, msg)
end

function FirePowerContestController:handleCancelMatch(status, msg)
	self:localNotify(FirePowerContestController.AfterCancelMatchResponse, status, msg)
end

function FirePowerContestController:handleLeaveGame(status, msg)
	local handler = FirePowerContestModel.instance.handler

	handler.data.isSelfLeave = true

	self:localNotify(FirePowerContestController.AfterLeaveGameResponse, status, msg)
end

function FirePowerContestController:handleNofityGameStart(status, msg)
	if status == 0 then
		local handler = FirePowerContestModel.instance.handler

		handler.data:updateStage(msg)
	end

	print("..............................FirePowerContestController:handleNofityGameStart")
	self:localNotify(FirePowerContestController.NotifyGameStart, status)
end

function FirePowerContestController:handleNofityGameNext(status, msg)
	if status == 0 then
		local handler = FirePowerContestModel.instance.handler

		handler.data:updateStage(msg)
	end

	print("..............................FirePowerContestController:handleNofityGameNext")
	self:localNotify(FirePowerContestController.NotifyGameNext, status)
end

function FirePowerContestController:handleNofityAbort(status, msg)
	self:localNotify(FirePowerContestController.NotifyAbort, status, msg)
	self:reqDisposeGame()
end

function FirePowerContestController:handleNofityGameEnd(status, msg)
	if status == 0 then
		FirePowerContestModel.instance:handleNofityGameEnd(msg)
		self:localNotify(FirePowerContestController.NotifyGameEnd, status, msg)
	end
end

function FirePowerContestController:handleRecord(status, msg)
	if status == 0 then
		self:localNotify(FirePowerContestController.AfterGetRecord, msg)
	end
end

function FirePowerContestController:handleNotifyMatchFinish(status, msg)
	if status == 0 then
		local handler = FirePowerContestModel.instance.handler

		handler.data:updateUserInfo(msg.userInfos)
		self:localNotify(FirePowerContestController.NotifyMatchFinish, status, msg)
	end
end

function FirePowerContestController:handleNofityLaunch(status, msg)
	print("..............................FirePowerContestController:handleNofityLaunch")

	if status == 0 then
		self:localNotify(FirePowerContestController.NotifyLaunch, msg.angle, msg.bulletId, msg.lanuchTimes)
	end
end

function FirePowerContestController:handleNofityHit(status, msg)
	print("..............................FirePowerContestController:handleNofityHit")

	if status == 0 then
		local handler = FirePowerContestModel.instance.handler

		handler.data:updateRivalScore(msg.curRivalScore)
		self:localNotify(FirePowerContestController.NotifyHit, msg)
	end
end

function FirePowerContestController:handleNotifyLeaveGame(status, msg)
	if status == 0 then
		local handler = FirePowerContestModel.instance.handler

		if msg.userId == handler.data.rivalUserInfo.userId then
			handler.data.isRivalLeave = true

			self:localNotify(FirePowerContestController.NotifyLeaveGame, msg.userId)
		end
	end
end

function FirePowerContestController:showResultView(data)
	UIStateManager.instance:push(ViewName.FirePowerContestResultView, data)
end

function FirePowerContestController:setIsTourArenaMode(isTourMode)
	self._isTourArenaMode = isTourMode

	if not self._isTourArenaMode then
		self._callbackStartTourArena = nil
		self._callbackFinishTourArena = nil
	end
end

function FirePowerContestController:getIsTourArenaMode()
	return self._isTourArenaMode
end

function FirePowerContestController:startMatchByTourArena(startCallBack, finishCallBack)
	self._callbackStartTourArena = startCallBack
	self._callbackFinishTourArena = finishCallBack
end

function FirePowerContestController:callBackStartTourArena()
	if self._isTourArenaMode and self._callbackStartTourArena then
		GameUtil.callBack(self._callbackStartTourArena)
	end
end

function FirePowerContestController:callBackFinishTourArena(info)
	if self._isTourArenaMode and self._callbackFinishTourArena then
		GameUtil.callBack(self._callbackFinishTourArena, info)
	end
end

function FirePowerContestController:sendPM_FPCSweepReq(activityId)
	FirePowerContestAgent.instance:sendPM_FPCSweepReq(activityId)
end

function FirePowerContestController:handlePM_FPCSweepRes(msg)
	DuoLaLightModel.instance:handlePM_FPCSweepRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_FPCSweepRes)
end

FirePowerContestController.instance = FirePowerContestController.New()

return FirePowerContestController
