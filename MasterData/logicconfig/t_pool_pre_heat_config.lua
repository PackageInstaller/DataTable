-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pool_pre_heat_config.lua

module("logicconfig.config.t_pool_pre_heat_config", package.seeall)

local title = {
	dailyPlanId = 2,
	storyPlanId = 3,
	signInDay = 5,
	raceId = 4,
	activityId = 1
}
local dataList = {
	{
		36001,
		1,
		1,
		{
			10205,
			10179,
			10329
		},
		3
	},
	{
		36002,
		2,
		1,
		{
			10205,
			10179,
			10329
		},
		3
	},
	{
		36003,
		3,
		2,
		{},
		3
	},
	{
		36004,
		4,
		3,
		{},
		3
	}
}
local t_pool_pre_heat_config = {
	[36001] = dataList[1],
	[36002] = dataList[2],
	[36003] = dataList[3],
	[36004] = dataList[4]
}

t_pool_pre_heat_config.dataList = dataList

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

return t_pool_pre_heat_config
