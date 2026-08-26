-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballMarblesGlassEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballMarblesGlassEntity", package.seeall)

local PinballMarblesGlassEntity = class("PinballMarblesGlassEntity", PinballMarblesEntity)

function PinballMarblesGlassEntity:onHitEnter(hitEntityId, hitX, hitY, hitDir)
	local hitEntity = PinballEntityMgr.instance:getEntity(hitEntityId)

	if not hitEntity then
		return
	end

	if hitEntity:isResType() then
		if hitEntity.unitType == PinballEnum.UnitType.ResMine and hitEntity.totalHitCount > self.hitNum then
			PinballMarblesGlassEntity.super.onHitEnter(self, hitEntityId, hitX, hitY, hitDir)
		else
			AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio16)
			hitEntity:doHit(self.hitNum)
		end
	else
		PinballMarblesGlassEntity.super.onHitEnter(self, hitEntityId, hitX, hitY, hitDir)
	end
end

function PinballMarblesGlassEntity:getHitResCount()
	return self.hitNum
end

return PinballMarblesGlassEntity
