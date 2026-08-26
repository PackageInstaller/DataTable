-- chunkname: @modules/logic/fight/view/preview/FightSkillEditorFlow.lua

module("modules.logic.fight.view.preview.FightSkillEditorFlow", package.seeall)

local FightSkillEditorFlow = class("FightSkillEditorFlow", BaseFlow)

function FightSkillEditorFlow:ctor(fightStepData)
	self.fightStepData = fightStepData
	self._skillReleaseFlow = FlowParallel.New()

	self._skillReleaseFlow:addWork(FunctionWork.New(self._playSkill, self))

	local effectHealWork

	for _, actEffectData in ipairs(fightStepData.actEffect) do
		local isHealEffect = actEffectData.effectType == FightEnum.EffectType.HEAL or actEffectData.effectType == FightEnum.EffectType.HEALCRIT

		if isHealEffect and actEffectData.effectNum > 0 then
			if not effectHealWork then
				effectHealWork = FightWorkSkillFinallyHeal.New(fightStepData)

				self._skillReleaseFlow:addWork(effectHealWork)
			end

			effectHealWork:addActEffectData(actEffectData)
		end
	end
end

function FightSkillEditorFlow:_playSkill()
	self._attacker = FightHelper.getEntity(self.fightStepData.fromId)
	self._skillId = self.fightStepData.actId

	local mo = self._attacker:getMO()
	local skinId = mo and mo.skin
	local timeline = FightConfig.instance:getSkinSkillTimeline(skinId, self._skillId)

	if string.nilorempty(timeline) then
		self:onDone(true)

		return
	end

	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillEnd, self)

	if FightSkillMgr.instance:isEntityPlayingTimeline(self._attacker.id) then
		TaskDispatcher.runRepeat(self._checkNoSkillPlaying, self, 0.01)
	else
		self._attacker.skill:playSkill(self._skillId, self.fightStepData)
	end
end

function FightSkillEditorFlow:_checkNoSkillPlaying()
	if not FightSkillMgr.instance:isEntityPlayingTimeline(self._attacker.id) then
		TaskDispatcher.cancelTask(self._checkNoSkillPlaying, self)
		self._attacker.skill:playSkill(self._skillId, self.fightStepData)
	end
end

function FightSkillEditorFlow:_onSkillEnd()
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillEnd, self)
	self:onDone(true)
end

function FightSkillEditorFlow:onStart()
	self._skillReleaseFlow:start()
end

function FightSkillEditorFlow:clearWork()
	return
end

function FightSkillEditorFlow:onDestroy()
	if self._skillReleaseFlow then
		self._skillReleaseFlow:stop()

		self._skillReleaseFlow = nil
	end

	FightSkillEditorFlow.super.onDestroy(self)
end

function FightSkillEditorFlow:stopSkillFlow()
	if self._skillReleaseFlow and self._skillReleaseFlow.status == WorkStatus.Running then
		local workList = self._skillReleaseFlow:getWorkList()
		local curWorkIdx = self._skillReleaseFlow._curIndex

		for i = curWorkIdx, #workList do
			local work = workList[i]

			work:onDone(true)
		end

		self._skillReleaseFlow:stop()

		self._skillReleaseFlow = nil
	end
end

return FightSkillEditorFlow
