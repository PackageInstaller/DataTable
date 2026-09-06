-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cloud_cut_fan_reward_prize.lua

module("logicconfig.config.t_cloud_cut_fan_reward_prize", package.seeall)

local title = {
	prizeId = 2,
	rewardPrize = 4,
	activityId = 1,
	requiredCount = 3
}
local dataList = {
	{
		615001,
		1,
		2,
		"4:36:5"
	},
	{
		615001,
		2,
		4,
		"60:1:1000"
	},
	{
		615001,
		3,
		6,
		"4:36:5"
	},
	{
		615001,
		4,
		8,
		"60:1:1000"
	},
	{
		615001,
		5,
		10,
		"4:400002:100"
	},
	{
		615001,
		6,
		12,
		"60:1:1000"
	},
	{
		615001,
		7,
		14,
		"4:400002:100"
	},
	{
		615001,
		8,
		16,
		"60:1:1000"
	},
	{
		615001,
		9,
		18,
		"4:510022:2"
	},
	{
		615001,
		10,
		21,
		"60:1:2000"
	},
	{
		615001,
		11,
		24,
		"4:510022:3"
	},
	{
		615001,
		12,
		27,
		"60:1:2000"
	},
	{
		615001,
		13,
		30,
		"4:12101:2"
	},
	{
		615001,
		14,
		33,
		"60:1:2000"
	},
	{
		615001,
		15,
		36,
		"4:12101:3"
	},
	{
		615001,
		16,
		39,
		"1:400052:-1:1"
	}
}
local t_cloud_cut_fan_reward_prize = {
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
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_cloud_cut_fan_reward_prize.dataList = dataList

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

return t_cloud_cut_fan_reward_prize
