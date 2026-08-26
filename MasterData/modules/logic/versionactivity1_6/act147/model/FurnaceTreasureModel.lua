-- chunkname: @modules/logic/versionactivity1_6/act147/model/FurnaceTreasureModel.lua

module("modules.logic.versionactivity1_6.act147.model.FurnaceTreasureModel", package.seeall)

local FurnaceTreasureModel = class("FurnaceTreasureModel", BaseModel)

function FurnaceTreasureModel:onInit()
	self:resetData()
end

function FurnaceTreasureModel:reInit()
	self:resetData()
end

function FurnaceTreasureModel:_checkServerData(serverData)
	local result = false

	if serverData then
		local serverActId = serverData.activityId

		result = self:_checkActId(serverActId)
	end

	return result
end

function FurnaceTreasureModel:_checkActId(serverActId)
	local result = false

	if serverActId then
		local localActId = self:getActId()

		result = serverActId == localActId
	end

	return result
end

function FurnaceTreasureModel:getActId()
	local list = ActivityModel.instance:getOnlineActIdByType(ActivityEnum.ActivityTypeID.Act147)

	return list and list[1]
end

function FurnaceTreasureModel:isActivityOpen()
	local actId = self:getActId()

	return (ActivityModel.instance:isActOnLine(actId))
end

function FurnaceTreasureModel:_checkGoodsData(storeId, goodsId)
	local result = false
	local isOpen = self:isActivityOpen()

	if not storeId or not goodsId and not isOpen then
		return result
	end

	if self._store2GoodsData[storeId] and self._store2GoodsData[storeId][goodsId] then
		result = true
	else
		logError(string.format("FurnaceTreasureModel:_checkGoodsData error,data is nil, storeId:%s, goodsId:%s", storeId, goodsId))
	end

	return result
end

function FurnaceTreasureModel:getGoodsPoolId(storeId, goodsId)
	local result = 0

	if not self:_checkGoodsData(storeId, goodsId) then
		return result
	end

	result = self._store2GoodsData[storeId][goodsId].poolId

	return self._store2GoodsData[storeId][goodsId].poolId
end

function FurnaceTreasureModel:getGoodsRemainCount(storeId, goodsId)
	local result = 0

	if not self:_checkGoodsData(storeId, goodsId) then
		return result
	end

	result = self._store2GoodsData[storeId][goodsId].remainCount

	return self._store2GoodsData[storeId][goodsId].remainCount
end

function FurnaceTreasureModel:getGoodsListByStoreId(storeId)
	local result = {}
	local isOpen = self:isActivityOpen()

	if storeId and isOpen and self._store2GoodsData[storeId] then
		for goodsId, _ in pairs(self._store2GoodsData[storeId]) do
			result[#result + 1] = goodsId
		end
	end

	return result
end

function FurnaceTreasureModel:getCostItem(storeId)
	local result = FurnaceTreasureEnum.StoreId2CostItem[storeId]

	if not result then
		logError(string.format("FurnaceTreasureModel:getCostItem error, no store cost item, storeId:%s", storeId))
	end

	return result
end

function FurnaceTreasureModel:getTotalRemainCount()
	return self._totalRemainCount
end

function FurnaceTreasureModel:getSpinePlayData(poolId)
	local co = {}

	co.motion = FurnaceTreasureEnum.BeginnerViewSpinePlayData

	if poolId and FurnaceTreasureEnum.Pool2SpinePlayData[poolId] then
		co.motion = FurnaceTreasureEnum.Pool2SpinePlayData[poolId]
	end

	return co
end

function FurnaceTreasureModel:setServerData(serverData, isResetData)
	local checkResult = self:_checkServerData(serverData)

	if not checkResult then
		return
	end

	if isResetData then
		self:resetData()
	end

	if serverData.act147Goods then
		for _, goodsData in ipairs(serverData.act147Goods) do
			self:setGoodsData(goodsData)
		end
	end

	self:setTotalRemainCount(serverData.totalRemainCount)
	FurnaceTreasureController.instance:dispatchEvent(FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate)
end

function FurnaceTreasureModel:setGoodsData(serverGoodsData)
	local storeId = serverGoodsData.belongStoreId
	local goodsId = serverGoodsData.id
	local remainCount = serverGoodsData.remainCount
	local poolId = serverGoodsData.poolId
	local storeGoodsData = self._store2GoodsData[storeId]

	if not storeGoodsData then
		storeGoodsData = {}
		self._store2GoodsData[storeId] = storeGoodsData
	end

	local goodsData = storeGoodsData[goodsId]

	if not goodsData then
		goodsData = {
			poolId = poolId
		}
		storeGoodsData[goodsId] = goodsData
	end

	self:setGoodsRemainCount(storeId, goodsId, remainCount)
end

function FurnaceTreasureModel:updateGoodsData(serverData)
	local serverActId = serverData.activityId
	local checkResult = self:_checkActId(serverActId)

	if not checkResult then
		return
	end

	local serverGoodsId = serverData.goodsId
	local serverRemainCount = serverData.remainCount
	local serverStoreId = serverData.storeId

	self:setGoodsRemainCount(serverStoreId, serverGoodsId, serverRemainCount)
	FurnaceTreasureController.instance:dispatchEvent(FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate)
end

function FurnaceTreasureModel:setGoodsRemainCount(storeId, goodsId, remainCount)
	local storeGoodsData = self._store2GoodsData[storeId]

	if storeGoodsData then
		if not storeGoodsData[goodsId] then
			local goodsData

			if not goodsData then
				return
			end

			goodsData.remainCount = remainCount
		end
	end
end

function FurnaceTreasureModel:setTotalRemainCount(count)
	count = count or 0
	self._totalRemainCount = count
end

function FurnaceTreasureModel:decreaseTotalRemainCount(serverActId)
	local checkResult = self:_checkActId(serverActId)

	if checkResult then
		local localActId = self:getActId()
		local originalCount = self:getTotalRemainCount(localActId)
		local newCount = originalCount - 1

		self:setTotalRemainCount(newCount)
		FurnaceTreasureController.instance:dispatchEvent(FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate)
	end
end

function FurnaceTreasureModel:resetData(dispatchEvent)
	self._store2GoodsData = {}

	self:setTotalRemainCount()

	if dispatchEvent then
		FurnaceTreasureController.instance:dispatchEvent(FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate)
	end
end

FurnaceTreasureModel.instance = FurnaceTreasureModel.New()

return FurnaceTreasureModel
