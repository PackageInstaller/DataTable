-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airtightroom/util/AirtightRoomUtil.lua

module("logic.extensions.airtightroom.util.AirtightRoomUtil", package.seeall)

local AirtightRoomUtil = {}

function AirtightRoomUtil.getSystemKey()
	return GameEnum.SystemEnum.Chamber
end

function AirtightRoomUtil.isSystemOpen(showToast)
	if AirtightRoomModel.instance:getIgnoreSpSetting() then
		return true
	end

	local systemKey = AirtightRoomUtil.getSystemKey()

	return SystemOpenFacade.instance:isOpen(systemKey, showToast)
end

function AirtightRoomUtil.getNormalTimerGuideId()
	return ChamberConfig.instance:getConstByKey(ConstConfigKeyEnum.ReturnNormalTimerGuideId)
end

function AirtightRoomUtil.getAirtightTimeGuideId()
	return ChamberConfig.instance:getConstByKey(ConstConfigKeyEnum.AirtightTimeGuideId)
end

function AirtightRoomUtil.getNormalTimerGuideFinish()
	if AirtightRoomModel.instance:getIgnoreSpSetting() then
		return true
	end

	local guideId = AirtightRoomUtil.getNormalTimerGuideId()

	if guideId > 0 then
		return GuideModel.instance:isGuideFinish(guideId)
	end

	return true
end

function AirtightRoomUtil.getAirtightTimeGuideFinish()
	if AirtightRoomModel.instance:getIgnoreSpSetting() then
		return true
	end

	local guideId = AirtightRoomUtil.getAirtightTimeGuideId()

	if guideId > 0 then
		return GuideModel.instance:isGuideFinish(guideId)
	end

	return true
end

function AirtightRoomUtil.getSpTimeInfo()
	local inSpTime, inSpNormal, inSpAirtight = false, false, false

	if AirtightRoomModel.instance:getIgnoreSpSetting() then
		return inSpTime, inSpNormal, inSpAirtight
	end

	local guideFinishAirtight = AirtightRoomUtil.getAirtightTimeGuideFinish()

	if not guideFinishAirtight then
		inSpTime, inSpNormal, inSpAirtight = true, true, false

		return inSpTime, inSpNormal, inSpAirtight
	end

	local dungeonPass = true
	local dungeonId = ChamberConfig.instance:getConstByKey(ConstConfigKeyEnum.NormalTimeDungeon)

	if dungeonId > 0 then
		local mo = DungeonModel.instance:getDungeonMoById(dungeonId)

		if mo then
			dungeonPass = mo:hasPassed()
		else
			printError(string.format("无法找到[%s] dungeonMo", dungeonId))
		end
	end

	local canTimer = AirtightRoomUtil.getNormalTimerGuideFinish() and dungeonPass

	if canTimer then
		inSpTime, inSpNormal, inSpAirtight = false, false, false
	else
		inSpTime, inSpNormal, inSpAirtight = true, false, true
	end

	return inSpTime, inSpNormal, inSpAirtight
end

function AirtightRoomUtil.getOneDayTimeStruct(totalSecond)
	local hour = math.floor(totalSecond / 3600)
	local minute = math.floor((totalSecond - hour * 3600) / 60)
	local second = totalSecond % 60

	return hour, minute, second
end

function AirtightRoomUtil.getWDayTimeStamp(nowTimeStamp, targetWday, targetHour, targetMin, targetSec)
	targetHour = targetHour and targetHour or 0
	targetMin = targetMin and targetMin or 0
	targetSec = targetSec and targetSec or 0

	local nowDate = os.date("*t", nowTimeStamp)
	local nowWDay = AirtightRoomUtil.getNowWeekDay(nowTimeStamp)
	local nowZeroTime = os.time({
		hour = 0,
		min = 0,
		sec = 0,
		year = nowDate.year,
		month = nowDate.month,
		day = nowDate.day
	})
	local offsetDay = targetWday - nowWDay

	return nowZeroTime + 86400 * offsetDay + (targetHour * 60 * 60 + targetMin * 60 + targetSec)
end

function AirtightRoomUtil.getNowWeekDay(nowTimeStamp)
	local nowWDay = os.date("%w", nowTimeStamp)

	nowWDay = tonumber(nowWDay)
	nowWDay = nowWDay == 0 and 7 or nowWDay

	return nowWDay
end

function AirtightRoomUtil.getWeekDayDate(nowTime, weekDay, weekOffset)
	weekOffset = weekOffset or 0

	local mondayTS = AirtightRoomUtil.getWDayTimeStamp(nowTime, 1)
	local nowDate = os.date("*t", mondayTS + weekOffset * 7 * 24 * 60 * 60 + (weekDay - 1) * 86400)

	return nowDate
end

function AirtightRoomUtil.getItemId()
	local idList = ConstConfig.instance:getNumValuesByKey("AirtightRoomItem")
	local itemId = 0
	local expireTime = 0

	for i, v in ipairs(idList) do
		local itemDataList = ItemModel.instance:getItemsByItemId(v)

		if #itemDataList > 0 then
			for ii, vv in ipairs(itemDataList) do
				local itemData = vv
				local count = itemData:getCount()
				local etime = tonumber(itemData:getExpireTime())

				if not ItemUtil.isItemOverTime(itemData) then
					if count > 0 and expireTime == 0 then
						itemId = v
						expireTime = etime
					end

					if (etime < expireTime and etime ~= 0 or expireTime == 0) and count > 0 then
						expireTime = etime
						itemId = v
					end
				end
			end
		end
	end

	if itemId == 0 then
		itemId = idList[1]
	end

	return itemId
end

function AirtightRoomUtil.getNextEnvAnim(nowTime)
	nowTime = nowTime or AirtightRoomModel.instance:getServerTime()

	local lastInTime, lastTS = AirtightRoomController.instance:getLastAirtightState()
	local inTime = AirtightRoomController.instance:getIsInAirtightTime()
	local playAni = false

	if inTime then
		if lastInTime then
			playAni = not TimeUtil.instance:isSameDay(nowTime, lastTS)
		else
			playAni = true
		end
	end

	return inTime, playAni
end

return AirtightRoomUtil
