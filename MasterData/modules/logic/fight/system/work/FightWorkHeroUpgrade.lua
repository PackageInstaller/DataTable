-- chunkname: @modules/logic/fight/system/work/FightWorkHeroUpgrade.lua

module("modules.logic.fight.system.work.FightWorkHeroUpgrade", package.seeall)

local FightWorkHeroUpgrade = class("FightWorkHeroUpgrade", FightEffectBase)

function FightWorkHeroUpgrade:onStart()
	self:onDone(true)
end

function FightWorkHeroUpgrade:clearWork()
	return
end

return FightWorkHeroUpgrade
