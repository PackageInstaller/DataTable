-- chunkname: @modules/logic/fight/system/work/FightWorkRemoveMonsterSub325.lua

module("modules.logic.fight.system.work.FightWorkRemoveMonsterSub325", package.seeall)

local FightWorkRemoveMonsterSub325 = class("FightWorkRemoveMonsterSub325", FightEffectBase)

function FightWorkRemoveMonsterSub325:onStart()
	self:com_sendFightEvent(FightEvent.RefreshMonsterSubCount)
	self:onDone(true)
end

function FightWorkRemoveMonsterSub325:clearWork()
	return
end

return FightWorkRemoveMonsterSub325
