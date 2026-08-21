-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/tacit/TaskHeroCutOtherSan.lua

module("logic.extensions.task.util.impl.tacit.TaskHeroCutOtherSan", package.seeall)

local M = class("TaskHeroCutOtherSan")

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

	maxCount = tonumber(paramArray[1])

	local id = tonumber(paramArray[2])

	id = id == -1 and heroId or id

	local name = false
	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(id)

	if heroInfoCO then
		name = heroInfoCO.name
	end

	tempStr = string.gsub(tempStr, "#2#", name)

	local sideTips = string.gsub(tempStr, "#1#", "%%s")

	tempStr = string.gsub(tempStr, "#1#", maxCount)

	return tempStr, maxCount, sideTips
end

return M
