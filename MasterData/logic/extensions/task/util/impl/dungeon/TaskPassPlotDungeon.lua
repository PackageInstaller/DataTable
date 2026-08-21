-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/dungeon/TaskPassPlotDungeon.lua

module("logic.extensions.task.util.impl.dungeon.TaskPassPlotDungeon", package.seeall)

local M = class("TaskPassPlotDungeon", TaskPassDungeon)

function M:parseContent(code, desc, param)
	local tempStr, maxCount = M.super.parseContent(self, code, desc, param)

	return tempStr, maxCount
end

return M
