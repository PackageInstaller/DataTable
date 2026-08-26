-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballResFoodEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballResFoodEntity", package.seeall)

local PinballResFoodEntity = class("PinballResFoodEntity", PinballResEntity)

function PinballResFoodEntity:onHitCount()
	local beginAngle = math.random(0, 360)
	local addAngle = 360 / self.divNum

	for i = 1, self.divNum do
		local randomAngle = beginAngle + addAngle * i
		local entity = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.ResSmallFood)

		entity:initByCo(self.unitCo)

		local newX, newY = PinballHelper.rotateAngle(entity.width * self.childScale * 0.5 + self.width * 0.5, entity.height * self.childScale * 0.5 + self.height * 0.5, randomAngle)

		entity.x = newX + self.x
		entity.y = newY + self.y
		entity.resNum = self.resNum
		entity.scale = self.childScale * self.scale
		entity.width = entity.width * self.childScale
		entity.height = entity.height * self.childScale

		entity:loadRes()
		entity:tick(0)
		entity:playAnim("clone")
	end

	PinballEntityMgr.instance:removeEntity(self.id)
end

function PinballResFoodEntity:onInitByCo()
	local arr = string.splitToNumber(self.spData, "#") or {}

	self.resNum = arr[1] or 0
	self.divNum = arr[2] or 0
	self.childScale = (arr[3] or 1000) / 1000
end

return PinballResFoodEntity
