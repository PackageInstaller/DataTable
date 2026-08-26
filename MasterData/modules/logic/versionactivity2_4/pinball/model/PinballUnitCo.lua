-- chunkname: @modules/logic/versionactivity2_4/pinball/model/PinballUnitCo.lua

module("modules.logic.versionactivity2_4.pinball.model.PinballUnitCo", package.seeall)

local PinballUnitCo = pureTable("PinballUnitCo")

function PinballUnitCo:init(co)
	self.unitType = co[1]
	self.posX = co[2]
	self.posY = co[3]
	self.specialData = co[4]
	self.angle = co[5] or 0
	self.spriteName = co[6] or ""
	self.size = co[7] and Vector2(co[7][1], co[7][2]) or Vector2()
	self.shape = co[8] or PinballEnum.Shape.Rect
	self.scale = co[9] or 1
	self.resType = co[10] or PinballEnum.ResType.Food
	self.speed = co[11] and Vector2(co[11][1], co[11][2]) or Vector2()
end

return PinballUnitCo
