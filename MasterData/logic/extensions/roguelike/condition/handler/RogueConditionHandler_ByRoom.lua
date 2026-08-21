-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/condition/handler/RogueConditionHandler_ByRoom.lua

module("logic.extensions.roguelike.condition.handler.RogueConditionHandler_ByRoom", package.seeall)

local M = class("RogueConditionHandler_ByRoom", RogueBaseBuffHandler)

function M:ctor()
	return
end

function M:onTrigger(conditioinMO)
	local params = conditioinMO:getParams()
	local temp = string.split(params, "#")
	local compare = temp[2]
	local compareCount = tonumber(temp[3])
	local roomCount = RoguelikeModel.instance:getVisibleRoomCount()

	if compare == "GE" and compareCount <= roomCount then
		return true
	elseif compare == "LE" and roomCount <= compareCount then
		return true
	end

	return false
end

return M
