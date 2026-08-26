-- chunkname: @modules/logic/sodache/model/SodacheShopGoodsMo.lua

module("modules.logic.sodache.model.SodacheShopGoodsMo", package.seeall)

local SodacheShopGoodsMo = pureTable("SodacheShopGoodsMo")

function SodacheShopGoodsMo:init(shopMo)
	self.shopMo = shopMo
	self.selectCount = 0
end

return SodacheShopGoodsMo
