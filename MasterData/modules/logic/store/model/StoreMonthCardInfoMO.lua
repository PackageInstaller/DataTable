-- chunkname: @modules/logic/store/model/StoreMonthCardInfoMO.lua

module("modules.logic.store.model.StoreMonthCardInfoMO", package.seeall)

local StoreMonthCardInfoMO = pureTable("StoreMonthCardInfoMO")

function StoreMonthCardInfoMO:init(info)
	self:update(info)
end

function StoreMonthCardInfoMO:update(info)
	self.id = info.id
	self.expiredTime = info.expireTime
	self.hasGetBonus = info.hasGetBonus
	self.config = StoreConfig.instance:getChargeGoodsConfig(self.id)
end

function StoreMonthCardInfoMO:getRemainDay()
	local offsetSecond = self.expiredTime - ServerTime.now()

	if offsetSecond < 0 then
		return StoreEnum.MonthCardStatus.NotPurchase
	elseif offsetSecond < TimeUtil.OneDaySecond then
		return StoreEnum.MonthCardStatus.NotEnoughOneDay
	else
		return math.floor(offsetSecond / TimeUtil.OneDaySecond)
	end
end

function StoreMonthCardInfoMO:getRemainDay2()
	local offsetSecond = self.expiredTime - ServerTime.now()

	return math.ceil(offsetSecond / TimeUtil.OneDaySecond)
end

function StoreMonthCardInfoMO:hasExpired()
	return self.expiredTime < ServerTime.now()
end

return StoreMonthCardInfoMO
