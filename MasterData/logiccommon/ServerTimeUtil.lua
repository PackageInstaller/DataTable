-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/ServerTimeUtil.lua

module("logiccommon.common.util.ServerTimeUtil", package.seeall)

local ServerTimeUtil = {}

function ServerTimeUtil.getHMSFromString(time)
	local timeStrs = string.split(time, ":")
	local hour = tonumber(timeStrs[1])
	local min = tonumber(timeStrs[2])
	local sec = tonumber(timeStrs[3])

	return hour, min, sec
end

function ServerTimeUtil.timeDeltaFromHMSString(time)
	local hour, min, sec = ServerTimeUtil.getHMSFromString(time)

	return ServerTimeUtil.timeDeltaFromHMS(hour, min, sec)
end

function ServerTimeUtil.timeDeltaFromHMS(hour, min, sec)
	if ServerTimeUtil.isHMSPass(hour, min, sec) then
		return -1
	end

	local now = ServerTime.nowDateServerLook()
	local nowTime = os.time(now)
	local dateTime = os.time({
		year = now.year,
		month = now.month,
		day = now.day,
		hour = hour,
		min = min,
		sec = sec
	})

	return os.difftime(nowTime, dateTime)
end

function ServerTimeUtil.isHMSPass(hour, min, sec)
	local now = ServerTime.nowDateServerLook()

	if hour < now.hour then
		return true
	end

	if now.hour == hour and min < now.min then
		return true
	end

	if now.hour == hour and now.min == min and sec < now.sec then
		return true
	end

	return false
end

function ServerTimeUtil.isPassYMDHMS(year, month, day, hour, min, sec)
	local now = ServerTime.nowDateServerLook()

	if year < now.year then
		return true
	end

	if now.year == year and month < now.month then
		return true
	end

	if now.year == year and now.month == month and day < now.day then
		return true
	end

	if now.year == year and now.month == month and now.day == day and hour < now.hour then
		return true
	end

	if now.year == year and now.month == month and now.day == day and now.hour == hour and min < now.min then
		return true
	end

	if now.year == year and now.month == month and now.day == day and now.hour == hour and now.min == min and sec < now.sec then
		return true
	end

	return false
end

return ServerTimeUtil
