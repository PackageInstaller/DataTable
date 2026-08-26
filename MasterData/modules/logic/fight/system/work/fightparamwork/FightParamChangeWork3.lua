-- chunkname: @modules/logic/fight/system/work/fightparamwork/FightParamChangeWork3.lua

module("modules.logic.fight.system.work.fightparamwork.FightParamChangeWork3", package.seeall)

local FightParamChangeWork3 = class("FightParamChangeWork3", FightParamWorkBase)

function FightParamChangeWork3:onStart()
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnValueChange, self.oldValue, self.currValue, self.offset)
	self:com_registTimer(self._delayDone, FightDoomsdayClockView.ZhiZhenTweenDuration)
end

return FightParamChangeWork3
