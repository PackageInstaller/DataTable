-- chunkname: @modules/common/utils/TimeUtil.lua

module("modules.common.utils.TimeUtil", package.seeall)

local TimeUtil = {}

TimeUtil.maxDateTable = {
	month = 1,
	year = 2038,
	day = 1
}
TimeUtil.OneWeekSecond = 604800
TimeUtil.OneDaySecond = 86400
TimeUtil.OneHourSecond = 3600
TimeUtil.OneMinuteSecond = 60
TimeUtil.OneSecond = 1
TimeUtil.OneSecondMilliSecond = 1000
TimeUtil.MaxValue = 2147483647
TimeUtil.DateEnFormat = {
	Day = "d",
	Hour = "h",
	Year = "y",
	Second = "s",
	Minute = "m"
}

local function _dateStr(x, xUnit, y, yUnit)
	if LangSettings.instance:isEn() then
		return string.format("%s%s %s%s", x, xUnit, y, yUnit)
	else
		return string.format("%s%s%s%s", x, xUnit, y, yUnit)
	end
end

local function _YYYYDDhhmmssFormat(useEn, yearLangKey, dayLangKey, hourLangKey, minLangKey, secLangKey)
	if useEn then
		if not TimeUtil.DateEnFormat.Year then
			local yearFmt = luaLang(yearLangKey)

			if useEn then
				if not TimeUtil.DateEnFormat.Day then
					local dayFmt = luaLang(dayLangKey)

					if useEn then
						if not TimeUtil.DateEnFormat.Hour then
							local hourFmt = luaLang(hourLangKey)

							if useEn then
								if not TimeUtil.DateEnFormat.Minute then
									local minFmt = luaLang(minLangKey)

									if useEn then
										if not TimeUtil.DateEnFormat.Second then
											local secFmt = luaLang(secLangKey)

											return yearFmt, dayFmt, hourFmt, minFmt, secFmt
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

local function _YYYYDDhhmmssFormat2(useEn)
	return _YYYYDDhhmmssFormat(useEn, "time_year", "time_day", "time_hour2", "time_minute2", "time_second")
end

local function _DDhhmmssFormat(useEn, dayLangKey, hourLangKey, minLangKey, secLangKey)
	local yearFmt, dayFmt, hourFmt, minFmt, secFmt = _YYYYDDhhmmssFormat(useEn, "time_year", dayLangKey, hourLangKey, minLangKey, secLangKey)

	return dayFmt, hourFmt, minFmt, secFmt
end

local function _DDhhmmssFormat1(useEn)
	return _DDhhmmssFormat(useEn, "time_day", "time_hour", "time_minute", "time_second")
end

local function _DDhhmmssFormat2(useEn)
	return _DDhhmmssFormat(useEn, "time_day", "time_hour2", "time_minute2", "time_second")
end

function TimeUtil.secondsToDDHHMMSS(seconds)
	seconds = math.floor(seconds)

	local day = math.floor(seconds / 86400)
	local hour = math.floor(seconds % 86400 / 3600)
	local min = math.floor(seconds % 3600 / 60)
	local sec = math.floor(seconds % 60)

	return day, hour, min, sec
end

function TimeUtil.secondToHMS(seconds)
	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(seconds)

	if day > 0 then
		hour = hour + day * 24
	end

	return hour, min, sec
end

function TimeUtil.second2TimeString(seconds, isShowHour)
	local hour, min, sec = TimeUtil.secondToHMS(seconds)

	if isShowHour then
		return string.format("%02d:%02d:%02d", hour, min, sec)
	else
		return string.format("%02d:%02d", min, sec)
	end
end

function TimeUtil.stringToTimestamp(str)
	if string.nilorempty(str) then
		return 0
	end

	local _, _, y, m1, d, h, m2, s = string.find(str, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")

	if not y or not m1 or not d or not h or not m2 or not s then
		logError("请输入正确的时间文本格式!")

		return 0
	end

	local dtTable = {
		year = y,
		month = m1,
		day = d,
		hour = h,
		min = m2,
		sec = s
	}

	return TimeUtil.dtTableToTimeStamp(dtTable) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
end

function TimeUtil.timeToTimeStamp(year, month, day, hour, min, sec)
	local dtTable = {
		year = year,
		month = month,
		day = day,
		hour = hour,
		min = min,
		sec = sec
	}

	return TimeUtil.dtTableToTimeStamp(dtTable) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
end

function TimeUtil.dtTableToTimeStamp(dtTable)
	local timeStamp = os.time(dtTable)

	if not timeStamp then
		timeStamp = os.time(TimeUtil.maxDateTable)

		logError("os.time 32位溢出，输入时间超出2038年")
	end

	return timeStamp
end

function TimeUtil.timestampToString(time)
	return (os.date("%Y-%m-%d %H:%M:%S", time))
end

function TimeUtil.langTimestampToString(time)
	if LangSettings.instance:getCurLangShortcut() == "en" then
		return os.date("%m/%d/%Y %H:%M:%S", time)
	else
		return os.date("%Y-%m-%d %H:%M:%S", time)
	end
end

function TimeUtil.timestampToString1(time)
	return (os.date("%Y-%m-%d", time))
end

function TimeUtil.timestampToString2(time)
	return (string.format(os.date("%Y%%s%m%%s%d%%s", time), luaLang("time_year"), luaLang("time_month"), luaLang("time_day2")))
end

function TimeUtil.timestampToString3(time)
	return (os.date("%Y.%m.%d", time))
end

function TimeUtil.langTimestampToString3(time)
	if LangSettings.instance:getCurLangShortcut() == "en" then
		return os.date("%m/%d/%Y", time)
	else
		return os.date("%Y.%m.%d", time)
	end
end

function TimeUtil.timestampToString4(time)
	return (os.date("%H:%M", time))
end

function TimeUtil.timestampToString5(time)
	return (os.date("%Y/%m/%d", time))
end

function TimeUtil.timestampToString6(time)
	return (os.date("%Y-%m-%d %H", time))
end

function TimeUtil.localTime2ServerTimeString(time, format)
	if time then
		format = format or "%Y/%m/%d"

		return (os.date(format, ServerTime.timeInLocal(time)))
	end
end

function TimeUtil.timestampToTable(time)
	local timeTxt = os.date("%Y#%m#%d#%H#%M#%S", time)
	local times = string.split(timeTxt, "#")
	local year = tonumber(times[1])
	local month = tonumber(times[2])
	local day = tonumber(times[3])
	local hour = tonumber(times[4])
	local min = tonumber(times[5])
	local sec = tonumber(times[6])

	return {
		year = year,
		month = month,
		day = day,
		hour = hour,
		min = min,
		sec = sec
	}
end

function TimeUtil.secondToRoughTime(seconds, useEn)
	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(seconds)
	local date, dateformate
	local hasday = day > 0

	if day > 0 then
		date = day
		dateformate = useEn and TimeUtil.DateEnFormat.Day or luaLang("time_day")
	elseif hour > 0 then
		date = hour
		dateformate = useEn and TimeUtil.DateEnFormat.Hour or luaLang("time_hour")
	else
		date = min > 0 and min or "<1"
		dateformate = useEn and TimeUtil.DateEnFormat.Minute or luaLang("time_minute")
	end

	return date, dateformate, hasday
end

function TimeUtil.secondToRoughTime2(seconds, useEn)
	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(seconds)
	local date, dateformate

	if day > 0 then
		date = day
		dateformate = useEn and TimeUtil.DateEnFormat.Day or luaLang("time_day")
	elseif hour > 0 then
		date = hour
		dateformate = useEn and TimeUtil.DateEnFormat.Hour or luaLang("time_hour")
	elseif min >= 60 then
		date = 1
		dateformate = useEn and TimeUtil.DateEnFormat.Hour or luaLang("time_hour")
	else
		if min == 0 then
			min = 1
		end

		date = min
		dateformate = useEn and TimeUtil.DateEnFormat.Minute or luaLang("time_minute")
	end

	return date, dateformate
end

function TimeUtil.secondToRoughTime3(seconds, useEn)
	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(seconds)
	local dayFmt, hourFmt, minFmt = _DDhhmmssFormat1(useEn)

	if day > 0 then
		return _dateStr(day, dayFmt, hour, hourFmt)
	elseif hour > 0 then
		return _dateStr(hour, hourFmt, min, minFmt)
	elseif min > 0 then
		return (useEn or nil) and (" " .. min .. " " .. TimeUtil.DateEnFormat.Minute or min .. " " .. luaLang("time_minute"))
	else
		return luaLang("summonmain_deadline_time_min")
	end
end

function TimeUtil.convertWday(wday)
	wday = wday - 1

	if wday <= 0 then
		wday = 7
	end

	return wday
end

function TimeUtil.weekDayToLangStr(value)
	local langkey = string.format("weekday%s", value)

	return luaLang(langkey)
end

function TimeUtil.isSameDay(timeA, timeB)
	local dateA = os.date("!*t", timeA + ServerTime.serverUtcOffset())
	local dateB = os.date("!*t", timeB + ServerTime.serverUtcOffset())

	if dateA.year ~= dateB.year then
		return false
	end

	if dateA.month ~= dateB.month then
		return false
	end

	if dateA.day ~= dateB.day then
		return false
	end

	return true
end

function TimeUtil.getDiffDay(timeA, timeB)
	local timeATxt = os.date("%Y#%m#%d#%H#%M#%S", timeA)
	local timesA = string.split(timeATxt, "#")
	local yearA = tonumber(timesA[1])
	local monthA = tonumber(timesA[2])
	local dayA = tonumber(timesA[3])
	local timeBTxt = os.date("%Y#%m#%d#%H#%M#%S", timeB)
	local timesB = string.split(timeBTxt, "#")
	local yearB = tonumber(timesB[1])
	local monthB = tonumber(timesB[2])
	local dayB = tonumber(timesB[3])
	local timeDayA = os.time({
		hour = 0,
		min = 0,
		sec = 0,
		year = yearA,
		month = monthA,
		day = dayA
	})
	local timeDayB = os.time({
		hour = 0,
		min = 0,
		sec = 0,
		year = yearB,
		month = monthB,
		day = dayB
	})

	if not timeDayA or not timeDayB then
		logError("os.time 32位溢出，输入时间超出2038年")

		return 0
	end

	local diffTime = math.abs(timeDayA - timeDayB)

	return diffTime / 60 / 60 / 24
end

function TimeUtil.setDayFirstLoginRed(sign)
	local str = TimeUtil.timestampToString1(ServerTime.now() - 18000)

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayinfo().userId .. "_" .. PlayerPrefsKey.FirstLoginTodayRed .. "_" .. sign, str)
end

function TimeUtil.getDayFirstLoginRed(sign)
	local str = TimeUtil.timestampToString1(ServerTime.now() - 18000)
	local cur_save = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayinfo().userId .. "_" .. PlayerPrefsKey.FirstLoginTodayRed .. "_" .. sign)

	return cur_save ~= str
end

function TimeUtil.setWeekFirstLoginRed(sign)
	local weekEndTime = math.floor(ServerTime.getWeekEndTimeStamp(true) / 3600)

	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayinfo().userId .. "_" .. PlayerPrefsKey.FirstLoginWeekRed .. "_" .. sign, weekEndTime)
end

function TimeUtil.getWeekFirstLoginRed(sign)
	local weekEndTime = math.floor(ServerTime.getWeekEndTimeStamp(true) / 3600)
	local cur_save = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayinfo().userId .. "_" .. PlayerPrefsKey.FirstLoginWeekRed .. "_" .. sign, 0)

	return cur_save ~= weekEndTime
end

function TimeUtil.getTodayWeedDay(dt)
	if dt.wday == 1 then
		return 7
	end

	return dt.wday - 1
end

function TimeUtil.getFormatTime2(seconds, useEn)
	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(seconds)
	local dayFmt, hourFmt, minFmt, secFmt = _DDhhmmssFormat2(useEn)

	if day > 0 then
		return _dateStr(day, dayFmt, hour, hourFmt)
	elseif hour > 0 then
		return _dateStr(hour, hourFmt, min, minFmt)
	elseif min > 0 then
		return _dateStr(min, minFmt, sec, secFmt)
	else
		return string.format("%s%s", sec, secFmt)
	end
end

function TimeUtil.getFormatTime1(seconds, useEn)
	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(seconds)
	local dayFmt, hourFmt, minFmt, secFmt = _DDhhmmssFormat2(useEn)

	if day > 0 then
		return string.format("%s%s", day, dayFmt)
	elseif hour > 0 then
		return string.format("%s%s", hour, hourFmt)
	elseif min > 0 then
		return string.format("%s%s", min, minFmt)
	else
		return string.format("%s%s", sec, secFmt)
	end
end

local oneYearSecond = 31536000

function TimeUtil.SecondToActivityTimeFormat(seconds, useEn)
	local year = math.floor(seconds / oneYearSecond)
	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(seconds % oneYearSecond)
	local yearFormat, dayFmt, hourFmt, minFmt, secFmt = _YYYYDDhhmmssFormat2(useEn)

	if year > 0 then
		return _dateStr(year, yearFormat, day, dayFmt)
	elseif day > 0 then
		return _dateStr(day, dayFmt, hour, hourFmt)
	elseif hour > 0 then
		return _dateStr(hour, hourFmt, min, minFmt)
	else
		return _dateStr(0, hourFmt, math.max(1, min), minFmt)
	end
end

TimeUtil.maxDateTimeStamp = TimeUtil.dtTableToTimeStamp({
	hour = 0,
	month = 1,
	year = 2038,
	min = 0,
	sec = 0,
	day = 1
})

function TimeUtil.getServerDateToString()
	local dt = ServerTime.nowDateInLocal()

	return string.format("%04d-%02d-%02d %02d:%02d:%02d", dt.year, dt.month, dt.day, dt.hour, dt.min, dt.sec)
end

function TimeUtil.getServerDateUTCToString()
	return TimeUtil.getServerDateToString() .. " (" .. ServerTime.GetUTCOffsetStr() .. ")"
end

function TimeUtil.getTimeStamp(timeTable, zoneOffset)
	local timeStamp = TimeUtil.dtTableToTimeStamp(timeTable)
	local currentOffset = TimeUtil.getCurrentZoneOffset()
	local offset = currentOffset - zoneOffset

	timeStamp = timeStamp + 3600 * offset

	return timeStamp - ServerTime.getDstOffset()
end

function TimeUtil.getCurrentZoneOffset()
	return os.difftime(os.time(), os.time(os.date("!*t", os.time()))) / 3600
end

function TimeUtil.isDstTime(timeStamp)
	local time = os.date("*t", timeStamp)

	return time.isdst
end

function TimeUtil.getFormatTime(seconds)
	if not seconds or seconds <= 0 then
		return luaLang("summonmain_deadline_time_min")
	end

	local year = math.floor(seconds / oneYearSecond)
	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(seconds % oneYearSecond)
	local yearFormat, dayFmt, hourFmt, minFmt, secFmt = _YYYYDDhhmmssFormat2()

	if year > 0 then
		return _dateStr(year, yearFormat, day, dayFmt)
	elseif day > 0 then
		return _dateStr(day, dayFmt, hour, hourFmt)
	elseif hour > 0 then
		return _dateStr(hour, hourFmt, min, minFmt)
	elseif min > 0 then
		return string.format("%s%s", min, minFmt)
	else
		return luaLang("summonmain_deadline_time_min")
	end
end

function TimeUtil.getFormatTimeTable(timeStr)
	local t = {}

	for i = 1, #timeStr do
		local num = tonumber(string.sub(timeStr, i, i))

		if num then
			table.insert(t, num)
		end
	end

	return t
end

return TimeUtil
