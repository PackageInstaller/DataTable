-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/role/TaskWearEquipSuit.lua

module("logic.extensions.task.util.impl.role.TaskWearEquipSuit", package.seeall)

local M = class("TaskWearEquipSuit")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local paramArray = string.split(param, "#")

	if paramArray and #paramArray ~= 2 then
		if enableErrorLog then
			printError("Invalid parameter length with code:", code, param)
		end

		return tempStr, 1
	end

	local heroId = tonumber(paramArray[1])
	local suitId = tonumber(paramArray[2])
	local heroInfo = PastInfoConfig.instance:getCharacterInfo(heroId)
	local suitInfo = EquipSuitModel.instance:getSuitDataById(suitId)

	if heroInfo == nil or suitInfo == nil then
		printError(string.format("invalid heroId %s or suitId %s", heroId, suitId))

		return tempStr, 1
	end

	tempStr = string.gsub(tempStr, "#1#", heroInfo.name)
	tempStr = string.gsub(tempStr, "#2#", suitInfo:getName())

	return tempStr, 1
end

return M
