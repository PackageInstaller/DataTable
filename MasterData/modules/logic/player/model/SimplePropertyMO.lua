-- chunkname: @modules/logic/player/model/SimplePropertyMO.lua

module("modules.logic.player.model.SimplePropertyMO", package.seeall)

local SimplePropertyMO = pureTable("SimplePropertyMO")

function SimplePropertyMO:init(info)
	self.id = info.id
	self.property = info.property
end

return SimplePropertyMO
