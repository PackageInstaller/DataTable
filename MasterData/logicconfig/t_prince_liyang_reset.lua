-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_prince_liyang_reset.lua

module("logicconfig.config.t_prince_liyang_reset", package.seeall)

local title = {
	cost = 3,
	activityId = 1,
	times = 2
}
local dataList = {
	{
		509001,
		1,
		"66:21:5"
	},
	{
		509001,
		2,
		"66:21:5"
	},
	{
		509001,
		3,
		"66:21:10"
	},
	{
		509001,
		4,
		"66:21:10"
	},
	{
		509001,
		5,
		"66:21:15"
	},
	{
		509001,
		6,
		"66:21:15"
	}
}
local t_prince_liyang_reset = {
	[509001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_prince_liyang_reset.dataList = dataList

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

return t_prince_liyang_reset
