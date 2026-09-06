-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cloud_cut_fan_challenge_prize.lua

module("logicconfig.config.t_cloud_cut_fan_challenge_prize", package.seeall)

local title = {
	damageRange = 3,
	rangeId = 2,
	transDesc = 5,
	damagePrize = 4,
	activityId = 1
}
local dataList = {
	{
		615001,
		1,
		{
			1,
			1000000
		},
		"9:1001529:25",
		"100万以下获得材料"
	},
	{
		615001,
		2,
		{
			1000001,
			5000000
		},
		"9:1001529:26",
		"101万-500万获得材料"
	},
	{
		615001,
		3,
		{
			5000001,
			10000000
		},
		"9:1001529:27",
		"501万-1000万获得材料"
	},
	{
		615001,
		4,
		{
			10000001,
			30000000
		},
		"9:1001529:28",
		"1001万-3000万获得材料"
	},
	{
		615001,
		5,
		{
			30000001,
			50000000
		},
		"9:1001529:29",
		"3001万-5000万获得材料"
	},
	{
		615001,
		6,
		{
			50000001,
			60000000
		},
		"9:1001529:30",
		"5001万-6000万获得材料"
	},
	{
		615001,
		7,
		{
			60000001,
			70000000
		},
		"9:1001529:31",
		"6001万-7000万获得材料"
	},
	{
		615001,
		8,
		{
			70000001,
			80000000
		},
		"9:1001529:32",
		"7001万-8000万获得材料"
	},
	{
		615001,
		9,
		{
			80000001,
			99999999
		},
		"9:1001529:33",
		"8001万-9999万获得材料"
	},
	{
		615001,
		10,
		{
			100000000,
			300000000
		},
		"9:1001529:35",
		"1亿-3亿获得材料"
	}
}
local t_cloud_cut_fan_challenge_prize = {
	[615001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_cloud_cut_fan_challenge_prize.dataList = dataList

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

return t_cloud_cut_fan_challenge_prize
