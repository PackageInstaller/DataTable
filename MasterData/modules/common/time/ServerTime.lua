-- chunkname: @modules/common/time/ServerTime.lua

module("modules.common.time.ServerTime", package.seeall)

local ServerTime = _M
local _serverUtcOffset = 0
local _clientUtcOffset = 0
local _clientToServerOffset = 0
local _serverTimeStamp = os.time()
local _syncClientLocalStamp = 0

function ServerTime.init(serverUtcOffset)
	_serverUtcOffset = serverUtcOffset or ServerTime.getInitServerUtcOffset()
	_clientUtcOffset = os.difftime(os.time(), os.time(os.date("!*t", os.time())))
	_clientToServerOffset = _serverUtcOffset - _clientUtcOffset
end

function ServerTime.getInitServerUtcOffset()
	return ModuleEnum.ServerUtcOffset
end

function ServerTime.clientToServerOffset()
	return _clientToServerOffset
end

function ServerTime.update(serverTimeStamp)
	_serverTimeStamp = serverTimeStamp
	_syncClientLocalStamp = Time.realtimeSinceStartup
end

function ServerTime.now()
	local elapsed = Time.realtimeSinceStartup - _syncClientLocalStamp

	return _serverTimeStamp + math.floor(elapsed)
end

function ServerTime.nowInLocal()
	return ServerTime.now() + _clientToServerOffset + ServerTime.getDstOffset()
end

function ServerTime.timeInLocal(timestamp)
	return timestamp + _clientToServerOffset + ServerTime.getDstOffset()
end

function ServerTime.nowDate()
	return (os.date("*t", ServerTime.now()))
end

function ServerTime.nowDateInLocal()
	return (os.date("*t", ServerTime.nowInLocal()))
end

function ServerTime.weekDayInServerLocal()
	local nowDate = os.date("*t", ServerTime.nowInLocal() - 18000)

	return TimeUtil.convertWday(nowDate.wday)
end

function ServerTime.timeDateInLocal(timestamp)
	local serverTimeStamp = ServerTime.timeInLocal(timestamp)

	return (os.date("*t", serverTimeStamp))
end

function ServerTime.formatNow(fmt)
	return os.date(fmt, ServerTime.now())
end

function ServerTime.serverUtcOffset()
	return _serverUtcOffset
end

function ServerTime.formatNowInLocal(fmt)
	local stamp = ServerTime.nowInLocal()

	return os.date(fmt, stamp)
end

function ServerTime.formatTimeInLocal(timestamp, fmt)
	local stamp = ServerTime.timeInLocal(timestamp)

	return os.date(fmt, stamp)
end

function ServerTime.getDstOffset()
	local nowDate = os.date("*t", os.time())

	return nowDate.isdst and -3600 or 0
end

function ServerTime.timestampToString(time)
	return (os.date("%Y-%m-%d %H:%M:%S", time + _clientToServerOffset + ServerTime.getDstOffset()))
end

function ServerTime.ReplaceUTCStr(str)
	if str then
		return string.gsub(str, "UTC%+8", ServerTime.GetUTCOffsetStr())
	else
		return ""
	end
end

function ServerTime.getServerTimeToday(isNeedDailyFreshOffset)
	local serverTimeStamp = ServerTime.nowInLocal()

	if isNeedDailyFreshOffset then
		serverTimeStamp = serverTimeStamp - TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond
	end

	return tonumber(os.date("%d", serverTimeStamp))
end

function ServerTime.getToadyEndTimeStamp(isNeedDailyFreshOffset)
	local dailyRefreshTimeOffset = TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond
	local serverTimeStamp = ServerTime.nowInLocal()

	if isNeedDailyFreshOffset then
		serverTimeStamp = serverTimeStamp - dailyRefreshTimeOffset
	end

	local dt = os.date("*t", serverTimeStamp)
	local timeStamp = os.time({
		hour = 23,
		min = 59,
		sec = 59,
		year = dt.year,
		month = dt.month,
		day = dt.day
	})

	if isNeedDailyFreshOffset then
		timeStamp = timeStamp + dailyRefreshTimeOffset
	end

	return timeStamp + 1
end

function ServerTime.getWeekEndTimeStamp(isNeedDailyFreshOffset)
	local dailyRefreshTimeOffset = TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond
	local dt = ServerTime.nowDateInLocal()
	local weekDay = TimeUtil.getTodayWeedDay(dt)
	local isNextMonday = true

	if weekDay == 1 and isNeedDailyFreshOffset then
		local expiredSeconds = dt.hour * 3600 + dt.min * 60 + dt.sec

		if expiredSeconds < dailyRefreshTimeOffset then
			isNextMonday = false
		end
	end

	local dtTable

	if not isNextMonday then
		dtTable = {
			hour = 0,
			min = 0,
			sec = 0,
			year = dt.year,
			month = dt.month,
			day = dt.day
		}
	else
		local remainDay = 7 - weekDay
		local day = dt.day + remainDay + 1
		local month = dt.month
		local year = dt.year

		if month == 2 then
			local isRunYear = dt.year % 400 == 0 or dt.year % 4 == 0 and year % 100 ~= 0

			if day > 29 and isRunYear then
				month = month + 1
				day = day - 29
			elseif day > 28 then
				month = month + 1
				day = day - 28
			end
		elseif month == 4 or month == 6 or month == 9 or month == 11 then
			if day > 30 then
				month = month + 1
				day = day - 30
			end
		elseif day > 31 then
			month = month + 1
			day = day - 31
		end

		if month > 12 then
			year = year + 1
			month = month - 12
		end

		dtTable = {
			hour = 0,
			min = 0,
			sec = 0,
			year = year,
			month = month,
			day = day
		}
	end

	local serverTsInLocal = os.time(dtTable)

	if isNeedDailyFreshOffset then
		serverTsInLocal = serverTsInLocal + dailyRefreshTimeOffset
	end

	return ServerTime.clientTs2ServerTs(serverTsInLocal)
end

function ServerTime.getMonthEndTimeStamp(isNeedDailyFreshOffset)
	local dailyRefreshTimeOffset = TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond
	local dt = ServerTime.nowDateInLocal()
	local isNeedAddMonth = true

	if dt.day == 1 and isNeedDailyFreshOffset then
		local expiredSeconds = dt.hour * 3600 + dt.min * 60 + dt.sec

		if expiredSeconds < dailyRefreshTimeOffset then
			isNeedAddMonth = false
		end
	end

	if isNeedAddMonth then
		if dt.month == 12 then
			dt.year = dt.year + 1
			dt.month = 1
		else
			dt.month = dt.month + 1
		end
	end

	local dtTable = {
		hour = 0,
		min = 0,
		sec = 0,
		day = 1,
		year = dt.year,
		month = dt.month
	}
	local serverTsInLocal = os.time(dtTable)

	if isNeedDailyFreshOffset then
		serverTsInLocal = serverTsInLocal + dailyRefreshTimeOffset
	end

	return ServerTime.clientTs2ServerTs(serverTsInLocal)
end

function ServerTime.clientTs2ServerTs(clientTs)
	return clientTs - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
end

function ServerTime.GetUTCOffsetStr()
	return string.format("UTC%+d", _serverUtcOffset / 3600)
end

return ServerTime
