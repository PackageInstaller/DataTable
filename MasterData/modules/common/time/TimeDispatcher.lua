-- chunkname: @modules/common/time/TimeDispatcher.lua

module("modules.common.time.TimeDispatcher", package.seeall)

local TimeDispatcher = class("TimeDispatcher")

TimeDispatcher.OnHour = "OnHour"
TimeDispatcher.OnDay = "OnDay"
TimeDispatcher.OnWeek = "OnWeek"
TimeDispatcher.OnDailyRefresh = "OnDailyRefresh"
TimeDispatcher.CheckInterval = 5
TimeDispatcher.DailyRefreshTime = 5
TimeDispatcher.DailyRefreshSecond = TimeDispatcher.DailyRefreshTime * 3600

function TimeDispatcher:ctor()
	LuaEventSystem.addEventMechanism(self)

	self._lastCheckYear = -1
	self._lastCheckYDay = -1
	self._lastCheckHour = -1
	self._lastCheckWDay = -1
	self._lastCheckStamp = -1
	self._year = 0
	self._yday = 0
	self._wday = 0
	self._hour = 0
	self._stamp = 0
end

function TimeDispatcher:startTick()
	self:_check(true)
	TaskDispatcher.runRepeat(self._check, self, TimeDispatcher.CheckInterval)
end

function TimeDispatcher:stopTick()
	TaskDispatcher.cancelTask(self._check, self)

	self._lastCheckYear = -1
	self._lastCheckYDay = -1
	self._lastCheckHour = -1
	self._lastCheckWDay = -1
	self._lastCheckStamp = -1
end

function TimeDispatcher:_check(dontDispatch)
	self._stamp = ServerTime.nowInLocal()

	local dTable = os.date("*t", self._stamp)

	self._year = dTable.year
	self._wday = dTable.wday

	if self._wday == 1 then
		self._wday = 8
	end

	self._yday = dTable.yday
	self._hour = dTable.hour

	local isNewHour = self:_checkHour()

	if isNewHour and not dontDispatch then
		self:dispatchEvent(TimeDispatcher.OnHour)

		local isNewRefreshTime = self:_checkRefreshTime()

		if isNewRefreshTime then
			self:dispatchEvent(TimeDispatcher.OnDailyRefresh)
		end

		local isNewDay = self:_checkDay()

		if isNewDay then
			self:dispatchEvent(TimeDispatcher.OnDay)

			local isNewWeek = self:_checkWeek()

			if isNewWeek then
				self:dispatchEvent(TimeDispatcher.OnWeek)
			end
		end
	end

	self._lastCheckYear = self._year
	self._lastCheckYDay = self._yday
	self._lastCheckHour = self._hour
	self._lastCheckWDay = self._wday
	self._lastCheckStamp = self._stamp
end

function TimeDispatcher:_checkHour()
	if self._lastCheckYear < 0 then
		return false
	elseif self._lastCheckYear == self._year and self._lastCheckYDay == self._yday and self._lastCheckHour == self._hour then
		return false
	end

	return true
end

function TimeDispatcher:_checkRefreshTime()
	if self._hour == TimeDispatcher.DailyRefreshTime then
		return true
	end

	return false
end

function TimeDispatcher:_checkDay()
	if self._lastCheckYear < 0 then
		return false
	elseif self._lastCheckYear == self._year and self._lastCheckYDay == self._yday then
		return false
	end

	return true
end

function TimeDispatcher:_checkWeek()
	if self._lastCheckStamp < 0 then
		return false
	elseif self._stamp - self._lastCheckStamp < 604800 and self._wday >= self._lastCheckWDay then
		return false
	end

	return true
end

TimeDispatcher.instance = TimeDispatcher.New()

return TimeDispatcher
