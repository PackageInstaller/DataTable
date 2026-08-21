-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/house/TaskContainmentUp.lua

module("logic.extensions.task.util.impl.house.TaskContainmentUp", package.seeall)

local M = class("TaskContainmentUp")

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

	local id = tonumber(paramArray[2])

	tempStr = string.gsub(tempStr, "#1#", maxCount)

	local itemCo = BackpackConfig.instance:getItemInfoByItemId(id)

	if itemCo then
		tempStr = string.gsub(tempStr, "#2#", itemCo.name)
	end

	return tempStr, maxCount
end

return M
