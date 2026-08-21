-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/bag/TaskGetEcho.lua

module("logic.extensions.task.util.impl.bag.TaskGetEcho", package.seeall)

local M = class("TaskGetEcho")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local paramArray = string.split(param, "#")

	maxCount = tonumber(paramArray[1])

	return tempStr, maxCount, true
end

function M:_getEchoRarityName(rarity)
	local tmpName = ""

	if rarity == 2 then
		tmpName = "C"
	elseif rarity == 3 then
		tmpName = "B"
	elseif rarity == 4 then
		tmpName = "A"
	elseif rarity == 5 then
		tmpName = "S"
	end

	return tmpName
end

return M
