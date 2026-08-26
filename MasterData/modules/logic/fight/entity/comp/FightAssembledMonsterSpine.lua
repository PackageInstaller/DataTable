-- chunkname: @modules/logic/fight/entity/comp/FightAssembledMonsterSpine.lua

module("modules.logic.fight.entity.comp.FightAssembledMonsterSpine", package.seeall)

local FightAssembledMonsterSpine = class("FightAssembledMonsterSpine", FightUnitSpine)

function FightAssembledMonsterSpine:playBySub(entity, animState, loop, reStart)
	if animState == "die" or animState == "idle" then
		return
	end

	self:play(animState, loop, reStart)
end

return FightAssembledMonsterSpine
