-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/house/TaskBuildFacility.lua

module("logic.extensions.task.util.impl.house.TaskBuildFacility", package.seeall)

local M = class("TaskBuildFacility")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local type = tonumber(param)
	local livingFacilitiesCo = LivingFacilitiesConfig.instance:getConfigByKey(ConfigName.HouseLiveRoom, tonumber(type))

	if livingFacilitiesCo then
		tempStr = string.gsub(tempStr, "#1#", livingFacilitiesCo.name)
	end

	return tempStr, maxCount
end

return M
