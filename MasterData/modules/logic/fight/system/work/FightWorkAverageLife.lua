-- chunkname: @modules/logic/fight/system/work/FightWorkAverageLife.lua

module("modules.logic.fight.system.work.FightWorkAverageLife", package.seeall)

local FightWorkAverageLife = class("FightWorkAverageLife", FightEffectBase)

function FightWorkAverageLife:onStart()
	self:com_sendFightEvent(FightEvent.OnCurrentHpChange, self.actEffectData.targetId)
	self:onDone(true)
end

return FightWorkAverageLife
