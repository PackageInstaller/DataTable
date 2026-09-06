-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalfarm/model/EternalFarmModel.lua

module("logic.extensions.eternalfarm.model.EternalFarmModel", package.seeall)

local EternalFarmModel = class("EternalFarmModel", BaseModel)

EternalFarmModel.FieldState = {
	Mature = 2,
	Farming = 1,
	Empty = 0
}
EternalFarmModel.FarmState = {
	PickSeed = 1,
	Accelerate = 2,
	Empty = 0
}

function EternalFarmModel:ctor()
	return
end

function EternalFarmModel:onInit()
	self:onReset()
end

function EternalFarmModel:onReset()
	self._farmInfo = {}
	self._farmHarves = {}
	self._selectZoneId = 0
	self._selectIndexId = 0
end

function EternalFarmModel:setFarmInfo(msg)
	GameUtil.pbToTable(msg, self._farmInfo)
end

function EternalFarmModel:isGainDailyReward()
	return checkbool(self._farmInfo.hadGainPrize)
end

function EternalFarmModel:getZoneGainTimes(zoneId)
	for _, v in ipairs(self._farmInfo.zone) do
		if v.zoneId == zoneId then
			return checknumber(v.gainTimes)
		end
	end

	return 0
end

function EternalFarmModel:isUnlock(zoneId)
	for _, v in ipairs(self._farmInfo.zone) do
		if v.zoneId == zoneId then
			return v.unlocked
		end
	end

	return false
end

function EternalFarmModel:getZoneInfoById(zoneId)
	for _, v in ipairs(self._farmInfo.zone) do
		if v.zoneId == zoneId then
			return v.index
		end
	end
end

function EternalFarmModel:getCropInfoById(zoneId, indexId)
	local zoneInfo = self:getZoneInfoById(zoneId)

	if #zoneInfo > 0 then
		for _, v in ipairs(zoneInfo) do
			if v.indexId == indexId then
				return v
			end
		end
	end
end

function EternalFarmModel:setSelectId(zoneId, indexId)
	self._selectZoneId = zoneId
	self._selectIndexId = indexId
end

function EternalFarmModel:getSelectId()
	return self._selectZoneId, self._selectIndexId
end

function EternalFarmModel:setFarmHarvesInfo(msg)
	table.clear(self._farmHarves)
	GameUtil.pbToTable(msg, self._farmHarves)
end

function EternalFarmModel:getUltimateCropIds()
	return self._farmHarves.ultimateCropIds or {}
end

function EternalFarmModel:getRefreshField()
	return self._farmHarves.index or {}
end

function EternalFarmModel:getShopBuyTimes(shopId)
	if not TableUtil.isTableEmpty(self._farmInfo.shopBuyItems) then
		for _, v in ipairs(self._farmInfo.shopBuyItems) do
			if shopId == v.shopId then
				return v.buyTimes
			end
		end
	end

	return 0
end

function EternalFarmModel:hasGainPrizeIds(itemId)
	local prizeItems = self._farmInfo.prizeItems
	local prizeIds = {}

	if prizeItems then
		for index, prizeItem in pairs(prizeItems) do
			if prizeItem.itemId == itemId then
				prizeIds = prizeItem.hadGainPrizeIds
			end
		end
	end

	return prizeIds
end

EternalFarmModel.instance = EternalFarmModel.New()

return EternalFarmModel
