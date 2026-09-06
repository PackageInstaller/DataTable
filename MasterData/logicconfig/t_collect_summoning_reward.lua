-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_collect_summoning_reward.lua

module("logicconfig.config.t_collect_summoning_reward", package.seeall)

local title = {
	id = 2,
	petPrizePlanId = 1,
	prize = 4,
	score = 3
}
local dataList = {
	{
		1,
		1,
		1,
		"104:2:300"
	},
	{
		1,
		2,
		2,
		"104:2:300"
	},
	{
		1,
		3,
		3,
		"104:2:300"
	},
	{
		1,
		4,
		4,
		"4:400002:30"
	},
	{
		1,
		5,
		5,
		"104:2:300"
	},
	{
		1,
		6,
		6,
		"4:400002:30"
	},
	{
		1,
		7,
		7,
		"104:2:300"
	},
	{
		1,
		8,
		8,
		"4:400002:40"
	},
	{
		2,
		1,
		1,
		"104:2:88"
	},
	{
		2,
		2,
		3,
		"104:2:88"
	},
	{
		2,
		3,
		6,
		"14:248:1"
	},
	{
		3,
		1,
		5,
		"104:2:88"
	},
	{
		3,
		2,
		10,
		"104:2:88"
	},
	{
		3,
		3,
		20,
		"104:2:188"
	},
	{
		3,
		4,
		30,
		"14:169:1"
	},
	{
		4,
		1,
		5,
		"104:2:88"
	},
	{
		4,
		2,
		10,
		"104:2:88"
	},
	{
		4,
		3,
		15,
		"4:400004:5"
	},
	{
		4,
		4,
		20,
		"4:400004:5"
	},
	{
		4,
		5,
		25,
		"4:400004:5"
	},
	{
		4,
		6,
		30,
		"4:400004:10"
	}
}
local t_collect_summoning_reward = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11]
	},
	{
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	},
	{
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21]
	}
}

t_collect_summoning_reward.dataList = dataList

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

return t_collect_summoning_reward
