-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalfarm/controller/EternalFarmController.lua

module("logic.extensions.eternalfarm.controller.EternalFarmController", package.seeall)

local EternalFarmController = class("EternalFarmController", BaseController)

function EternalFarmController:ctor()
	return
end

function EternalFarmController:onInit()
	self:onReset()
end

function EternalFarmController:onReset()
	self.fieldMgr = {}
	self._yardId = 1
end

function EternalFarmController:sendPM_EternalFarmInfoReq(activityId)
	EternalFarmAgent.instance:sendPM_EternalFarmInfoReq(activityId)
end

function EternalFarmController:handlePM_EternalFarmInfoRes(status, msg)
	EternalFarmModel.instance:setFarmInfo(msg)
	self:_checkSellRedPoint(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.EternalFarmGetInfoRes, msg)
end

function EternalFarmController:sendPM_EternalFarmSowReq(activityId, zoneId, indexId, cropId)
	EternalFarmAgent.instance:sendPM_EternalFarmSowReq(activityId, zoneId, indexId, cropId)
end

function EternalFarmController:handlePM_EternalFarmSowRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.EternalFarmSowRes, msg)
end

function EternalFarmController:sendPM_EternalFarmHarvestReq(activityId, zoneIds)
	EternalFarmAgent.instance:sendPM_EternalFarmHarvestReq(activityId, zoneIds)
end

function EternalFarmController:handlePM_EternalFarmHarvestRes(status, msg)
	EternalFarmModel.instance:setFarmHarvesInfo(msg)
	self:_checkSellRedPoint()
	GlobalDispatcher:dispatch(GlobalNotify.EternalFarmHarvestRes, msg)
end

function EternalFarmController:sendPM_EternalFarmUseFertilizerReq(activityId, zoneId, indexId)
	EternalFarmAgent.instance:sendPM_EternalFarmUseFertilizerReq(activityId, zoneId, indexId)
end

function EternalFarmController:handlePM_EternalFarmUseFertilizerRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.EternalFarmUseFertilizerRes, msg)
end

function EternalFarmController:sendPM_EternalFarmGainTodayPrizeReq(activityId)
	EternalFarmAgent.instance:sendPM_EternalFarmGainTodayPrizeReq(activityId)
end

function EternalFarmController:handlePM_EternalFarmGainTodayPrizeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.EternalFarmGainTodayPrizeRes, msg)
end

function EternalFarmController:sendPM_EternalFarmShopReq(activityId, shopId, num)
	EternalFarmAgent.instance:sendPM_EternalFarmShopReq(activityId, shopId, num)
end

function EternalFarmController:handlePM_EternalFarmShopRes(status, msg)
	self:_checkSellRedPoint()
	GlobalDispatcher:dispatch(GlobalNotify.EternalFarmShopRes, msg)
end

function EternalFarmController:sendPM_EternalFarmGainPrizeReq(activityId, itemId, prizeId)
	EternalFarmAgent.instance:sendPM_EternalFarmGainPrizeReq(activityId, itemId, prizeId)
end

function EternalFarmController:handlePM_EternalFarmGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.EternalFarmGainPrizeRes, msg)
end

function EternalFarmController:sendPM_EternalFarmOneKeySowReq(activityId, items)
	EternalFarmAgent.instance:sendPM_EternalFarmOneKeySowReq(activityId, items)
end

function EternalFarmController:handlePM_EternalFarmOneKeySowRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_EternalFarmOneKeySowRes, msg)
end

function EternalFarmController:sendPM_EternalFarmOneKeySellReq(activityId, sellItems)
	EternalFarmAgent.instance:sendPM_EternalFarmOneKeySellReq(activityId, sellItems)
end

function EternalFarmController:handlePM_EternalFarmOneKeySellRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_EternalFarmOneKeySellRes, msg)
end

function EternalFarmController:isUnLock(zoneId)
	return EternalFarmModel.instance:isUnlock(zoneId)
end

function EternalFarmController:lockCondition(activityId, zoneId)
	local cfg = EternalFarmConfig.instance:getZoneCfgById(activityId, zoneId)

	if GameUtil.isEmptyString(cfg.condition) then
		return ""
	end

	local condition = string.splitToNumber(cfg.condition, ":")
	local conditionName = EternalFarmConfig.instance:getZoneCfgById(activityId, condition[1]).name

	return string.format("成功收获%d次%s后解锁", condition[2], conditionName)
end

function EternalFarmController:zoneGainTimes(zoneId)
	return EternalFarmModel.instance:getZoneGainTimes(zoneId)
end

function EternalFarmController:addField(fieldCell, zoneId)
	self.fieldMgr[zoneId] = self.fieldMgr[zoneId] or {}

	local fieldCellIdx = table.indexof(self.fieldMgr[zoneId], fieldCell)

	if checknumber(fieldCellIdx) > 0 then
		table.remove(self.fieldMgr[zoneId], fieldCellIdx)
	end

	table.insert(self.fieldMgr[zoneId], fieldCell)
end

function EternalFarmController:resetField()
	for zoneId, fields in pairs(self.fieldMgr) do
		for indexId, field in pairs(fields) do
			field:destroy()
		end
	end

	self.fieldMgr = {}
end

function EternalFarmController:getField(zoneId, indexId)
	if self.fieldMgr[zoneId] then
		for idx, field in pairs(self.fieldMgr[zoneId]) do
			if field:getIndexId() == indexId then
				return field
			end
		end
	end
end

function EternalFarmController:getFields(zoneId)
	if self.fieldMgr[zoneId] then
		table.sort(self.fieldMgr[zoneId], function(a, b)
			return a:getIndexId() < b:getIndexId()
		end)

		return self.fieldMgr[zoneId]
	end
end

function EternalFarmController:getFieldCanPlantNum(zoneId)
	local canPlantNum = 0

	table.sort(self.fieldMgr[zoneId], function(a, b)
		return a:getIndexId() < b:getIndexId()
	end)

	for idx, field in ipairs(self.fieldMgr[zoneId]) do
		if field:fieldGrowpState() == EternalFarmModel.FieldState.Empty then
			canPlantNum = canPlantNum + 1
		end
	end

	return canPlantNum
end

function EternalFarmController:getFieldCanPlantList(zoneId)
	local canPlantList = {}

	table.sort(self.fieldMgr[zoneId], function(a, b)
		return a:getIndexId() < b:getIndexId()
	end)

	for idx, field in ipairs(self.fieldMgr[zoneId]) do
		if field:fieldGrowpState() == EternalFarmModel.FieldState.Empty then
			table.insert(canPlantList, field)
		end
	end

	return canPlantList
end

function EternalFarmController:setYardId(yardId)
	self._yardId = yardId
end

function EternalFarmController:getYardId()
	return self._yardId
end

function EternalFarmController:getCanPlantFieldsByZoneId(zoneId)
	table.sort(self.fieldMgr[zoneId], function(a, b)
		return a:getIndexId() < b:getIndexId()
	end)

	return self.fieldMgr[zoneId]
end

function EternalFarmController:isCanGainCrop()
	for zoneId, fields in pairs(self.fieldMgr) do
		for i, field in ipairs(fields) do
			if field:isMature() then
				return true
			end
		end
	end

	return false
end

function EternalFarmController:ultimateCropCount()
	return #EternalFarmModel.instance:getUltimateCropIds()
end

function EternalFarmController:ultimateCropInfo(activityId)
	local desc = ""
	local cfg = EternalFarmConfig.instance:getCropCfg(activityId)
	local ultimateCrop = EternalFarmModel.instance:getUltimateCropIds()
	local reward = {}

	for _, cropId in ipairs(ultimateCrop) do
		if reward[cropId] == nil then
			reward[cropId] = 0
		end

		reward[cropId] = reward[cropId] + 1
	end

	for i, v in pairs(reward) do
		if reward[i] > 0 then
			local matType, matId, matNum = MaterialMgr.getMatParams(cfg[i].ultimatePrize)
			local matName = MaterialMgr.getMaterialsName(matType, matId)

			desc = desc .. matName .. "*" .. matNum * reward[i]
		end
	end

	return desc
end

function EternalFarmController:limitDesc(activityId, shopId)
	local cfg = EternalFarmConfig.instance:getShopCfgById(activityId, shopId)
	local preStr = "限购："

	if cfg.limitType == "daily" then
		preStr = "每日限购："
	elseif cfg.limitType == "weekly" then
		preStr = "每周限购："
	elseif cfg.limitType == "monthly" then
		preStr = "每月限购："
	elseif cfg.limitType == "allTime" then
		preStr = "永久限购："
	elseif cfg.limitType == "none" then
		return
	end

	local remainCount = self:shopRemainCount(cfg)

	return string.format("%s%d/%d", preStr, remainCount, cfg.limitTimes)
end

function EternalFarmController:shopRemainCount(cfg)
	if cfg.limitType == "none" then
		return 99
	end

	local times = EternalFarmModel.instance:getShopBuyTimes(cfg.shopId)

	return math.max(cfg.limitTimes - times, 0)
end

function EternalFarmController:isSellOut(cfg)
	if cfg.type == 2 then
		local itemType, itemId, itemNum = MaterialMgr.getMatParams(cfg.cost)

		hasCount = MaterialModel.instance:getMaterialsNumber(itemType, itemId)

		return hasCount <= 0
	else
		if cfg.limitType == "none" then
			return false
		end

		return self:shopRemainCount(cfg) <= 0
	end
end

function EternalFarmController:nextPrizeIds(activityId, itemId)
	local prizeIds = EternalFarmModel.instance:hasGainPrizeIds(itemId)
	local prizeData = EternalFarmConfig.instance:getCollectPrizeCfgByItemId(activityId, itemId)

	if prizeIds and prizeData then
		return (#prizeIds < #prizeData or nil) and (#prizeIds + 1 or #prizeData)
	end

	return 1
end

function EternalFarmController:isFinishAllReward(activityId, itemId)
	local itemPrizeNum = EternalFarmConfig.instance:getItemPrizeNum(activityId, itemId) or 0
	local curPrizeIds = EternalFarmModel.instance:hasGainPrizeIds(itemId)

	if curPrizeIds then
		if not #curPrizeIds then
			local curGainPrizeNum = 0

			return itemPrizeNum <= curGainPrizeNum
		end
	end
end

function EternalFarmController:getMultipleZoneId(activityId)
	local multipleCfg = EternalFarmConfig.instance:getMultipleCfg(activityId)
	local nowTime = ServerTime.now() - GameUtil.SERVER_TICK_DAILYR_EFRESH * 3600
	local timetable = GameUtil.time2date(nowTime)
	local day = timetable.wday - 1

	if day <= 0 then
		day = 7
	end

	local cfg = multipleCfg[day]

	return (cfg or nil) and (cfg.zoneId or {})
end

function EternalFarmController:loadBaseData()
	local activityId
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.EternalFarm)

	if cfgs then
		for i, v in pairs(cfgs) do
			if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.EternalFarm, v.activityId) == true then
				activityId = v.activityId

				break
			end
		end

		if activityId then
			EternalFarmController.instance:sendPM_EternalFarmInfoReq(activityId)
		end
	end
end

function EternalFarmController:_checkSellRedPoint()
	local isOn = false
	local activityId
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.EternalFarm)

	if cfgs then
		for i, v in pairs(cfgs) do
			if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.EternalFarm, v.activityId) == true then
				activityId = v.activityId

				break
			end
		end

		if activityId then
			local shopCfg = EternalFarmConfig.instance:getShopCfgByType(activityId, 2)

			for i, v in ipairs(shopCfg) do
				local matType, matId, matNum = MaterialMgr.getMatParams(v.cost)

				if MaterialModel.instance:getMaterialsNumber(matType, matId) > 0 then
					isOn = true

					break
				end
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ETERNAL_FARM_SELL, isOn)
end

EternalFarmController.instance = EternalFarmController.New()

return EternalFarmController
