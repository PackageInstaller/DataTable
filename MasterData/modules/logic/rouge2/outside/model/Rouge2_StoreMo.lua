-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_StoreMo.lua

module("modules.logic.rouge2.outside.model.Rouge2_StoreMo", package.seeall)

local Rouge2_StoreMo = pureTable("Rouge2_StoreMo")

function Rouge2_StoreMo:init(id)
	self.id = id
	self.config = Rouge2_OutSideConfig.instance:getRewardConfigById(id)
	self.buyCount = 0
end

return Rouge2_StoreMo
