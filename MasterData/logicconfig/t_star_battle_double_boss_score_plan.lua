-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_battle_double_boss_score_plan.lua

module("logicconfig.config.t_star_battle_double_boss_score_plan", package.seeall)

local title = {
	score = 4,
	scoreId = 2,
	differenceDamage = 3,
	doubleBossScorePlanId = 1
}
local dataList = {
	{
		1,
		1,
		10000,
		1000
	},
	{
		1,
		2,
		12000,
		990
	},
	{
		1,
		3,
		14000,
		980
	},
	{
		1,
		4,
		16000,
		970
	},
	{
		1,
		5,
		18000,
		960
	},
	{
		1,
		6,
		20000,
		950
	},
	{
		1,
		7,
		22000,
		940
	},
	{
		1,
		8,
		24000,
		930
	},
	{
		1,
		9,
		26000,
		920
	},
	{
		1,
		10,
		28000,
		910
	},
	{
		1,
		11,
		30000,
		900
	},
	{
		1,
		12,
		32000,
		890
	},
	{
		1,
		13,
		34000,
		880
	},
	{
		1,
		14,
		36000,
		870
	},
	{
		1,
		15,
		38000,
		860
	},
	{
		1,
		16,
		40000,
		850
	},
	{
		1,
		17,
		42000,
		840
	},
	{
		1,
		18,
		44000,
		830
	},
	{
		1,
		19,
		46000,
		820
	},
	{
		1,
		20,
		48000,
		810
	},
	{
		1,
		21,
		50000,
		800
	},
	{
		1,
		22,
		62500,
		750
	},
	{
		1,
		23,
		75000,
		700
	},
	{
		1,
		24,
		87500,
		650
	},
	{
		1,
		25,
		100000,
		600
	},
	{
		1,
		26,
		200000,
		500
	},
	{
		1,
		27,
		300000,
		400
	},
	{
		1,
		28,
		400000,
		300
	},
	{
		1,
		29,
		500000,
		200
	},
	{
		1,
		30,
		800000,
		100
	},
	{
		1,
		31,
		1000000,
		50
	}
}
local t_star_battle_double_boss_score_plan = {
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
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30],
		dataList[31]
	}
}

t_star_battle_double_boss_score_plan.dataList = dataList

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

return t_star_battle_double_boss_score_plan
