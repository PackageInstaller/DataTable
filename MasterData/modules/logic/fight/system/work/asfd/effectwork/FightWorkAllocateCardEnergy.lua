-- chunkname: @modules/logic/fight/system/work/asfd/effectwork/FightWorkAllocateCardEnergy.lua

module("modules.logic.fight.system.work.asfd.effectwork.FightWorkAllocateCardEnergy", package.seeall)

local FightWorkAllocateCardEnergy = class("FightWorkAllocateCardEnergy", FightEffectBase)

function FightWorkAllocateCardEnergy:onConstructor()
	self.SAFETIME = 3
end

FightWorkAllocateCardEnergy.AllocateEnum = {
	Clear = 0,
	Allocate = 1
}

function FightWorkAllocateCardEnergy:onStart()
	local effectNum1 = self.actEffectData.effectNum1

	if effectNum1 ~= FightWorkAllocateCardEnergy.AllocateEnum.Allocate then
		self:onDone(true)

		return
	end

	FightController.instance:registerCallback(FightEvent.ASFD_AllocateCardEnergyDone, self.allocateCardEnergyDone, self)
	FightController.instance:dispatchEvent(FightEvent.ASFD_StartAllocateCardEnergy)
end

FightWorkAllocateCardEnergy.ASFDOpenTime = 0.5

function FightWorkAllocateCardEnergy:allocateCardEnergyDone()
	TaskDispatcher.runDelay(self._delayDone, self, FightWorkAllocateCardEnergy.ASFDOpenTime / FightModel.instance:getUISpeed())
end

function FightWorkAllocateCardEnergy:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
	FightController.instance:unregisterCallback(FightEvent.ASFD_AllocateCardEnergyDone, self.allocateCardEnergyDone, self)
end

return FightWorkAllocateCardEnergy
