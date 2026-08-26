-- chunkname: @modules/logic/fight/system/work/FightWorkUnnamedStrengthen380.lua

module("modules.logic.fight.system.work.FightWorkUnnamedStrengthen380", package.seeall)

local FightWorkUnnamedStrengthen380 = class("FightWorkUnnamedStrengthen380", FightEffectBase)

function FightWorkUnnamedStrengthen380:onStart()
	return self:onDone(true)
end

return FightWorkUnnamedStrengthen380
