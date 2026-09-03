-- chunkname: @/tmp/or_script/lua_compile/dm/base/TimeUtil.lua

TimeUtil = TimeUtil or {}
REMOTE_UTC_DIFF = 28800

function TimeUtil:getRemoteTimeZone()
	local _developSystem = DmGame:getInstance()._injector:getInstance("DevelopSystem")

	if _developSystem and _developSystem.getTimeZone then
		return _developSystem:getTimeZone() * 3600
	end

	return REMOTE_UTC_DIFF
end

function TimeUtil:getLocalTimeZone()
	local now = os.time()
	local localTimeZone = os.difftime(now, os.time(os.date("!*t", now)))
	local isdst = os.date("*t", now).isdst

	if isdst then
		localTimeZone = localTimeZone + 3600
	end

	return localTimeZone
end

function TimeUtil:getLocalTimeZoneId()
	local diffTime = self:getLocalTimeZone()

	return diffTime / 3600
end

function TimeUtil:timeByRemoteDate(date)
	if date then
		local timeZoneDiff = self:getRemoteTimeZone() - self:getLocalTimeZone()

		return os.time(date) - timeZoneDiff
	else
		return DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimestamp()
	end
end

function TimeUtil:timeByLocalDate(date)
	return os.time(date)
end

function TimeUtil:remoteDate(format, time)
	format = format or "*t"

	local timeZoneDiff = self:getRemoteTimeZone() - self:getLocalTimeZone()

	return os.date(format, time + timeZoneDiff)
end

function TimeUtil:localDate(format, time)
	format = format or "*t"

	return os.date(format, time)
end

local __bases = {
	d = 86400,
	H = 3600,
	y = 31536000,
	S = 1,
	M = 60
}
local __baseOrder = {
	"y",
	"d",
	"H",
	"M",
	"S"
}

function TimeUtil:formatTime(fmt, seconds)
	if fmt and seconds then
		local t = TextTemplate:new(fmt)
		local components = {}
		local firstPass = setmetatable({}, {
			__index = function(t, k)
				local c = k:sub(1, 1)

				if __bases[c] == nil then
					return nil
				end

				local m, n = k:find(c .. "*")

				if n == k:len() then
					components[c] = {
						key = k,
						n = n
					}
				end

				return nil
			end
		})

		t:stringify(firstPass)

		local value = {}

		for _, baseName in ipairs(__baseOrder) do
			local comp = components[baseName]

			if comp ~= nil then
				local base = __bases[baseName]
				local x = math.floor(seconds / base)

				seconds = seconds - x * base
				value[comp.key] = string.format("%02d", x)
			end
		end

		return t:stringify(value)
	end
end

function TimeUtil:parseTime(out, timeString)
	local output = out or {}
	local parts = string.split(timeString, "[:-]", nil, true)
	local n = #parts

	if n >= 3 then
		output.hour = tonumber(parts[1])
		output.min = tonumber(parts[2])
		output.sec = tonumber(parts[3])
	elseif n == 2 then
		output.hour = 0
		output.min = tonumber(parts[1])
		output.sec = tonumber(parts[2])
	else
		output.hour = 0
		output.min = 0
		output.sec = tonumber(parts[1])
	end

	return output
end

function TimeUtil:parseDate(out, dateString)
	local output = out or {}
	local parts = string.split(dateString, "[-/]", nil, true)
	local n = #parts

	if n >= 3 then
		output.year = tonumber(parts[1])
		output.month = tonumber(parts[2])
		output.day = tonumber(parts[3])
	else
		output.month = tonumber(parts[1])
		output.day = tonumber(parts[2])
	end

	return output
end

function TimeUtil:parseDateTime(out, dateTimeString)
	local parts = string.split(dateTimeString, "%s+", 2, true)

	out = self:parseDate(out, parts[1])

	return self:parseTime(out, parts[2])
end

function TimeUtil:isSameDay(stampA, stampB, baseTime)
	assert(stampA ~= nil, "error:stampA=nil")
	assert(stampB ~= nil, "error:stampB=nil")

	if baseTime then
		local resetSeconds = (baseTime.hour or 0) * 3600 + (baseTime.min or 0) * 60 + (baseTime.sec or 0)

		stampA = stampA - resetSeconds
		stampB = stampB - resetSeconds
	end

	local dateA = os.date("*t", stampA)
	local dateB = os.date("*t", stampB)

	return dateA.day == dateB.day and dateA.month == dateB.month and dateA.year == dateB.year
end

function TimeUtil:getTimeByDateForTargetTimeInToday(t)
	local localUTCDiff = self:getLocalTimeZone()
	local diffTime = localUTCDiff - self:getRemoteTimeZone()
	local serverTimeMap = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimestamp()
	local tb = os.date("*t", serverTimeMap)

	tb.hour = t.hour
	tb.min = t.min
	tb.sec = t.sec

	return os.time(tb) + diffTime
end

function TimeUtil:getTimeByDateForTargetTime(t)
	local localUTCDiff = self:getLocalTimeZone()
	local diffTime = localUTCDiff - self:getRemoteTimeZone()
	local serverTimeMap = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimestamp()
	local tb = os.date("*t", serverTimeMap)

	tb.year = t.year or tb.year
	tb.month = t.month or tb.month
	tb.day = t.day or tb.day
	tb.hour = t.hour or tb.hour
	tb.min = t.min or tb.min
	tb.sec = t.sec or tb.sec

	return os.time(tb) + diffTime
end

function TimeUtil:getHMSByTimestamp(time)
	local tb = os.date("*t", time)

	return {
		hour = tb.hour,
		min = tb.min,
		sec = tb.sec
	}
end

function TimeUtil:formatStrToTImestamp(str)
	local _, _, y, m, d, hour, min, sec = string.find(str, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")

	return (os.time({
		year = y,
		month = m,
		day = d,
		hour = hour,
		min = min,
		sec = sec
	}))
end

function TimeUtil:formatStrToRemoteTImestamp(str)
	local _, _, y, m, d, hour, min, sec = string.find(str, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")

	return (self:timeByRemoteDate({
		year = y,
		month = m,
		day = d,
		hour = hour,
		min = min,
		sec = sec
	}))
end

function TimeUtil:getYMDByTimestamp(time)
	local tb = os.date("*t", time)

	return {
		year = tb.year,
		month = tb.month,
		day = tb.day
	}
end

function TimeUtil:getSystemResetDate(format)
	local todayFiveHour = self:getTimeByDateForTargetTimeInToday({
		sec = 0,
		min = 0,
		hour = 5
	})

	return (self:localDate(format or "%H:%M", todayFiveHour + 86400))
end

function TimeUtil:getLocalWeekByRemote(week)
	local weeklocal = os.date("%w", os.time())

	weeklocal = weeklocal == 0 and 7 or weeklocal + 1

	local localUTCDiff = self:getLocalTimeZone()
	local diffTime = localUTCDiff - self:getRemoteTimeZone()
	local weekremote = os.date("%w", os.time() + diffTime)

	weekremote = weekremote == 0 and 7 or weekremote + 1

	local trueWeek = week + weekremote - weeklocal

	if trueWeek <= 0 then
		trueWeek = week + weekremote - weeklocal + 7
	end

	if trueWeek > 7 then
		trueWeek = trueWeek - 7
	end

	return trueWeek
end

function TimeUtil:getLocalUTC()
	local a = os.date("!*t", os.time())
	local b = os.date("*t", os.time())
	local timeZone = (b.hour - a.hour) * 3600 + (b.min - a.min) * 60
	local curUTC = timeZone / 3600

	if curUTC > 12 then
		curUTC = curUTC - 24
	end

	return curUTC
end

function TimeUtil:formatTimeStr(remainTime)
	local fmtStr = "${d}:${HH}:${M}:${SS}"
	local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
	local parts = string.split(timeStr, ":", nil, true)
	local timeTab = {}

	timeTab.day = tonumber(parts[1])
	timeTab.hour = tonumber(parts[2])
	timeTab.min = tonumber(parts[3])
	timeTab.sec = tonumber(parts[4])

	return timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.min > 0 and timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.sec .. Strings:get("TimeUtil_Sec")
end
