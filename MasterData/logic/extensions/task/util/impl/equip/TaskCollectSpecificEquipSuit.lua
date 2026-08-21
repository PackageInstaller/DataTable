-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/equip/TaskCollectSpecificEquipSuit.lua

module("logic.extensions.task.util.impl.equip.TaskCollectSpecificEquipSuit", package.seeall)

local M = class("TaskCollectSpecificEquipSuit")

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

	local suitId = tonumber(paramArray[1])
	local quality = tonumber(paramArray[2])
	local cfgSuit = EquipmentConfig.instance:getConfigByKey(ConfigName.EquipmentSuit, suitId)
	local suitName = cfgSuit and cfgSuit.name or ""
	local qualityName = CommEnum.Quality2Name[quality]

	tempStr = string.gsub(tempStr, "#1#", suitName)
	tempStr = string.gsub(tempStr, "#2#", qualityName)

	return tempStr, maxCount
end

return M
