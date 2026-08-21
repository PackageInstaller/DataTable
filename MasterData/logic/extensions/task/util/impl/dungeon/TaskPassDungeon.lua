-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/dungeon/TaskPassDungeon.lua

module("logic.extensions.task.util.impl.dungeon.TaskPassDungeon", package.seeall)

local M = class("TaskPassDungeon")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local dungeonId = tonumber(param)

	if not dungeonId then
		if enableErrorLog then
			printError("Invalid parameter with code:", code)
		end

		return tempStr, maxCount
	end

	maxCount = 1

	local dungeonName

	if dungeonId == TaskEnum.Const.Any then
		dungeonName = lang("common_any")
	else
		dungeonName = TaskUtil.getDungeonFormatName(dungeonId)
	end

	if not string.nilorempty(dungeonName) then
		tempStr = string.gsub(tempStr, "#1#", dungeonName)
	end

	return tempStr, maxCount
end

return M
