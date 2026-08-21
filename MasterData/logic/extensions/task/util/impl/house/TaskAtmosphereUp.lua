-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/house/TaskAtmosphereUp.lua

module("logic.extensions.task.util.impl.house.TaskAtmosphereUp", package.seeall)

local M = class("TaskAtmosphereUp")

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

	local maxCount = tonumber(paramArray[1])
	local type = tonumber(paramArray[2])

	tempStr = string.gsub(tempStr, "#1#", maxCount)

	local co = LivingFacilitiesConfig.instance:getConfigByKey(ConfigName.HouseAtmosType, type)

	if co then
		tempStr = string.gsub(tempStr, "#2#", co.name)
	end

	return tempStr, maxCount
end

return M
