-- chunkname: @modules/logic/fight/system/work/FightWorkCheckNewSeasonSubSkill.lua

module("modules.logic.fight.system.work.FightWorkCheckNewSeasonSubSkill", package.seeall)

local FightWorkCheckNewSeasonSubSkill = class("FightWorkCheckNewSeasonSubSkill", FightWorkItem)

function FightWorkCheckNewSeasonSubSkill:onStart()
	self:onDone(true)
end

return FightWorkCheckNewSeasonSubSkill
