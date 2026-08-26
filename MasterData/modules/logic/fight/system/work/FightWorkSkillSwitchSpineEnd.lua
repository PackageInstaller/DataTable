-- chunkname: @modules/logic/fight/system/work/FightWorkSkillSwitchSpineEnd.lua

module("modules.logic.fight.system.work.FightWorkSkillSwitchSpineEnd", package.seeall)

local FightWorkSkillSwitchSpineEnd = class("FightWorkSkillSwitchSpineEnd", BaseWork)

function FightWorkSkillSwitchSpineEnd:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkSkillSwitchSpineEnd:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 0.5)

	local entity = FightHelper.getEntity(self.fightStepData.fromId)
	local entityMO = entity and entity:getMO()

	if not entityMO then
		self:onDone(true)

		return
	end

	if FightEntityDataHelper.isPlayerUid(entityMO.id) then
		self:onDone(true)

		return
	end

	local modelId = self.fightStepData.supportHeroId

	if not modelId then
		self:onDone(true)

		return
	end

	if modelId ~= 0 and modelId ~= entityMO.modelId then
		if self.context.Custom_OriginSkin then
			entityMO.skin = self.context.Custom_OriginSkin

			if entity.spine and entity.spine.releaseSpecialSpine then
				entity.spine.LOCK_SPECIALSPINE = false
			end
		end

		TaskDispatcher.cancelTask(self._delayDone, self)
		TaskDispatcher.runDelay(self._delayDone, self, 10)

		self._flow = FlowSequence.New()

		self._flow:addWork(FightWorkChangeEntitySpine.New(entity))
		self._flow:registerDoneListener(self._onFlowDone, self)
		self._flow:start()

		return
	end

	self:onDone(true)
end

function FightWorkSkillSwitchSpineEnd:_onFlowDone()
	self:onDone(true)
end

function FightWorkSkillSwitchSpineEnd:_delayDone()
	self:onDone(true)
end

function FightWorkSkillSwitchSpineEnd:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)

	if self._flow then
		self._flow:unregisterDoneListener(self._onFlowDone, self)
		self._flow:stop()

		self._flow = nil
	end
end

return FightWorkSkillSwitchSpineEnd
