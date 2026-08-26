-- chunkname: @modules/logic/fight/system/work/FightWorkCallMonsterToSub.lua

module("modules.logic.fight.system.work.FightWorkCallMonsterToSub", package.seeall)

local FightWorkCallMonsterToSub = class("FightWorkCallMonsterToSub", FightEffectBase)

function FightWorkCallMonsterToSub:onStart()
	self:com_sendFightEvent(FightEvent.AddSubEntity)
	self:onDone(true)
end

return FightWorkCallMonsterToSub
