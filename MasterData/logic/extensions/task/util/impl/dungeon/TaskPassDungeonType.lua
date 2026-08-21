-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/dungeon/TaskPassDungeonType.lua

module("logic.extensions.task.util.impl.dungeon.TaskPassDungeonType", package.seeall)

local M = class("TaskPassDungeonType")

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

	local type = tonumber(paramArray[2])

	tempStr = string.gsub(tempStr, "#1#", maxCount)

	if string.nilorempty(DungeonConfig.instance:getDungeonTypeName(type)) then
		printError("Dungeon Type can not find:", code, "type:", type)
	end

	tempStr = string.gsub(tempStr, "#2#", DungeonConfig.instance:getDungeonTypeName(type) or "nil")

	return tempStr, maxCount
end

return M
