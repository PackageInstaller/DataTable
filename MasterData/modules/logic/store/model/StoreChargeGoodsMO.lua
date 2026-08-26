-- chunkname: @modules/logic/store/model/StoreChargeGoodsMO.lua

module("modules.logic.store.model.StoreChargeGoodsMO", package.seeall)

local StoreChargeGoodsMO = pureTable("StoreChargeGoodsMO")

function StoreChargeGoodsMO:init(belongStoreId, info)
	self.belongStoreId = belongStoreId
	self.id = info.id
	self.buyCount = info.buyCount
	self.firstCharge = info.firstCharge
	self.config = StoreConfig.instance:getChargeGoodsConfig(self.id)
end

return StoreChargeGoodsMO
