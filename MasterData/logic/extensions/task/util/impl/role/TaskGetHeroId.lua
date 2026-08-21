-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/role/TaskGetHeroId.lua

module("logic.extensions.task.util.impl.role.TaskGetHeroId", package.seeall)

local M = class("TaskGetHeroId")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local heroId = tonumber(param)

	if not heroId then
		if enableErrorLog then
			printError("Invalid parameter with code:", code)
		end

		return tempStr, maxCount
	end

	maxCount = 1

	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(heroId)

	if heroInfoCO then
		tempStr = string.gsub(tempStr, "#1#", heroInfoCO.name)
	end

	return tempStr, maxCount
end

return M
