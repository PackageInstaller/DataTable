-- chunkname: @modules/logic/fight/system/work/FightGuideBeforeSkill.lua

module("modules.logic.fight.system.work.FightGuideBeforeSkill", package.seeall)

local FightGuideBeforeSkill = class("FightGuideBeforeSkill", BaseWork)

function FightGuideBeforeSkill:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightGuideBeforeSkill:onStart(context)
	if self.fightStepData.fromId == FightEntityScene.MySideId or self.fightStepData.fromId == FightEntityScene.EnemySideId then
		self:_done()

		return
	end

	self._attacker = FightHelper.getEntity(self.fightStepData.fromId)
	self._skillId = self.fightStepData.actId

	if self._attacker == nil then
		self:_done()

		return
	end

	local result = FightController.instance:GuideFlowPauseAndContinue("OnGuideBeforeSkillPause", FightEvent.OnGuideBeforeSkillPause, FightEvent.OnGuideBeforeSkillContinue, self._done, self, self._attacker:getMO().modelId, self._skillId)
end

function FightGuideBeforeSkill:_done()
	self:onDone(true)
end

return FightGuideBeforeSkill
