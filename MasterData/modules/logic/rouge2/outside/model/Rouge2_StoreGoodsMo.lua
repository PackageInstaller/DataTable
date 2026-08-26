-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_StoreGoodsMo.lua

module("modules.logic.rouge2.outside.model.Rouge2_StoreGoodsMo", package.seeall)

local Rouge2_StoreGoodsMo = pureTable("Rouge2_StoreGoodsMo")

function Rouge2_StoreGoodsMo:init(mo)
	self.goodsId = mo.id
	self.storeMo = mo
end

return Rouge2_StoreGoodsMo
