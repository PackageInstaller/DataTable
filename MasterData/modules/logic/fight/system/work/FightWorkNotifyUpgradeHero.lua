-- chunkname: @modules/logic/fight/system/work/FightWorkNotifyUpgradeHero.lua

module("modules.logic.fight.system.work.FightWorkNotifyUpgradeHero", package.seeall)

local FightWorkNotifyUpgradeHero = class("FightWorkNotifyUpgradeHero", FightEffectBase)

function FightWorkNotifyUpgradeHero:onStart()
	self:onDone(true)
end

function FightWorkNotifyUpgradeHero:clearWork()
	return
end

return FightWorkNotifyUpgradeHero
