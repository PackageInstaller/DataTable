-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/other/TaskPlayerAttr.lua

module("logic.extensions.task.util.impl.other.TaskPlayerAttr", package.seeall)

local M = class("TaskPlayerAttr")
local map = {
	"力量",
	"敏捷",
	"知识",
	"沟通",
	"洞察",
	"幸运"
}

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

	local id = tonumber(paramArray[2])
	local name = map[id]

	tempStr = string.gsub(tempStr, "#1#", maxCount)
	tempStr = string.gsub(tempStr, "#2#", name)

	return tempStr, maxCount
end

return M
