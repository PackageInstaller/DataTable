-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballTriggerObstacleEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballTriggerObstacleEntity", package.seeall)

local PinballTriggerObstacleEntity = class("PinballTriggerObstacleEntity", PinballTriggerEntity)

function PinballTriggerObstacleEntity:onInitByCo()
	self.force = (tonumber(self.spData) or 1000) / 1000
	self.baseForceX = self.force
	self.baseForceY = self.force
end

return PinballTriggerObstacleEntity
