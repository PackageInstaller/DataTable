-- chunkname: @modules/logic/fight/system/work/FightWorkPowerInfoChange.lua

module("modules.logic.fight.system.work.FightWorkPowerInfoChange", package.seeall)

local FightWorkPowerInfoChange = class("FightWorkPowerInfoChange", FightEffectBase)

function FightWorkPowerInfoChange:onStart()
	local entityId = self.actEffectData.targetId
	local powerId = self.actEffectData.powerInfo.powerId

	self:com_sendFightEvent(FightEvent.PowerInfoChange, entityId, powerId)
	self:onDone(true)
end

return FightWorkPowerInfoChange
