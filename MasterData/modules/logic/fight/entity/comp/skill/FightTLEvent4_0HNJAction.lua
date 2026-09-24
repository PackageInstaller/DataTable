-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEvent4_0HNJAction.lua

module("modules.logic.fight.entity.comp.skill.FightTLEvent4_0HNJAction", package.seeall)

local FightTLEvent4_0HNJAction = class("FightTLEvent4_0HNJAction", FightTimelineTrackItem)
local Action = {
	AddEffect = 2,
	Active = 3,
	RemoveStageEffect = 4,
	PlayAction = 1
}

function FightTLEvent4_0HNJAction:onTrackStart(fightStepData, duration, paramsArr)
	local action = tonumber(paramsArr[1])

	if action == Action.PlayAction then
		local actionName = paramsArr[2]

		FightController.instance:dispatchEvent(FightEvent.On4_0HNJPlayAction, self.id, actionName)
	elseif action == Action.AddEffect then
		local effectName = paramsArr[2]
		local hangPoint = paramsArr[3]

		FightController.instance:dispatchEvent(FightEvent.On4_0HNJAddEffect, self.id, effectName, hangPoint)
	elseif action == Action.Active then
		local active = FightTLHelper.getBoolParam(paramsArr[2])

		FightController.instance:dispatchEvent(FightEvent.On4_0HNJSetActive, self.id, active)
	elseif action == Action.RemoveStageEffect then
		FightController.instance:dispatchEvent(FightEvent.On4_0HNJRemoveStageEffect)
	end
end

return FightTLEvent4_0HNJAction
