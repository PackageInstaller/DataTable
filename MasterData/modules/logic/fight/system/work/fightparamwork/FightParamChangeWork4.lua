-- chunkname: @modules/logic/fight/system/work/fightparamwork/FightParamChangeWork4.lua

module("modules.logic.fight.system.work.fightparamwork.FightParamChangeWork4", package.seeall)

local FightParamChangeWork4 = class("FightParamChangeWork4", FightParamWorkBase)

function FightParamChangeWork4:onStart()
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnAreaChange, self.currValue)
	self:com_registTimer(self._delayDone, FightDoomsdayClockView.RotateDuration)
end

return FightParamChangeWork4
