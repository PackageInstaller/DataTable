-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ranking_match_level_prize.lua

module("logicconfig.config.t_ranking_match_level_prize", package.seeall)

local title = {
	levelTitle = 5,
	bigLevel = 2,
	rankingMatchId = 1,
	levelPrize = 4,
	bigLevelName = 3,
	sort = 6
}
local dataList = {
	{
		0,
		1,
		"青铜",
		"104:2:100#8:3:400#8:1:4000#4:110006:5",
		"初来乍到",
		8
	},
	{
		0,
		2,
		"白银",
		"104:2:160#8:3:600#8:1:8000#4:110006:5",
		"新手入门",
		7
	},
	{
		0,
		3,
		"黄金",
		"104:2:200#8:3:800#8:1:12000#4:110006:5#4:400004:10",
		"马马虎虎",
		6
	},
	{
		0,
		4,
		"铂金",
		"104:2:240#8:3:1000#8:1:16000#4:110006:5#4:400004:10",
		"牛刀小试",
		5
	},
	{
		0,
		5,
		"钻石",
		"104:2:300#8:3:1200#8:1:20000#4:110006:5#4:400004:20",
		"驾轻就熟",
		4
	},
	{
		0,
		6,
		"星耀",
		"104:2:400#8:3:1400#8:1:24000#4:110006:5#4:400004:30",
		"传奇正盛",
		3
	},
	{
		0,
		7,
		"王者",
		"104:2:500#8:3:1600#8:1:30000#4:110006:5#4:400004:40",
		"登峰造极",
		2
	},
	{
		0,
		8,
		"传说",
		"4:510487:1#2:190:1#104:2:600#8:3:2000#8:1:40000#4:110006:5#4:400004:50",
		"王者无敌",
		1
	},
	{
		1,
		1,
		"青铜",
		"104:2:50#8:3:200#8:1:2000#4:110006:5",
		"初生牛犊",
		8
	},
	{
		1,
		2,
		"白银",
		"104:2:80#8:3:300#8:1:4000#4:110006:5",
		"新手报道",
		7
	},
	{
		1,
		3,
		"黄金",
		"104:2:100#8:3:400#8:1:6000#4:110006:5#4:400004:10",
		"出类拔萃",
		6
	},
	{
		1,
		4,
		"铂金",
		"104:2:120#8:3:500#8:1:8000#4:110006:5#4:400004:10",
		"一骑绝尘",
		5
	},
	{
		1,
		5,
		"钻石",
		"104:2:150#8:3:600#8:1:10000#4:110006:5#4:400004:20",
		"运筹帷幄",
		4
	},
	{
		1,
		6,
		"星耀",
		"104:2:200#8:3:700#8:1:12000#4:110006:5#4:400004:30",
		"千载难逢",
		3
	},
	{
		1,
		7,
		"王者",
		"104:2:250#8:3:800#8:1:15000#4:110006:5#4:400004:40",
		"独孤求败",
		2
	},
	{
		1,
		8,
		"传说",
		"2:191:1#104:2:300#8:3:1000#8:1:20000#4:110006:5#4:400004:50",
		"天下无双",
		1
	}
}
local t_ranking_match_level_prize = {
	[0] = {
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
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_ranking_match_level_prize.dataList = dataList

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

return t_ranking_match_level_prize
