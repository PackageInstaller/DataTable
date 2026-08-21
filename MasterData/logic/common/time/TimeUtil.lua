-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/time/TimeUtil.lua

module("logic.common.time.TimeUtil", package.seeall)

local M = class("TimeUtil")

function M:dateStr2TimeStamp(dateStr)
	local findT = string.find(dateStr, "T")
	local dateStrs = findT and string.split(dateStr, "T") or string.split(dateStr, " ")
	local dateStr1s = string.split(dateStrs[1], "-")
	local year = tonumber(dateStr1s[1])
	local month = tonumber(dateStr1s[2])
	local day = tonumber(dateStr1s[3])
	local hour = 0
	local min = 0
	local sec = 0

	if dateStrs[2] then
		local dateStr2s = string.split(dateStrs[2], ":")

		hour = tonumber(dateStr2s[1])
		min = tonumber(dateStr2s[2])

		if dateStr2s[3] then
			sec = tonumber(dateStr2s[3])
		end
	end

	local timeStamp = ServerTime.dateToTimeServerLook({
		year = year,
		month = month,
		day = day,
		hour = hour,
		min = min,
		sec = sec
	})

	timeStamp = timeStamp or ServerTime.dateToTimeServerLook({
		month = 1,
		year = 2038,
		day = 1
	})

	return timeStamp
end

function M:stampToDateStr(stamp)
	local fmt = "%Y-%m-%d %H:%M:%S"

	return ServerTime.formatTimeServerLook(stamp, fmt)
end

function M:numberToTime(time, model)
	model = model or "m:s"
	time = math.max(time, 0)

	local h = self:numberFixPre(math.floor(time / 3600))
	local m = self:numberFixPre(math.floor(time % 3600 / 60))
	local s = self:numberFixPre(math.floor(time % 3600 % 60))

	model = string.gsub(model, "h", h)
	model = string.gsub(model, "m", m)
	model = string.gsub(model, "s", s)

	return model
end

function M:numberToTimeMS(msTime, model)
	model = model or "m:s.M"
	msTime = math.max(msTime, 0)

	local seconds = math.floor(msTime / 1000)
	local h = self:numberFixPre(math.floor(seconds / 3600))
	local m = self:numberFixPre(math.floor(seconds % 3600 / 60))
	local s = self:numberFixPre(math.floor(seconds % 3600 % 60))
	local ms = self:numberFixPre(math.floor(msTime % 1000 / 10))

	model = string.gsub(model, "h", h)
	model = string.gsub(model, "m", m)
	model = string.gsub(model, "s", s)
	model = string.gsub(model, "M", ms)

	return model
end

function M:date2String(date, pattern)
	pattern = pattern or "%Y/%m/%d %H:%M"
	pattern = string.gsub(pattern, "%%Y", date.year)
	pattern = string.gsub(pattern, "%%m", date.month)
	pattern = string.gsub(pattern, "%%d", date.day)
	pattern = string.gsub(pattern, "%%H", date.hour)
	pattern = string.gsub(pattern, "%%M", self:numberFixPre(date.min))

	return pattern
end

function M:numberFixPre(number)
	if number >= 10 then
		return number
	end

	return string.format("0%s", number)
end

function M:formatUnixTime2Date(unixTime)
	if unixTime and unixTime >= 0 then
		local tb = {}

		tb.year = tonumber(os.date("%Y", unixTime))
		tb.month = tonumber(os.date("%m", unixTime))
		tb.day = tonumber(os.date("%d", unixTime))
		tb.hour = tonumber(os.date("%H", unixTime))
		tb.minute = tonumber(os.date("%M", unixTime))
		tb.second = tonumber(os.date("%S", unixTime))

		return tb
	end

	return false
end

function M:getNowMonth()
	local month = os.date("%m", ServerTime.now())

	return tonumber(month)
end

function M:getNowDate()
	local day = os.date("%d", ServerTime.now())

	return tonumber(day)
end

local monthday = {
	31,
	28,
	31,
	30,
	31,
	30,
	31,
	31,
	30,
	31,
	30,
	31
}

function M:getMonthHaveDay(month)
	if month == 2 then
		local year = os.date("%Y", ServerTime.now())
		local yearn = tonumber(year)

		if yearn % 400 == 0 or yearn % 4 == 0 and yearn % 100 ~= 0 then
			return 29
		else
			return 28
		end
	else
		return monthday[month]
	end
end

function M:simpleStr2TS(dataStr)
	local dateStr1s = string.split(dataStr, "-")
	local year = tonumber(dateStr1s[1])
	local month = tonumber(dateStr1s[2])
	local day = tonumber(dateStr1s[3])
	local hour = tonumber(dateStr1s[4])
	local min = 0
	local sec = 0
	local timeStamp = ServerTime.dateToTimeServerLook({
		year = year,
		month = month,
		day = day,
		hour = hour,
		min = min,
		sec = sec
	})

	timeStamp = timeStamp or ServerTime.dateToTimeServerLook({
		month = 1,
		year = 7777,
		day = 1
	})

	return timeStamp
end

function M:trsSeconds2TimeStr(seconds, fmtStr)
	local leftTime = seconds

	if string.find(fmtStr, "$d") then
		local day = math.floor(seconds / 3600 / 24)

		fmtStr = string.gsub(fmtStr, "$d", day)
		leftTime = seconds - day * 3600 * 24
	end

	if string.find(fmtStr, "$h") then
		local hour = math.floor(leftTime / 3600)

		fmtStr = string.gsub(fmtStr, "$h", hour)
		leftTime = leftTime - hour * 3600
	end

	if string.find(fmtStr, "$m") then
		local min = math.floor(leftTime / 60)

		fmtStr = string.gsub(fmtStr, "$m", min)
		leftTime = seconds - leftTime - min * 60
	end

	if string.find(fmtStr, "$s") then
		fmtStr = string.gsub(fmtStr, "$s", leftTime)
	end

	return fmtStr
end

function M:trsSeconds2BriefStr(seconds, fixType, dayStr, hourStr, minStr, secStr)
	local leftTime = seconds
	local fixType = fixType or 4
	local dayStr = dayStr or lang("tip_common_day")
	local hourStr = hourStr or lang("tip_common_hour")
	local minStr = minStr or lang("tip_common_minute")
	local secStr = secStr or lang("tip_common_second")
	local day = math.floor(leftTime / 3600 / 24)

	if day > 0 or fixType == 1 then
		return day, dayStr
	end

	leftTime = leftTime - day * 3600 * 24

	local hour = math.floor(leftTime / 3600)

	if hour > 0 or fixType == 2 then
		return hour, hourStr
	end

	leftTime = leftTime - hour * 3600

	local min = math.floor(leftTime / 60)

	if min > 0 or fixType == 3 then
		return min, minStr
	end

	local sec = leftTime - min * 60

	return sec, secStr
end

function M:getRemainTimeToNextWeek()
	local date = os.date("*t", ServerTime.now())
	local curWeekDay = CommEnum.WeekDayMapping[date.wday]
	local hour = date.hour
	local min = date.min
	local sec = date.sec
	local remainTime = 0

	if curWeekDay == 1 and hour < 5 then
		remainTime = 18000 - hour * 3600 - min * 60 - sec
	else
		remainTime = 604800 - (curWeekDay - 1) * 24 * 3600 - hour * 3600 - min * 60 - sec
		remainTime = remainTime + 18000
	end

	return remainTime
end

function M:getNextMondayRefreshTimeStamp(nowTime, offsetSecond)
	nowTime = nowTime or ServerTime.now()
	offsetSecond = offsetSecond or 0

	local targetHour = 5
	local targetMin = 0
	local targetSec = 0
	local date = os.date("*t", nowTime)
	local endTime = 0

	if date.wday == 2 and date.hour < 5 then
		endTime = TimeUtil.instance:getWDayTimeStamp(nowTime, 1, targetHour, targetMin, targetSec)
	else
		endTime = TimeUtil.instance:getWDayTimeStamp(nowTime, 7)
		endTime = endTime + 86400 + (targetHour * 60 * 60 + targetMin * 60 + targetSec)
	end

	endTime = endTime + offsetSecond

	return endTime
end

function M:isSameDay(timeStamp1, timeStamp2)
	if not timeStamp1 or not timeStamp2 then
		return false
	end

	local date1 = os.date("*t", timeStamp1)
	local date2 = os.date("*t", timeStamp2)

	return date1.year == date2.year and date1.month == date2.month and date1.day == date2.day
end

function M:getTodaySpTimeStamp(offsetTS, offsetDay, offsetHour, offsetMin, offsetSec)
	local now = ServerTime.nowDateServerLook()

	offsetTS = offsetTS and offsetTS or 0
	offsetDay = offsetDay and offsetDay or 0
	offsetHour = offsetHour and offsetHour or 0
	offsetMin = offsetMin and offsetMin or 0
	offsetSec = offsetSec and offsetSec or 0

	local nowZeroTime = os.time({
		hour = 0,
		min = 0,
		sec = 0,
		year = now.year,
		month = now.month,
		day = now.day
	})
	local returnTime = nowZeroTime + offsetTS + 86400 * offsetDay + (offsetHour * 60 * 60 + offsetMin * 60 + offsetSec)

	return returnTime
end

function M:getNowWeekDay(nowTimeStamp)
	local nowWDay = os.date("%w", nowTimeStamp)

	nowWDay = tonumber(nowWDay)
	nowWDay = nowWDay == 0 and 7 or nowWDay

	return nowWDay
end

function M:getWDayTimeStamp(nowTimeStamp, targetWday, targetHour, targetMin, targetSec)
	targetHour = targetHour and targetHour or 0
	targetMin = targetMin and targetMin or 0
	targetSec = targetSec and targetSec or 0

	local nowDate = os.date("*t", nowTimeStamp)
	local nowWDay = self:getNowWeekDay(nowTimeStamp)
	local nowZeroTime = os.time({
		hour = 0,
		min = 0,
		sec = 0,
		year = nowDate.year,
		month = nowDate.month,
		day = nowDate.day
	}) or 0
	local offsetDay = targetWday - nowWDay

	return nowZeroTime + 86400 * offsetDay + (targetHour * 60 * 60 + targetMin * 60 + targetSec)
end

function M:second2TimeString(seconds, isShowHour)
	seconds = math.floor(seconds)

	local hour = math.floor(seconds / 3600)
	local min = math.floor(seconds % 3600 / 60)
	local sec = math.floor(seconds % 60)

	if isShowHour then
		return string.format("%02d:%02d:%02d", hour, min, sec)
	else
		return string.format("%02d:%02d", min, sec)
	end
end

function M:getDay_Hour_Min_Sec(seconds)
	seconds = math.floor(seconds)

	local day = math.floor(seconds / 86400)
	local hour = math.floor(seconds % 86400 / 3600)
	local min = math.floor(seconds % 3600 / 60)
	local sec = math.floor(seconds % 60)

	return day, hour, min, sec
end

function M:autoFormatSecondToString(seconds, alwaysShowHMS)
	local day, hour, min, sec = TimeUtil.instance:getDay_Hour_Min_Sec(seconds)

	if alwaysShowHMS then
		if day > 0 then
			return langF("tip_time_day_hour_min_sec", day, hour, min, sec)
		else
			return string.format("%02d:%02d:%02d", hour, min, sec)
		end
	end

	local timeStr = ""

	if day > 0 then
		timeStr = langF("tip_time_day_hour", day, hour)
	elseif hour > 0 then
		timeStr = langF("tip_time_hour_min", hour, min)
	else
		timeStr = langF("tip_time_min_sec", min, sec)
	end

	return timeStr
end

function M:isInRange(startTime, endTime)
	local beginTime = string.nilorempty(startTime) and 0 or TimeUtil.instance:dateStr2TimeStamp(startTime)
	local endTime = string.nilorempty(endTime) and math.huge or TimeUtil.instance:dateStr2TimeStamp(endTime)
	local curTime = ServerTime.now()

	if endTime < curTime or curTime < beginTime then
		return false
	end

	return true
end

function M:getNextDayTimeStamp(nowTimeStamp, offset)
	local nowDate = os.date("*t", nowTimeStamp)
	local descTime = nowTimeStamp

	if nowDate.hour < 5 then
		descTime = os.time({
			hour = 5,
			min = 0,
			sec = 0,
			year = nowDate.year,
			month = nowDate.month,
			day = nowDate.day + offset - 1
		})
	else
		descTime = os.time({
			hour = 5,
			min = 0,
			sec = 0,
			year = nowDate.year,
			month = nowDate.month,
			day = nowDate.day + offset
		})
	end

	return descTime
end

function M:formatRemainTime(longTS, shortTS)
	local remainTime = ServerTime.getDateTimeDiff(longTS, shortTS)
	local remainTimeStr

	if remainTime.month > 0 then
		remainTimeStr = langF("%s月", remainTime.month)
	elseif remainTime.day > 0 then
		remainTimeStr = langF("%s天", remainTime.day)
	elseif remainTime.hour > 0 then
		remainTimeStr = langF("%s小时", remainTime.hour)
	elseif remainTime.min > 0 then
		remainTimeStr = langF("%s分钟", remainTime.min)
	else
		remainTimeStr = langF("%s分钟", 0)
	end

	return remainTimeStr
end

M.instance = M.New()

return M
