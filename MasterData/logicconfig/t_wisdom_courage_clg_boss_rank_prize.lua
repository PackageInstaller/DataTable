-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wisdom_courage_clg_boss_rank_prize.lua

module("logicconfig.config.t_wisdom_courage_clg_boss_rank_prize", package.seeall)

local title = {
	prize = 5,
	id = 2,
	title = 4,
	activityId = 1,
	rankRange = 3
}
local dataList = {
	{
		456001,
		1,
		{
			1,
			1
		},
		"1名",
		"2:212:1#104:2:1000#8:1:1000000"
	},
	{
		456001,
		2,
		{
			2,
			5
		},
		"2~5名",
		"2:212:1#104:2:800#8:1:800000"
	},
	{
		456001,
		3,
		{
			6,
			20
		},
		"6~20名",
		"2:212:1#104:2:600#8:1:600000"
	},
	{
		456001,
		4,
		{
			21,
			50
		},
		"21~50名",
		"2:212:1#104:2:400#8:1:500000"
	},
	{
		456001,
		5,
		{
			51,
			100
		},
		"51~100名",
		"2:212:1#104:2:300#8:1:400000"
	},
	{
		456001,
		6,
		{
			101,
			1000
		},
		"101~1000名",
		"2:212:1#104:2:200#8:1:300000"
	}
}
local t_wisdom_courage_clg_boss_rank_prize = {
	[456001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_wisdom_courage_clg_boss_rank_prize.dataList = dataList

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

return t_wisdom_courage_clg_boss_rank_prize
