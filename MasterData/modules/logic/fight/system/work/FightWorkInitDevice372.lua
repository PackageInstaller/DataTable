-- chunkname: @modules/logic/fight/system/work/FightWorkInitDevice372.lua

module("modules.logic.fight.system.work.FightWorkInitDevice372", package.seeall)

local FightWorkInitDevice372 = class("FightWorkInitDevice372", FightEffectBase)

function FightWorkInitDevice372:onStart()
	FightController.instance:dispatchEvent(FightEvent.OnCreateDeviceArea)

	return self:onDone(true)
end

return FightWorkInitDevice372
