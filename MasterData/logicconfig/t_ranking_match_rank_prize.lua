-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ranking_match_rank_prize.lua

module("logicconfig.config.t_ranking_match_rank_prize", package.seeall)

local title = {
	rightTop = 3,
	prize = 4,
	planId = 1,
	rankingMatchId = 2
}
local dataList = {
	{
		1,
		0,
		1,
		"104:2:1000#8:3:20000"
	},
	{
		1,
		0,
		3,
		"104:2:900#8:3:20000"
	},
	{
		1,
		0,
		10,
		"104:2:800#8:3:18000"
	},
	{
		1,
		0,
		50,
		"104:2:700#8:3:16000"
	},
	{
		1,
		0,
		100,
		"104:2:600#8:3:14000"
	},
	{
		1,
		0,
		200,
		"104:2:600#8:3:14000"
	},
	{
		1,
		0,
		500,
		"104:2:500#8:3:12000"
	},
	{
		1,
		0,
		1000,
		"104:2:400#8:3:10000"
	},
	{
		1,
		1,
		1,
		"104:2:500#8:3:10000"
	},
	{
		1,
		1,
		3,
		"104:2:450#8:3:10000"
	},
	{
		1,
		1,
		10,
		"104:2:400#8:3:9000"
	},
	{
		1,
		1,
		50,
		"104:2:350#8:3:8000"
	},
	{
		1,
		1,
		100,
		"104:2:300#8:3:7000"
	},
	{
		1,
		1,
		200,
		"104:2:300#8:3:7000"
	},
	{
		1,
		1,
		500,
		"104:2:250#8:3:6000"
	},
	{
		1,
		1,
		1000,
		"104:2:200#8:3:5000"
	},
	{
		2,
		0,
		1,
		"2:11:1#13:337:1#104:2:1000#8:3:20000"
	},
	{
		2,
		0,
		3,
		"13:337:1#104:2:900#8:3:20000"
	},
	{
		2,
		0,
		10,
		"13:337:1#104:2:800#8:3:18000"
	},
	{
		2,
		0,
		50,
		"13:337:1#104:2:700#8:3:16000"
	},
	{
		2,
		0,
		100,
		"13:337:1#104:2:600#8:3:14000"
	},
	{
		2,
		0,
		200,
		"104:2:600#8:3:14000"
	},
	{
		2,
		0,
		500,
		"104:2:500#8:3:12000"
	},
	{
		2,
		0,
		1000,
		"104:2:400#8:3:10000"
	},
	{
		2,
		1,
		1,
		"2:12:1#14:342:1#104:2:500#8:3:10000"
	},
	{
		2,
		1,
		3,
		"14:342:1#104:2:450#8:3:10000"
	},
	{
		2,
		1,
		10,
		"14:342:1#104:2:400#8:3:9000"
	},
	{
		2,
		1,
		50,
		"14:342:1#104:2:350#8:3:8000"
	},
	{
		2,
		1,
		100,
		"14:342:1#104:2:300#8:3:7000"
	},
	{
		2,
		1,
		200,
		"104:2:300#8:3:7000"
	},
	{
		2,
		1,
		500,
		"104:2:250#8:3:6000"
	},
	{
		2,
		1,
		1000,
		"104:2:200#8:3:5000"
	}
}
local t_ranking_match_rank_prize = {
	{
		[0] = {
			dataList[1],
			[3] = dataList[2],
			[10] = dataList[3],
			[50] = dataList[4],
			[100] = dataList[5],
			[200] = dataList[6],
			[500] = dataList[7],
			[1000] = dataList[8]
		},
		{
			dataList[9],
			[3] = dataList[10],
			[10] = dataList[11],
			[50] = dataList[12],
			[100] = dataList[13],
			[200] = dataList[14],
			[500] = dataList[15],
			[1000] = dataList[16]
		}
	},
	{
		[0] = {
			dataList[17],
			[3] = dataList[18],
			[10] = dataList[19],
			[50] = dataList[20],
			[100] = dataList[21],
			[200] = dataList[22],
			[500] = dataList[23],
			[1000] = dataList[24]
		},
		{
			dataList[25],
			[3] = dataList[26],
			[10] = dataList[27],
			[50] = dataList[28],
			[100] = dataList[29],
			[200] = dataList[30],
			[500] = dataList[31],
			[1000] = dataList[32]
		}
	}
}

t_ranking_match_rank_prize.dataList = dataList

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

return t_ranking_match_rank_prize
