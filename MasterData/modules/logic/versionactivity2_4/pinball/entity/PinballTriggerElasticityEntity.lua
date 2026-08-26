-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballTriggerElasticityEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballTriggerElasticityEntity", package.seeall)

local PinballTriggerElasticityEntity = class("PinballTriggerElasticityEntity", PinballTriggerEntity)

function PinballTriggerElasticityEntity:onInit()
	PinballTriggerElasticityEntity.super.onInit(self)
end

function PinballTriggerElasticityEntity:onInitByCo()
	self.force = (tonumber(self.spData) or 1000) / 1000
	self.baseForceX = self.force
	self.baseForceY = self.force
end

return PinballTriggerElasticityEntity
