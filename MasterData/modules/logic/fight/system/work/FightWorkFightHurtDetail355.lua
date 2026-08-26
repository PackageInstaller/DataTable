-- chunkname: @modules/logic/fight/system/work/FightWorkFightHurtDetail355.lua

module("modules.logic.fight.system.work.FightWorkFightHurtDetail355", package.seeall)

local FightWorkFightHurtDetail355 = class("FightWorkFightHurtDetail355", FightEffectBase)

function FightWorkFightHurtDetail355:onStart()
	return self:onDone(true)
end

return FightWorkFightHurtDetail355
