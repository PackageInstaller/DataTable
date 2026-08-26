-- chunkname: @modules/logic/summon/model/SummonPoolHistoryTypeMO.lua

module("modules.logic.summon.model.SummonPoolHistoryTypeMO", package.seeall)

local SummonPoolHistoryTypeMO = pureTable("SummonPoolHistoryTypeMO")

function SummonPoolHistoryTypeMO:init(id, config)
	self.id = id
	self.config = config or SummonConfig.instance:getPoolDetailConfig(id)
end

return SummonPoolHistoryTypeMO
