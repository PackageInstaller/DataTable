-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/house/TaskBuildFurniture.lua

module("logic.extensions.task.util.impl.house.TaskBuildFurniture", package.seeall)

local M = class("TaskBuildFurniture")

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

	local furnitureId = tonumber(paramArray[2])
	local furnitureName = lang("common_any")

	tempStr = string.gsub(tempStr, "#1#", maxCount)

	if furnitureId == 0 then
		tempStr = string.gsub(tempStr, "#2#", furnitureName)
	else
		local itemCo = BackpackConfig.instance:getItemInfoByItemId(furnitureId)

		if itemCo then
			tempStr = string.gsub(tempStr, "#2#", itemCo.name)
		end
	end

	return tempStr, maxCount
end

return M
