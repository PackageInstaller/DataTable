-- chunkname: @modules/logic/fight/system/work/asfd/effectwork/FightWorkChangeCardEnergy.lua

module("modules.logic.fight.system.work.asfd.effectwork.FightWorkChangeCardEnergy", package.seeall)

local FightWorkChangeCardEnergy = class("FightWorkChangeCardEnergy", FightEffectBase)

function FightWorkChangeCardEnergy:onConstructor()
	self.SAFETIME = 1.5
end

function FightWorkChangeCardEnergy:onStart()
	local changeList = FightStrUtil.instance:getSplitString2Cache(self.actEffectData.reserveStr, true)

	FightController.instance:dispatchEvent(FightEvent.ASFD_OnChangeCardEnergy, changeList)
	TaskDispatcher.runDelay(self._delayDone, self, 1 / FightModel.instance:getUISpeed())
end

function FightWorkChangeCardEnergy:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightWorkChangeCardEnergy
