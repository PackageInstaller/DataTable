-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmdrinkshop/model/MMDrinkShopModel.lua

module("logic.extensions.mmdrinkshop.model.MMDrinkShopModel", package.seeall)

local MMDrinkShopModel = class("MMDrinkShopModel", BaseModel)

MMDrinkShopModel.SLOT_SERVER_STATUS = {
	EMPTY = 0,
	FINISHED = 2,
	MAKING = 1
}
MMDrinkShopModel.SLOT_CLIENT_STATUS = {
	EMPTY = 0,
	CLAIMED = 3,
	MAKING = 1,
	FINISHED = 2,
	ERROR = -1
}

function MMDrinkShopModel:onInit()
	self:onReset()
end

function MMDrinkShopModel:onReset()
	self._infoMap = {}
end

function MMDrinkShopModel:onGetInfo(msg)
	local data = GameUtil.pbToTable(msg)
	local activityId = data.activityId
	local slotInfoMap = {}

	if data.slotInfos then
		for _, slotInfo in ipairs(data.slotInfos) do
			slotInfoMap[slotInfo.slotId] = slotInfo
		end
	end

	local gainPrizeIdMap = {}

	if data.gainPrizeIds then
		for _, prizeId in ipairs(data.gainPrizeIds) do
			gainPrizeIdMap[prizeId] = true
		end
	end

	data.slotInfoMap = slotInfoMap
	data.gainPrizeIdMap = gainPrizeIdMap
	self._infoMap[activityId] = data
end

function MMDrinkShopModel:onStartMake(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		info.curScore = data.curScore

		if not info.slotInfoMap then
			if not info.slotInfoMap[data.slotId] then
				local slotInfo = {}

				slotInfo.slotId = data.slotId
				slotInfo.status = MMDrinkShopModel.SLOT_SERVER_STATUS.MAKING
				slotInfo.startTime = data.startTime
				slotInfo.drinkId = data.drinkId
				info.slotInfoMap[data.slotId] = slotInfo
				info.slotInfoMap = info.slotInfoMap
			end
		end
	end
end

function MMDrinkShopModel:onFinishMake(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		info.curScore = data.curScore

		if not info.slotInfoMap then
			local slotInfoMap = {}
			local slotInfo = slotInfoMap[data.slotId]

			if slotInfo then
				slotInfo.status = MMDrinkShopModel.SLOT_SERVER_STATUS.FINISHED
			end

			info.totalCupCount = (info.totalCupCount or 0) + 1
		end
	end
end

function MMDrinkShopModel:onGainPrize(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		if not info.gainPrizeIdMap then
			info.gainPrizeIdMap[data.prizeId] = true
			info.gainPrizeIdMap = info.gainPrizeIdMap
		end
	end
end

function MMDrinkShopModel:getInfo(activityId)
	local info = self._infoMap[activityId]

	if info then
		return info
	else
		printError(":getInfo - no info found for activityId:", activityId)

		return nil
	end
end

function MMDrinkShopModel:getSlotInfo(activityId, slotId)
	local info = self._infoMap[activityId]

	if info and info.slotInfoMap then
		return info.slotInfoMap[slotId]
	end
end

function MMDrinkShopModel:getCurScore(activityId)
	local info = self._infoMap[activityId]

	if info then
		return info.curScore or 0
	end

	return 0
end

function MMDrinkShopModel:getTotalCupCount(activityId)
	local info = self._infoMap[activityId]

	if info then
		return info.totalCupCount or 0
	end

	return 0
end

function MMDrinkShopModel:isPrizeGained(activityId, prizeId)
	local info = self._infoMap[activityId]

	if info and info.gainPrizeIdMap then
		return info.gainPrizeIdMap[prizeId] == true
	end

	return false
end

function MMDrinkShopModel:getSlotClientStatus(activityId, slotId)
	local slotInfo = self:getSlotInfo(activityId, slotId)

	if not slotInfo then
		return MMDrinkShopModel.SLOT_CLIENT_STATUS.EMPTY
	end

	if slotInfo.status == MMDrinkShopModel.SLOT_SERVER_STATUS.EMPTY then
		return MMDrinkShopModel.SLOT_CLIENT_STATUS.EMPTY
	end

	local currentTime = ServerTime.now()
	local startTime = Mathf.Floor(checknumber(slotInfo.startTime) / 1000)
	local drinkId = slotInfo.drinkId
	local drinkConfig = MMDrinkShopConfig.instance:getDrinkCfgByDrinkId(activityId, drinkId)

	if not drinkConfig then
		printError("梦梦饮品配置未找到:", drinkId)

		return MMDrinkShopModel.SLOT_CLIENT_STATUS.ERROR
	end

	local makeSeconds = checknumber(drinkConfig.makeSeconds)
	local finishTime = startTime + makeSeconds

	if slotInfo.status == MMDrinkShopModel.SLOT_SERVER_STATUS.MAKING then
		if finishTime <= currentTime then
			return MMDrinkShopModel.SLOT_CLIENT_STATUS.FINISHED
		else
			return MMDrinkShopModel.SLOT_CLIENT_STATUS.MAKING
		end
	elseif slotInfo.status == MMDrinkShopModel.SLOT_SERVER_STATUS.FINISHED then
		local todayDate = GameUtil.time2date(currentTime)
		local todayStartTime = GameUtil.date2time(todayDate.year, todayDate.month, todayDate.day, 5, 0, 0)

		if startTime < todayStartTime then
			return MMDrinkShopModel.SLOT_CLIENT_STATUS.EMPTY
		else
			return MMDrinkShopModel.SLOT_CLIENT_STATUS.CLAIMED
		end
	end

	return MMDrinkShopModel.SLOT_CLIENT_STATUS.EMPTY
end

function MMDrinkShopModel:getSlotDrinkId(activityId, slotId)
	local drinkId = 0
	local slotClientStatus = self:getSlotClientStatus(activityId, slotId)

	if slotClientStatus == MMDrinkShopModel.SLOT_CLIENT_STATUS.MAKING or slotClientStatus == MMDrinkShopModel.SLOT_CLIENT_STATUS.FINISHED or slotClientStatus == MMDrinkShopModel.SLOT_CLIENT_STATUS.CLAIMED then
		local slotInfo = self:getSlotInfo(activityId, slotId)

		if slotInfo then
			drinkId = slotInfo.drinkId or 0
		end
	elseif slotClientStatus == MMDrinkShopModel.SLOT_CLIENT_STATUS.ERROR or slotClientStatus == MMDrinkShopModel.SLOT_CLIENT_STATUS.EMPTY then
		local currentDay = ActivityDefineController.instance:getActivityCurrentDay(activityId)

		if currentDay > 0 then
			local slotLoopDayCount = MMDrinkShopConfig.instance:getSlotLoopDayCount(activityId)

			if slotLoopDayCount > 0 then
				local loopDayIndex = (currentDay - 1) % slotLoopDayCount + 1
				local daySlotCfg = MMDrinkShopConfig.instance:getDaySlotCfgByDayIndex(activityId, loopDayIndex)

				if daySlotCfg and daySlotCfg.drinkId then
					local drinkIds = daySlotCfg.drinkId

					if type(drinkIds) == "table" and slotId <= #drinkIds then
						drinkId = drinkIds[slotId] or 0
					end
				end
			end
		end
	end

	return drinkId
end

MMDrinkShopModel.instance = MMDrinkShopModel.New()

return MMDrinkShopModel
