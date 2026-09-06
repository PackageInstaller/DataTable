-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redpointex/controller/RedPointExController.lua

module("logic.extensions.redpointex.controller.RedPointExController", package.seeall)

local RedPointExController = class("RedPointExController", BaseController)
local DAY_RED_KEY_PRE = "day_red_key_"
local WEEK_RED_KEY_PRE = "Local_Week_"
local MOON_RED_KEY_PRE = "Local_Moon_"
local ONCE_RED_KEY_PRE = "once_red_key_"
local ONCE_RED_RECORD_KEY_PRE = "once_red_record_key_"

function RedPointExController:ctor()
	return
end

function RedPointExController:onInit()
	self:onReset()
end

function RedPointExController:onReset()
	GlobalDispatcher:removeListener(RedPointAgent.PM_LoadAllRedPointRes, self._regAllRpeRedOnReset, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpenDone, self._setAllRpeRedOnViewOpenDone, self)
	GlobalDispatcher:addListener(RedPointAgent.PM_LoadAllRedPointRes, self._regAllRpeRedOnReset, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpenDone, self._setAllRpeRedOnViewOpenDone, self)
end

function RedPointExController:_regAllRpeRedOnReset()
	GlobalDispatcher:removeListener(RedPointAgent.PM_LoadAllRedPointRes, self._regAllRpeRedOnReset, self)
	self:_regAllCycleRed()
	self:_regAllOnceRed()
end

function RedPointExController:_setAllRpeRedOnViewOpenDone(viewPresentor)
	self:_updateAllCycleRedByView(viewPresentor)
	self:_updateAllOnceRedByView(viewPresentor)
end

function RedPointExController:_regAllCycleRed()
	local dataList = RedPointExConfig.instance:getRpeCycleDataList()

	if dataList then
		for _, data in pairs(dataList) do
			self:_regCycleRedByType(data.cycleRedId, data.redType)
		end
	end
end

function RedPointExController:_updateAllCycleRedByView(viewPresentor)
	local dataList = RedPointExConfig.instance:getRpeCycleDataListByViewName(viewPresentor.viewName)

	if dataList then
		for _, data in ipairs(dataList) do
			self:_saveCycleRedByType(data.cycleRedId, data.redType, true)
		end
	end
end

function RedPointExController:_regCycleRedByType(redId, redType)
	if string.nilorempty(redId) or string.nilorempty(redType) then
		return
	end

	local function handle(value)
		value = checknumber(value)

		local data = RedPointExConfig.instance:getRpeCycleData(redId)

		if data then
			if not string.nilorempty(data.startUnlockTime) and not string.nilorempty(data.endUnlockTime) then
				if self:_isUnlockByForceLockAsCycleRed(redId) then
					local startTimeStamp, endTimeStamp = GameUtil.string2time(data.startUnlockTime), GameUtil.string2time(data.endUnlockTime)

					RedPointController.instance:setRedPointInfo(redId, value == 0, false, startTimeStamp, endTimeStamp, data.funcIdArray)
				end
			elseif self:_isUnlockCycleRed(redId) then
				RedPointController.instance:setRedPointInfo(redId, value == 0)
			end
		else
			RedPointController.instance:setRedPointInfo(redId, value == 0)
		end
	end

	if redType == GameEnum.CycleRedType.Day then
		GameUtil.getUserDayData(DAY_RED_KEY_PRE .. redId, handle)
	elseif redType == GameEnum.CycleRedType.Week then
		GameUtil.getUserWeekData(WEEK_RED_KEY_PRE .. redId, handle)
	elseif redType == GameEnum.CycleRedType.Moon then
		LocalUserDataController.instance:getUserMonthData(MOON_RED_KEY_PRE .. redId, handle)
	else
		printError(string.format("暂不支持此类型红点( redId=%d, redType=%d )", redId, redType))

		return
	end
end

function RedPointExController:_saveCycleRedByType(redId, redType, isHasActivated)
	if string.nilorempty(redId) or string.nilorempty(redType) then
		return
	end

	if RedPointExConfig.instance:getRpeCycleData(redId) then
		if isHasActivated then
			self:_saveCycleRedUserDataByType(redId, redType, isHasActivated)
		elseif self:_isUnlockCycleRed(redId) then
			self:_saveCycleRedUserDataByType(redId, redType, isHasActivated)
		end
	else
		self:_saveCycleRedUserDataByType(redId, redType, isHasActivated)
	end
end

function RedPointExController:_saveCycleRedUserDataByType(redId, redType, isHasActivated)
	if string.nilorempty(redId) or string.nilorempty(redType) then
		return
	end

	local value = isHasActivated and 1 or 0

	if redType == GameEnum.CycleRedType.Day then
		GameUtil.saveUserDayData(DAY_RED_KEY_PRE .. redId, value)
	elseif redType == GameEnum.CycleRedType.Week then
		GameUtil.saveUserWeekData(WEEK_RED_KEY_PRE .. redId, value)
	elseif redType == GameEnum.CycleRedType.Moon then
		LocalUserDataController.instance:saveUserMonthData(MOON_RED_KEY_PRE .. redId, value)
	else
		printError(string.format("暂不支持此类型红点( redId=%d, redType=%d )", redId, redType))

		return
	end

	RedPointController.instance:setRedPointInfo(redId, not isHasActivated)
end

function RedPointExController:_isUnlockCycleRed(cycleRedId)
	return self:_isUnlockByForceLockAsCycleRed(cycleRedId) and self:_isUnlockByTimeAsCycleRed(cycleRedId) and self:_isUnlockByFuncIdAsCycleRed(cycleRedId)
end

function RedPointExController:_isUnlockByForceLockAsCycleRed(cycleRedId)
	local data = RedPointExConfig.instance:getRpeCycleData(cycleRedId)

	return data and not data.isForceLock or false
end

function RedPointExController:_isUnlockByTimeAsCycleRed(cycleRedId)
	return self:_getUnlockTimePeriodAsCycleRed(cycleRedId) == GameUtil.inTimePeriod
end

function RedPointExController:_getUnlockTimePeriodAsCycleRed(cycleRedId)
	local data = RedPointExConfig.instance:getRpeCycleData(cycleRedId)

	if data == nil then
		return GameUtil.errorTimePeriod
	end

	return self:_getTimePeriod(data.startUnlockTime, data.endUnlockTime)
end

function RedPointExController:_isUnlockByFuncIdAsCycleRed(cycleRedId)
	local data = RedPointExConfig.instance:getRpeCycleData(cycleRedId)

	if data == nil then
		return false
	end

	if data.funcIdArray == nil then
		return true
	end

	local isUnlock = true

	for _, funcId in ipairs(data.funcIdArray) do
		if not FuncOpenModel.instance:getFuncIsOpen(funcId) then
			isUnlock = false

			break
		end
	end

	return isUnlock
end

function RedPointExController:_regAllOnceRed()
	local dataList = RedPointExConfig.instance:getRpeOnceDataList()

	if dataList then
		for _, data in pairs(dataList) do
			self:_regOnceRed(data.onceRedId)
		end
	end
end

function RedPointExController:_updateAllOnceRedByView(viewPresentor)
	local dataList = RedPointExConfig.instance:getRpeOnceDataListByViewName(viewPresentor.viewName)

	if dataList then
		for _, data in ipairs(dataList) do
			self:_saveOnceRed(data.onceRedId, true)
		end
	end
end

function RedPointExController:_regOnceRed(redId)
	if string.nilorempty(redId) then
		return
	end

	local function handle(value)
		local data = RedPointExConfig.instance:getRpeOnceData(redId)

		if data then
			if self:_isUnlockOnceRed(redId) then
				local curRecord = self:_makeCurOnceRedRecordValue(redId)
				local oldRecord = self:_getOnceRedRecord(redId)

				if curRecord ~= oldRecord then
					self:_saveOnceRedRecord(redId)
					self:_saveOnceRed(redId, false)
					RedPointController.instance:setRedPointInfo(redId, not data.isStatic)
				elseif value == nil then
					RedPointController.instance:setRedPointInfo(redId, not data.isStatic)
				else
					RedPointController.instance:setRedPointInfo(redId, checknumber(value) == 0)
				end
			end
		else
			RedPointController.instance:setRedPointInfo(redId, checknumber(value) == 0)
		end
	end

	GameUtil.getUserData(ONCE_RED_KEY_PRE .. redId, handle)
end

function RedPointExController:_saveOnceRed(redId, isHasActivated)
	if string.nilorempty(redId) then
		return
	end

	if RedPointExConfig.instance:getRpeOnceData(redId) then
		if isHasActivated then
			self:_saveOnceRedUserData(redId, isHasActivated)
		elseif self:_isUnlockOnceRed(redId) then
			self:_saveOnceRedUserData(redId, isHasActivated)
		end
	else
		self:_saveOnceRedUserData(redId, isHasActivated)
	end
end

function RedPointExController:_saveOnceRedUserData(redId, isHasActivated)
	if string.nilorempty(redId) then
		return
	end

	local value = isHasActivated and 1 or 0

	GameUtil.saveUserData(ONCE_RED_KEY_PRE .. redId, value)
	RedPointController.instance:setRedPointInfo(redId, not isHasActivated)
end

function RedPointExController:_getOnceRedRecord(onceRedId)
	return GameUtil.getUserData(ONCE_RED_RECORD_KEY_PRE .. onceRedId)
end

function RedPointExController:_saveOnceRedRecord(onceRedId)
	GameUtil.saveUserData(ONCE_RED_RECORD_KEY_PRE .. onceRedId, self:_makeCurOnceRedRecordValue(onceRedId))
end

function RedPointExController:_makeCurOnceRedRecordValue(onceRedId)
	local data = RedPointExConfig.instance:getRpeOnceData(onceRedId)

	if data == nil then
		return
	end

	local startTimeStamp = data.startUnlockTime and GameUtil.string2time(data.startUnlockTime) or 0
	local endTimeStamp = data.endUnlockTime and GameUtil.string2time(data.endUnlockTime) or 0
	local value = string.format("%s/%s/%s/%s", data.viewName, data.isForceLock and 1 or 0, startTimeStamp, endTimeStamp)

	value = self:_string10To62(self:_strToAsciiSum(value))

	return value
end

function RedPointExController:_isUnlockOnceRed(onceRedId)
	return self:_isUnlockByForceLockAsOnceRed(onceRedId) and self:_isUnlockByTimeAsOnceRed(onceRedId)
end

function RedPointExController:_isUnlockByForceLockAsOnceRed(onceRedId)
	local data = RedPointExConfig.instance:getRpeOnceData(onceRedId)

	return data and not data.isForceLock or false
end

function RedPointExController:_isUnlockByTimeAsOnceRed(onceRedId)
	return self:_getUnlockTimePeriodAsOnceRed(onceRedId) == GameUtil.inTimePeriod
end

function RedPointExController:_getUnlockTimePeriodAsOnceRed(onceRedId)
	local data = RedPointExConfig.instance:getRpeOnceData(onceRedId)

	if data == nil then
		return GameUtil.errorTimePeriod
	end

	return self:_getTimePeriod(data.startUnlockTime, data.endUnlockTime)
end

function RedPointExController:_getTimePeriod(startTime, endTime)
	local timePeriod = GameUtil.errorTimePeriod

	if string.nilorempty(startTime) and string.nilorempty(endTime) then
		timePeriod = GameUtil.inTimePeriod
	elseif not string.nilorempty(startTime) and not string.nilorempty(endTime) then
		timePeriod = GameUtil.getTimePeriodType(startTime, endTime)
	elseif string.nilorempty(startTime) and not string.nilorempty(endTime) then
		local timeNow = ServerTime.now()
		local timeEnd = GameUtil.string2time(endTime)

		timePeriod = timeEnd <= timeNow and GameUtil.afterTimePeriod or GameUtil.getTimePeriodTypeBySec(timeNow, timeEnd)
	elseif not string.nilorempty(startTime) and string.nilorempty(endTime) then
		local timeStart = GameUtil.string2time(startTime)
		local timeNow = ServerTime.now()

		timePeriod = timeNow < timeStart and GameUtil.beforeTimePeriod or GameUtil.getTimePeriodTypeBySec(timeStart, timeNow + 1)
	end

	return timePeriod
end

function RedPointExController:_strToAsciiSum(str)
	local con = ""

	string.gsub(str, ".", function(c)
		con = con .. string.byte(c)
	end)

	local per = math.floor(string.len(con) / 8)
	local sum = 0

	for i = 0, per do
		sum = sum + checknumber((string.sub(con, i * 8 + 1, i * 8 + 8)))
	end

	return sum
end

local base62_Dic = {
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z",
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k",
	"l",
	"m",
	"n",
	"o",
	"p",
	"q",
	"r",
	"s",
	"t",
	"u",
	"v",
	"w",
	"x",
	"y",
	"z",
	"0",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9"
}
local base62_Dic_Re = {
	p = 42,
	a = 27,
	Z = 26,
	["2"] = 55,
	R = 18,
	Q = 17,
	o = 41,
	U = 21,
	P = 16,
	A = 1,
	C = 3,
	h = 34,
	i = 35,
	["1"] = 54,
	O = 15,
	n = 40,
	["0"] = 53,
	l = 38,
	T = 20,
	q = 43,
	r = 44,
	j = 36,
	M = 13,
	k = 37,
	u = 47,
	L = 12,
	v = 48,
	y = 51,
	x = 50,
	J = 10,
	f = 32,
	K = 11,
	z = 52,
	F = 6,
	V = 22,
	Y = 25,
	w = 49,
	m = 39,
	X = 24,
	I = 9,
	g = 33,
	G = 7,
	H = 8,
	["9"] = 62,
	W = 23,
	["4"] = 57,
	["8"] = 61,
	t = 46,
	e = 31,
	["7"] = 60,
	["6"] = 59,
	d = 30,
	N = 14,
	s = 45,
	["3"] = 56,
	b = 28,
	E = 5,
	c = 29,
	D = 4,
	["5"] = 58,
	S = 19,
	B = 2
}

function RedPointExController:_string10To62(number)
	local num = number
	local remArray = {}
	local scale = 62

	while num > 0 do
		table.insert(remArray, num % scale)

		num = math.floor(num / scale)
	end

	local resStr = ""

	for i = #remArray, 1, -1 do
		resStr = resStr .. base62_Dic[remArray[i] + 1]
	end

	return resStr
end

function RedPointExController:_num62To10(str_62)
	local strArray = {}

	string.gsub(str_62, ".", function(c)
		table.insert(strArray, c)
	end)

	local scale = 62
	local resNum = 0
	local strLen = string.len(str_62)

	for i = 1, strLen do
		resNum = resNum + (base62_Dic_Re[strArray[i]] - 1) * Mathf.Pow(scale, strLen - i)
	end

	return checkint(resNum)
end

RedPointExController.instance = RedPointExController.New()

return RedPointExController
