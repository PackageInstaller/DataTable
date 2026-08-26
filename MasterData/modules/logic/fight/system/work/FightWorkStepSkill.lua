-- chunkname: @modules/logic/fight/system/work/FightWorkStepSkill.lua

module("modules.logic.fight.system.work.FightWorkStepSkill", package.seeall)

local FightWorkStepSkill = class("FightWorkStepSkill", BaseWork)
local idCounter = 1
local SkillInterval = 0.01
local lastSkillEndTime = 0

function FightWorkStepSkill:ctor(fightStepData)
	self.fightStepData = fightStepData
	self._id = idCounter
	idCounter = idCounter + 1
end

function FightWorkStepSkill:onStart()
	FightController.instance:registerCallback(FightEvent.ForceEndSkillStep, self._forceEndSkillStep, self)

	self._attacker = FightHelper.getEntity(self.fightStepData.fromId)

	TaskDispatcher.runDelay(self._delayDone, self, 20)

	if not self._attacker then
		self:onDone(true)

		return
	end

	self._skillId = self.fightStepData.actId

	local mo = self._attacker:getMO()
	local skinId = mo and mo.skin
	local timeline = FightConfig.instance:getSkinSkillTimeline(skinId, self._skillId)

	if string.nilorempty(timeline) then
		self:onDone(true)

		return
	end

	FightController.instance:registerCallback(FightEvent.BeforeDestroyEntity, self._onBeforeDestroyEntity, self)
	self:_canPlaySkill()
end

function FightWorkStepSkill:_canPlaySkill()
	FightWorkStepSkill.needWaitBeforeSkill = nil

	FightController.instance:dispatchEvent(FightEvent.BeforeSkillDialog, self._skillId)

	if FightWorkStepSkill.needWaitBeforeSkill then
		TaskDispatcher.cancelTask(self._delayDone, self)
		FightController.instance:registerCallback(FightEvent.DialogContinueSkill, self._canPlaySkill2, self)
	else
		self:_canPlaySkill2()
	end
end

function FightWorkStepSkill:_canPlaySkill2()
	TaskDispatcher.cancelTask(self._delayDone, self)
	TaskDispatcher.runDelay(self._delayDone, self, 20)
	FightController.instance:unregisterCallback(FightEvent.DialogContinueSkill, self._canPlaySkill2, self)

	local version = FightModel.instance:getVersion()

	if version >= 1 then
		if FightHelper.isPlayerCardSkill(self.fightStepData) then
			if self.fightStepData.cardIndex - 1 > FightPlayCardModel.instance:getCurIndex() then
				FightController.instance:dispatchEvent(FightEvent.InvalidPreUsedCard, self.fightStepData.cardIndex)
				TaskDispatcher.runDelay(self._delayAfterDissolveCard, self, 1 / FightModel.instance:getUISpeed())

				return
			end

			FightController.instance:dispatchEvent(FightEvent.BeforePlaySkill, self._attacker, self._skillId, self.fightStepData)
		end

		self:_playSkill(self._skillId)
	else
		local notEditor = not self.fightStepData.editorPlaySkill
		local isMySideSkill = self._attacker:isMySide() and FightCardDataHelper.isActiveSkill(self.fightStepData.fromId, self._skillId)
		local leftSkillOpList = FightPlayCardModel.instance:getClientLeftSkillOpList()
		local curShowingOp = leftSkillOpList and leftSkillOpList[#leftSkillOpList]
		local isPlayCardSkill = curShowingOp and self._skillId == curShowingOp.skillId

		if notEditor and (isMySideSkill or isPlayCardSkill) then
			local skillDelay = lastSkillEndTime + SkillInterval - Time.realtimeSinceStartup

			if skillDelay > 0 then
				TaskDispatcher.runDelay(self._toPlaySkill, self, skillDelay)
			else
				self:_toPlaySkill()
			end
		else
			self:_playSkill(self._skillId)
		end
	end
end

function FightWorkStepSkill:_delayAfterDissolveCard()
	FightController.instance:dispatchEvent(FightEvent.BeforePlaySkill, self._attacker, self._skillId, self.fightStepData)
	self:_playSkill(self._skillId)
end

function FightWorkStepSkill:_delayPlaySkill()
	self:_playSkill(self._skillId)
end

function FightWorkStepSkill:_toPlaySkill()
	FightController.instance:registerCallback(FightEvent.ToPlaySkill, self._playSkill, self)
	FightController.instance:dispatchEvent(FightEvent.BeforePlaySkill, self._attacker, self._skillId, self.fightStepData)
end

function FightWorkStepSkill:_playSkill(skillId)
	if skillId ~= self.fightStepData.actId then
		self:onDone(true)

		return
	end

	if self.fightStepData.fromId == "0" or self._attacker then
		FightController.instance:unregisterCallback(FightEvent.ToPlaySkill, self._playSkill, self)

		local work = self._attacker.skill:registPlaySkillWork(self._skillId, self.fightStepData)

		if work then
			work:registFinishCallback(self.onWorkTimelineFinish, self)
			TaskDispatcher.cancelTask(self._delayDone, self)

			if FightScene.ios3GBMemory and (FightDataHelper.fieldMgr:isRouge2() or FightDataHelper.fieldMgr.episodeId == SurvivalConst.Shelter_EpisodeId or FightDataHelper.fieldMgr.episodeId == SurvivalConst.Survival_EpisodeId) and (work.timelineName == "ndk_312002_unique_1" or work.timelineName == "ndk_312002_unique_1ex") then
				FightHelper.clearNoUseEffect()
			end

			work:start()
		else
			self:onDone(true)
		end
	else
		logError("attacker entity not exist, can't play skill " .. self._skillId)
		self:onDone(true)
	end
end

function FightWorkStepSkill:onWorkTimelineFinish()
	if self.status ~= WorkStatus.Done then
		self:_removeEvents()

		lastSkillEndTime = Time.realtimeSinceStartup
		FightWorkStepSkill.needStopSkillEnd = nil

		FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.HPRateAfterSkillNP)
		FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.HPRateAfterSkillP)

		if FightWorkStepSkill.needStopSkillEnd then
			TaskDispatcher.cancelTask(self._delayDone, self)
			FightController.instance:registerCallback(FightEvent.FightDialogEnd, self._onFightDialogEnd, self)
		else
			local version = FightModel.instance:getVersion()

			if version >= 1 then
				if FightHelper.isPlayerCardSkill(self.fightStepData) then
					TaskDispatcher.runDelay(self._delayAfterSkillEnd, self, 0.3 / FightModel.instance:getUISpeed())
				else
					self:onDone(true)
				end
			else
				self:onDone(true)
			end
		end
	end
end

function FightWorkStepSkill:_delayAfterSkillEnd()
	self:onDone(true)
end

function FightWorkStepSkill:_onFightDialogEnd()
	self:onDone(true)
end

function FightWorkStepSkill:_forceEndSkillStep(step)
	if step == self.fightStepData then
		self:_removeEvents()
		self:onDone(true)
	end
end

function FightWorkStepSkill:_delayDone()
	logError("skill play timeout, skillId = " .. self._skillId)
	self:_removeEvents()
	FightController.instance:dispatchEvent(FightEvent.FightWorkStepSkillTimeout, self.fightStepData)
end

function FightWorkStepSkill:_removeEvents()
	TaskDispatcher.cancelTask(self._delayAfterDissolveCard, self)
	TaskDispatcher.cancelTask(self._delayPlaySkill, self)
	TaskDispatcher.cancelTask(self._delayAfterSkillEnd, self)
	TaskDispatcher.cancelTask(self._delayDone, self)
	TaskDispatcher.cancelTask(self._toPlaySkill, self)
	FightController.instance:unregisterCallback(FightEvent.ToPlaySkill, self._playSkill, self)
	FightController.instance:unregisterCallback(FightEvent.ForceEndSkillStep, self._forceEndSkillStep, self)
	FightController.instance:unregisterCallback(FightEvent.DialogContinueSkill, self._canPlaySkill2, self)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, self._onFightDialogEnd, self)
	FightController.instance:unregisterCallback(FightEvent.BeforeDestroyEntity, self._onBeforeDestroyEntity, self)
end

function FightWorkStepSkill:_onBeforeDestroyEntity(unit)
	if self._attacker and self._attacker.id == unit.id then
		self:onDone(true)
	end
end

function FightWorkStepSkill:onStop()
	FightWorkStepSkill.super.onStop(self)

	if self._attacker and self._attacker.skill then
		self._attacker.skill:stopSkill()
	end
end

function FightWorkStepSkill:onResume()
	logError("skill step can't resume")
end

function FightWorkStepSkill:clearWork()
	self:_removeEvents()
end

return FightWorkStepSkill
