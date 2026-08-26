-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballResSmallFoodEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballResSmallFoodEntity", package.seeall)

local PinballResSmallFoodEntity = class("PinballResSmallFoodEntity", PinballResEntity)

function PinballResSmallFoodEntity:initByCo(pinballUnitCo)
	PinballResSmallFoodEntity.super.initByCo(self, pinballUnitCo)

	self._initDt = UnityEngine.Time.realtimeSinceStartup
end

function PinballResSmallFoodEntity:onHitCount()
	PinballModel.instance:addGameRes(self.resType, self.resNum)
	PinballEntityMgr.instance:addNumShow(self.resNum, self.x + self.width, self.y + self.height)
	PinballEntityMgr.instance:removeEntity(self.id)
end

return PinballResSmallFoodEntity
