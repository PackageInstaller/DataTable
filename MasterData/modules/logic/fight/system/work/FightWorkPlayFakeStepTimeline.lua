-- chunkname: @modules/logic/fight/system/work/FightWorkPlayFakeStepTimeline.lua

module("modules.logic.fight.system.work.FightWorkPlayFakeStepTimeline", package.seeall)

local FightWorkPlayFakeStepTimeline = class("FightWorkPlayFakeStepTimeline", FightWorkItem)

function FightWorkPlayFakeStepTimeline:onConstructor(timelineName, fightStepData)
	self.timelineName = timelineName
	self.fightStepData = fightStepData
	self.SAFETIME = 30
end

function FightWorkPlayFakeStepTimeline:onStart()
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, LuaEventSystem.Low)

	local entity = FightHelper.getEntity(self.fightStepData.fromId)

	if not entity then
		self:onDone(true)

		return
	end

	entity.skill:playTimeline(self.timelineName, self.fightStepData)
end

function FightWorkPlayFakeStepTimeline:_onSkillPlayFinish(entity, curSkillId, fightStepData)
	if fightStepData == self.fightStepData then
		self:onDone(true)
	end
end

return FightWorkPlayFakeStepTimeline
