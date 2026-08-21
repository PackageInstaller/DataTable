-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/bag/TaskGetItemByOption.lua

module("logic.extensions.task.util.impl.bag.TaskGetItemByOption", package.seeall)

local M = class("TaskGetItemByOption")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local paramArray = string.split(param, "#")

	if paramArray and #paramArray ~= 3 then
		if enableErrorLog then
			printError("Invalid parameter length with code:", code)
		end

		return tempStr, maxCount
	end

	maxCount = tonumber(paramArray[1])

	local itemId = tonumber(paramArray[2])
	local optionType = tonumber(paramArray[3])
	local optionName = lang(string.format("tip_optiontype_%s", optionType))
	local itemCO = BackpackConfig.instance:getItemInfoByItemId(itemId)
	local itemName = itemCO and itemCO.name or ""

	tempStr = string.gsub(desc, "#1#", maxCount)
	tempStr = string.gsub(tempStr, "#2#", itemName)
	tempStr = string.gsub(tempStr, "#3#", optionName)

	return tempStr, maxCount
end

return M
