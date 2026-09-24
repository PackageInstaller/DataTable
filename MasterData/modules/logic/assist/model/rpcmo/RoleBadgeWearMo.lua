-- chunkname: @modules/logic/assist/model/rpcmo/RoleBadgeWearMo.lua

module("modules.logic.assist.model.rpcmo.RoleBadgeWearMo", package.seeall)

local RoleBadgeWearMo = pureTable("RoleBadgeWearMo")

function RoleBadgeWearMo:init(data)
	self.position = data.position
	self.badgeId = data.badgeId
end

return RoleBadgeWearMo
