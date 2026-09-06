-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_help_dragon_mom_reward_player.lua

module("logicconfig.config.t_help_dragon_mom_reward_player", package.seeall)

local title = {
	id = 2,
	playerRewardPlanId = 1,
	prize = 4,
	progress = 3
}
local dataList = {
	{
		1,
		1,
		500,
		"4:510012:75"
	},
	{
		1,
		2,
		1000,
		"4:112:4"
	},
	{
		1,
		3,
		2000,
		"4:36:5"
	},
	{
		1,
		4,
		3000,
		"4:40008:1"
	},
	{
		1,
		5,
		3500,
		"4:510012:75"
	},
	{
		1,
		6,
		4000,
		"4:112:4"
	},
	{
		1,
		7,
		4500,
		"4:36:5"
	},
	{
		1,
		8,
		5000,
		"4:40008:1"
	},
	{
		1,
		9,
		5500,
		"4:510012:75"
	},
	{
		1,
		10,
		6000,
		"4:112:4"
	},
	{
		1,
		11,
		6500,
		"4:36:5"
	},
	{
		1,
		12,
		7000,
		"4:40008:1"
	},
	{
		1,
		13,
		7500,
		"4:90212:1"
	},
	{
		1,
		14,
		8000,
		"4:510012:75"
	},
	{
		1,
		15,
		8500,
		"4:112:4"
	},
	{
		1,
		16,
		9000,
		"4:36:5"
	},
	{
		1,
		17,
		9500,
		"4:40008:1"
	},
	{
		1,
		18,
		10000,
		"4:510012:100"
	},
	{
		1,
		19,
		10500,
		"4:112:4"
	},
	{
		1,
		20,
		11000,
		"4:36:5"
	},
	{
		1,
		21,
		11500,
		"4:40008:1"
	},
	{
		1,
		22,
		12000,
		"4:510012:100"
	},
	{
		1,
		23,
		12500,
		"4:40008:1"
	},
	{
		1,
		24,
		13000,
		"4:36:5"
	},
	{
		1,
		25,
		13500,
		"4:40008:1"
	},
	{
		1,
		26,
		14000,
		"4:510012:100"
	},
	{
		1,
		27,
		14500,
		"4:40008:1"
	},
	{
		1,
		28,
		15000,
		"4:90212:1"
	},
	{
		1,
		29,
		15500,
		"4:40008:1"
	},
	{
		1,
		30,
		16000,
		"4:40008:1"
	},
	{
		1,
		31,
		16500,
		"4:70021:1"
	}
}
local t_help_dragon_mom_reward_player = {
	{
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
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30],
		dataList[31]
	}
}

t_help_dragon_mom_reward_player.dataList = dataList

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

return t_help_dragon_mom_reward_player
