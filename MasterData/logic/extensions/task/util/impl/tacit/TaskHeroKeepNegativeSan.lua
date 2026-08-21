-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/tacit/TaskHeroKeepNegativeSan.lua

module("logic.extensions.task.util.impl.tacit.TaskHeroKeepNegativeSan", package.seeall)

local M = class("TaskHeroKeepNegativeSan")

function M:parseContent(code, desc, param, heroId)
	local tempStr = desc
	local maxCount = 1
	local paramArray = string.split(param, "#")

	if paramArray and #paramArray ~= 2 then
		if enableErrorLog then
			printError("Invalid parameter length with code:", code)
		end

		return tempStr, maxCount
	end

	local round = tonumber(paramArray[1])
	local id = tonumber(paramArray[2])

	id = id == -1 and heroId or id

	local name = ""
	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(id)

	if heroInfoCO then
		name = heroInfoCO.name
	end

	tempStr = string.gsub(tempStr, "#1#", round)
	tempStr = string.gsub(tempStr, "#2#", name)

	return tempStr, maxCount
end

return M
