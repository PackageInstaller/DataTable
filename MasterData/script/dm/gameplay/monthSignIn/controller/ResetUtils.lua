-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/monthSignIn/controller/ResetUtils.lua

ResetUtils = ResetUtils or {}

function ResetUtils:getMonth(time)
	return (os.date("%m", time))
end

function ResetUtils:getYear(time)
	return (os.date("%Y", time))
end

function ResetUtils:getDayThisMonth(time)
	return (os.date("%d", time))
end

function ResetUtils:getTotalDayThisMonth(time)
	return os.date("%d", os.time({
		day = 0,
		year = os.date("%Y", time),
		month = os.date("%m", time) + 1
	}))
end

function ResetUtils:getFirstDayTimeThisMonth(time)
	local day = self:getDayThisMonth(time)
	local curDayTime = self:getDayZeroTime(time)
	local dayTime = (day - 1) * 24 * 3600

	return curDayTime - dayTime
end

function ResetUtils:isMonthDayInArray(curMonthDay, array)
	for k, v in pairs(array) do
		if tonumber(v) == tonumber(curMonthDay) then
			return curMonthDay
		end
	end

	return nil
end

function ResetUtils:getNextRefreshTime(systemTime, resetSystem)
	if not systemTime or not resetSystem then
		return nil
	end

	self:setCurSystemTime(systemTime)

	return self:getNextTime(systemTime, resetSystem)
end

function ResetUtils:getNextTime(systemTime, resetSystem)
	local curTime = self:getCurSystemTime()

	dump(curTime, "local curTime = self:getCurSystemTime()")

	if resetSystem.resetMode == "WEEK" then
		local zeroTime = self:getDayZeroTime(systemTime)
		local week = self:getWeek(systemTime)
		local result = self:isWeekDayInArray(week, resetSystem.resetDate)

		if result then
			for k, v in pairs(resetSystem.resetTime) do
				local time = self:toTime(v)

				if curTime <= zeroTime + time then
					return zeroTime + time
				end
			end
		end

		return self:getNextTime(systemTime + 86400, resetSystem)
	elseif resetSystem.resetMode == "MONTH" then
		local zeroTime = self:getFirstDayTimeThisMonth(systemTime)
		local day = self:getDayThisMonth(systemTime)
		local result = self:isMonthDayInArray(day, resetSystem.resetDate)

		if result then
			for k, v in pairs(resetSystem.resetTime) do
				local time = self:toTime(v)
				local dayTime = zeroTime + (day - 1) * 24 * 3600 + time

				if curTime <= dayTime then
					return dayTime
				end
			end
		end

		return self:getNextTime(systemTime + 86400, resetSystem)
	end

	return nil
end

function ResetUtils:isWeekDayInArray(curWeekDay, array)
	for k, v in pairs(array) do
		if tonumber(v) == tonumber(curWeekDay) then
			return curWeekDay
		end
	end

	return nil
end

function ResetUtils:getDayZeroTime(time)
	return math.floor(time / 3600 / 24) * 3600 * 24 - 28800
end

function ResetUtils:getCurSystemTime()
	return self._systemTime
end

function ResetUtils:setCurSystemTime(time)
	self._systemTime = time
end

function ResetUtils:getWeek(time)
	local week = os.date("%w", time)

	if tonumber(week) == 0 then
		return 7
	end

	return tonumber(week)
end

function ResetUtils:getRemoteWeek(time)
	local week = TimeUtil:remoteDate("%w", time)

	if tonumber(week) == 0 then
		return 7
	end

	return tonumber(week)
end

function ResetUtils:toTime(timeString)
	local result = string.split(timeString, ":")
	local h = tonumber(result[1])
	local m = tonumber(result[2])
	local s = tonumber(result[3])

	return h * 3600 + m * 60 + s
end
