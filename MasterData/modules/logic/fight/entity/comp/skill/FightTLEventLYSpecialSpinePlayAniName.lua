-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventLYSpecialSpinePlayAniName.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventLYSpecialSpinePlayAniName", package.seeall)

local FightTLEventLYSpecialSpinePlayAniName = class("FightTLEventLYSpecialSpinePlayAniName", FightTimelineTrackItem)

function FightTLEventLYSpecialSpinePlayAniName:onTrackStart(fightStepData, duration, paramsArr)
	local animName = paramsArr[1]

	FightController.instance:dispatchEvent(FightEvent.TimelineLYSpecialSpinePlayAniName, animName)
end

function FightTLEventLYSpecialSpinePlayAniName:onTrackEnd()
	return
end

function FightTLEventLYSpecialSpinePlayAniName:onDestructor()
	return
end

return FightTLEventLYSpecialSpinePlayAniName
