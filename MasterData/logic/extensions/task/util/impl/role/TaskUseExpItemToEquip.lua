-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/role/TaskUseExpItemToEquip.lua

module("logic.extensions.task.util.impl.role.TaskUseExpItemToEquip", package.seeall)

local M = class("TaskUseExpItemToEquip")

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

	local quality = tonumber(paramArray[2])
	local qualityName = CommEnum.Quality2Name[quality] or quality

	tempStr = string.gsub(tempStr, "#1#", maxCount)
	tempStr = string.gsub(tempStr, "#2#", qualityName)

	return tempStr, maxCount
end

return M
