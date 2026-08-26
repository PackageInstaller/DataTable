-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/mo/RogueGoodsInfoMO.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueGoodsInfoMO", package.seeall)

local RogueGoodsInfoMO = pureTable("RogueGoodsInfoMO")

function RogueGoodsInfoMO:init(info)
	self.activityId = info.activityId
	self.id = info.id
	self.buyCount = info.buyCount
end

return RogueGoodsInfoMO
