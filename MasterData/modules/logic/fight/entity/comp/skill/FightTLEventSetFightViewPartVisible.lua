-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventSetFightViewPartVisible.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventSetFightViewPartVisible", package.seeall)

local FightTLEventSetFightViewPartVisible = class("FightTLEventSetFightViewPartVisible", FightTimelineTrackItem)

function FightTLEventSetFightViewPartVisible:onTrackStart(fightStepData, duration, paramsArr)
	local showWaitArea = FightTLHelper.getBoolParam(paramsArr[1])

	FightViewPartVisible.setWaitAreaActive(showWaitArea)
end

function FightTLEventSetFightViewPartVisible:onTrackEnd()
	return
end

function FightTLEventSetFightViewPartVisible:onDestructor()
	return
end

return FightTLEventSetFightViewPartVisible
