-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballTriggerEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballTriggerEntity", package.seeall)

local PinballTriggerEntity = class("PinballTriggerEntity", PinballColliderEntity)

function PinballTriggerEntity:onHitEnter(hitEntityId, hitX, hitY, hitDir)
	local effectEntity = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.CommonEffect)

	effectEntity:setDelayDispose(2)

	effectEntity.x = hitX
	effectEntity.y = hitY

	effectEntity:tick(0)
	effectEntity:playAnim("hit")
end

return PinballTriggerEntity
