-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalSupplyMgr.lua

module("logic.extensions.landlords.view.FalSupplyMgr", package.seeall)

local FalSupplyMgr = class("FalSupplyMgr")

FalSupplyMgr.TimerState = {
	MaxTimeLimitReached = 3,
	TimerRunning = 1,
	IntervalTimeLimitReached = 2
}

function FalSupplyMgr:ctor()
	return
end

function FalSupplyMgr:enter(activityId)
	self._activityId = activityId

	local intervalTimeMin = FightAgainstLandlordsConfig.instance:getFalCommonValue("SUPPLY_GAIN_INTERVAL_TIME")

	self._intervalTimeSec = self:getMinToSec(checknumber(intervalTimeMin))

	local maxTimeLimitMin = FightAgainstLandlordsConfig.instance:getFalCommonValue("SUPPLY_GAIN_TIME_MAX_LIMIT")

	self._maxTimeLimitSec = self:getMinToSec(checknumber(maxTimeLimitMin))

	local maxIntervalTimeLimitMin = FightAgainstLandlordsConfig.instance:getFalCommonValue("SUPPLY_GAIN_INTERVAL_TIME_MAX_LIMIT")

	self._maxIntervalTimeLimitSec = self:getMinToSec(checknumber(maxIntervalTimeLimitMin))

	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKGetOnlineTimeSupplyGainInfoRes, self._startTimer, self)
	self:_startTimer()
end

function FalSupplyMgr:exit()
	self:_stopTimer()
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKGetOnlineTimeSupplyGainInfoRes, self._startTimer, self)
end

function FalSupplyMgr:_startTimer()
	self._activateTimeStamp = FightAgainstLandlordsModel.instance:getActivateTimeStamp()
	self._onlineTimeSec = FightAgainstLandlordsModel.instance:getOnlineTimeSec()
	self._totalOnlineTimeSec = FightAgainstLandlordsModel.instance:getTotalOnlineTimeSec()
	self._deltaTimeSec = 0.1
	self._isNeedNotify = true
	self._timerState = FalSupplyMgr.TimerState.TimerRunning
	self._isCanGainOlineReward = false
	self._startRealTime = UnityEngine.Time.realtimeSinceStartup
	self._curOnlineTimeSec = self._onlineTimeSec

	self:_onTicking()
	settimer(self._deltaTimeSec, self._onTicking, self)
end

function FalSupplyMgr:_stopTimer()
	removetimer(self._onTicking, self)
end

function FalSupplyMgr:_onTicking()
	if self._curOnlineTimeSec < self._maxIntervalTimeLimitSec - self._totalOnlineTimeSec then
		self._curOnlineTimeSec = self._onlineTimeSec + math.floor(UnityEngine.Time.realtimeSinceStartup - self._startRealTime)
	end

	if self._curOnlineTimeSec >= self._maxIntervalTimeLimitSec - self._totalOnlineTimeSec then
		self._timerState = FalSupplyMgr.TimerState.IntervalTimeLimitReached
	end

	if self._totalOnlineTimeSec + self._curOnlineTimeSec >= self._maxTimeLimitSec then
		self._timerState = FalSupplyMgr.TimerState.MaxTimeLimitReached
	end

	if self._curOnlineTimeSec >= self._intervalTimeSec then
		self._isCanGainOlineReward = true

		if self._isNeedNotify then
			self._isNeedNotify = false

			GlobalDispatcher:dispatch(GlobalNotify.NotifyLandlordsPKSupplyCanGain)
			RedPointController.instance:setRedPointInfo(RedPointModel.FightAgainstLandlordsSupplyCanGain, true)
		end
	end
end

function FalSupplyMgr:getMinToSec(timeMin)
	return timeMin * 60
end

function FalSupplyMgr:getOnlineTimeSec()
	return self._curOnlineTimeSec
end

function FalSupplyMgr:getOnlineTimeMin()
	return math.floor(self:getOnlineTimeSec() / 60)
end

function FalSupplyMgr:getLeftOnlineTimeSec()
	return Mathf.Max(self._intervalTimeSec - self:getOnlineTimeSec(), 0)
end

function FalSupplyMgr:isCanGetOlineReward()
	return self._isCanGainOlineReward
end

function FalSupplyMgr:isCanGetDailyReward()
	return not FightAgainstLandlordsModel.instance:isHasGainDailySupply()
end

function FalSupplyMgr:getTimerState()
	return self._timerState
end

return FalSupplyMgr
