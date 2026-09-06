-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_help_dragon_mom_reward_world.lua

module("logicconfig.config.t_help_dragon_mom_reward_world", package.seeall)

local title = {
	id = 2,
	progress = 3,
	prize = 4,
	worldRewardPlanId = 1
}
local dataList = {
	{
		1,
		1,
		500000,
		"8:1:20000"
	},
	{
		1,
		2,
		1500000,
		"8:1:30000"
	},
	{
		1,
		3,
		3000000,
		"8:1:50000"
	},
	{
		1,
		4,
		6000000,
		"8:1:100000"
	},
	{
		1,
		5,
		9000000,
		"8:1:100000"
	},
	{
		1,
		6,
		12000000,
		"8:1:150000"
	},
	{
		1,
		7,
		15000000,
		"8:1:150000"
	},
	{
		1,
		8,
		18000000,
		"8:1:150000"
	},
	{
		1,
		9,
		21000000,
		"8:1:150000"
	},
	{
		1,
		10,
		24000000,
		"8:1:150000"
	},
	{
		1,
		11,
		27000000,
		"8:1:150000"
	},
	{
		1,
		12,
		30000000,
		"8:1:150000"
	},
	{
		1,
		13,
		33000000,
		"8:1:150000"
	},
	{
		1,
		14,
		36000000,
		"8:1:150000"
	},
	{
		1,
		15,
		39000000,
		"8:1:150000"
	},
	{
		1,
		16,
		42000000,
		"8:1:150000"
	},
	{
		1,
		17,
		45000000,
		"8:1:150000"
	},
	{
		1,
		18,
		48000000,
		"8:1:150000"
	},
	{
		1,
		19,
		51000000,
		"8:1:150000"
	},
	{
		1,
		20,
		54000000,
		"8:1:150000"
	},
	{
		1,
		21,
		57000000,
		"8:1:150000"
	},
	{
		1,
		22,
		60000000,
		"8:1:150000"
	},
	{
		1,
		23,
		63000000,
		"8:1:150000"
	}
}
local t_help_dragon_mom_reward_world = {
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
		dataList[23]
	}
}

t_help_dragon_mom_reward_world.dataList = dataList

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

return t_help_dragon_mom_reward_world
