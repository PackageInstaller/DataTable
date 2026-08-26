-- chunkname: @modules/logic/fight/system/work/FightWorkPlayTimeline.lua

module("modules.logic.fight.system.work.FightWorkPlayTimeline", package.seeall)

local FightWorkPlayTimeline = class("FightWorkPlayTimeline", FightWorkItem)

function FightWorkPlayTimeline:onConstructor(entity, timeline, toId)
	self._entity = entity
	self._entityId = entity.id
	self._timeline = timeline
	self._toId = toId
end

function FightWorkPlayTimeline:onStart(context)
	if self._entity.IS_REMOVED then
		self:onDone(true)
	else
		self:_playTimeline()
	end
end

function FightWorkPlayTimeline:_playTimeline()
	if string.nilorempty(self._timeline) then
		self:onDone(true)

		return
	end

	if self._entity.skill and self._entity:__isActive() then
		local var_3_0 = {
			actId = 0,
			actEffect = {
				{
					targetId = self._entityId
				}
			},
			fromId = self._entityId
		}

		var_3_0.toId = self._toId or self._entityId
		var_3_0.actType = FightEnum.ActType.SKILL
		var_3_0.stepUid = FightTLEventEntityVisible.latestStepUid or 0

		local temp_data = var_3_0

		self:com_registFightEvent(FightEvent.BeforeDestroyEntity, self._onBeforeDestroyEntity)

		local work = self._entity.skill:registTimelineWork(self._timeline, temp_data)

		self:playWorkAndDone(work)
	else
		self:onDone(true)
	end
end

function FightWorkPlayTimeline:_onBeforeDestroyEntity(entity)
	if entity == self._entity then
		self:onDone(true)
	end
end

function FightWorkPlayTimeline:clearWork()
	return
end

return FightWorkPlayTimeline
