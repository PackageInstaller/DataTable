-- chunkname: @modules/logic/fight/system/work/FightWorkNuoDiKaRandomAttack341.lua

module("modules.logic.fight.system.work.FightWorkNuoDiKaRandomAttack341", package.seeall)

local FightWorkNuoDiKaRandomAttack341 = class("FightWorkNuoDiKaRandomAttack341", FightEffectBase)

function FightWorkNuoDiKaRandomAttack341:onStart()
	self:onDone(true)
end

return FightWorkNuoDiKaRandomAttack341
