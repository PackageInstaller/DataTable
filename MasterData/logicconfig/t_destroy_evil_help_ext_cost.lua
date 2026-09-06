-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_destroy_evil_help_ext_cost.lua

module("logicconfig.config.t_destroy_evil_help_ext_cost", package.seeall)

local title = {
	extCostId = 2,
	helpTimes = 3,
	activityId = 1,
	rate = 4
}
local dataList = {
	{
		322001,
		1,
		30,
		2
	},
	{
		322001,
		2,
		60,
		4
	},
	{
		322001,
		3,
		90,
		8
	}
}
local t_destroy_evil_help_ext_cost = {
	[322001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_destroy_evil_help_ext_cost.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_destroy_evil_help_ext_cost
