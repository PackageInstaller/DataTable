-- chunkname: @modules/logic/store/model/StoreSkinChargeMo.lua

module("modules.logic.store.model.StoreSkinChargeMo", package.seeall)

local StoreSkinChargeMo = pureTable("StoreSkinChargeMo")

function StoreSkinChargeMo:init(belongStoreId, info)
	self.belongStoreId = belongStoreId
	self.id = info.id
	self.buyCount = info.buyCount
	self.config = StoreConfig.instance:getChargeGoodsConfig(self.id)
end

function StoreSkinChargeMo:getSkinChargePrice()
	local price, originalPrice

	if self.config then
		price = self.config.price
		originalPrice = self.config.originalCost
	end

	return price, originalPrice
end

function StoreSkinChargeMo:isSoldOut()
	return self.buyCount > 0
end

return StoreSkinChargeMo
