-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/equip/TaskGainEquipment.lua

module("logic.extensions.task.util.impl.equip.TaskGainEquipment", package.seeall)

local M = class("TaskGainEquipment")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local paramArray = string.split(param, "#")
	local maxCount = tonumber(paramArray[1])
	local quality = tonumber(paramArray[2])
	local qualityName = CommEnum.Quality2Name[quality]

	tempStr = string.gsub(tempStr, "#1#", maxCount)
	tempStr = string.gsub(tempStr, "#2#", qualityName)

	return tempStr, maxCount
end

return M
