-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballTriggerNoneEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballTriggerNoneEntity", package.seeall)

local PinballTriggerNoneEntity = class("PinballTriggerNoneEntity", PinballTriggerEntity)

function PinballTriggerNoneEntity:canHit()
	return false
end

return PinballTriggerNoneEntity
