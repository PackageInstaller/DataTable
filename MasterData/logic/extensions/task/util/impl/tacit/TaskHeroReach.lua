-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/tacit/TaskHeroReach.lua

module("logic.extensions.task.util.impl.tacit.TaskHeroReach", package.seeall)

local M = class("TaskHeroReach")

function M:parseContent(code, desc, param, heroId)
	local tempStr = desc
	local maxCount = 1
	local paramArray = string.split(param, "#")

	if paramArray and #paramArray ~= 5 then
		if enableErrorLog then
			printError("Invalid parameter length with code:", code)
		end

		return tempStr, maxCount
	end

	local tempTb = {}
	local level = tonumber(paramArray[2])
	local affinity = tonumber(paramArray[3])
	local breakLv = tonumber(paramArray[4])
	local fightingCapacity = tonumber(paramArray[5])

	if level > 0 then
		table.insert(tempTb, level)
	end

	if affinity > 0 then
		table.insert(tempTb, affinity)
	end

	if breakLv > 0 then
		table.insert(tempTb, breakLv)
	end

	if fightingCapacity > 0 then
		table.insert(tempTb, fightingCapacity)
	end

	local isSingle = #tempTb == 1

	if isSingle then
		maxCount = tempTb[1]

		if affinity > 0 then
			maxCount = 1
		end
	end

	return tempStr, maxCount
end

return M
