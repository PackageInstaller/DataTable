-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sun_wu_kong_challenge_cimelia_level.lua

module("logicconfig.config.t_sun_wu_kong_challenge_cimelia_level", package.seeall)

local title = {
	cost = 3,
	cimeliaLevelPlanId = 1,
	cimeliaLevel = 2
}
local dataList = {
	{
		1,
		2,
		"4:190:20"
	},
	{
		1,
		3,
		"4:190:30"
	},
	{
		1,
		4,
		"4:190:40"
	},
	{
		2,
		2,
		"4:292:10"
	},
	{
		2,
		3,
		"4:292:20"
	},
	{
		2,
		4,
		"4:292:40"
	}
}
local t_sun_wu_kong_challenge_cimelia_level = {
	{
		[2] = dataList[1],
		[3] = dataList[2],
		[4] = dataList[3]
	},
	{
		[2] = dataList[4],
		[3] = dataList[5],
		[4] = dataList[6]
	}
}

t_sun_wu_kong_challenge_cimelia_level.dataList = dataList

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

return t_sun_wu_kong_challenge_cimelia_level
