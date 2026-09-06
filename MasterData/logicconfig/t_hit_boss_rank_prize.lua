-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hit_boss_rank_prize.lua

module("logicconfig.config.t_hit_boss_rank_prize", package.seeall)

local title = {
	prize = 5,
	index = 2,
	title = 4,
	activityId = 1,
	rankRange = 3
}
local dataList = {
	{
		327001,
		1,
		{
			1,
			1
		},
		"1名",
		"104:2:2000#8:1:2000000"
	},
	{
		327001,
		2,
		{
			2,
			3
		},
		"2~3名",
		"104:2:1600#8:1:1600000"
	},
	{
		327001,
		3,
		{
			4,
			10
		},
		"4~10名",
		"104:2:1200#8:1:1200000"
	},
	{
		327001,
		4,
		{
			11,
			50
		},
		"11~50名",
		"104:2:800#8:1:1000000"
	},
	{
		327001,
		5,
		{
			51,
			100
		},
		"51~100名",
		"104:2:600#8:1:800000"
	},
	{
		327001,
		6,
		{
			101,
			300
		},
		"101~300名",
		"104:2:400#8:1:600000"
	},
	{
		327001,
		7,
		{
			301,
			500
		},
		"301~500名",
		"104:2:200#8:1:400000"
	}
}
local t_hit_boss_rank_prize = {
	[327001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_hit_boss_rank_prize.dataList = dataList

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

return t_hit_boss_rank_prize
