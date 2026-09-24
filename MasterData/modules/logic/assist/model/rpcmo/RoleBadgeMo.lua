-- chunkname: @modules/logic/assist/model/rpcmo/RoleBadgeMo.lua

module("modules.logic.assist.model.rpcmo.RoleBadgeMo", package.seeall)

local RoleBadgeMo = pureTable("RoleBadgeMo")

function RoleBadgeMo:init(data)
	self.id = data.id
	self.progress = data.progress
	self.status = data.status
	self.config = RoleBadgeConfig.instance:getBadgeCo(self.id)
end

return RoleBadgeMo
