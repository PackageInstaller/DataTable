-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventSameSkillJump.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventSameSkillJump", package.seeall)

local FightTLEventSameSkillJump = class("FightTLEventSameSkillJump", FightTimelineTrackItem)

function FightTLEventSameSkillJump:onTrackStart(fightStepData, duration, paramsArr)
	if not FightModel.instance:canParallelSkill(fightStepData) then
		return
	end

	if not string.nilorempty(paramsArr[1]) then
		CameraMgr.instance:getCameraRootAnimator().enabled = true

		FightController.instance:registerCallback(FightEvent.BeforePlaySameSkill, self._onBeforePlaySameSkill, self)

		self.fightStepData = fightStepData
		self._paramsArr = paramsArr

		FightController.instance:dispatchEvent(FightEvent.CheckPlaySameSkill, fightStepData)
	end
end

function FightTLEventSameSkillJump:_onBeforePlaySameSkill(stepData, nextStepData)
	if not string.nilorempty(self._paramsArr[1]) and not self._done then
		self._jump_type = tonumber(self._paramsArr[1]) or 0
		self.audioId = self.fightStepData.atkAudioId
		self._done = true
		self._animComp = CameraMgr.instance:getCameraRootAnimator()
		self._animComp.enabled = false
		self._attacker = FightHelper.getEntity(self.fightStepData.fromId)

		AudioEffectMgr.instance:stopAudio(self.audioId, 0)

		self.curAnimState = self._attacker.spine.curAnimState

		if self._attacker.spine:hasAnimation(SpineAnimState.posture) then
			self._attacker.spine:play(SpineAnimState.posture, true)
		end

		if not string.nilorempty(self._paramsArr[2]) then
			local arr = string.splitToNumber(self._paramsArr[2], "#")

			for i, v in ipairs(arr) do
				self.fightStepData.cusParam_lockTimelineTypes = self.fightStepData.cusParam_lockTimelineTypes or {}
				self.fightStepData.cusParam_lockTimelineTypes[v] = true
			end
		end

		if self._paramsArr[3] == "1" then
			self.fightStepData.cus_Param_invokeSpineActTimelineEnd = true
		end

		if not string.nilorempty(self._paramsArr[4]) then
			self._attacker.skill:recordFilterAtkEffect(self._paramsArr[4], nextStepData)
		end

		if not string.nilorempty(self._paramsArr[5]) then
			self._attacker.skill:recordFilterFlyEffect(self._paramsArr[5], nextStepData)
		end

		self._attacker.skill:stopCurTimelineWaitPlaySameSkill(self._jump_type, self.curAnimState, self.audioId, stepData, nextStepData)
	end
end

function FightTLEventSameSkillJump:onDestructor()
	self._done = nil
	self._animComp = nil

	FightController.instance:unregisterCallback(FightEvent.BeforePlaySameSkill, self._onBeforePlaySameSkill, self)
end

return FightTLEventSameSkillJump
