-- chunkname: @IQIGame\\Global.lua

colorCode = {
	Violet = "#FF00FF",
	Red = "#FF0000",
	Yellow = "#FFFF00",
	Green = "#00FF00"
}
__global_default_time_format_hms = {
	"00",
	"00",
	"00"
}

function logDebug(message, ...)
	Log.Debug(tostring(message) .. debug.traceback("", 1), ...)
end

function log(message, ...)
	Log.Info(tostring(message) .. debug.traceback("", 1), ...)
end

function warning(message, ...)
	Log.Warning(tostring(message) .. debug.traceback("", 1), ...)
end

function logError(message, ...)
	local msg = tostring(message) .. debug.traceback("", 1)

	Log.Error(msg, ...)
end

function logColorInfo(message, colorCode, ...)
	Log.Info(string.format("<color=%s>%s</color>", colorCode, tostring(message)) .. debug.traceback("", 1), ...)
end

function urlEncode(s)
	s = string.gsub(s, "([^%w%.%- ])", function(c)
		return string.format("%%%02X", string.byte(c))
	end)

	return string.gsub(s, " ", "+")
end

function getErrorMsg(code)
	if code == 0 then
		return ""
	end

	if CfgErrorCodeTable[code] == nil then
		return "Unknown Error : " .. code
	end

	return CfgErrorCodeTable[code].Describe
end

function getErrorFormatMsg(code, ...)
	if code == 0 then
		return ""
	end

	if CfgErrorCodeTable[code] == nil then
		return "Unknown Error : " .. code
	end

	return string.format(CfgErrorCodeTable[code].Describe, ...)
end

function getI18NValue(id)
	if id == 0 then
		return ""
	end

	local data = CfgI18NTable[id]

	if data == nil then
		return ""
	end

	local refID = data.RefId

	if refID > 0 then
		return getI18NValue(refID)
	else
		return data.Str
	end
end

function getTipText(tipID, ...)
	local cfgTipData = CfgTipsTable[tipID]

	if cfgTipData == nil then
		logError("Tip not found in Tip.csv : {0}", tipID)

		return ""
	end

	if tipID == 9 or tipID == 10 or tipID == 11 then
		return CfgTipsTable[tipID].Text
	end

	local argsNum = select("#", ...)

	if argsNum == 0 then
		return CfgTipsTable[tipID].Text
	end

	return string.format(CfgTipsTable[tipID].Text, ...)
end

function getDateTimeText(timeStamp)
	return __getTimeFormatText(timeStamp, "DateTimeFormat")
end

function getDateTimeMText(timeStamp)
	return __getTimeFormatText(timeStamp, "DateTimeFormatM")
end

function getDateText(timeStamp)
	return __getTimeFormatText(timeStamp, "DateFormat")
end

function getDateText2(timeStamp)
	return __getTimeFormatText(timeStamp, "DateFormat2")
end

function getTimeText(timeStamp)
	return __getTimeFormatText(timeStamp, "TimeFormat")
end

function getYearText(timeStamp)
	return __getTimeFormatText(timeStamp, "YearFormat")
end

function getMonthText(timeStamp)
	return __getTimeFormatText(timeStamp, "MonthFormat")
end

function getWeekText(timeStamp)
	return __getTimeFormatText(timeStamp, "WeekFormat")
end

function getOnlyDateText(timeStamp)
	return __getTimeFormatText(timeStamp, "OnlyDateFormat")
end

function getHourText(timeStamp)
	return __getTimeFormatText(timeStamp, "HourFormat")
end

function getHourMinuteText(timeStamp)
	return __getTimeFormatText(timeStamp, "HourMinuteFormat")
end

function getMonthAndDayText(timeStamp)
	return __getTimeFormatText(timeStamp, "MonthAndDayFormat")
end

function GetTimeDurationNum(second)
	local timeUnitToSeconds = {
		86400,
		3600,
		60,
		1
	}
	local currentValue
	local leftValue = second
	local len = 1

	for i = 1, len do
		currentValue = math.floor(leftValue / timeUnitToSeconds[i])
	end

	return currentValue
end

function getCustomDateTimeText(timeStamp, miscApiKey)
	return __getTimeFormatText(timeStamp, miscApiKey)
end

function getTimeDurationText(second, index)
	local timeText = ""
	local timeUnitToSeconds = {
		86400,
		3600,
		60,
		1
	}
	local currentValue
	local leftValue = second
	local len = #timeUnitToSeconds

	if index ~= nil and index > 0 and index < 5 then
		len = index
	end

	for i = 1, len do
		currentValue = math.floor(leftValue / timeUnitToSeconds[i])
		leftValue = second % timeUnitToSeconds[i]

		if currentValue > 0 or i == len then
			timeText = timeText .. getTipText(Constant.TipConst.TIP_DAY_NUM - 1 + i, currentValue)
		end
	end

	return timeText
end

function getSimpleTimeDurationText(second)
	if second == nil then
		logError("格式化时间错误，second == nil")

		return ""
	end

	local timeText = ""
	local timeUnitToSeconds = {
		86400,
		3600,
		60,
		1
	}
	local timeUnitTextTipId = {
		Constant.TipConst.TIP_DAY_NUM,
		Constant.TipConst.TIP_HOUR_NUM,
		Constant.TipConst.TIP_MINUTE_NUM,
		Constant.TipConst.TIP_SECOND_NUM
	}
	local index = #timeUnitToSeconds

	for i = 1, #timeUnitToSeconds do
		if second >= timeUnitToSeconds[i] then
			index = i

			break
		end
	end

	timeText = getTipText(timeUnitTextTipId[index], math.floor(second / timeUnitToSeconds[index]))

	return timeText
end

function setIsRayCastTarget(gameObject, value, recursively)
	local graphics = gameObject:GetComponents(typeof(UnityEngine.UI.Graphic))

	if graphics.Length > 0 then
		for i = 0, graphics.Length - 1 do
			graphics[i].raycastTarget = value
		end
	end

	if recursively and gameObject.transform.childCount > 0 then
		for i = 0, gameObject.transform.childCount - 1 do
			setIsRayCastTarget(gameObject.transform:GetChild(i).gameObject, value, recursively)
		end
	end
end

api_text_process = string.format
api_datetime_text = getDateTimeText
api_date_text = getDateText
api_time_text = getTimeText

function getMonthText(second)
	return os.date("%m", second)
end

function api_item(id)
	return CfgItemTable[id]
end

api_duration_text = getTimeDurationText

function getTableLength(tb)
	local ret = 0

	if tb == nil then
		return ret
	end

	for i, v in pairs(tb) do
		ret = ret + 1
	end

	return ret
end

function getCfgTableLength(cfgTable)
	local length = 0

	for _, _ in pairsCfg(cfgTable) do
		length = length + 1
	end

	return length
end

function getTypeIsTable(tb)
	return type(tb) == "table"
end

function SetRenderSortingOrder(parent, order)
	local comp = parent:GetComponent("Renderer")

	if comp ~= nil then
		comp.sortingOrder = order
	end

	for i = 0, parent.childCount - 1 do
		local child = parent:GetChild(i)

		comp = child:GetComponent("Renderer")

		if comp ~= nil then
			comp.sortingOrder = order
		end

		SetRenderSortingOrder(child, order)
	end
end

function setGameObjectLayers(parent, layerName)
	parent.gameObject.layer = UnityEngine.LayerMask.NameToLayer(layerName)

	local count = parent.childCount
	local child

	for i = 0, count - 1 do
		child = parent:GetChild(i)
		child.gameObject.layer = UnityEngine.LayerMask.NameToLayer(layerName)

		local comp = child:GetComponent("Renderer")

		if comp ~= nil then
			comp.sortingLayerName = UnityEngine.LayerMask.NameToLayer(layerName)
		end

		setGameObjectLayers(child, layerName)
	end
end

function findOnTransformByNameRecursively(transform, name)
	if transform.name == name then
		return transform
	end

	for i = 0, transform.childCount - 1 do
		local result = findOnTransformByNameRecursively(transform:GetChild(i), name)

		if result ~= nil then
			return result
		end
	end

	return nil
end

function hexStringToColor(hexString)
	hexString = string.sub(hexString, 2, -1)

	local len = string.len(hexString)
	local r = string.sub(hexString, 1, 2)
	local g = string.sub(hexString, 3, 4)
	local b = string.sub(hexString, 5, 6)
	local a = "ff"

	if len > 6 then
		a = string.sub(hexString, 7, 8)
	end

	return Color(tonumber(r, 16) / 255, tonumber(g, 16) / 255, tonumber(b, 16) / 255, tonumber(a, 16) / 255)
end

function tableToString(t)
	if t == nil then
		return "nil"
	end

	local str = "{"

	for key, value in pairs(t) do
		local valueStr

		if type(value) == "table" then
			valueStr = tableToString(value)
		else
			valueStr = tostring(value)
		end

		str = str .. key .. " = " .. valueStr .. ", "
	end

	str = str .. "}"

	return str
end

function GetFormatTime(second)
	local timeText = ""
	local h = math.floor(second / 3600)

	h = h < 10 and "0" .. h or tostring(h)

	local m = math.floor(second % 3600 / 60)

	m = m < 10 and "0" .. m or tostring(m)

	local s = math.floor(second % 60)

	s = s < 10 and "0" .. s or tostring(s)
	timeText = string.format("%s:%s:%s", h, m, s)

	return timeText
end

function cfgDateTimeToTimeStamp(cfgTime, timeZone, separator)
	if cfgTime == "" then
		return 0
	end

	if timeZone == nil then
		timeZone = PlayerModule.TimeZone
	end

	if separator == nil then
		separator = "/"
	end

	local dateAndTime = string.split(string.trim(cfgTime), " ")
	local dates = string.split(dateAndTime[1], separator)
	local times = __global_default_time_format_hms

	if #dateAndTime > 1 then
		times = string.split(dateAndTime[#dateAndTime], ":")
	end

	local dateTable = {}

	dateTable.year = dates[1]
	dateTable.month = dates[2]
	dateTable.day = dates[3]
	dateTable.hour = times[1]
	dateTable.min = times[2]
	dateTable.sec = times[3]

	return dateTimeToTimeStamp(dateTable, timeZone)
end

function dateTimeToTimeStamp(date, timeZone)
	local localTimeZone = getLocalTimeZone()

	date.isdst = false

	local cfgTimeToUnixTime = os.time(date) + localTimeZone * 3600

	return cfgTimeToUnixTime - timeZone * 3600
end

function getLocalTimeZone()
	local unixDate = os.date("!*t", os.time())
	local diffTimeLocalToUnix = os.difftime(os.time(), os.time(unixDate))

	return diffTimeLocalToUnix / 3600
end

function getMountPoint(transform, pointCid)
	if transform == nil then
		logError("获取挂载点出错：transform不能为空。")

		return nil
	end

	if LuaCodeInterface.GameObjIsDestroy(transform) then
		logError("获取挂载点出错：transform已被销毁。")

		return nil
	end

	if pointCid == nil or pointCid == 0 then
		logError("获取挂载点出错：PointCid" .. tostring(pointCid) .. "无效.")

		return nil
	end

	local cfgElementPointData = CfgElementPointTable[pointCid]

	if cfgElementPointData == nil then
		logError("获取挂载点出错：在ElementPoint表中找不到PointCid" .. tostring(pointCid) .. "对应的配置.")

		return nil
	end

	local mountPointTrans = findOnTransformByNameRecursively(transform, cfgElementPointData.PointName)

	if mountPointTrans == nil then
		logError("获取挂载点出错：找不到挂点 Transform name: " .. transform.name .. " ElementPoint Cid: " .. pointCid)

		return nil
	end

	return mountPointTrans
end

function __getTimeFormatText(timeStamp, apiKey)
	timeStamp = timeStamp + PlayerModule.TimeZone * 3600

	return os.date(MiscApi:GetString(apiKey), timeStamp)
end

function getDateTimeTable(timeStamp)
	timeStamp = timeStamp + PlayerModule.TimeZone * 3600

	return os.date("!*t", timeStamp)
end

function getDateTimeDiffDay(timeStamp1, timeStamp2)
	local date1 = getDateTimeTable(timeStamp1)
	local date2 = getDateTimeTable(timeStamp2)
	local num1 = os.time({
		year = date1.year,
		month = date1.month,
		day = date1.day
	})
	local num2 = os.time({
		year = date2.year,
		month = date2.month,
		day = date2.day
	})

	return math.abs(num1 - num2) / 86400
end

function getDateTimeDiffDay_New(timeStamp1, timeStamp2)
	local date1 = getDateTimeTable(timeStamp1)
	local date2 = getDateTimeTable(timeStamp2)
	local num1 = os.time({
		year = date1.year,
		month = date1.month,
		day = date1.day
	})
	local num2 = os.time({
		year = date2.year,
		month = date2.month,
		day = date2.day
	})

	return (num1 - num2) / 86400
end

function GetPreciseDecimal(nNum, n)
	if type(nNum) ~= "number" then
		return nNum
	end

	n = n or 0
	n = math.floor(n)

	if n < 0 then
		n = 0
	end

	local nDecimal = 10^n
	local nTemp = math.floor(nNum * nDecimal)
	local nRet = nTemp / nDecimal

	return nRet
end

function FilterName(name)
	local result = {}
	local k = 1

	while true do
		if k > #name then
			break
		end

		local character = name.byte(name, k)

		if not character then
			break
		end

		if character < 192 then
			if character >= 48 and character <= 57 or character >= 65 and character <= 90 or character >= 97 and character <= 122 then
				table.insert(result, name.char(character))
			end

			k = k + 1
		elseif character < 224 then
			k = k + 2
		elseif character < 240 then
			if character >= 228 and character <= 233 then
				local c1 = name.byte(name, k + 1)
				local c2 = name.byte(name, k + 2)

				if c1 and c2 then
					local a1, a2, a3, a4 = 128, 191, 128, 191

					if character == 228 then
						a1 = 184
					elseif character == 233 then
						a2, a4 = 190, c1 ~= 190 and 191 or 165
					end

					if a1 <= c1 and c1 <= a2 and a3 <= c2 and c2 <= a4 then
						table.insert(result, name.char(character, c1, c2))
					end
				end
			end

			k = k + 3
		elseif character < 248 then
			k = k + 4
		elseif character < 252 then
			k = k + 5
		elseif character < 254 then
			k = k + 6
		end
	end

	return table.concat(result)
end

function DateTimeFormat(sec, fmt, useShort)
	fmt = string.lower(fmt)

	local fmtSecInfo = {}

	fmtSecInfo.d = 86400
	fmtSecInfo.h = 3600
	fmtSecInfo.m = 60
	fmtSecInfo.s = 0

	local startIdx = 1
	local parttern = "%l+"
	local i, j = string.find(fmt, parttern, startIdx)
	local fmtChar = string.match(fmt, parttern, startIdx)
	local retFmt = string.sub(fmt, 1, i - 1)

	while j and fmtChar do
		startIdx = j + 1

		local k, m = string.find(fmt, parttern, startIdx)
		local nextStart = k and k - 1 or #fmt
		local f = string.sub(fmtChar, 1, 1)
		local fmtSec = fmtSecInfo[f]

		if not fmtSec then
			return "时间格式=" .. fmt .. " 无效"
		end

		local val

		if fmtSec > 0 then
			val = math.floor(sec / fmtSec)
			sec = sec % fmtSec
		else
			val = GetPreciseDecimal(sec, 0)
		end

		if val > 0 or not useShort then
			local valStr = tostring(val)

			if #fmtChar == 2 and val < 10 then
				valStr = "0" .. val
			end

			local tempFmtStr = string.sub(fmt, i, nextStart)

			retFmt = retFmt .. string.gsub(tempFmtStr, parttern, valStr)
		end

		fmtChar = string.match(fmt, parttern, startIdx)
		i, j = k, m
	end

	return retFmt
end

function DateStandardFormation(seconds)
	local str

	if seconds <= 0 then
		seconds = 0
	end

	if seconds > 86400 then
		str = DateTimeFormat(seconds, UIGlobalApi.DateTimeFormat_DDHH(), false)
	else
		str = DateTimeFormat(seconds, UIGlobalApi.DateTimeFormat_HHMMSS(), false)
	end

	return str
end

function NumToStr(num)
	if type(num) == "string" then
		return num
	end

	if type(num) ~= "number" then
		logError("数字转字符串错误")

		return num
	end

	local str = ""

	if num > 99999 and num <= 999999 then
		return UIGlobalApi.GetNumToStr_Wan(ConfigNum(math.floor(num * 100 / 10000) * 0.01))
	elseif num > 999999 and num <= 10000000 then
		return UIGlobalApi.GetNumToStr_Wan(ConfigNum(math.floor(num * 100 / 10000) * 0.01))
	elseif num > 10000000 and num <= 99999999 then
		return UIGlobalApi.GetNumToStr_Wan(ConfigNum(math.floor(num * 100 / 10000) * 0.01))
	elseif num > 99999999 then
		return UIGlobalApi.GetNumToStr_Yi(ConfigNum(math.floor(num * 10 / 100000000) * 0.1))
	else
		return ConfigNum(num)
	end
end

function ConfigNum(num)
	t1, t2 = math.modf(num)

	if t2 == 0 then
		return t1
	end

	return num
end

function sortByValue(value1, value2, ascending)
	if value1 == value2 then
		return false, false
	end

	if ascending then
		return true, value2 < value1
	else
		return true, value1 < value2
	end
end

function ClearGC(CSharpGC)
	if csharpGC then
		LuaCodeInterface.GC()
	end

	collectgarbage("collect")
end

function DeepClearTable(t, clearmeta, seen, filter, dispose)
	if type(t) ~= "table" then
		return
	end

	seen = seen or {}

	if seen[t] then
		return
	end

	seen[t] = true

	if dispose and t.Dispose then
		t:Dispose()
	end

	for k, v in pairs(t) do
		if type(v) == "table" then
			DeepClearTable(v, clearmeta, seen, filter)
		elseif not filter or filter(k, v) then
			t[k] = nil
		end
	end

	if not clearmeta then
		return
	end

	local meta = getmetatable(t)

	if meta and meta.__index then
		DeepClearTable(meta.__index, clearmeta, seen, filter)
	end
end

function DestoryUnityObject(t, key)
	if type(t) ~= "table" then
		return
	end

	LuaCodeInterface.TryDestory(t[key])

	t[key] = nil
end

function DestoryAllUnityObjects(t, clearmeta, dispose)
	if type(t) ~= "table" then
		return
	end

	local function filter(k, v)
		if type(v) == "userdata" then
			LuaCodeInterface.TryDestory(v)

			return true
		end

		return false
	end

	DeepClearTable(t, clearmeta, nil, filter, dispose)

	t = nil
	filter = nil
end

function TableToString(t, indent, seen)
	local result = ""

	if type(t) ~= "table" then
		return "table is nil or not table"
	end

	seen = seen or {}

	if seen[t] then
		return result
	end

	seen[t] = true
	indent = indent or 0

	for k, v in pairs(t) do
		if not LuaCodeInterface.IsUnityNull(v) and type(v) ~= "thread" then
			local formatting = string.format("%s%s(%s): ", string.rep("  ", indent), tostring(k), type(v))

			if type(v) == "table" then
				result = result .. formatting .. "{\n"
				result = result .. TableToString(v, indent + 2, seen)
				result = result .. string.rep("  ", indent) .. "}\n"
			else
				result = result .. formatting .. tostring(v) .. "\n"
			end
		end
	end

	return result
end

function PrintTable(name, t, logger)
	name = name or ""

	local result = string.format("<color=#00D5FF> PrintTable : %s(%s) \n%s</color>", name, tostring(t), TableToString(t, 2))

	if logger then
		logger(result)
	else
		print(result)
	end
end

function ForIn(iterators, func)
	if iterators == nil then
		return
	end

	for value in iterators do
		if func(value) == true then
			return
		end
	end
end

function ForPairs(table, func)
	if table == nil then
		return
	end

	for k, v in pairs(table) do
		if func(k, v) == true then
			return
		end
	end
end

function ForArray(table, func)
	if table == nil then
		return
	end

	for i = 1, #table do
		if func(i, table[i]) == true then
			return
		end
	end
end

function ForArrayByCount(begin, count, step, func)
	for i = begin, count, step do
		if func(i) == true then
			return
		end
	end
end

function ForArrayTable(table, func, inverted)
	if table == nil then
		return
	end

	if inverted then
		__ForArray(table, func, #table, 1, -1)
	else
		__ForArray(table, func, 1, #table, 1)
	end
end

function ForArrayCustomStep(table, func, step)
	if table == nil then
		return
	end

	__ForArray(table, func, 1, #table, step)
end

function __ForArray(arrayTable, func, value, limitValue, step)
	for i = value, limitValue, step do
		if func(i, arrayTable[i]) == true then
			return
		end
	end
end

function UUID()
	local seed = {
		"e",
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9",
		"a",
		"b",
		"c",
		"d",
		"e",
		"f"
	}
	local tb = {}

	for i = 1, 32 do
		table.insert(tb, seed[math.random(1, 16)])
	end

	local sid = table.concat(tb)

	return string.format("%s%s%s%s%s", string.sub(sid, 1, 8), string.sub(sid, 9, 12), string.sub(sid, 13, 16), string.sub(sid, 17, 20), string.sub(sid, 21, 32))
end

function TernaryConditionalOperator(expression, ansTrue, ansFalse)
	if expression then
		return ansTrue
	else
		return ansFalse
	end
end

function OrderPairs(tb)
	local a = {}
	local j = 1

	for key, value in pairs(tb) do
		local t = {}

		t.key = key
		t.value = value
		a[j] = t
		j = j + 1
	end

	table.sort(a, function(a, b)
		return a.key < b.key
	end)

	local i = 0

	return function()
		i = i + 1

		if not a[i] then
			return nil, nil
		end

		return a[i].key, tb[a[i].key]
	end
end

function ValueInArray(array, value)
	local isIn = false
	local index = 0

	ForArray(array, function(_index, _value)
		isIn = _value == value
		index = _index

		return isIn
	end)

	return isIn, index
end

function ForTransformChild(transform, handler)
	for i = 0, transform.childCount - 1 do
		local childTrans = transform:GetChild(i)

		handler(childTrans, i)
	end
end

function StrFormat(str, index, param)
	local resultStr = ""
	local placeholderStr = "s" .. index .. "%%"

	if string.find(str, placeholderStr) then
		resultStr = string.gsub(str, placeholderStr, param, 1)
	end

	return resultStr
end

function EnsurePercent(param)
	if string.sub(param, -1) == "%" then
		param = param .. "%"
	end

	return param
end

function TableComparison(tab1, tab2, func)
	local discontinue = false

	ForPairs(tab1, function(_k, _v)
		local v2 = tab2[_k]

		discontinue = func(_k, _v, v2)

		return discontinue
	end)

	if discontinue then
		return
	end

	ForPairs(tab2, function(_k, _v)
		local v1 = tab1[_k]

		if v1 ~= nil then
			return
		end

		discontinue = func(_k, v1, _v)

		return discontinue
	end)
end

function GetArrayValue(arrayTab, index, defaultValue)
	if arrayTab == nil then
		return defaultValue
	end

	local value = arrayTab[index]

	if value == nil then
		return defaultValue
	end

	return value
end

function TryToNumber(value, defaultValue)
	local result = tonumber(value)

	if result == nil then
		return defaultValue
	end

	return result
end

function TryToBoolean(value, defaultValue)
	if value == nil then
		return defaultValue
	end

	if value == true then
		return true
	end

	return false
end

function TryToTable(value, includeEmptyTable, defaultTable)
	if value == nil then
		return defaultTable
	end

	if includeEmptyTable and next(value) == nil then
		return defaultTable
	end

	return value
end

function MergeTables(target, ...)
	for _, tbl in ipairs({
		...
	}) do
		for k, v in pairs(tbl) do
			target[k] = v
		end
	end

	return target
end

function NumberInRange(value, minValue, includeMin, maxValue, includeMax)
	if value < minValue then
		return false
	end

	if value == minValue and not includeMin then
		return false
	end

	if maxValue < value then
		return false
	end

	if value == maxValue and not includeMax then
		return false
	end

	return true
end

function ValueToFloat(value, targetPrecision, exZero)
	local num = TryToNumber(value, 0)

	if num == 0 then
		return 0
	end

	local factor = 10^targetPrecision

	num = math.floor(num * factor + 0.5) / factor

	local formatString = string.format("%%.%d", targetPrecision)
	local numStr = tostring(num, formatString)

	if exZero then
		numStr = string.gsub(numStr, "^%.%d+$", "")
	end

	return TryToNumber(numStr, 0)
end
