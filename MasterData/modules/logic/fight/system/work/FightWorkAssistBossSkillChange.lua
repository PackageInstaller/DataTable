-- chunkname: @modules/logic/fight/system/work/FightWorkAssistBossSkillChange.lua

module("modules.logic.fight.system.work.FightWorkAssistBossSkillChange", package.seeall)

local FightWorkAssistBossSkillChange = class("FightWorkAssistBossSkillChange", FightEffectBase)

function FightWorkAssistBossSkillChange:onStart()
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossPowerChange)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossCDChange)
	FightController.instance:dispatchEvent(FightEvent.OnSwitchAssistBossSkill)
	self:onDone(true)
end

return FightWorkAssistBossSkillChange
