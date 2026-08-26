-- chunkname: @modules/logic/fight/system/work/FightWorkSkillSwitchSpine.lua

module("modules.logic.fight.system.work.FightWorkSkillSwitchSpine", package.seeall)

local FightWorkSkillSwitchSpine = class("FightWorkSkillSwitchSpine", BaseWork)

function FightWorkSkillSwitchSpine:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkSkillSwitchSpine:onStart()
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
		TaskDispatcher.cancelTask(self._delayDone, self)
		TaskDispatcher.runDelay(self._delayDone, self, 10)

		self._flow = FlowSequence.New()

		local skinId = FightHelper.processSkinByStepData(self.fightStepData)
		local skinConfig = FightConfig.instance:getSkinCO(skinId)

		if skinConfig then
			::label_2_0::

			local var_2_0 = entity.spine

			if entity.spine then
				local url = entity.spine:getSpineUrl(skinConfig)

				if string.nilorempty(url) then
					logError("释放支援角色技能,但是找不到替换spine的url, heroId:" .. entityMO.modelId)
					self:onDone(true)

					return
				end

				if entity.spine and entity.spine.releaseSpecialSpine then
					entity.spine:releaseSpecialSpine()

					entity.spine.LOCK_SPECIALSPINE = true
				end

				self.context.Custom_OriginSkin = entityMO.skin
				entityMO.skin = skinId

				self._flow:addWork(FightWorkChangeEntitySpine.New(entity, url))
				self._flow:registerDoneListener(self._onFlowDone, self)
				self._flow:start()

				return
			end
		end
	end

	self:onDone(true)
end

function FightWorkSkillSwitchSpine:_onFlowDone()
	self:onDone(true)
end

function FightWorkSkillSwitchSpine:_delayDone()
	self:onDone(true)
end

function FightWorkSkillSwitchSpine:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)

	if self._flow then
		self._flow:unregisterDoneListener(self._onFlowDone, self)
		self._flow:stop()

		self._flow = nil
	end
end

return FightWorkSkillSwitchSpine
