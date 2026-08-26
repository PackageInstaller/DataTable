-- chunkname: @modules/logic/rouge/model/rpcmo/RougeTalentMO.lua

module("modules.logic.rouge.model.rpcmo.RougeTalentMO", package.seeall)

local RougeTalentMO = pureTable("RougeTalentMO")

function RougeTalentMO:init(info)
	self.id = info.id
	self.isActive = info.isActive
end

return RougeTalentMO
