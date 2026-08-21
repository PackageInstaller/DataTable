-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/time/ServerTimeExtend.lua

module("logic.common.time.ServerTimeExtend", package.seeall)

local M = {}

local function _timeDataServerLook(timestamp)
	timestamp = timestamp + ServerTime.getDst()

	return os.date("*t", timestamp + ServerTime._clientToServerOffset)
end

local function _formatTimeServerLook(timestamp, fmt)
	timestamp = timestamp + ServerTime.getDst()

	return os.date(fmt, timestamp + ServerTime._clientToServerOffset)
end

local function _dateToTimeServerLook(date)
	return os.time(date) - ServerTime._clientToServerOffset - ServerTime.getDst()
end

function M.extend()
	ServerTime.MINUTE_SECONDS = 60
	ServerTime.HOUR_SECONDS = 3600
	ServerTime.DAY_SECONDS = 86400
	ServerTime.timeDateServerLook = _timeDataServerLook
	ServerTime.formatTimeServerLook = _formatTimeServerLook
	ServerTime.dateToTimeServerLook = _dateToTimeServerLook
end

function ServerTime.nowDateServerLook()
	local serverLocalStamp = ServerTime.nowServerLook() + ServerTime.getDst()
	local dt = os.date("*t", serverLocalStamp)

	return dt
end

function ServerTime.formatNowServerLook(fmt)
	local stamp = ServerTime.nowServerLook() + ServerTime.getDst()

	return os.date(fmt, stamp)
end

function ServerTime.isToday(seconds)
	local date = ServerTime.timeDateServerLook(seconds)
	local now = ServerTime.nowDateServerLook()

	return now.year == date.year and now.month == date.month and now.day == date.day
end

function ServerTime.daysOffset(seconds1, seconds2)
	seconds1 = ServerTime.getSecondsYMD(seconds1)
	seconds2 = ServerTime.getSecondsYMD(seconds2)

	return (seconds2 - seconds1) / ServerTime.DAY_SECONDS
end

function ServerTime.getSecondsYMD(seconds)
	local date = os.date("*t", seconds)

	date.hour = 0
	date.min = 0
	date.sec = 0

	return os.time(date)
end

function ServerTime.getDst()
	local nowDate = os.date("*t", os.time())

	return nowDate.isdst and -3600 or 0
end

function ServerTime.getDateTimeDiff(long_time_stamp, short_time_stamp)
	local n_short_time, n_long_time, carry, diff = os.date("*t", short_time_stamp), os.date("*t", long_time_stamp), false, {}
	local colMax = {
		60,
		60,
		24,
		os.date("*t", os.time({
			day = 0,
			year = n_short_time.year,
			month = n_short_time.month + 1
		})).day,
		12,
		0
	}

	n_long_time.hour = n_long_time.hour - (n_long_time.isdst and 1 or 0) + (n_short_time.isdst and 1 or 0)

	for i, v in ipairs({
		"sec",
		"min",
		"hour",
		"day",
		"month",
		"year"
	}) do
		diff[v] = n_long_time[v] - n_short_time[v] + (carry and -1 or 0)
		carry = diff[v] < 0

		if carry then
			diff[v] = diff[v] + colMax[i]
		end
	end

	return diff
end

return M
