-- chunkname: @IQIGame\\Global.lua

local __global_timeUnitToSeconds1 = {
	86400,
	3600,
	60,
	1
}
local __global_timeUnitToSeconds2 = {
	3600,
	60,
	1
}
local __global_default_time_format_hms = {
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

function urlEncode(s)
	s = string.gsub(s, "([^%w%.%- ])", function(c)
		return string.format("%%%02X", string.byte(c))
	end)
	s = string.gsub(s, " ", "+")

	return s
end

function getErrorMsg(code)
	if code == 0 then
		return ""
	end

	if code > 100000 then
		local data = CfgLoginErrorCodeTable[code]

		if data ~= nil then
			return data.Describe
		end
	else
		local data = CfgErrorCodeTable[code]

		if data ~= nil then
			return data.Describe
		end
	end

	return "UNKNOWN ERROR CODE " .. code
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
	local cfgTipData = CfgTipTable[tipID]

	if cfgTipData == nil then
		logError("Tip not found in Tip.csv : {0}", tipID)

		return ""
	end

	if tipID == 9 or tipID == 10 or tipID == 11 then
		return CfgTipTable[tipID].Text
	end

	local argsNum = select("#", ...)

	if argsNum == 0 then
		return CfgTipTable[tipID].Text
	end

	return string.format(CfgTipTable[tipID].Text, ...)
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

function getCustomDateTimeText(timeStamp, miscApiKey)
	return __getTimeFormatText(timeStamp, miscApiKey)
end

function __getTimeFormatText(timeStamp, apiKey)
	timeStamp = timeStamp + PlayerModule.TimeZone * 3600

	local isH12 = MiscApi:GetString("IsHour12")
	local isAm = false

	if isH12 then
		local hour24 = os.date("!*t", timeStamp).hour

		isAm = hour24 < 12
	end

	local formatStr, hasAmOrPm = MiscApi:GetString(apiKey, isH12)
	local formattedStr = os.date(formatStr, timeStamp)

	return MiscApi:GetString("FinalTimeFormat", formattedStr, hasAmOrPm, isAm)
end

function getDateTimeTable(timeStamp)
	timeStamp = timeStamp + PlayerModule.TimeZone * 3600

	return os.date("!*t", timeStamp)
end

function getTimeDurationText(second, index)
	local timeText = ""
	local currentValue
	local leftValue = second
	local len = #__global_timeUnitToSeconds1

	if index ~= nil and index > 0 and index < 5 then
		len = index
	end

	for i = 1, len do
		currentValue = math.floor(leftValue / __global_timeUnitToSeconds1[i])
		leftValue = second % __global_timeUnitToSeconds1[i]

		if currentValue > 0 or i == len then
			timeText = timeText .. getTipText(Constant.TipConst.TIP_DAY_NUM - 1 + i, currentValue)
		end
	end

	return timeText
end

function getTimeDurationText2(second, removeZero, unitNum)
	if unitNum == nil then
		unitNum = 3
	end

	local timeText = ""
	local currentValue
	local leftValue = second
	local len = #__global_timeUnitToSeconds2
	local unitStartIndex = len - unitNum

	for i = 1, len do
		currentValue = math.floor(leftValue / __global_timeUnitToSeconds2[i])
		leftValue = second % __global_timeUnitToSeconds2[i]

		if unitStartIndex < i and (not removeZero or currentValue > 0 or i == len) then
			if currentValue < 10 then
				timeText = timeText .. "0" .. currentValue
			else
				timeText = timeText .. currentValue
			end

			if i < len then
				timeText = timeText .. ":"
			end
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
	local index = #__global_timeUnitToSeconds1

	for i = 1, #__global_timeUnitToSeconds1 do
		if second >= __global_timeUnitToSeconds1[i] then
			index = i

			break
		end
	end

	local tipCid = 0

	if index == 1 then
		tipCid = Constant.TipConst.TIP_DAY_NUM
	elseif index == 2 then
		tipCid = Constant.TipConst.TIP_HOUR_NUM
	elseif index == 3 then
		tipCid = Constant.TipConst.TIP_MINUTE_NUM
	elseif index == 4 then
		tipCid = Constant.TipConst.TIP_SECOND_NUM
	end

	timeText = getTipText(tipCid, math.floor(second / __global_timeUnitToSeconds1[index]))

	return timeText
end

function cfgDateTimeToTimeStamp(cfgTime, timeZone)
	if cfgTime == "" then
		return 0
	end

	if timeZone == nil then
		timeZone = PlayerModule.TimeZone
	end

	local dateAndTime = string.split(string.trim(cfgTime), " ")
	local dates = string.split(dateAndTime[1], "/")
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

function int2bin(n)
	local t = {}

	for i = 32, 0, -1 do
		if type(n) ~= "number" then
			logError("int2bin error: " .. n)
		end

		t[#t + 1] = math.floor(n / 2^i)
		n = n % 2^i
	end

	return table.concat(t)
end

function getBinBitValue(num, bit)
	local binStr = int2bin(num)
	local indexFromRight = 0

	for i = #binStr, 1, -1 do
		indexFromRight = indexFromRight + 1

		if bit == indexFromRight then
			return tonumber(string.sub(binStr, i, i))
		end
	end

	return 0
end

api_text_process = string.format
api_datetime_text = getDateTimeText
api_date_text = getDateText
api_time_text = getTimeText

function api_item(id)
	return CfgItemTable[id]
end

api_duration_text = getTimeDurationText
api_time_text_to_seconds = cfgDateTimeToTimeStamp

function getTableLength(tb)
	local ret = 0

	for i, v in pairs(tb) do
		ret = ret + 1
	end

	return ret
end

function setRendererSortingOrder(gameObject, order)
	local renderers = gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	for i = 0, renderers.Length - 1 do
		renderers[i].sortingOrder = order
	end
end

function setGameObjectLayers(parent, layerName)
	local layerId = UnityEngine.LayerMask.NameToLayer(layerName)

	__setGameObjectLayers(parent, layerId)
end

function __setGameObjectLayers(parent, layerId)
	parent.gameObject.layer = layerId

	for i = 0, parent.childCount - 1 do
		local child = parent:GetChild(i)

		child.gameObject.layer = layerId

		__setGameObjectLayers(child, layerId)
	end
end

function setAnimatorTrigger(go, triggerName)
	local animator = go:GetComponentInChildren(typeof(UnityEngine.Animator))

	animator:SetTrigger(triggerName)
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

function worldToScreenPoint(sceneCamera, uiCamera, sceneTrans, uiTrans)
	return __changePointSystem(sceneCamera, uiCamera, sceneTrans, uiTrans)
end

function screenToWorldPoint(uiCamera, sceneCamera, uiTrans, sceneTrans)
	return __changePointSystem(uiCamera, sceneCamera, uiTrans, sceneTrans)
end

function __changePointSystem(fromCamera, toCamera, fromTrans, toTrans)
	local fromPoint = fromCamera:WorldToScreenPoint(fromTrans.position)
	local toPoint = toCamera:ScreenToWorldPoint(fromPoint)

	if toTrans ~= nil then
		toPoint.z = toTrans.position.z
		toTrans.position = toPoint
	end

	return toPoint
end

function extend(base, extendProperties)
	local m = Clone(base)

	for key, value in pairs(extendProperties) do
		m[key] = value
	end

	return m
end

function isBasicType(value)
	if value == nil then
		return false
	end

	local t = type(value)

	if t == "number" or t == "string" or t == "boolean" then
		return true
	end

	return false
end

function deepClonePOD(src, target, keepAllTableReference)
	local newT = target

	if newT == nil then
		newT = {}
	else
		clearTable(newT, keepAllTableReference)
	end

	for key, value in pairs(src) do
		if type(value) == "table" then
			newT[key] = deepClonePOD(value, newT[key])
		else
			newT[key] = value
		end
	end

	return newT
end

function clearTable(t, keepTableValueReference)
	if t == nil then
		logError("参数t不能为空。")

		return
	end

	if next(t) == nil then
		return
	end

	for key, value in pairs(t) do
		if keepTableValueReference and type(value) == "table" then
			clearTable(value, true)
		else
			t[key] = nil
		end
	end
end

function inverseTransformPoint(canvas, position)
	local currentSize = canvas.transform.sizeDelta
	local canvasScaler = canvas:GetComponent(typeof(UnityEngine.UI.CanvasScaler))

	if canvasScaler == nil then
		logError("CanvasScaler为空，必须使用UI根节点的Canvas")

		return position
	end

	local standardSize = canvasScaler.referenceResolution
	local rectTransform = canvas.transform
	local anchoredPositionWithScale = rectTransform:InverseTransformPoint(position)
	local resultPos = anchoredPositionWithScale:Clone()
	local scale = 1

	if currentSize.x / currentSize.y < 1.7786666666666666 then
		scale = currentSize.x / standardSize.x
	end

	resultPos.x = anchoredPositionWithScale.x / scale
	resultPos.y = anchoredPositionWithScale.y / scale

	return resultPos
end
