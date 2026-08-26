-- chunkname: @modules/logic/fight/system/work/FightWorkRougePowerLimitChange.lua

module("modules.logic.fight.system.work.FightWorkRougePowerLimitChange", package.seeall)

local FightWorkRougePowerLimitChange = class("FightWorkRougePowerLimitChange", FightEffectBase)

function FightWorkRougePowerLimitChange:onStart()
	local value = FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.MagicLimit)

	FightModel.instance:setRougeExData(FightEnum.ExIndexForRouge.MagicLimit, value + self.actEffectData.effectNum)
	FightController.instance:dispatchEvent(FightEvent.RougeMagicLimitChange)
	self:onDone(true)
end

function FightWorkRougePowerLimitChange:clearWork()
	return
end

return FightWorkRougePowerLimitChange
