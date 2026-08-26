-- chunkname: @modules/logic/fight/system/work/asfd/effectwork/FightWorkEmitterEnergyChange.lua

module("modules.logic.fight.system.work.asfd.effectwork.FightWorkEmitterEnergyChange", package.seeall)

local FightWorkEmitterEnergyChange = class("FightWorkEmitterEnergyChange", FightEffectBase)

function FightWorkEmitterEnergyChange:beforePlayEffectData()
	local side = self.actEffectData.effectNum

	self.beforeEnergy = FightDataHelper.ASFDDataMgr:getEmitterEnergy(side)
end

function FightWorkEmitterEnergyChange:onStart()
	local side = self.actEffectData.effectNum
	local curEnergy = FightDataHelper.ASFDDataMgr:getEmitterEnergy(side)

	FightController.instance:dispatchEvent(FightEvent.ASFD_EmitterEnergyChange, side, self.beforeEnergy, curEnergy)

	return self:onDone(true)
end

return FightWorkEmitterEnergyChange
