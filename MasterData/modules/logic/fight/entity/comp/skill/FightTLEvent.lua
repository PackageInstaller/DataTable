-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEvent.lua

module("modules.logic.fight.entity.comp.skill.FightTLEvent", package.seeall)

local FightTLEvent = class("FightTLEvent")

function FightTLEvent:ctor()
	self.type = nil
	self.id = nil
end

function FightTLEvent:handleSkillEvent(fightStepData, duration, paramsArr)
	return
end

function FightTLEvent:handleSkillEventEnd()
	return
end

function FightTLEvent:onSkillEnd()
	return
end

function FightTLEvent:reset()
	return
end

function FightTLEvent:dispose()
	return
end

return FightTLEvent
