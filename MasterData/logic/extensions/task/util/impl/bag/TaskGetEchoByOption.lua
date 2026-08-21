-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/bag/TaskGetEchoByOption.lua

module("logic.extensions.task.util.impl.bag.TaskGetEchoByOption", package.seeall)

local M = class("TaskGetEchoByOption")

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

	local optionType = tonumber(paramArray[2])
	local optionName = lang(string.format("tip_optiontype_%s", optionType))

	tempStr = string.gsub(tempStr, "#1#", maxCount)
	tempStr = string.gsub(tempStr, "#2#", optionName)

	return tempStr, maxCount
end

return M
