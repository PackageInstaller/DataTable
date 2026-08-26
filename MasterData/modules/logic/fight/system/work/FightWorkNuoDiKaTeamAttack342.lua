-- chunkname: @modules/logic/fight/system/work/FightWorkNuoDiKaTeamAttack342.lua

module("modules.logic.fight.system.work.FightWorkNuoDiKaTeamAttack342", package.seeall)

local FightWorkNuoDiKaTeamAttack342 = class("FightWorkNuoDiKaTeamAttack342", FightEffectBase)

function FightWorkNuoDiKaTeamAttack342:onStart()
	self:onDone(true)
end

return FightWorkNuoDiKaTeamAttack342
