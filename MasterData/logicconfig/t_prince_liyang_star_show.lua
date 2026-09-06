-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_prince_liyang_star_show.lua

module("logicconfig.config.t_prince_liyang_star_show", package.seeall)

local title = {
	showStrar = 4,
	showTitle = 5,
	activityId = 1,
	typeId = 2,
	star = 3,
	zdlRecommend = 6
}
local dataList = {
	{
		509001,
		1,
		1,
		1,
		"1星",
		"战力20-50W"
	},
	{
		509001,
		1,
		2,
		3,
		"3星",
		"战力100-150W"
	},
	{
		509001,
		1,
		3,
		5,
		"5星",
		"战力200-250W"
	},
	{
		509001,
		2,
		1,
		1,
		"1星",
		"战力20-50W"
	},
	{
		509001,
		2,
		2,
		3,
		"3星",
		"战力100-150W"
	},
	{
		509001,
		2,
		3,
		5,
		"5星",
		"战力200-250W"
	}
}
local t_prince_liyang_star_show = {
	[509001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		}
	}
}

t_prince_liyang_star_show.dataList = dataList

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

return t_prince_liyang_star_show
