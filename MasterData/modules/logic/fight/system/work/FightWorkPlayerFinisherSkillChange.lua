-- chunkname: @modules/logic/fight/system/work/FightWorkPlayerFinisherSkillChange.lua

module("modules.logic.fight.system.work.FightWorkPlayerFinisherSkillChange", package.seeall)

local FightWorkPlayerFinisherSkillChange = class("FightWorkPlayerFinisherSkillChange", FightEffectBase)

function FightWorkPlayerFinisherSkillChange:onStart()
	self:com_sendMsg(FightMsgId.RefreshPlayerFinisherSkill)
	self:onDone(true)
end

return FightWorkPlayerFinisherSkillChange
