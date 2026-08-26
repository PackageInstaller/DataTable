-- chunkname: @modules/logic/fight/system/work/FightWorkSkillSwitchSpineByServerSkinEnd.lua

module("modules.logic.fight.system.work.FightWorkSkillSwitchSpineByServerSkinEnd", package.seeall)

local FightWorkSkillSwitchSpineByServerSkinEnd = class("FightWorkSkillSwitchSpineByServerSkinEnd", BaseWork)

function FightWorkSkillSwitchSpineByServerSkinEnd:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkSkillSwitchSpineByServerSkinEnd:onStart()
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

function FightWorkSkillSwitchSpineByServerSkinEnd:_onFlowDone()
	self:onDone(true)
end

function FightWorkSkillSwitchSpineByServerSkinEnd:_delayDone()
	self:onDone(true)
end

function FightWorkSkillSwitchSpineByServerSkinEnd:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)

	if self._flow then
		self._flow:unregisterDoneListener(self._onFlowDone, self)
		self._flow:stop()

		self._flow = nil
	end
end

return FightWorkSkillSwitchSpineByServerSkinEnd
