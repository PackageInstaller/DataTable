-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/role/TaskWearEcho.lua

module("logic.extensions.task.util.impl.role.TaskWearEcho", package.seeall)

local M = class("TaskWearEcho")

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
	local echoId = tonumber(paramArray[2])
	local heroInfo = PastInfoConfig.instance:getCharacterInfo(heroId)
	local echoInfo = BackpackConfig.instance:getItemInfoByItemId(echoId)

	if heroInfo == nil or echoInfo == nil then
		printError(string.format("invalid heroId %s or echoId %s", heroId, echoId))

		return tempStr, 1
	end

	tempStr = string.gsub(tempStr, "#1#", heroInfo.name)
	tempStr = string.gsub(tempStr, "#2#", echoInfo.name)

	return tempStr, 1
end

return M
