-- chunkname: @modules/logic/versionactivity3_3/marsha/model/MarshaUnitCo.lua

module("modules.logic.versionactivity3_3.marsha.model.MarshaUnitCo", package.seeall)

local MarshaUnitCo = pureTable("MarshaUnitCo")

function MarshaUnitCo:init(co)
	self.unitType = co[1]
	self.posX = co[2]
	self.posY = co[3]
	self.weight = co[4]
	self.speed = co[5] or 0
	self.acceleration = co[6] or 0
end

return MarshaUnitCo
