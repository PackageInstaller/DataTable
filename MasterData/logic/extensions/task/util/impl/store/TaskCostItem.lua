-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/store/TaskCostItem.lua

module("logic.extensions.task.util.impl.store.TaskCostItem", package.seeall)

local M = class("TaskCostItem")

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

	local itemId = paramArray[2]
	local itemCO = BackpackConfig.instance:getItemInfoByItemId(tonumber(itemId))

	if itemCO then
		tempStr = string.gsub(tempStr, "#1#", maxCount)
		tempStr = string.gsub(tempStr, "#2#", itemCO.name)
	end

	return tempStr, maxCount, true
end

return M
