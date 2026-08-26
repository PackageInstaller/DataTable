-- chunkname: @modules/logic/fight/entity/comp/skill/FightTimelineTrackItem.lua

module("modules.logic.fight.entity.comp.skill.FightTimelineTrackItem", package.seeall)

local FightTimelineTrackItem = class("FightTimelineTrackItem", FightBaseClass)

function FightTimelineTrackItem:onConstructor(id, type, binder, timelineItem)
	self.id = id
	self.type = type
	self.binder = binder
	self.timelineItem = timelineItem
	self.workTimelineItem = timelineItem.workTimelineItem
end

function FightTimelineTrackItem:onTrackStart(fightStepData, duration, paramsArr)
	return
end

function FightTimelineTrackItem:onTrackEnd()
	return
end

function FightTimelineTrackItem:addWork2TimelineFinishWork(work)
	self.timelineItem:addWork2FinishWork(work)
end

function FightTimelineTrackItem:onDestructor()
	return
end

return FightTimelineTrackItem
