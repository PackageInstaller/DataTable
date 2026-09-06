-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mirror_trial_prize_plan.lua

module("logicconfig.config.t_mirror_trial_prize_plan", package.seeall)

local title = {
	score = 2,
	prize = 3,
	planId = 1,
	rechargePrize = 4
}
local dataList = {
	{
		1,
		0,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		10,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		20,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		30,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		40,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		50,
		"104:2:50",
		"4:36:5"
	},
	{
		1,
		60,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		70,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		80,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		90,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		100,
		"104:2:50",
		"104:2:200"
	},
	{
		1,
		110,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		120,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		130,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		140,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		150,
		"104:2:50",
		"4:36:5"
	},
	{
		1,
		160,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		170,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		180,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		190,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		200,
		"104:2:50",
		"104:2:200"
	},
	{
		1,
		210,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		220,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		230,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		240,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		250,
		"104:2:50",
		"4:36:5"
	},
	{
		1,
		260,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		270,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		280,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		290,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		300,
		"104:2:50",
		"104:2:200"
	},
	{
		1,
		310,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		320,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		330,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		340,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		350,
		"104:2:50",
		"4:36:5"
	},
	{
		1,
		360,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		370,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		380,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		390,
		"4:30002:5",
		"104:2:50"
	},
	{
		1,
		400,
		"104:2:50",
		"104:2:200"
	}
}
local t_mirror_trial_prize_plan = {
	{
		[0] = dataList[1],
		[10] = dataList[2],
		[20] = dataList[3],
		[30] = dataList[4],
		[40] = dataList[5],
		[50] = dataList[6],
		[60] = dataList[7],
		[70] = dataList[8],
		[80] = dataList[9],
		[90] = dataList[10],
		[100] = dataList[11],
		[110] = dataList[12],
		[120] = dataList[13],
		[130] = dataList[14],
		[140] = dataList[15],
		[150] = dataList[16],
		[160] = dataList[17],
		[170] = dataList[18],
		[180] = dataList[19],
		[190] = dataList[20],
		[200] = dataList[21],
		[210] = dataList[22],
		[220] = dataList[23],
		[230] = dataList[24],
		[240] = dataList[25],
		[250] = dataList[26],
		[260] = dataList[27],
		[270] = dataList[28],
		[280] = dataList[29],
		[290] = dataList[30],
		[300] = dataList[31],
		[310] = dataList[32],
		[320] = dataList[33],
		[330] = dataList[34],
		[340] = dataList[35],
		[350] = dataList[36],
		[360] = dataList[37],
		[370] = dataList[38],
		[380] = dataList[39],
		[390] = dataList[40],
		[400] = dataList[41]
	}
}

t_mirror_trial_prize_plan.dataList = dataList

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

return t_mirror_trial_prize_plan
