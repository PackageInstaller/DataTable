-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_maintain_power_pillar_boss.lua

module("logicconfig.config.t_maintain_power_pillar_boss", package.seeall)

local title = {
	eventId = 1,
	scale = 6,
	spinePath = 4,
	creepsMasterId = 2,
	bossName = 3,
	headPath = 5
}
local dataList = {
	{
		8101,
		100301,
		"第一关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8102,
		100302,
		"第二关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8103,
		100303,
		"第三关",
		"0303_eling01",
		"board_dafuweng_10",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8104,
		100304,
		"第四关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8105,
		100305,
		"第五关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8106,
		100306,
		"第六关",
		"0303_eling01",
		"board_dafuweng_10",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8107,
		100307,
		"第七关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8108,
		100308,
		"第八关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8109,
		100309,
		"第九关",
		"0303_eling01",
		"board_dafuweng_10",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8110,
		100310,
		"第十关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8111,
		100311,
		"第十一关",
		"0303_eling01",
		"board_dafuweng_10",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8112,
		100312,
		"第十二关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8113,
		100313,
		"第十三关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8114,
		100314,
		"第十四关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8115,
		100315,
		"第十五关",
		"0303_eling02",
		"board_dafuweng_11",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8401,
		200301,
		"第一关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8402,
		200302,
		"第二关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8403,
		200303,
		"第三关",
		"0303_eling01",
		"board_dafuweng_10",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8404,
		200304,
		"第四关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8405,
		200305,
		"第五关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8406,
		200306,
		"第六关",
		"0303_eling01",
		"board_dafuweng_10",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8407,
		200307,
		"第七关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8408,
		200308,
		"第八关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8409,
		200309,
		"第九关",
		"0303_eling01",
		"board_dafuweng_10",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8410,
		200310,
		"第十关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8411,
		200311,
		"第十一关",
		"0303_eling01",
		"board_dafuweng_10",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8412,
		200312,
		"第十二关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8413,
		200313,
		"第十三关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8414,
		200314,
		"第十四关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8415,
		200315,
		"第十五关",
		"0303_eling02",
		"board_dafuweng_11",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8501,
		300301,
		"第一关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8502,
		300302,
		"第二关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8503,
		300303,
		"第三关",
		"0303_eling01",
		"board_dafuweng_10",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8504,
		300304,
		"第四关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8505,
		300305,
		"第五关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8506,
		300306,
		"第六关",
		"0303_eling01",
		"board_dafuweng_10",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8507,
		300307,
		"第七关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8508,
		300308,
		"第八关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8509,
		300309,
		"第九关",
		"0303_eling01",
		"board_dafuweng_10",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8510,
		300310,
		"第十关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8511,
		300311,
		"第十一关",
		"0303_eling01",
		"board_dafuweng_10",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8512,
		300312,
		"第十二关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8513,
		300313,
		"第十三关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8514,
		300314,
		"第十四关",
		"0303_eling",
		"board_dafuweng_09",
		{
			0,
			-50,
			0.05
		}
	},
	{
		8515,
		300315,
		"第十五关",
		"0303_eling02",
		"board_dafuweng_11",
		{
			0,
			-50,
			0.05
		}
	}
}
local t_maintain_power_pillar_boss = {
	[8101] = dataList[1],
	[8102] = dataList[2],
	[8103] = dataList[3],
	[8104] = dataList[4],
	[8105] = dataList[5],
	[8106] = dataList[6],
	[8107] = dataList[7],
	[8108] = dataList[8],
	[8109] = dataList[9],
	[8110] = dataList[10],
	[8111] = dataList[11],
	[8112] = dataList[12],
	[8113] = dataList[13],
	[8114] = dataList[14],
	[8115] = dataList[15],
	[8401] = dataList[16],
	[8402] = dataList[17],
	[8403] = dataList[18],
	[8404] = dataList[19],
	[8405] = dataList[20],
	[8406] = dataList[21],
	[8407] = dataList[22],
	[8408] = dataList[23],
	[8409] = dataList[24],
	[8410] = dataList[25],
	[8411] = dataList[26],
	[8412] = dataList[27],
	[8413] = dataList[28],
	[8414] = dataList[29],
	[8415] = dataList[30],
	[8501] = dataList[31],
	[8502] = dataList[32],
	[8503] = dataList[33],
	[8504] = dataList[34],
	[8505] = dataList[35],
	[8506] = dataList[36],
	[8507] = dataList[37],
	[8508] = dataList[38],
	[8509] = dataList[39],
	[8510] = dataList[40],
	[8511] = dataList[41],
	[8512] = dataList[42],
	[8513] = dataList[43],
	[8514] = dataList[44],
	[8515] = dataList[45]
}

t_maintain_power_pillar_boss.dataList = dataList

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

return t_maintain_power_pillar_boss
