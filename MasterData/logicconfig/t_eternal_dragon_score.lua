-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_dragon_score.lua

module("logicconfig.config.t_eternal_dragon_score", package.seeall)

local title = {
	score = 3,
	picturePath = 7,
	storyIdList = 6,
	prize = 5,
	id = 2,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		295001,
		1,
		0,
		"种子",
		"4:30006:10#10:17084:100#8:1:300000",
		{
			1,
			2
		},
		"eternaldragon/board_zhongshu_09"
	},
	{
		295001,
		2,
		20,
		"发芽",
		"4:30006:20#10:17084:150#8:1:400000",
		{
			3,
			4
		},
		"eternaldragon/board_zhongshu_10"
	},
	{
		295001,
		3,
		120,
		"树苗",
		"4:90316:1#10:17084:150#8:1:500000",
		{
			5,
			6
		},
		"eternaldragon/board_zhongshu_11"
	},
	{
		295001,
		4,
		270,
		"大树",
		"4:30006:20#10:17084:200#8:1:500000",
		{
			7,
			8
		},
		"eternaldragon/board_zhongshu_12"
	},
	{
		295001,
		5,
		450,
		"花苞",
		"4:30006:30#10:17084:200#8:1:500000",
		{
			9,
			10
		},
		"eternaldragon/board_zhongshu_13"
	},
	{
		295001,
		6,
		650,
		"结果",
		"4:90316:1#10:17084:200#8:1:500000",
		{
			11,
			12
		},
		"eternaldragon/board_zhongshu_14"
	},
	{
		295002,
		1,
		0,
		"幼年",
		"4:31:10#8:1:750000#60:1:375",
		{
			13,
			14
		},
		"eternaldragon/board_jiyisuipian_04"
	},
	{
		295002,
		2,
		50,
		"童年",
		"4:31:10#8:1:750000#60:1:375",
		{
			15,
			16
		},
		"eternaldragon/board_jiyisuipian_05"
	},
	{
		295002,
		3,
		250,
		"少年",
		"4:31:10#8:1:750000#60:1:375",
		{
			17,
			18
		},
		"eternaldragon/board_jiyisuipian_06"
	},
	{
		295002,
		4,
		600,
		"青年",
		"4:31:10#8:1:750000#60:1:375",
		{
			19,
			20
		},
		"eternaldragon/board_jiyisuipian_07"
	},
	{
		295003,
		1,
		0,
		"混沌",
		"60:1:500#8:1:500000",
		{
			21,
			22
		},
		"eternaldragon/board_wuwensuipian_02"
	},
	{
		295003,
		2,
		50,
		"降生",
		"60:1:1000#8:1:500000",
		{
			23,
			24
		},
		"eternaldragon/board_wuwensuipian_03"
	},
	{
		295003,
		3,
		250,
		"出世",
		"60:1:1500#8:1:500000#4:90312:1",
		{
			25,
			26
		},
		"eternaldragon/board_wuwensuipian_04"
	},
	{
		295003,
		4,
		600,
		"入世",
		"60:1:2000#8:1:500000#4:90312:1",
		{
			27,
			28
		},
		"eternaldragon/board_wuwensuipian_05"
	},
	{
		295004,
		1,
		0,
		"魔界",
		"4:31:5#8:1:1250000",
		{
			29,
			30
		},
		"eternaldragon/board_sidamojun_02"
	},
	{
		295004,
		2,
		50,
		"战争魔君",
		"4:31:5#8:1:1250000",
		{
			31,
			32
		},
		"eternaldragon/board_sidamojun_03"
	},
	{
		295004,
		3,
		250,
		"死亡魔君",
		"4:31:5#8:1:1250000",
		{
			33,
			34
		},
		"eternaldragon/board_sidamojun_04"
	},
	{
		295004,
		4,
		600,
		"瘟疫魔君",
		"4:31:5#8:1:1250000",
		{
			35,
			36
		},
		"eternaldragon/board_sidamojun_05"
	}
}
local t_eternal_dragon_score = {
	[295001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[295002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[295003] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	},
	[295004] = {
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_eternal_dragon_score.dataList = dataList

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

return t_eternal_dragon_score
