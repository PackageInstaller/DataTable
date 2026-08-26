-- chunkname: @modules/logic/fight/system/work/fightparamwork/FightParamChangeWork9.lua

module("modules.logic.fight.system.work.fightparamwork.FightParamChangeWork9", package.seeall)

local FightParamChangeWork9 = class("FightParamChangeWork9", FightParamWorkBase)

function FightParamChangeWork9:onStart()
	FightController.instance:dispatchEvent(FightEvent.UpdateFightParam, self.keyId, self.oldValue, self.currValue, self.offset)
	self:onDone(true)
end

return FightParamChangeWork9
