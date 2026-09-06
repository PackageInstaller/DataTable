-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_water_dark_tower_common.lua

module("logicconfig.config.t_water_dark_tower_common", package.seeall)

local title = {
	buyTimesPlanId = 5,
	bigPrize = 7,
	buffPlanId = 6,
	prizePlanId = 4,
	dailyTimes = 2,
	activityId = 1,
	challengePlanId = 3
}
local dataList = {
	{
		59001,
		10,
		1,
		1,
		1,
		0,
		"8:1:2500"
	},
	{
		59002,
		5,
		3,
		2,
		2,
		0,
		"8:1:2500"
	},
	{
		59003,
		5,
		3,
		2,
		2,
		0,
		"8:1:2500"
	},
	{
		59004,
		5,
		4,
		3,
		2,
		0,
		"8:1:2500"
	},
	{
		59005,
		5,
		5,
		3,
		2,
		0,
		"8:1:2500"
	},
	{
		59006,
		10,
		6,
		4,
		3,
		1,
		"4:30006:200"
	},
	{
		59007,
		5,
		7,
		3,
		2,
		0,
		"4:400002:100"
	},
	{
		59008,
		5,
		8,
		3,
		2,
		0,
		"4:400002:100"
	},
	{
		59009,
		5,
		9,
		3,
		2,
		0,
		"4:90312:1"
	}
}
local t_water_dark_tower_common = {
	[59001] = dataList[1],
	[59002] = dataList[2],
	[59003] = dataList[3],
	[59004] = dataList[4],
	[59005] = dataList[5],
	[59006] = dataList[6],
	[59007] = dataList[7],
	[59008] = dataList[8],
	[59009] = dataList[9]
}

t_water_dark_tower_common.dataList = dataList

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

return t_water_dark_tower_common
