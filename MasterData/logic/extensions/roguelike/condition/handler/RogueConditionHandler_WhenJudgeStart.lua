-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/condition/handler/RogueConditionHandler_WhenJudgeStart.lua

module("logic.extensions.roguelike.condition.handler.RogueConditionHandler_WhenJudgeStart", package.seeall)

local M = class("RogueConditionHandler_WhenJudgeStart", RogueBaseBuffHandler)

function M:ctor()
	return
end

function M:onTrigger(conditioinMO)
	local params = conditioinMO:getParams()
	local type = tonumber(params)
	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()

	if type == 0 then
		return true
	elseif type == 1 then
		return eventType == RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT
	elseif type == 2 then
		return eventType >= RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT and eventType <= RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT
	end

	return false
end

return M
