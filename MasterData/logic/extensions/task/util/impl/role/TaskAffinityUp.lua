-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/role/TaskAffinityUp.lua

module("logic.extensions.task.util.impl.role.TaskAffinityUp", package.seeall)

local M = class("TaskAffinityUp")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1

	maxCount = tonumber(param)
	tempStr = string.gsub(tempStr, "#1#", maxCount)

	return tempStr, maxCount
end

return M
