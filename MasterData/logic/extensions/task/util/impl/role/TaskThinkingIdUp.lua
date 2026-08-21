-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/role/TaskThinkingIdUp.lua

module("logic.extensions.task.util.impl.role.TaskThinkingIdUp", package.seeall)

local M = class("TaskThinkingIdUp")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local paramArray = string.split(param, "#")

	if paramArray and #paramArray ~= 2 then
		if enableErrorLog then
			printError("Invalid parameter length with code:", code)
		end

		return tempStr, maxCount
	end

	maxCount = tonumber(paramArray[1])

	local thinkingId = tonumber(paramArray[2])
	local itemName = false
	local thinkingCO = ThinkingConfig.instance:getThinkingCO(thinkingId)

	if thinkingCO then
		itemName = thinkingCO.name
	end

	tempStr = string.gsub(tempStr, "#1#", maxCount)
	tempStr = string.gsub(tempStr, "#2#", itemName)

	return tempStr, maxCount
end

return M
