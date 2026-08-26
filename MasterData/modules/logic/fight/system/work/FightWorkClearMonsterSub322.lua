-- chunkname: @modules/logic/fight/system/work/FightWorkClearMonsterSub322.lua

module("modules.logic.fight.system.work.FightWorkClearMonsterSub322", package.seeall)

local FightWorkClearMonsterSub322 = class("FightWorkClearMonsterSub322", FightEffectBase)

function FightWorkClearMonsterSub322:onStart()
	self:com_sendFightEvent(FightEvent.ClearMonsterSub)
	self:onDone(true)
end

function FightWorkClearMonsterSub322:clearWork()
	return
end

return FightWorkClearMonsterSub322
