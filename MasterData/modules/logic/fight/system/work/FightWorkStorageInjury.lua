-- chunkname: @modules/logic/fight/system/work/FightWorkStorageInjury.lua

module("modules.logic.fight.system.work.FightWorkStorageInjury", package.seeall)

local FightWorkStorageInjury = class("FightWorkStorageInjury", FightEffectBase)

function FightWorkStorageInjury:onStart()
	self:onDone(true)
end

function FightWorkStorageInjury:clearWork()
	return
end

return FightWorkStorageInjury
