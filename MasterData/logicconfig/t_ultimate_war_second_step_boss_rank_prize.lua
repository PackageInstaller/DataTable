-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_war_second_step_boss_rank_prize.lua

module("logicconfig.config.t_ultimate_war_second_step_boss_rank_prize", package.seeall)

local title = {
	prize = 5,
	index = 2,
	title = 4,
	activityId = 1,
	rankRange = 3
}
local dataList = {
	{
		434001,
		1,
		{
			1,
			10
		},
		"第1-10名",
		"2:186:1#104:2:1000#8:1:10000000"
	},
	{
		434001,
		2,
		{
			11,
			20
		},
		"第11-20名",
		"2:186:1#104:2:800#8:1:8000000"
	},
	{
		434001,
		3,
		{
			21,
			50
		},
		"第21-50名",
		"2:186:1#104:2:700#8:1:7000000"
	},
	{
		434001,
		4,
		{
			51,
			100
		},
		"第51-100名",
		"2:186:1#104:2:600#8:1:6000000"
	},
	{
		434001,
		5,
		{
			101,
			300
		},
		"第101-300名",
		"2:186:1#104:2:500#8:1:5000000"
	},
	{
		434001,
		6,
		{
			301,
			500
		},
		"第301-500名",
		"2:186:1#104:2:400#8:1:4000000"
	},
	{
		434001,
		7,
		{
			501,
			700
		},
		"第501-700名",
		"2:186:1#104:2:300#8:1:3000000"
	},
	{
		434001,
		8,
		{
			701,
			1000
		},
		"第701-1000名",
		"2:186:1#104:2:200#8:1:2000000"
	}
}
local t_ultimate_war_second_step_boss_rank_prize = {
	[434001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_ultimate_war_second_step_boss_rank_prize.dataList = dataList

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

return t_ultimate_war_second_step_boss_rank_prize
