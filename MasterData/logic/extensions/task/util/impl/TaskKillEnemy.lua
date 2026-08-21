-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/TaskKillEnemy.lua

module("logic.extensions.task.util.impl.TaskKillEnemy", package.seeall)

local M = class("TaskKillEnemy")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 0
	local paramArray = string.split(param, "#")

	if paramArray and #paramArray ~= 4 then
		if enableErrorLog then
			printError("Invalid parameter length with code:", code)
		end

		return tempStr, maxCount
	end

	maxCount = tonumber(paramArray[1])

	return tempStr, maxCount, true
end

return M
