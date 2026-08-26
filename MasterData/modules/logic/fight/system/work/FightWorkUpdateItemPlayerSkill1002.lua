-- chunkname: @modules/logic/fight/system/work/FightWorkUpdateItemPlayerSkill1002.lua

module("modules.logic.fight.system.work.FightWorkUpdateItemPlayerSkill1002", package.seeall)

local FightWorkUpdateItemPlayerSkill1002 = class("FightWorkUpdateItemPlayerSkill1002", FightEffectBase)

function FightWorkUpdateItemPlayerSkill1002:onStart()
	self:onDone(true)
end

return FightWorkUpdateItemPlayerSkill1002
