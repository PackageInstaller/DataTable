-- chunkname: @modules/logic/fight/system/work/FightWorkPlayMonsterChangeTimeline.lua

module("modules.logic.fight.system.work.FightWorkPlayMonsterChangeTimeline", package.seeall)

local FightWorkPlayMonsterChangeTimeline = class("FightWorkPlayMonsterChangeTimeline", FightWorkItem)

function FightWorkPlayMonsterChangeTimeline:onConstructor(entity, timeline, stepData)
	self._entity = entity
	self._entityId = entity.id
	self._timeline = timeline
	self._stepData = stepData
end

function FightWorkPlayMonsterChangeTimeline:onStart(context)
	if self._entity.IS_REMOVED then
		self:onDone(true)
	else
		self:_playTimeline()
	end
end

function FightWorkPlayMonsterChangeTimeline:_playTimeline()
	if string.nilorempty(self._timeline) then
		self:onDone(true)

		return
	end

	if self._entity.skill and self._entity:__isActive() then
		self:com_registFightEvent(FightEvent.BeforeDestroyEntity, self._onBeforeDestroyEntity)

		local work = self._entity.skill:registTimelineWork(self._timeline, self._stepData)

		self:playWorkAndDone(work)
	else
		self:onDone(true)
	end
end

function FightWorkPlayMonsterChangeTimeline:_onBeforeDestroyEntity(entity)
	if entity == self._entity then
		self:onDone(true)
	end
end

function FightWorkPlayMonsterChangeTimeline:clearWork()
	return
end

return FightWorkPlayMonsterChangeTimeline
