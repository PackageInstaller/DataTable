-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/dungeon/TaskAdditionalTerrainAdd.lua

module("logic.extensions.task.util.impl.dungeon.TaskAdditionalTerrainAdd", package.seeall)

local M = class("TaskAdditionalTerrainAdd")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local paramArray = string.split(param, "#")
	local maxCount = tonumber(paramArray[1])

	tempStr = string.gsub(tempStr, "#1#", maxCount)

	return tempStr, maxCount
end

return M
