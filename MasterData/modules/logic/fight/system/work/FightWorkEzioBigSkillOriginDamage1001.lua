-- chunkname: @modules/logic/fight/system/work/FightWorkEzioBigSkillOriginDamage1001.lua

module("modules.logic.fight.system.work.FightWorkEzioBigSkillOriginDamage1001", package.seeall)

local FightWorkEzioBigSkillOriginDamage1001 = class("FightWorkEzioBigSkillOriginDamage1001", FightEffectBase)

function FightWorkEzioBigSkillOriginDamage1001:onStart()
	self:onDone(true)
end

return FightWorkEzioBigSkillOriginDamage1001
