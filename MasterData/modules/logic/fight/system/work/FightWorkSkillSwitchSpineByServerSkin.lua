-- chunkname: @modules/logic/fight/system/work/FightWorkSkillSwitchSpineByServerSkin.lua

module("modules.logic.fight.system.work.FightWorkSkillSwitchSpineByServerSkin", package.seeall)

local FightWorkSkillSwitchSpineByServerSkin = class("FightWorkSkillSwitchSpineByServerSkin", BaseWork)

function FightWorkSkillSwitchSpineByServerSkin:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkSkillSwitchSpineByServerSkin:onStart()
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

	local realSkinId = self.fightStepData.realSkinId

	if realSkinId ~= 0 then
		TaskDispatcher.cancelTask(self._delayDone, self)
		TaskDispatcher.runDelay(self._delayDone, self, 10)

		self._flow = FlowSequence.New()

		local skinConfig

		if self.fightStepData.realSkillType == 1 then
			skinConfig = lua_skin.configDict[realSkinId]
		elseif self.fightStepData.realSkillType == 2 then
			skinConfig = lua_monster_skin.configDict[realSkinId]
		end

		if not skinConfig then
			self:onDone(true)

			return
		end

		if skinConfig then
			::label_2_0::

			local var_2_0 = entity.spine

			if entity.spine then
				local url = entity.spine:getSpineUrl(skinConfig)

				if string.nilorempty(url) then
					self:onDone(true)

					return
				end

				if entity.spine and entity.spine.releaseSpecialSpine then
					entity.spine:releaseSpecialSpine()

					entity.spine.LOCK_SPECIALSPINE = true
				end

				self.context.Custom_OriginSkin = entityMO.skin
				entityMO.skin = realSkinId

				self._flow:addWork(FightWorkChangeEntitySpine.New(entity, url))
				self._flow:registerDoneListener(self._onFlowDone, self)
				self._flow:start()

				return
			end
		end
	end

	self:onDone(true)
end

function FightWorkSkillSwitchSpineByServerSkin:_onFlowDone()
	self:onDone(true)
end

function FightWorkSkillSwitchSpineByServerSkin:_delayDone()
	self:onDone(true)
end

function FightWorkSkillSwitchSpineByServerSkin:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)

	if self._flow then
		self._flow:unregisterDoneListener(self._onFlowDone, self)
		self._flow:stop()

		self._flow = nil
	end
end

return FightWorkSkillSwitchSpineByServerSkin
