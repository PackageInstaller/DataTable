-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/roguelike/TaskRoguelikeGetProps.lua

module("logic.extensions.task.util.impl.roguelike.TaskRoguelikeGetProps", package.seeall)

local M = class("TaskRoguelikeGetProps")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local propsId = tonumber(param)

	if not propsId then
		if enableErrorLog then
			printError("Invalid parameter with code:", code)
		end

		return tempStr, maxCount
	end

	local name = false
	local propCo = RoguelikeConfig.instance:getPropById(propsId)

	if propCo then
		name = propCo.name
	end

	tempStr = string.gsub(tempStr, "#1#", name)

	return tempStr, maxCount
end

return M
