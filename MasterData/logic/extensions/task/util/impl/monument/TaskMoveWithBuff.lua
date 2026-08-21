-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/monument/TaskMoveWithBuff.lua

module("logic.extensions.task.util.impl.monument.TaskMoveWithBuff", package.seeall)

local M = class("TaskMoveWithBuff")

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

	local buffId = tonumber(paramArray[2])
	local name = ""
	local buffCO = BuffConfig.instance:getBuffCO(buffId)

	if buffCO then
		name = buffCO.name
	end

	tempStr = string.gsub(tempStr, "#2#", name)
	tempStr = string.gsub(tempStr, "#1#", maxCount)

	return tempStr, maxCount
end

return M
