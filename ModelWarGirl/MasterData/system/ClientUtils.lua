-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\ClientUtils.lua

local json = require("cjson")
local ClientUtils = {}
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResRoleAttrConfig = require("ClientData/ResRoleAttrConfig")
local Equip = require("Common/Object/Equip")
local Artifact = require("Common/Object/Artifact")
local PetGem = require("Common/Object/PetGem")
local BugReport = require("SDK/Plugin/BugReport")
local Item = require("Common/Object/Item")
local Time = Time
local Hero = require("Common/Object/Hero")
local OtherPlayer = require("Common/Object/OtherPlayer")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResCurrencyExchange = require("ClientData/ResCurrencyExchange")
local ResRandClient = require("ClientData/ResRandClient")
local ResItem = require("ClientData/ResItem")
local ResCommonModel = require("ClientData/ResCommonModel")
local ResTimeValidConfig = require("ClientData/ResTimeValidConfig")
local UserData = require("Helper/UserData")
local ResContentAvalid = require("ClientData/ResContentAvalid")
local ResCommonHardCode = require("ClientData/ResCommonHardCode")
local ResTimeReplaceConfig = require("ClientData/ResTimeReplaceConfig")
local ResClientHardCode = require("ClientData/ResClientHardCode")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local ResMallSubPanelConfig = require("ClientData/ResMallSubPanelConfig")
local ResCardClient = require("ClientData/ResCardClient")
local ResConditionLimit = require("ClientData/ResConditionLimit")
local ResCrystalLevelCost = require("ClientData/ResCrystalLevelCost")
local ResOpActivityChatGameFormula = require("ClientData/ResOpActivityChatGameFormula")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResHero = require("ClientData/ResHero")
local ResRecharge = require("ClientData/ResRecharge")
local ResMainMenuCountryEntryConfig = require("ClientData/ResMainMenuCountryEntryConfig")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResVoiceConfig = require("ClientData/ResVoiceConfig")
local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local Monster = require("Common/Object/Monster")
local ResArtifact = require("ClientData/ResArtifact")
local FileUtils = Framework.Tools.FileUtils
local SystemInfo = UnityEngine.SystemInfo

function ClientUtils.isHuawei()
	local model = string.lower(SystemInfo.deviceModel)

	if string.find(model, "huawei") then
		return true
	else
		return false
	end
end

function ClientUtils.GetFuncUpValue(func, name)
	if func ~= nil then
		local valueFunc = debug.getupvalue

		for i = 1, 100 do
			local n, v = valueFunc(func, i)

			if not n then
				break
			end

			if n == name then
				return v
			end
		end
	end

	return nil
end

function ClientUtils.string2Table(stringData)
	local tableData = {}

	if type(stringData) ~= "string" then
		-- block empty
	else
		local succ, t = pcall(json.decode, stringData)

		if succ and type(t) == "table" then
			ClientUtils.stripUserData(t)

			tableData = t
		end
	end

	return tableData
end

function ClientUtils.table2String(tableData)
	if type(tableData) ~= "table" then
		return nil
	end

	local stringData = "{}"
	local succ, t = pcall(json.encode, tableData)

	if succ then
		stringData = t
	end

	return stringData
end

function ClientUtils.stripUserData(tableData, stripped)
	if stripped == nil then
		stripped = {}
	end

	if type(tableData) == "table" then
		for k, v in pairs(tableData) do
			local valueType = type(v)

			if valueType == "userdata" then
				tableData[k] = nil
			elseif valueType == "table" and not stripped[v] then
				stripped[v] = true

				ClientUtils.stripUserData(v, stripped)
			end
		end
	end
end

local ServerTimeInterval = 0

ClientUtils.DebugTimeInterval = 0

function ClientUtils.onSetServerTime(serverTime, fromLogin)
	ServerTimeInterval = serverTime - os.time()

	if fromLogin then
		ClientUtils.initTimeReplace()
	end
end

function ClientUtils.initTimeReplace()
	for _, data in pairs(ResTimeReplaceConfig) do
		if ClientUtils.getServerTimeByTimeStr(data.valid_tick) <= ClientUtils.getServerTime() then
			local itData = ResItem[data.item_id]

			if itData then
				itData.name = data.new_name
				itData.desc = data.new_desc
				itData.iconPath = data.new_icon_path
				itData.icon = data.new_icon
			end
		end
	end

	Const.RED_PACK_START_TIME = ClientUtils.getServerTimeByTimeStr(ResClientHardCode[13].desc[1])
	Const.RED_PACK_END_TIME = ClientUtils.getServerTimeByTimeStr(ResClientHardCode[13].desc[2])
end

function ClientUtils.getServerTime()
	return os.time() + ServerTimeInterval + ClientUtils.DebugTimeInterval
end

local SERVER_TIME_ZONE = Const.DEFAULT_TIME_ZONE
local SERVER_TIME_ZONE_DIFF

function ClientUtils.SetServerZone(zone)
	if zone then
		SERVER_TIME_ZONE = -zone
		SERVER_TIME_ZONE_DIFF = nil

		ClientUtils.initServerTimeDiff()
	end
end

function ClientUtils.initServerTimeDiff()
	local localTime = os.time()
	local baseTimeData = os.date("!*t", localTime)
	local baseTime = os.time(baseTimeData)
	local serverDiffTime = SERVER_TIME_ZONE * 3600
	local localDiffTime = os.difftime(localTime, baseTime)

	SERVER_TIME_ZONE_DIFF = localDiffTime - serverDiffTime
end

function ClientUtils.isTimeConfigPassed(timeValidId)
	return ClientUtils.getTimeConfigTimestamp(timeValidId) <= ClientUtils.getServerTime()
end

function ClientUtils.IsRandomValid(randId)
	local vData = ResContentAvalid[randId]

	if vData and vData.availd_Time then
		return ClientUtils.getServerTimeByTimeStr(vData.availd_Time) <= ClientUtils.getServerTime()
	end

	return true
end

function ClientUtils.getTimeConfigTimestamp(timeValidId)
	if timeValidId then
		local timeValidData = ResTimeValidConfig[timeValidId]

		if timeValidData then
			return ClientUtils.getServerTimeByTimeStr(timeValidData.valid_tick)
		end
	end

	return 0
end

function ClientUtils.getServerTimeByTimeStr(timeStr)
	local timeList = utils.splitString(timeStr, " ")

	if #timeList ~= 2 then
		return 0
	end

	local dayList = utils.splitString(timeList[1], ".")
	local hourList = utils.splitString(timeList[2], ":")

	if #dayList ~= 3 or #hourList ~= 3 then
		return 0
	end

	local timeDict = {}

	timeDict.year = math.min(tonumber(dayList[1]), 2037)
	timeDict.month = tonumber(dayList[2])
	timeDict.day = tonumber(dayList[3])
	timeDict.hour = tonumber(hourList[1])
	timeDict.min = tonumber(hourList[2])
	timeDict.sec = tonumber(hourList[3])

	local clientTime = os.time(timeDict)

	return clientTime + (SERVER_TIME_ZONE_DIFF or 0)
end

function ClientUtils.getServerOsDate(format, time)
	return ClientUtils.getServerTimeData(time, format)
end

function ClientUtils.getServerTimeData(time, format)
	if SERVER_TIME_ZONE_DIFF == nil then
		ClientUtils.initServerTimeDiff()
	end

	if time == nil then
		time = ClientUtils.getServerTime()
	end

	if format == nil then
		format = "*t"
	end

	local isdst = os.date("*t", time - SERVER_TIME_ZONE_DIFF).isdst

	if isdst then
		return os.date(format, time - SERVER_TIME_ZONE_DIFF - 3600)
	else
		return os.date(format, time - SERVER_TIME_ZONE_DIFF)
	end
end

local SecDiffTimeZone = SERVER_TIME_ZONE * 3600
local TIME_CONST_DAY = 86400

function ClientUtils.getTodayTimeStamp(hour, minute, second)
	local localZoneTime = hour * 3600 + minute * 60 + second
	local nowTime = ClientUtils.getServerTime()
	local targetStamp = nowTime - (nowTime + SecDiffTimeZone) % TIME_CONST_DAY + localZoneTime

	return targetStamp
end

function ClientUtils.getServerTimeNextDay()
	local time = ClientUtils.getServerTime()
	local timeData = ClientUtils.getServerTimeData(time, "*t")
	local runTime = timeData.hour * 3600 + timeData.min * 60 + timeData.sec

	time = time - runTime + Const.TIME_NEXT_DAY

	if runTime >= Const.TIME_NEXT_DAY then
		time = time + 86400
	end

	return time
end

function ClientUtils.isTickToday(tick)
	local nextDayTick = ClientUtils.getServerTimeNextDay()
	local todayStartTick = nextDayTick - 86400
	local isToday = todayStartTick <= tick and tick < nextDayTick

	return isToday
end

function ClientUtils.timeStampToTimeFormat(stamp, isSecond)
	if stamp == nil then
		return
	end

	local format = "%Y-%m-%d %H:%M"

	if isSecond then
		format = "%Y-%m-%d %H:%M %S"
	end

	return ClientUtils.getServerTimeData(stamp, format)
end

function ClientUtils.getServerTimeTodayStart(serverTime)
	serverTime = serverTime or ClientUtils.getServerTime()

	local timeData = ClientUtils.getServerTimeData(serverTime, "*t")
	local runTime = timeData.hour * 3600 + timeData.min * 60 + timeData.sec

	serverTime = serverTime - runTime + Const.TIME_NEXT_DAY

	if runTime < Const.TIME_NEXT_DAY then
		serverTime = serverTime - TIME_CONST_DAY
	end

	return serverTime
end

function ClientUtils.getNextResetTime(dayOffset, refreshDay)
	local timeData = ClientUtils.getServerTimeData(ClientUtils.openZoneTime, "*t")
	local allTime = ClientUtils.getServerTime() - ClientUtils.openZoneTime
	local offsetDays = (allTime - (dayOffset - 1) * 3600 * 24) / 86400
	local offsetDay = math.floor(offsetDays / refreshDay)

	return refreshDay * 24 * 3600 + (dayOffset - 1 + offsetDay * refreshDay) * 24 * 3600 + ClientUtils.openZoneTime - timeData.hour * 3600 + Const.TIME_NEXT_DAY + 1
end

function ClientUtils.getSeasonIndex(dayOffset, refreshDay)
	local allTime = ClientUtils.getServerTime() - ClientUtils.openZoneTime
	local offsetDays = (allTime - (dayOffset - 1) * 3600 * 24) / 86400

	return math.ceil(offsetDays / refreshDay)
end

function ClientUtils.getServerTimeNextWday(wday)
	wday = wday + 1

	if wday == 8 then
		wday = 1
	end

	local time = ClientUtils.getServerTime()
	local timeData = ClientUtils.getServerTimeData(time, "*t")
	local timeRun = timeData.hour * 3600 + timeData.min * 60 + timeData.sec
	local timeStart = time - timeRun

	if timeRun <= Const.TIME_NEXT_DAY then
		timeStart = timeStart - 86400
	end

	local startIdx = 1

	for i = startIdx, 7 do
		local nowT = timeStart + i * 3600 * 24
		local nowData = ClientUtils.getServerTimeData(nowT, "*t")

		if nowData.wday == wday then
			return nowT + Const.TIME_NEXT_DAY
		end
	end
end

function ClientUtils.getServerTimeNextMonth()
	local time = ClientUtils.getServerTime()
	local timeData = ClientUtils.getServerTimeData(time, "*t")
	local timeRun = timeData.hour * 3600 + timeData.min * 60 + timeData.sec
	local timeStart = time - timeRun

	if timeData.day == 1 and timeRun <= Const.TIME_NEXT_DAY then
		return timeStart + Const.TIME_NEXT_DAY
	else
		return os.time({
			hour = 0,
			day = 1,
			year = timeData.year,
			month = timeData.month + 1
		}) + Const.TIME_NEXT_DAY
	end
end

local traceback = traceback

function ClientUtils.trycall(func, ...)
	local flag, msg = xpcall(func, traceback, ...)

	if not flag then
		ClientUtils.trySendException("ClientUtils", msg)
	end

	return flag
end

local lger = logerror
local ExceptionList = {}

function ClientUtils.trySendException(type, exceptionMsg)
	if Const.SHOW_ERROR_LOG then
		lger(type, exceptionMsg)
	end

	for inde, msg in pairs(ExceptionList) do
		if msg == exceptionMsg then
			return
		end
	end

	BugReport.reportException(type, type, exceptionMsg)
	table.insert(ExceptionList, exceptionMsg)
end

function ClientUtils.getBitsListFromByteString(byteString)
	if not byteString then
		return {}
	end

	local bytesList = {
		byteString:byte(1, -1)
	}
	local bitCount = 8
	local bitList = {}

	for index = 1, #bytesList do
		for j = 1, bitCount do
			if bit.band(bytesList[index], bit.lshift(1, bitCount - j)) ~= 0 then
				local position = (index - 1) * bitCount + j

				table.insert(bitList, position)
			end
		end
	end

	return bitList
end

function ClientUtils.getBitsDictFromByteString(byteString)
	if not byteString then
		return {}
	end

	local bytesList = {
		byteString:byte(1, -1)
	}
	local bitCount = 8
	local bitList = {}

	for index = 1, #bytesList do
		for j = 1, bitCount do
			if bit.band(bytesList[index], bit.lshift(1, bitCount - j)) ~= 0 then
				local position = (index - 1) * bitCount + j

				bitList[position] = true
			end
		end
	end

	return bitList
end

function ClientUtils.getRolePropZhName(attrName, attrValue, fromPlayer)
	local zhName = attrName
	local isSpAttr = false

	if ResRoleAttrConfig[attrName] then
		local attrData = ResRoleAttrConfig[attrName]

		zhName = attrData.zhName
		attrValue = attrValue or 0

		if attrValue and attrData.isPercent then
			if fromPlayer then
				attrValue = tonumber(string.format("%.2f", attrValue * 100)) .. "%"
			else
				attrValue = tonumber(string.format("%.2f", attrValue / 100)) .. "%"
			end
		else
			attrValue = math.floor(attrValue)
		end

		isSpAttr = attrData.isSpecial
	end

	return zhName, attrValue, isSpAttr
end

function ClientUtils.getRolePropZhNameByType(attrTypeID, attrValue, fromPlayer)
	local attrName = BattleConst.PROP_TYPE_CONFIG[attrTypeID]

	return ClientUtils.getRolePropZhName(attrName, attrValue, fromPlayer)
end

function ClientUtils.getRolePropIcon(attrName)
	if ResRoleAttrConfig[attrName] and ResRoleAttrConfig[attrName].iconPath then
		return {
			UIConst.COMMON_ICON_PATH .. ResRoleAttrConfig[attrName].iconPath,
			ResRoleAttrConfig[attrName].icon
		}
	end
end

function ClientUtils.getRolePropIconByType(attrTypeID)
	local attrName = BattleConst.PROP_TYPE_CONFIG[attrTypeID]

	return ClientUtils.getRolePropIcon(attrName)
end

function ClientUtils.strServerTimePassed(preTick)
	if preTick == 0 or preTick == nil then
		return Lang.get(30031)
	else
		return ClientUtils.timeFormat4Record(ClientUtils.getServerTime() - preTick)
	end
end

local ONE_MINUTE = 60
local ONE_HOUR = 3600
local ONE_DAY = ONE_HOUR * 24
local TEN_DAY = ONE_DAY * 10
local ONE_MONTH = ONE_DAY * 30
local ONE_YEAR = ONE_MONTH * 12

function ClientUtils.timeFormat4Record(timeSecond)
	if timeSecond < 0 then
		timeSecond = 0
	end

	if timeSecond <= ONE_MINUTE then
		return string.format(Lang.get(30016), math.floor(timeSecond))
	elseif timeSecond <= ONE_HOUR then
		return string.format(Lang.get(30017), math.floor(timeSecond / ONE_MINUTE))
	elseif timeSecond <= ONE_DAY then
		return string.format(Lang.get(30018), math.floor(timeSecond / ONE_HOUR))
	elseif timeSecond <= ONE_MONTH then
		return string.format(Lang.get(30019), math.floor(timeSecond / ONE_DAY))
	elseif timeSecond <= ONE_YEAR then
		return string.format(Lang.get(30020), math.floor(timeSecond / ONE_MONTH))
	else
		return string.format(Lang.get(30021), math.floor(timeSecond / ONE_YEAR))
	end
end

function ClientUtils.timeFormat4CircleRecord(timeSecond)
	if timeSecond < 0 then
		timeSecond = 0
	end

	if timeSecond <= ONE_HOUR then
		return Lang.get(776)
	elseif timeSecond <= ONE_DAY then
		return string.format(Lang.get(30018), math.floor(timeSecond / ONE_HOUR))
	elseif timeSecond <= TEN_DAY then
		return string.format(Lang.get(30019), math.floor(timeSecond / ONE_DAY))
	else
		return Lang.get(30032)
	end
end

function ClientUtils.CeilToDayOrHour(timeSecond)
	if timeSecond < 0 then
		timeSecond = 0
	end

	local day = timeSecond / ONE_DAY

	if day > 1 then
		return string.format(Lang.get(30022), math.ceil(day))
	else
		local hour = math.ceil(timeSecond / ONE_HOUR)

		if hour >= 10 then
			return string.format(Lang.get(30023), hour)
		else
			return string.format(Lang.get(30024), hour)
		end
	end
end

function ClientUtils.getTimeStrBySecond(timeSecond)
	if timeSecond < 0 then
		timeSecond = 0
	end

	local sec = math.floor(timeSecond % ONE_MINUTE)
	local min = math.floor(timeSecond % ONE_HOUR / ONE_MINUTE)
	local hour = math.floor(timeSecond / ONE_HOUR)
	local secStr = sec > 0 and string.format(Lang.get(30025), sec) or ""
	local minStr = min > 0 and string.format(Lang.get(30026), min) or ""

	if hour >= 1 then
		if sec > 0 then
			return utils.format(Lang.get(30027), hour, min, secStr)
		else
			return utils.format(Lang.get(30028), hour, minStr)
		end
	else
		return minStr .. secStr
	end
end

function ClientUtils.getNextWdayByOffset(wday, hourTime, fixedZone)
	if hourTime == nil then
		hourTime = Const.TIME_NEXT_DAY
	end

	wday = wday + 1

	if wday == 8 then
		wday = 1
	end

	local time = ClientUtils.getServerTime()
	local timeData = ClientUtils.getServerTimeData(time, "*t")
	local timeRun = timeData.hour * 3600 + timeData.min * 60 + timeData.sec
	local timeStart = time - timeRun

	if timeRun <= Const.TIME_NEXT_DAY then
		timeStart = timeStart - ONE_DAY
	end

	local startIdx = 1
	local serverTime

	for i = startIdx, 7 do
		local nowT = timeStart + i * ONE_DAY
		local nowData = ClientUtils.getServerTimeData(nowT, "*t")

		if nowData.wday == wday then
			serverTime = nowT + hourTime

			break
		end
	end

	if serverTime and fixedZone and fixedZone ~= SERVER_TIME_ZONE then
		local diff = SERVER_TIME_ZONE - fixedZone

		serverTime = serverTime + diff * 3600

		if serverTime < time then
			serverTime = serverTime + ONE_DAY * 7
		elseif serverTime - time > ONE_DAY * 7 then
			serverTime = serverTime - ONE_DAY * 7
		end
	end

	return serverTime
end

function ClientUtils.getNumShortStr(num, showPinYin)
	local negaStr = ""

	if num < 0 then
		negaStr = "-"
		num = -num
	end

	if Const.REVIEW_VERSION then
		if num >= 100000000 then
			if showPinYin then
				return negaStr .. math.floor(num / 100000000) .. "Y"
			else
				return negaStr .. math.floor(num / 100000000) .. Lang.get(50267)
			end
		elseif num >= 100000 then
			if showPinYin then
				return negaStr .. math.floor(num / 10000) .. "W"
			else
				return negaStr .. math.floor(num / 10000) .. Lang.get(50266)
			end
		else
			return negaStr .. num
		end
	elseif num >= 10000000 then
		return negaStr .. math.floor(num / 1000000) .. "M"
	elseif num >= 100000 then
		return negaStr .. math.floor(num / 1000) .. "K"
	else
		return negaStr .. num
	end
end

function ClientUtils.getNumShortStr2(num)
	local negaStr = ""

	if num < 0 then
		negaStr = "-"
		num = -num
	end

	if Const.REVIEW_VERSION then
		if num >= 100000 then
			return negaStr .. math.floor(num / 1000) .. Lang.get(50265)
		else
			return negaStr .. num
		end
	elseif num >= 100000 then
		return negaStr .. math.floor(num / 1000) .. "K"
	else
		return negaStr .. num
	end
end

function ClientUtils.getNumShortStrSplit(num)
	if num >= 10000000 then
		return math.floor(num / 1000000), "M"
	elseif num >= 100000 then
		return math.floor(num / 1000), "K"
	else
		return num, ""
	end
end

function ClientUtils.getAllMailItems(mailAttach)
	local clientItems = {}

	for _, info in ipairs(mailAttach) do
		if info.type == "kMsgMailAttachExtendTypeHero" then
			table.insert(clientItems, Hero(info.data.hero))
		elseif info.type == "kMsgMailAttachExtendTypeEquip" then
			table.insert(clientItems, Equip(info.data.equip))
		elseif info.type == "kMsgMailAttachExtendTypePetGem" then
			local gem = BaseObject.GetObject(info.data.pet_gem.resid)

			table.insert(clientItems, gem)
		else
			local newItem = BaseObject.GetObject(info.id, info.num)

			if not newItem.resData or newItem.resData.hide_in_mail ~= 1 then
				table.insert(clientItems, newItem)
			end
		end
	end

	return clientItems
end

function ClientUtils.getAllClientItems(attrs, items, heros, equip, artifact, relic, petGems)
	local clientItems = {}

	for _, item in pairs(ClientUtils.getAttrItems(attrs)) do
		table.insert(clientItems, item)
	end

	for _, item in pairs(ClientUtils.getCommonItems(items)) do
		table.insert(clientItems, item)
	end

	for _, item in pairs(ClientUtils.getCommonEquips(equip)) do
		table.insert(clientItems, item)
	end

	for _, item in pairs(ClientUtils.getCommonArtifactsById(artifact)) do
		table.insert(clientItems, item)
	end

	if relic then
		for _, item in pairs(ClientUtils.getCommonRelicsById(relic)) do
			table.insert(clientItems, item)
		end
	end

	if petGems then
		local gemNumDic = {}

		for _, petGem in pairs(petGems) do
			local curNum = gemNumDic[petGem.resid]

			if not curNum then
				gemNumDic[petGem.resid] = 1
			else
				gemNumDic[petGem.resid] = curNum + 1
			end
		end

		for k, v in pairs(gemNumDic) do
			local item = BaseObject.GetObject(k)

			item.num = v

			table.insert(clientItems, item)
		end
	end

	return clientItems
end

function ClientUtils.getAttrItems(attrs)
	local items = {}

	for _, attrUnit in ipairs(attrs or {}) do
		local moneyType = attrUnit.type
		local moneyValue = attrUnit.value

		if Const.MONEY_TYPE2ID[moneyType] and moneyValue > 0 then
			local iId = Const.MONEY_TYPE2ID[moneyType]

			table.insert(items, Item({
				id = iId,
				num = moneyValue
			}))
		end
	end

	return items
end

function ClientUtils.getItemSpeTypeId(id)
	if id == nil then
		return
	end

	local item = ResItem[id]

	if item and item.subtype == Const.ITEM_STYPE_HEAD_FRAME then
		return item.extend_args1
	end
end

function ClientUtils.getMoney(moneyID)
	if RegionUtils.isKR() and moneyID == Const.MONEY_ID_DIAMOND and CurAvatar and CurAvatar:getMoneyByType(Const.MONEY_TYPE_DIAMOND_BUY) < 0 then
		return CurAvatar:getMoneyByType(Const.MONEY_TYPE_DIAMOND_BUY)
	end

	return CurAvatar and CurAvatar:getItemNumById(moneyID) or 0
end

function ClientUtils.getMoneyIcon(moneyID)
	if UIConst.MONEY_ID2INFO[moneyID] then
		return UIConst.MONEY_ID2INFO[moneyID]
	else
		local resData = ResItem[moneyID]

		if resData and resData.sourceIconPath and resData.sourceIcon then
			return {
				UIConst.ITEM_ICON_PATH .. resData.sourceIconPath,
				resData.sourceIcon
			}
		elseif resData and resData.iconPath and resData.icon then
			return {
				UIConst.ITEM_ICON_PATH .. resData.iconPath,
				resData.icon
			}
		end
	end
end

function ClientUtils.BuyNotice(moneyID)
	local info = UIConst.MONEY_ID2INFO[moneyID]

	if info then
		local msg = info[4] and ResClientNotice[info[4]].notice or string.format(Lang.get(30029), info[3])

		return msg
	else
		local resData = ResItem[moneyID]

		if resData and resData.not_enough_desc then
			return resData.not_enough_desc
		elseif resData and resData.name then
			return string.format(Lang.get(30029), resData.name)
		else
			return ""
		end
	end
end

function ClientUtils.getClientNotice(id)
	if id == nil then
		return ""
	end

	if not ResClientNotice[id] then
		return ""
	end

	return ResClientNotice[id].notice or ""
end

function ClientUtils.CheckExchange(moneyID)
	local result = false

	for k, v in ipairs(ResCurrencyExchange) do
		for i, data in ipairs(v.exchange) do
			if data.key == moneyID then
				result = true

				break
			end
		end
	end

	return result
end

function ClientUtils.isForbideModifyInfo(...)
	if Const.FORBID_INFO_MODIFY then
		local info = ResCommonHardCode[45]

		if info and ClientUtils.getServerTime() > info.value[1] and ClientUtils.getServerTime() < info.value[2] then
			return true, info.content or ""
		end
	end
end

function ClientUtils.checkMoneyChange(moneyID, moneyValue, enoughCallback, preUI, tryToExchange, goRechargeCallBack)
	local haveV = ClientUtils.getMoney(moneyID)
	local canBuy = moneyValue <= haveV

	if canBuy then
		if moneyID == Const.MONEY_ID_GOLD_LEAF and moneyValue > haveV * 0.6 then
			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(868), string.format(ResClientNotice[431].notice, moneyValue), Slot(enoughCallback, preUI))
		else
			enoughCallback(preUI)
		end
	else
		local canExchange = ClientUtils.CheckExchange(moneyID)

		local function hidePreUI()
			if preUI then
				preUI:setVisible(false)
			end
		end

		if moneyID == Const.MONEY_ID_DIAMOND then
			local function goRechage()
				CurAvatar:jumpToRecharge()

				if goRechargeCallBack then
					goRechargeCallBack()
				end

				hidePreUI()
			end

			if VersionUtils.IsRechargeDisabled() then
				UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(30033), Lang.get(1910))
			elseif RegionUtils.isKR() and CurAvatar and CurAvatar:getMoneyByType(Const.MONEY_TYPE_DIAMOND_BUY) < 0 then
				MsgManager.notice("해당 계정은 이미 동결되었습니다. 상세한 내용은 고객센터에 문의하세요. ")
			else
				UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(30033), Lang.get(30034), goRechage, hidePreUI)
			end
		elseif tryToExchange and canExchange == true then
			local box = UIManager.getUI("moneyTradeBox")

			box:show(preUI, moneyID, moneyValue - haveV, Slot(enoughCallback, preUI))
			box:bindWindow(preUI)
		else
			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(30033), ClientUtils.BuyNotice(moneyID), nil)
		end
	end
end

function ClientUtils.getCommonItems(itemList)
	local clientItems = {}

	for _, iInfo in ipairs(itemList or {}) do
		if iInfo.num > 0 then
			local item = Item(iInfo)

			if item.subType ~= Const.ITEM_STYPE_ACTIVITY_PROGRESS then
				table.insert(clientItems, item)
			elseif item.resData.isShow and item.resData.isShow == 1 then
				table.insert(clientItems, item)
			end
		end
	end

	return clientItems
end

function ClientUtils.getCommonEquips(equipList)
	local clientEquips = {}

	for _, eInfo in ipairs(equipList or {}) do
		local equip = Equip(eInfo)

		table.insert(clientEquips, equip)
	end

	return clientEquips
end

function ClientUtils.getCommonArtifactsById(artifactIdList)
	local clientArtifacts = {}

	for _, idNum in ipairs(artifactIdList or {}) do
		for i = 1, idNum.num do
			local artifact = BaseObject.GetObject(idNum.id)

			table.insert(clientArtifacts, artifact)
		end
	end

	return clientArtifacts
end

function ClientUtils.getCommonRelicsById(relicIdList)
	local clientRelics = {}

	for _, idNum in ipairs(relicIdList or {}) do
		for i = 1, idNum.num do
			local relic = BaseObject.GetObject(idNum.id)

			table.insert(clientRelics, relic)
		end
	end

	return clientRelics
end

function ClientUtils.getCommonPetItemsById(petItemlist)
	local clientPetItems = {}

	for _, idNum in ipairs(petItemlist or {}) do
		for i = 1, idNum.num do
			local item = BaseObject.GetObject(idNum.id)

			if idNum.transId then
				item.transId = idNum.transId
				item.transNum = 1
			end

			table.insert(clientPetItems, item)
		end
	end

	return clientPetItems
end

function ClientUtils.getFilterConfig(filterData)
	local filterConfig = {}

	for typeIdx, siftList in pairs(filterData) do
		filterConfig[typeIdx] = {}

		for _, siftIdx in pairs(siftList) do
			local data = {}

			data.idx = siftIdx

			table.insert(filterConfig[typeIdx], data)
		end
	end

	return filterConfig
end

function ClientUtils.subStringByLength(inputText, needLength)
	local lenInByte = #inputText
	local nowIndex = 1
	local chnCount = 0
	local engCount = 0

	for i = 1, lenInByte do
		local curByte = string.byte(inputText, nowIndex)

		if not curByte then
			break
		end

		local byteCount = 1

		if curByte > 0 and curByte <= 127 then
			byteCount = 1
		elseif curByte >= 192 and curByte < 223 then
			byteCount = 2
		elseif curByte >= 224 and curByte <= 239 then
			byteCount = 3
		elseif curByte >= 240 and curByte <= 247 then
			byteCount = 4
		end

		if byteCount ~= 1 then
			chnCount = chnCount + 1
		elseif curByte < 48 or curByte > 57 and curByte < 65 or curByte > 122 or curByte > 90 and curByte < 97 then
			engCount = engCount + 1
		else
			engCount = engCount + 1
		end

		local afterLength = chnCount * 2 + engCount

		if needLength < afterLength then
			local resultStr = string.sub(inputText, 1, nowIndex - 1)

			return resultStr, true
		end

		nowIndex = nowIndex + byteCount
	end

	return inputText, false
end

local MIN_NUM = 4
local MAX_NUM = 14
local CHN_COUNT = 2
local SP_KEY = {
	"(",
	")",
	".",
	"%",
	"+",
	"-",
	"*",
	"?",
	"[",
	"^",
	"$",
	"/",
	";",
	"?",
	"@",
	"<",
	"=",
	">",
	"\\",
	"]",
	"_",
	"`",
	"{",
	"}",
	"|",
	"~",
	"!",
	"#",
	"&",
	":"
}

function ClientUtils.checkPlayerName(name)
	local num = utils.utf8len(name, CHN_COUNT)
	local failMsg = ""

	if num == 0 then
		failMsg = Lang.get(30035)
	elseif num < MIN_NUM then
		failMsg = Lang.get(30035)
	elseif num > MAX_NUM then
		failMsg = utils.format(Lang.get(30030), MAX_NUM / CHN_COUNT, MAX_NUM)
	elseif string.find(name, " ") then
		if Const.NAME_CONTAINS_SPACE == true then
			local newName = string.gsub(name, " ", "")
			local newNum = utils.utf8len(newName, CHN_COUNT)

			if newNum == 0 then
				failMsg = Lang.get(52361)
			end
		else
			failMsg = Lang.get(30036)
		end
	elseif string.match(name, "%d+") == name then
		failMsg = Lang.get(30037)
	else
		for i, c in ipairs(SP_KEY) do
			if string.find(name, "%" .. c) then
				failMsg = Lang.get(30038)

				break
			end
		end
	end

	return failMsg
end

function ClientUtils.checkCircleName(name)
	local num = utils.utf8len(name, CHN_COUNT)
	local failMsg = ""

	if num == 0 then
		failMsg = ResClientNotice[228].notice
	elseif num > Const.MAX_CIRCLE_NAME_MAXLEN then
		failMsg = utils.format(Lang.get(30030), Const.MAX_CIRCLE_NAME_MAXLEN / CHN_COUNT, Const.MAX_CIRCLE_NAME_MAXLEN)
	elseif string.find(name, " ") then
		if Const.NAME_CONTAINS_SPACE == true then
			local newName = string.gsub(name, " ", "")
			local newNum = utils.utf8len(newName, CHN_COUNT)

			if newNum == 0 then
				failMsg = Lang.get(52361)
			end
		else
			failMsg = Lang.get(30036)
		end
	elseif string.match(name, "%d+") == name then
		failMsg = Lang.get(30037)
	else
		for i, c in ipairs(SP_KEY) do
			if string.find(name, "%" .. c) then
				failMsg = Lang.get(30038)

				break
			end
		end
	end

	return failMsg
end

function ClientUtils.checkEquipPlanName(name)
	local num = utils.utf8len(name, CHN_COUNT)
	local failMsg = ""

	if num == 0 then
		failMsg = ResClientNotice[375].notice
	elseif num > Const.MAX_EQUIPPLAN_NAME_MAXLEN then
		failMsg = utils.format(Lang.get(30030), Const.MAX_EQUIPPLAN_NAME_MAXLEN / CHN_COUNT, Const.MAX_EQUIPPLAN_NAME_MAXLEN)
	elseif string.find(name, " ") then
		if Const.NAME_CONTAINS_SPACE == true then
			local newName = string.gsub(name, " ", "")
			local newNum = utils.utf8len(newName, CHN_COUNT)

			if newNum == 0 then
				failMsg = Lang.get(52361)
			end
		else
			failMsg = Lang.get(30036)
		end
	elseif string.match(name, "%d+") == name then
		failMsg = Lang.get(30037)
	else
		for i, c in ipairs(SP_KEY) do
			if string.find(name, "%" .. c) then
				failMsg = Lang.get(30038)

				break
			end
		end
	end

	return failMsg
end

function ClientUtils._sliderAni(uiData, valueData, delayTime, aniTime, onLevelUp, onAniFinish)
	if uiData == nil or valueData == nil then
		return nil
	end

	if uiData.slider ~= nil then
		uiData.slider:setValue(valueData.prePercent)

		if uiData.levelLabel ~= nil then
			uiData.levelLabel:setText(valueData.preLevel)
		end

		local totalValue = 1 - valueData.prePercent + (valueData.curLevel - valueData.preLevel - 1) + valueData.curPercent

		if aniTime == nil then
			aniTime = totalValue * 0.7
		end

		local avrTime = aniTime / totalValue
		local data = {}

		if valueData.preLevel == valueData.curLevel then
			local d = {
				level = valueData.preLevel,
				percent = valueData.curPercent,
				changePercent = valueData.curPercent - valueData.prePercent
			}

			table.insert(data, d)
		else
			for i = valueData.preLevel, valueData.curLevel - 1 do
				local d = {
					percent = 1,
					level = i
				}

				if i == valueData.preLevel then
					d.changePercent = 1 - valueData.prePercent
				else
					d.changePercent = 1
				end

				table.insert(data, d)
			end

			table.insert(data, {
				level = valueData.curLevel,
				percent = valueData.curPercent,
				changePercent = valueData.curPercent
			})
		end

		if delayTime ~= nil then
			coroutine.wait(delayTime)
		end

		local quickTime = 0
		local tempPercent = 0

		for idx, info in ipairs(data) do
			uiData.slider:setValue(info.percent, info.changePercent * avrTime)
			coroutine.wait(info.changePercent * avrTime)

			if info.level + 1 > valueData.curLevel then
				if onAniFinish ~= nil then
					onAniFinish()
				end
			else
				if idx == #data - 1 and onLevelUp ~= nil then
					local effectDuration = 0

					effectDuration = onLevelUp()

					coroutine.wait(effectDuration)
				end

				uiData.slider:setValue(0)

				if uiData.levelLabel ~= nil then
					uiData.levelLabel:setText(info.level + 1)
				end
			end
		end
	end
end

function ClientUtils.sliderAni(...)
	return coroutine.start(ClientUtils._sliderAni, ...)
end

function ClientUtils.notToday(dayInfos)
	if dayInfos == nil then
		return false
	end

	for i, wday in ipairs(dayInfos) do
		local nextTime = ClientUtils.getServerTimeNextWday(wday)

		if not nextTime then
			return false
		end
	end

	return true
end

function ClientUtils.isMobile(str)
	return string.match(str, "[1][3,4,5,6,7,8,9]%d%d%d%d%d%d%d%d%d") == str
end

local PATTERN_CONFIG = {
	{
		pattern = "<quad.->?",
		rep = "*"
	},
	{
		pattern = "<%w.->(.-)</.->",
		rep = "*%1*"
	}
}

function ClientUtils.checkMarkIllegal(content, forbidList)
	if not content then
		return ""
	end

	for i, info in ipairs(PATTERN_CONFIG) do
		content = string.gsub(content, info.pattern, info.rep)
	end

	if forbidList then
		for _, keyWord in ipairs(forbidList) do
			local replaceStr = ""
			local markCount = utils.utf8len(keyWord, 1)

			for i = 1, markCount do
				replaceStr = replaceStr .. "*"
			end

			content = utils.replaceString(content, keyWord, replaceStr)
		end
	end

	return content
end

function ClientUtils.checkInputValueChange(input)
	if input == nil then
		return
	end

	input:addEventValueChanged(function(...)
		input:setText(ClientUtils.checkMarkIllegal(input:getText()))
	end)
end

function ClientUtils.checkHaveAbilityMonthCard(...)
	if RegionUtils.isJP() then
		return VersionUtils.hasAbilityJPVIPMonthCard()
	elseif RegionUtils.isTW() then
		return VersionUtils.hasAbilityBiliVIPMonthCard()
	elseif RegionUtils.isKR() then
		local packageName = SDKAppUtils.getPackageName()

		if packageName == "com.biligamekr.figureone" then
			return false
		end

		return VersionUtils.hasAbilityBiliVIPMonthCard()
	elseif RegionUtils.isSEA() then
		return VersionUtils.hasAbilityBiliVIPMonthCard()
	else
		return false
	end
end

function ClientUtils.markInputIllegal(input, hint)
	if input == nil then
		return
	end

	input:setText(ClientUtils.checkMarkIllegal(input:getText(), hint))
end

function ClientUtils.urlEncode(s)
	s = string.gsub(s, "[\x80-\xBF\xC2-\xF4]", function(c)
		return string.format("%%%02X", string.byte(c))
	end)

	return string.gsub(s, " ", "+")
end

function ClientUtils.composeGetParams(data)
	local encoded = {}

	for k, v in pairs(data) do
		table.insert(encoded, string.format("%s=%s", ClientUtils.urlEncode(k), ClientUtils.urlEncode(v)))
	end

	return table.concat(encoded, "&")
end

function ClientUtils.composeGetUrl(url, data, hasQuestionMark)
	local paramStr = ClientUtils.composeGetParams(data)
	local questionMark = hasQuestionMark and "&" or "?"

	if paramStr ~= nil and #paramStr > 0 then
		if type(url) == "string" then
			return url .. questionMark .. paramStr
		else
			url:SetUrlAppend(questionMark .. paramStr)

			return url
		end
	else
		return url
	end
end

ClientUtils._docPath = FileUtils.GetDocumentPath()

function ClientUtils.getDocumentPath(relativePath)
	local absPath = ClientUtils._docPath

	if type(relativePath) == "string" then
		absPath = absPath .. relativePath
	end

	return absPath
end

ClientUtils._patchPath = FileUtils.GetDocumentResourcesPath()

function ClientUtils.getPatchPath(relativePath)
	local absPath = ClientUtils._patchPath

	if type(relativePath) == "string" then
		absPath = absPath .. relativePath
	end

	return absPath
end

function ClientUtils.getAndroidPicGallery()
	local docPath = ClientUtils.getDocumentPath()
	local elements = {}

	for k in docPath:gmatch("[^\\/]+[\\/]*") do
		table.insert(elements, k)
	end

	for i = #elements, #elements - 3, -1 do
		table.remove(elements)
	end

	table.insert(elements, "DCIM")

	return table.concat(elements)
end

function ClientUtils.getMainStageLevelStr(season, chapter, level)
	return chapter .. "-" .. level
end

function ClientUtils.getMainStageLevelNum(season, chapter, level)
	if season == nil then
		local curData = CurAvatar.mainStageCur

		season = curData.season
		chapter = curData.chapter
		level = curData.level
	end

	return season * 10000 + chapter * 100 + level
end

function ClientUtils.parseStage(stage)
	if stage == nil then
		return
	end

	local s1, s2, s3

	s1 = stage % 100
	s2 = math.floor(stage / 100) % 100
	s3 = math.floor(stage / 10000)

	return s3, s2, s1
end

function ClientUtils.parseStageToLevelStr(stage)
	return ClientUtils.getMainStageLevelStr(ClientUtils.parseStage(stage))
end

function ClientUtils.CreateBonusGrid(parent, grids, gridPath, bonusId, awardMode, maxNum, disableWays, awardExtraConfig, configId, gridConfig)
	local bonus = ResRandClient[bonusId] or {}
	local showIds = bonus.show_ids or {}
	local showNums = bonus.show_nums or {}
	local showFlag = bonus.show_flag or {}
	local gridConfig = gridConfig or {}

	maxNum = maxNum or #showIds

	for index = #grids, maxNum - 1 do
		if awardMode then
			local newGrid = UIControls.getGridAwardContainer(parent, gridPath)

			newGrid.awardExtraConfig = awardExtraConfig

			table.insert(grids, newGrid)
		else
			local newGrid = UIControls.getGridContainer(parent, gridPath)

			table.insert(grids, newGrid)
		end
	end

	for index, grid in ipairs(grids) do
		if showIds[index] then
			local num = showNums[index] or 1

			if gridConfig.PrivilegeId then
				num = CurAvatar:getPrivilegeValue(gridConfig.PrivilegeId, num)
			end

			local clientItem = BaseObject.GetObject(showIds[index], num)

			grid.mDisableWays = disableWays

			if configId then
				grid:setContainerConfig(configId)
			end

			grid:setObj(clientItem, gridConfig.checkNeedConvertObject)
			grid:setVisible(true)

			if grid.setSpe then
				if showFlag[index] and showFlag[index] >= 1 then
					grid:setSpe(true, 3, showFlag[index])
				else
					grid:setSpe(false)
				end
			end
		else
			grid:setVisible(false)
		end
	end
end

function ClientUtils.CreatePreviewBonusSumGrid(parent, grids, gridPath, bonusIds, prefabPath, maxNum, awardMode)
	local previewAwards = {
		show_ids = {},
		show_nums = {}
	}

	for i, bonusId in pairs(bonusIds or {}) do
		local bonus = ResRandClient[bonusId] or {}

		for j, id in ipairs(bonus.show_ids or {}) do
			local index = 0

			for k, v in ipairs(previewAwards.show_ids) do
				if v == id then
					index = k
				end
			end

			if index == 0 then
				table.insert(previewAwards.show_ids, id)
				table.insert(previewAwards.show_nums, bonus.show_nums[j])
			else
				previewAwards.show_nums[index] = previewAwards.show_nums[index] + bonus.show_nums[j]
			end
		end
	end

	local showIds = previewAwards.show_ids or {}
	local showNums = previewAwards.show_nums or {}

	maxNum = maxNum or #showIds

	for index = #grids, maxNum - 1 do
		if awardMode then
			local newGrid = UIControls.getGridAwardContainer(parent, gridPath)

			table.insert(grids, newGrid)
		else
			local newGrid = UIControls.getGridAwardPanelContainer(parent, gridPath, prefabPath)

			table.insert(grids, newGrid)
		end
	end

	for index, grid in ipairs(grids) do
		if showIds[index] then
			local clientItem = BaseObject.GetObject(showIds[index], showNums[index] or 1)

			grid.mDisableWays = true

			grid:setObj(clientItem)
			grid:setVisible(true)
		else
			grid:setVisible(false)
		end
	end
end

function ClientUtils.CreateActivityBonusGrid(parent, grids, gridPath, bonusId, prefabPath, maxNum)
	local bonus = ResRandClient[bonusId] or {}
	local showIds = bonus.show_ids or {}
	local showNums = bonus.show_nums or {}
	local show_flag = bonus.show_flag or {}

	maxNum = maxNum or #showIds

	for index = #grids, maxNum - 1 do
		local newGrid = UIControls.getGridAwardPanelContainer(parent, gridPath, prefabPath)

		table.insert(grids, newGrid)
	end

	for index, grid in ipairs(grids) do
		if showIds[index] then
			local clientItem = BaseObject.GetObject(showIds[index], showNums[index] or 1)

			grid.mDisableWays = true

			grid:setObj(clientItem)
			grid:setVisible(true)

			if show_flag[index] and show_flag[index] >= 1 then
				grid:setSpe(true, 3, show_flag[index])
			else
				grid:setSpe(false)
			end
		else
			grid:setVisible(false)
		end
	end
end

function ClientUtils.CreateBonusGridByItems(parent, grids, gridPath, items, prefabPath, maxNum)
	maxNum = maxNum or #items

	for index = #grids, maxNum - 1 do
		local newGrid = UIControls.getGridAwardContainer(parent, gridPath)

		table.insert(grids, newGrid)
	end

	for index, grid in ipairs(grids) do
		if items[index] then
			local clientItem = items[index]

			grid.mDisableWays = true

			grid:setObj(clientItem)
			grid:setVisible(true)

			if clientItem.awardFlag and clientItem.awardFlag >= 1 then
				grid:setSpe(true, 3, clientItem.awardFlag)
			else
				grid:setSpe(false)
			end
		else
			grid:setVisible(false)
		end
	end
end

function ClientUtils.createHeroGrids(parent, heroObjList, gridList, gridPath, maxNum, btnMore)
	heroObjList = heroObjList or {}
	gridList = gridList or {}

	local dataNum = #heroObjList
	local checkBeyondMax = maxNum and maxNum < dataNum or false

	if btnMore then
		btnMore:setVisible(checkBeyondMax)
	end

	dataNum = checkBeyondMax and maxNum or dataNum

	local gridNum = #gridList

	for i = 1, dataNum do
		local grid

		if gridNum < i then
			grid = GridHeroStarUp(parent, gridPath, "System/StarUp/GridHeroStarUp")

			table.insert(gridList, grid)
		else
			grid = gridList[i]
		end

		grid:setHero(heroObjList[i])
		grid:setVisible(true)
	end

	if dataNum < gridNum then
		for i = dataNum + 1, gridNum do
			gridList[i]:setVisible(false)
		end
	end
end

function ClientUtils.createMonsterGrids(parent, pveId, monsterObjList, gridList, gridPath, maxNum, btnMore)
	monsterObjList = monsterObjList or {}
	gridList = gridList or {}

	if pveId then
		utils.clearTable(monsterObjList)

		local battleConfig = ResBattleConfig[pveId] or {}
		local monsterIdList = battleConfig and battleConfig.monsters or {}

		for pos, monsterId in pairs(monsterIdList) do
			if monsterId and monsterId ~= 0 then
				local newMonster = Monster(monsterId, battleConfig.monster_level or 220)

				table.insert(monsterObjList, newMonster)
			end
		end
	end

	local dataNum = #monsterObjList
	local checkBeyondMax = maxNum and maxNum < dataNum or false

	if btnMore then
		btnMore:setVisible(checkBeyondMax)
	end

	dataNum = checkBeyondMax and maxNum or dataNum

	local gridNum = #gridList

	for i = 1, dataNum do
		local grid

		if gridNum < i then
			grid = UIControls.MonsterCardChild(parent, gridPath, "System/Common/Grid/GridMonster")

			table.insert(gridList, grid)
		else
			grid = gridList[i]
		end

		grid:setObj(monsterObjList[i])
		grid:setVisible(true)
	end

	if dataNum < gridNum then
		for i = dataNum + 1, gridNum do
			gridList[i]:setVisible(false)
		end
	end
end

function ClientUtils.CreateBuffGrids(parent, gridList, gridPath, buffIdList, maxNum, btnMore)
	buffIdList = buffIdList or {}
	gridList = gridList or {}

	local dataNum = #buffIdList
	local checkBeyondMax = maxNum and maxNum < dataNum or false

	if btnMore then
		btnMore:setVisible(checkBeyondMax)
	end

	dataNum = checkBeyondMax and maxNum or dataNum

	local gridNum = #gridList

	for i = 1, dataNum do
		local grid

		if gridNum < i then
			grid = UIControls.BattleBuffGridChild(parent, gridPath, "System/Common/Grid/GridBuffSmall", 0, 0, true)

			table.insert(gridList, grid)
		else
			grid = gridList[i]
		end

		grid:setObj(buffIdList[i])
		grid:setVisible(true)
	end

	if dataNum < gridNum then
		for i = dataNum + 1, gridNum do
			gridList[i]:setVisible(false)
		end
	end
end

function ClientUtils.getObjectByRandId(bonusId)
	local data = {}

	if not bonusId then
		return data
	end

	local bonus = ResRandClient[bonusId] or {}
	local showIds = bonus.show_ids or {}
	local showNums = bonus.show_nums or {}

	for i, id in ipairs(showIds) do
		local item = BaseObject.GetObject(id, showNums[i] or 1)

		table.insert(data, item)
	end

	return data
end

function ClientUtils.GetMazeNodeBranchType(nodeData, branchIndex)
	if nodeData and nodeData.branchs and nodeData.branchs[branchIndex] then
		return nodeData.branchs[branchIndex].type
	end
end

function ClientUtils.getMostValueByKey(tab, key)
	local temp

	for k, v in pairs(tab) do
		if temp == nil then
			temp = v
		end

		if temp[key] < v[key] then
			temp = v
		end
	end

	return temp
end

function ClientUtils.isSuportHidePkg(...)
	if string.find(SP_MARK, "business") then
		return true
	else
		return false
	end
end

function ClientUtils.handleStageChannel()
	local subChannel = ChannelUtil.getSubChannelID()

	if subChannel == "bilibili" then
		Const.MAIN_MENU_MODEL_STAGE = "ModelStage/NewDisplayModelStage_bili"
	elseif subChannel == "haoyoukuaibao" then
		Const.MAIN_MENU_MODEL_STAGE = "ModelStage/NewDisplayModelStage_hay"
	elseif subChannel == "taptap" then
		Const.MAIN_MENU_MODEL_STAGE = "ModelStage/NewDisplayModelStage_tap"
	elseif subChannel == "ssjj" then
		Const.MAIN_MENU_MODEL_STAGE = "ModelStage/NewDisplayModelStage_4399"
	else
		Const.MAIN_MENU_MODEL_STAGE = "ModelStage/NewDisplayModelStage"
	end
end

function ClientUtils.hasSkinShowState(modelId)
	if ResCommonModel[modelId] and ResCommonModel[modelId].show_info_skin then
		return true
	end
end

function ClientUtils.ConvertContent(desc)
	if CurAvatar then
		desc = string.gsub(desc, "|101|", CurAvatar:getPlayerName())
		desc = string.gsub(desc, "|102|", CurAvatar.genderTitle)
		desc = string.gsub(desc, "|103|", CurAvatar.genderHonorTitle)
		desc = string.gsub(desc, "|104|", CurAvatar.genderBrotherTitle)
	end

	return desc
end

function ClientUtils.isPatchTxtMissing()
	if not IS_EDITOR and not VersionUtils.hasAbilityPatchV2() then
		local filePath = ClientUtils.getPatchPath("cur_files_info.txt")

		if not FileUtils.Exists(filePath, false) then
			return true
		end
	end

	return false
end

local isFirst

function ClientUtils.isFirstOpen()
	if isFirst ~= nil then
		return isFirst
	else
		local isFirstOpen = UserData.loadCommonData("IsFirstOpen")

		if isFirstOpen ~= "True" then
			isFirst = true

			UserData.saveCommonData("IsFirstOpen", "True")
		else
			isFirst = false
		end

		return isFirst
	end
end

function ClientUtils.isInBeginner()
	if UIManager.getUI("newbieTalkDlg", nil, false) and UIManager.getUI("newbieTalkDlg", nil, false):isInShow() then
		return true
	elseif UIManager.getUI("rookieMainDlg", nil, false) and UIManager.getUI("rookieMainDlg", nil, false):isInShow() then
		return true
	elseif UIManager.getUI("createRoleDlg", nil, false) and UIManager.getUI("createRoleDlg", nil, false):isInShow() then
		return true
	elseif UIManager.getUI("returnConfirmDlg", nil, false) and UIManager.getUI("returnConfirmDlg", nil, false):isInShow() then
		return true
	end

	return false
end

function ClientUtils.ShowBonusPreviewDlg(randId, hasGot)
	local randData = ResRandClient[randId]

	if randData and randData.bonus_preview_id then
		UIManager.getUI("bonusPreviewDlg", true):onShow(randData, hasGot)
	end
end

function ClientUtils.CheckRandomHasDiamond(randIds)
	for _, itId in ipairs(randIds or {}) do
		if itId == Const.MONEY_ID_FAKE_DIAMOND then
			return true
		end
	end
end

function ClientUtils.GetCrystalNewLevelState(nowLevel)
	nowLevel = nowLevel or CurAvatar.crystalNewLevel

	local nowLevelData = ResCrystalLevelCost[nowLevel]

	if not nowLevelData then
		return 0, 0, 10, ResCrystalLevelCost[1]
	end

	local showLevel = nowLevelData.show_level
	local nowStar = 0
	local totalStar = 0

	if showLevel == 0 then
		totalStar = 1
	end

	for _, lData in ipairs(ResCrystalLevelCost) do
		if lData.show_level == showLevel then
			if lData.level == nowLevel then
				nowStar = totalStar
			end

			totalStar = totalStar + 1
		end
	end

	return showLevel, nowStar, totalStar, ResCrystalLevelCost[nowLevel + 1]
end

local UPDATE_DRAG_HERO_DLG = {
	"battleDragHeroDlg",
	"defendDragHeroDlg",
	"mazeDragHeroDlg",
	"multiDragHeroDlg",
	"activityPvpDragHeroDlg",
	"rentDragHeroDlg",
	"newMazeDragHeroDlg",
	"topPvpDragHeroDlg",
	"topPvpKnockoutDragHeroDlg",
	"worldBossEliteDragHeroDlg"
}

function ClientUtils.getNowDragDlg()
	local ui

	for index, uiName in ipairs(UPDATE_DRAG_HERO_DLG) do
		ui = UIManager.tryGetUI(uiName)

		if ui then
			break
		end
	end

	return ui
end

function ClientUtils.JumpToFirstRecharge()
	local jumped = false
	local jumpInfo = UIMiscConfig.FIRST_RECHARGE_JUMP_INFO

	CurAvatar:initMallClientData()

	if ClientUtils.checkFirstMonthCard() then
		jumped = true
	else
		for _, info in ipairs(jumpInfo) do
			if not ConditionLimitManager.inLimitState(info[4]) then
				local config = ResMallSubPanelConfig[info[2]]

				if config and (not config.unlockCondition or not ConditionLimitManager.inLimitState(config.unlockCondition)) and not CurAvatar:isWelfareHide(config.pageType) == true then
					local ui = UIManager.getUI(info[3], true)

					if ui then
						ui:onShow(info[1], info[2])
					end

					jumped = true

					break
				end
			end
		end
	end

	if jumped == true then
		return true
	else
		local limitId = Const.MONEY_BUY_JUMP_CONDITION[Const.MONEY_ID_DIAMOND]

		MsgManager.notice(ResConditionLimit[limitId].unlock_desc)
	end
end

function ClientUtils.tryBuySkinObj(obj, callback)
	if obj:isGet() then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), ResClientNotice[284].notice, callback)
	elseif not obj:isHeroGet() then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), ResClientNotice[280].notice, callback)
	else
		callback()
	end
end

function ClientUtils.getValentineShareContent(actId, itemId)
	if ResOpActivityChatGameFormula[actId] and ResOpActivityChatGameFormula[actId][itemId] then
		return ResOpActivityChatGameFormula[actId][itemId].share_content
	end
end

function ClientUtils.getHeroVoiceIdByType(heroId, type)
	if not heroId or not type then
		return
	end

	local ResHeroVocal = require("ClientData/ResHeroVocal")

	if ResHeroVocal[heroId] then
		return ResHeroVocal[heroId][type]
	end
end

function ClientUtils.checkCanShowVoCalBullet(vocalId)
	if vocalId and ResVoiceConfig[vocalId] then
		local data = ResVoiceConfig[vocalId]

		if data.show_state and data.show_state == 1 and data.desc then
			return true, data.desc
		end
	end

	return false
end

function ClientUtils.getHeroVoicelByInteractType(heroId, type)
	if not heroId or not type then
		return
	end

	local ResHandBookHero = require("ClientData/ResHandBookHero")

	if ResHandBookHero[heroId] then
		local voiceLists = ResHandBookHero[heroId].voice_id

		for index, id in ipairs(voiceLists or {}) do
			if ResVoiceConfig[id] then
				local data = ResVoiceConfig[id]

				if data.interact_type and data.interact_type == type then
					return id
				end
			end
		end
	end
end

function ClientUtils.fliterHeroListByLimit(herosList, limits, filterMap)
	local filter = filterMap or {}
	local limitType = {
		"camp",
		"career",
		"team"
	}

	if not limits then
		return
	end

	for _, limit in ipairs(limits) do
		local type = limitType[limit.check_type]
		local needValue = limit.need_value or 0

		if limit.compare_type == Const.FORMATION_LIMIT_COMPARE_TYPE_FILTER then
			needValue = utils.getTableElemCount(herosList)
		end

		if type then
			for index, hero in ipairs(herosList) do
				for i, param in ipairs(limit.param) do
					if hero and not filter[hero.id] and hero[type] == param then
						filter[hero.id] = true
						needValue = needValue - 1
					end
				end

				if needValue == 0 then
					break
				end
			end
		end
	end

	return filter
end

function ClientUtils.getFormationByHeros(herosList, power, nowFormation, miniNum, careerData, limit, filterMap)
	local filter = filterMap or {}
	local limitType = {
		"camp",
		"career",
		"team"
	}

	if not herosList or utils.getTableElemCount(herosList) == 0 then
		return
	end

	local nowFormation = nowFormation or {}

	if limit then
		if limit.compare_type == Const.FORMATION_LIMIT_COMPARE_TYPE_FILTER then
			filter = ClientUtils.fliterHeroListByLimit(herosList, {
				limit
			}, filter)
		else
			local limitheroList = {}
			local type = limitType[limit.check_type]

			for index, hero in ipairs(herosList) do
				for i, param in ipairs(limit.param) do
					if hero[type] == param and not filter[hero.id] then
						table.insert(nowFormation, hero)

						filter[hero.id] = true
					end
				end

				if #nowFormation == limit.need_value then
					break
				end
			end

			if #nowFormation < limit.need_value then
				return false
			end
		end
	end

	local careerIndex = 1
	local nowPower = 0

	for index, hero in ipairs(nowFormation) do
		nowPower = nowPower + hero:getCapacity()
	end

	local needNum = 0
	local hasNum = 0

	while not (careerIndex > #careerData) and (not (power <= nowPower) or not (miniNum <= #nowFormation)) and not (#nowFormation >= 6) do
		needNum = careerData[careerIndex].num

		local needCareer = careerData[careerIndex].career

		hasNum = 0

		for index, hero in ipairs(nowFormation) do
			if hero.career == needCareer then
				hasNum = hasNum + 1
			end
		end

		for index, hero in ipairs(herosList) do
			if hero then
				if needNum <= hasNum or #nowFormation >= 6 or power <= nowPower and miniNum <= #nowFormation then
					break
				end

				if not filter[hero.id] and hero.career == needCareer then
					nowPower = nowPower + hero:getCapacity()

					table.insert(nowFormation, hero)

					filter[hero.id] = true
					hasNum = hasNum + 1
				end
			end
		end

		if needNum <= hasNum then
			careerIndex = careerIndex + 1
		else
			local remainderNum = 0

			for index, hero in ipairs(herosList) do
				if hero.career == needCareer and not filter[hero.id] then
					remainderNum = remainderNum + 1
				end
			end

			if remainderNum == 0 then
				careerIndex = careerIndex + 1
			end
		end
	end

	if careerIndex > #careerData and miniNum > #nowFormation and #nowFormation < 6 then
		for index, hero in ipairs(herosList) do
			if not filter[hero.id] then
				nowPower = nowPower + hero:getCapacity()

				table.insert(nowFormation, hero)

				filter[hero.id] = true
			end

			if power < nowPower and miniNum <= #nowFormation or #nowFormation == 6 then
				break
			end
		end
	end

	local function sortHeroByCareerPriority(a, b)
		local prioritya = 0
		local priorityb = 0

		for index, data in ipairs(careerData) do
			if a.career == data.career then
				prioritya = index
			end

			if b.career == data.career then
				priorityb = index
			end
		end

		return prioritya < priorityb
	end

	return power <= nowPower, nowFormation
end

function ClientUtils.getSneakBattleFormation(heros, power, miniNum, careerData, limit, remainderLimits)
	if not heros then
		return
	end

	local heroList = {}

	for gid, hero in pairs(heros) do
		table.insert(heroList, hero)
	end

	local function sortHeroByPower(heroa, herob)
		local powera = heroa:getCapacity() or 0
		local powerb = herob:getCapacity() or 0

		return powerb < powera
	end

	table.sort(heroList, sortHeroByPower)

	local siftLimits = {}

	if remainderLimits then
		for index, limit in ipairs(remainderLimits) do
			if limit.compare_type == Const.FORMATION_LIMIT_COMPARE_TYPE_SIFT then
				table.insert(siftLimits, limit)
			end
		end
	end

	if siftLimits and #siftLimits ~= 0 then
		while #siftLimits ~= 0 do
			local filter = ClientUtils.fliterHeroListByLimit(heroList, siftLimits)
			local state, formation = ClientUtils.getFormationByHeros(heroList, power, {}, miniNum, careerData, limit, filter)

			if state then
				return state, formation
			else
				table.remove(siftLimits)
			end
		end
	else
		return ClientUtils.getFormationByHeros(heroList, power, {}, miniNum, careerData, limit, {})
	end
end

local BEGINNER_MONTH_CARD_ID = 6

function ClientUtils.checkFirstMonthCard()
	local cData = ResCardClient[BEGINNER_MONTH_CARD_ID]

	if cData and cData.recharge_id then
		for _, recharge_id in ipairs(cData.recharge_id) do
			local RechargeManager = require("System/Recharge/RechargeManager")
			local product = RechargeManager.getProductByRechargeId(recharge_id)

			if product and product:productCanBuy() then
				UIManager.getUI("mallDlg", true):onShow(2, 40)

				return true
			end
		end
	end
end

function ClientUtils.getMonthCardMallTick()
	local cData = ResCardClient[BEGINNER_MONTH_CARD_ID]

	if cData and cData.recharge_id then
		for _, recharge_id in ipairs(cData.recharge_id) do
			local RechargeManager = require("System/Recharge/RechargeManager")
			local rTime = RechargeManager.getProductRemainTime(recharge_id)

			if rTime and rTime < Const.TIME_ONE_DAY then
				return true, rTime
			end
		end
	end

	return false
end

function ClientUtils.isNewSkinValid(groupInfo)
	if not groupInfo.is_hide and ClientUtils.isTimeConfigPassed(groupInfo.valid_time_id) and (not groupInfo.expire_time_id or not ClientUtils.isTimeConfigPassed(groupInfo.expire_time_id)) then
		local itData = ResItem[groupInfo.param]

		if itData and RegionUtils.isCN() then
			local heroID = itData.extend_args1
			local skinId = itData.extend_args2

			if ResItemHeroSkin[heroID] and ResItemHeroSkin[heroID][skinId] then
				local clientData = ResItemHeroSkin[heroID][skinId]

				if clientData.condition_id and ConditionLimitManager.inLimitState(clientData.condition_id) then
					return false
				end
			end
		end

		return true
	end

	return false
end

function ClientUtils.isNewArtifactValid(groupInfo)
	if ClientUtils.isTimeConfigPassed(groupInfo.open_time) and (not groupInfo.close_time or not ClientUtils.isTimeConfigPassed(groupInfo.close_time)) then
		local itData = ResArtifact[groupInfo.artifact_id]

		if itData then
			return true
		end
	end

	return false
end

function ClientUtils.isPushConfigValid(configInfo)
	if configInfo.condition_id and ConditionLimitManager.inLimitState(configInfo.condition_id) then
		return false
	end

	if configInfo.relate_activity then
		local actObj = CurAvatar:getActivityObj(configInfo.relate_activity)

		if actObj and actObj:checkOpenTime(configInfo.act_day) then
			return true
		end
	elseif ClientUtils.isTimeConfigPassed(configInfo.open_time) and (not configInfo.close_time or not ClientUtils.isTimeConfigPassed(configInfo.close_time)) then
		return true
	end

	return false
end

function ClientUtils.isHeroValidById(heroId)
	if ResHero[heroId] and ResHero[heroId].valid_time_id then
		return ClientUtils.isTimeConfigPassed(ResHero[heroId].valid_time_id)
	end

	return true
end

function ClientUtils.isRechargeIdValid(rechargdId)
	local rechargeData = ResRecharge[rechargdId]

	if not rechargeData then
		return false
	end

	if rechargeData.condition_id and ConditionLimitManager.inLimitState(rechargeData.condition_id) then
		return false
	end

	local limitState = rechargeData.unlock_stage
	local limitVip = rechargeData.unlock_vip
	local limitLock = limitState and not CurAvatar:mainStageStatePassed(limitState[1], limitState[2], limitState[3])
	local vipLock = limitVip and limitVip > (CurAvatar.vipLevel or 0)

	if limitState and limitVip then
		if limitLock and vipLock then
			return false
		end
	elseif limitLock or vipLock then
		return false
	end

	return true
end

function ClientUtils.canOpenCountryEntry(entryId)
	local data = ResMainMenuCountryEntryConfig[entryId]

	if data then
		local curValue

		if data.country_type == 1 then
			curValue = RegionUtils.region
		elseif data.country_type == 2 then
			curValue = Const.COUNTRY_STR
		end

		local condOk = false

		for _, value in ipairs(data.country_args or {}) do
			if value == curValue then
				condOk = true

				break
			end
		end

		if condOk then
			if data.show_condition and ConditionLimitManager.inLimitState(data.show_condition) then
				return false
			end

			return true
		end
	end

	return false
end

function ClientUtils.jumpCountryEntry(entryId)
	local data = ResMainMenuCountryEntryConfig[entryId]

	if data and data.jump_id then
		JumpGuideManager.jump(data.jump_id)
	end
end

function ClientUtils.RelateActivityReddot(window, uiPath, args)
	local actId = tonumber(args[2])

	if actId and UIConst.ACTIVITY_RED_DOT_CONFIG[actId] then
		local newRD = UIControls.RedDot(window, uiPath)

		newRD:addHint({
			UIConst.ACTIVITY_RED_DOT_CONFIG[actId]
		})
	end
end

return ClientUtils
