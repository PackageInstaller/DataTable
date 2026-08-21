-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/manufacture/model/ManufacturePlantMO.lua

module("logic.extensions.manufacture.model.ManufacturePlantMO", package.seeall)

local M = class("ManufacturePlantMO")

function M:ctor(id)
	self._id = id
	self._isLock = true
	self._scheme = 0
end

function M:updateByAgent(NO, isPush)
	self._isLock = false

	self:setCurrProductivity(NO.productivity)
	self:setCurrStore(NO.store)

	self._scheme = checknumber(NO.schema)
	self._productSpeed = NO.productSpeed
	self._productHero = NO.productHero
	self._productHouseRatio = NO.productHouseRatio
	self._schemeCO = nil

	if self._scheme > 0 then
		self._schemeCO = ManufactureConfig.instance:getConfigByKey(ConfigName.HouseManufactureScheme, self._scheme)
	end

	self:updateNextProductTimeStamp(isPush)
	self:_updateProductCostTime()
end

function M:updateNextProductTimeStamp(isPush)
	self._nextProductTimeStamp = 0

	if self._scheme > 0 then
		local needNum = self._schemeCO.need
		local minCount = math.ceil((needNum - self._productivity) / self._productSpeed)
		local serverDate = ServerTime.nowDate()
		local currSecond = isPush and 0 or serverDate.sec

		self._nextProductTimeStamp = ServerTime.now() - currSecond + minCount * 60
	end
end

function M:isLock()
	return self._isLock
end

function M:getPlantId()
	return self._id
end

function M:setCurrStore(store)
	store = checknumber(store)
	self._store = store
end

function M:getCurrStore()
	return self._store
end

function M:setCurrProductivity(productivity)
	self._productivity = productivity
end

function M:getSchemeId()
	return self._scheme
end

function M:getProductSpeed()
	return self._productSpeed
end

function M:getProductHero()
	return self._productHero
end

function M:getProductHouseRatio()
	return self._productHouseRatio
end

function M:getStoreCost()
	if self._schemeCO then
		return self._schemeCO.store
	end
end

function M:isStoreFulled()
	local currStore = self:getCurrStore()
	local limitStore = ManufactureModel.instance:getPlantLimitStore()

	return limitStore < self:getStoreCost() + currStore
end

function M:getRemainProductNum()
	local currStore = self:getCurrStore()
	local limitStore = ManufactureModel.instance:getPlantLimitStore()

	return math.floor((limitStore - currStore) / self:getStoreCost())
end

function M:getProductCostTime()
	return self._productCostTime
end

function M:getProductCostSec()
	return self._productCostSec
end

function M:getNextProductTimeStamp()
	return self._nextProductTimeStamp
end

function M:getNextProductProgress()
	local remainTime = self._nextProductTimeStamp - ServerTime.now()
	local progress = remainTime > 0 and (self._productCostTime - remainTime) / self._productCostTime or 1

	progress = math.max(0, progress)

	return progress
end

function M:getRemainTimeToFull()
	local remainTime = 0

	if not self:isStoreFulled() then
		local currStore = self:getCurrStore()
		local limitStore = ManufactureModel.instance:getPlantLimitStore()
		local remainCount = math.floor((limitStore - currStore) / self:getStoreCost())

		remainCount = math.max(0, remainCount - 1)
		remainTime = self._nextProductTimeStamp - ServerTime.now() + remainCount * self._productCostSec
		remainTime = math.max(0, remainTime)
	end

	return remainTime
end

function M:_updateProductCostTime()
	self._productCostTime = 0
	self._productCostSec = 0

	if self._scheme > 0 then
		local needNum = self._schemeCO.need
		local minCount = needNum / self._productSpeed

		self._productCostSec = minCount * 60
		self._productCostTime = math.ceil(minCount) * 60
	end
end

return M
