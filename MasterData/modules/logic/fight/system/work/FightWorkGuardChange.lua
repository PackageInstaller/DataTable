-- chunkname: @modules/logic/fight/system/work/FightWorkGuardChange.lua

module("modules.logic.fight.system.work.FightWorkGuardChange", package.seeall)

local FightWorkGuardChange = class("FightWorkGuardChange", FightEffectBase)

function FightWorkGuardChange:onStart()
	local actEffectData = self.actEffectData
	local entityMO = FightDataHelper.entityMgr:getById(actEffectData.targetId)

	if entityMO then
		FightController.instance:dispatchEvent(FightEvent.EntityGuardChange, entityMO.id, self.actEffectData.effectNum, entityMO.guard)
	end

	self:onDone(true)
end

function FightWorkGuardChange:clearWork()
	return
end

return FightWorkGuardChange
