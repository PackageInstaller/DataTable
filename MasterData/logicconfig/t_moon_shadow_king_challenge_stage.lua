-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_moon_shadow_king_challenge_stage.lua

module("logicconfig.config.t_moon_shadow_king_challenge_stage", package.seeall)

local title = {
	stagePlanId = 1,
	stageId = 2,
	score = 5,
	stageName = 6,
	creepsMasterId = 4,
	stageDes = 7,
	difficultyPlanId = 3
}
local dataList = {
	{
		1,
		1,
		1,
		10101,
		100,
		"挑战 I",
		"潜龙勿用"
	},
	{
		1,
		2,
		2,
		10102,
		100,
		"挑战 II",
		"潜龙勿用"
	},
	{
		1,
		3,
		3,
		10103,
		100,
		"挑战 III",
		"潜龙勿用"
	},
	{
		1,
		4,
		4,
		10104,
		100,
		"挑战 IV",
		"潜龙勿用"
	},
	{
		1,
		5,
		5,
		10105,
		100,
		"挑战V",
		"潜龙勿用"
	},
	{
		2,
		1,
		1,
		10201,
		100,
		"挑战 I",
		"见龙在田"
	},
	{
		2,
		2,
		2,
		10202,
		100,
		"挑战 II",
		"终日乾乾"
	},
	{
		2,
		3,
		3,
		10203,
		100,
		"挑战 III",
		"终日乾乾"
	},
	{
		2,
		4,
		6,
		10204,
		100,
		"挑战 IV",
		"终日乾乾"
	},
	{
		2,
		5,
		7,
		10205,
		100,
		"挑战V",
		"终日乾乾"
	},
	{
		3,
		1,
		1,
		10301,
		100,
		"挑战 I",
		"或跃在渊"
	},
	{
		3,
		2,
		2,
		10302,
		100,
		"挑战 II",
		"或跃在渊"
	},
	{
		3,
		3,
		3,
		10303,
		100,
		"挑战 III",
		"或跃在渊"
	},
	{
		3,
		4,
		8,
		10304,
		100,
		"挑战 IV",
		"或跃在渊"
	},
	{
		3,
		5,
		9,
		10305,
		100,
		"挑战V",
		"或跃在渊"
	},
	{
		4,
		1,
		1,
		10401,
		100,
		"挑战 I",
		"见群龙无首"
	},
	{
		4,
		2,
		2,
		10402,
		100,
		"挑战 II",
		"见群龙无首"
	},
	{
		4,
		3,
		3,
		10403,
		100,
		"挑战 III",
		"见群龙无首"
	},
	{
		4,
		4,
		10,
		10404,
		100,
		"挑战 IV",
		"见群龙无首"
	},
	{
		4,
		5,
		11,
		10405,
		100,
		"挑战V",
		"见群龙无首"
	},
	{
		5,
		1,
		12,
		20101,
		2100,
		"炎天疾速- I",
		"炎天疾速"
	},
	{
		5,
		2,
		13,
		20102,
		2200,
		"炎天疾速- II",
		"炎天疾速"
	},
	{
		5,
		3,
		14,
		20103,
		2300,
		"炎天疾速- III",
		"炎天疾速"
	},
	{
		5,
		4,
		15,
		20104,
		2400,
		"炎天疾速- IV",
		"炎天疾速"
	},
	{
		5,
		5,
		16,
		20105,
		2500,
		"炎天疾速-V",
		"炎天疾速"
	},
	{
		6,
		1,
		12,
		20201,
		2100,
		"炎轮金石- I",
		"炎轮金石"
	},
	{
		6,
		2,
		13,
		20202,
		2200,
		"炎轮金石- II",
		"炎轮金石"
	},
	{
		6,
		3,
		14,
		20203,
		2300,
		"炎轮金石- III",
		"炎轮金石"
	},
	{
		6,
		4,
		15,
		20204,
		2400,
		"炎轮金石- IV",
		"炎轮金石"
	},
	{
		6,
		5,
		16,
		20205,
		2500,
		"炎轮金石-V",
		"炎轮金石"
	},
	{
		7,
		1,
		12,
		20301,
		2100,
		"赤火威鸣- I",
		"赤火威鸣"
	},
	{
		7,
		2,
		13,
		20302,
		2200,
		"赤火威鸣- II",
		"赤火威鸣"
	},
	{
		7,
		3,
		14,
		20303,
		2300,
		"赤火威鸣- III",
		"赤火威鸣"
	},
	{
		7,
		4,
		15,
		20304,
		2400,
		"赤火威鸣- IV",
		"赤火威鸣"
	},
	{
		7,
		5,
		16,
		20305,
		2500,
		"赤火威鸣-V",
		"赤火威鸣"
	},
	{
		8,
		1,
		12,
		20401,
		2100,
		"炎罗怒击- I",
		"炎罗怒击"
	},
	{
		8,
		2,
		13,
		20402,
		2200,
		"炎罗怒击- II",
		"炎罗怒击"
	},
	{
		8,
		3,
		14,
		20403,
		2300,
		"炎罗怒击- III",
		"炎罗怒击"
	},
	{
		8,
		4,
		15,
		20404,
		2400,
		"炎罗怒击- IV",
		"炎罗怒击"
	},
	{
		8,
		5,
		16,
		20405,
		2500,
		"炎罗怒击-V",
		"炎罗怒击"
	},
	{
		9,
		1,
		12,
		20501,
		2100,
		"炎踪之歌- I",
		"炎踪之歌"
	},
	{
		9,
		2,
		13,
		20502,
		2200,
		"炎踪之歌- II",
		"炎踪之歌"
	},
	{
		9,
		3,
		14,
		20503,
		2300,
		"炎踪之歌- III",
		"炎踪之歌"
	},
	{
		9,
		4,
		15,
		20504,
		2400,
		"炎踪之歌- IV",
		"炎踪之歌"
	},
	{
		9,
		5,
		16,
		20505,
		2500,
		"炎踪之歌-V",
		"炎踪之歌"
	},
	{
		10,
		1,
		12,
		30101,
		100,
		"挑战 I",
		"挑战 I"
	},
	{
		10,
		2,
		13,
		30102,
		200,
		"挑战 II",
		"挑战 II"
	},
	{
		10,
		3,
		14,
		30103,
		300,
		"挑战 III",
		"挑战 III"
	},
	{
		10,
		4,
		15,
		30104,
		400,
		"挑战 IV",
		"挑战 IV"
	},
	{
		10,
		5,
		17,
		30105,
		500,
		"挑战V",
		"挑战V"
	},
	{
		11,
		1,
		12,
		30201,
		100,
		"挑战 I",
		"挑战 I"
	},
	{
		11,
		2,
		13,
		30202,
		200,
		"挑战 II",
		"挑战 II"
	},
	{
		11,
		3,
		14,
		30203,
		300,
		"挑战 III",
		"挑战 III"
	},
	{
		11,
		4,
		15,
		30204,
		400,
		"挑战 IV",
		"挑战 IV"
	},
	{
		11,
		5,
		17,
		30205,
		500,
		"挑战V",
		"挑战V"
	},
	{
		12,
		1,
		12,
		30301,
		100,
		"挑战 I",
		"挑战 I"
	},
	{
		12,
		2,
		13,
		30302,
		200,
		"挑战 II",
		"挑战 II"
	},
	{
		12,
		3,
		14,
		30303,
		300,
		"挑战 III",
		"挑战 III"
	},
	{
		12,
		4,
		15,
		30304,
		400,
		"挑战 IV",
		"挑战 IV"
	},
	{
		12,
		5,
		17,
		30305,
		500,
		"挑战V",
		"挑战V"
	},
	{
		13,
		1,
		12,
		30401,
		100,
		"挑战 I",
		"挑战 I"
	},
	{
		13,
		2,
		13,
		30402,
		200,
		"挑战 II",
		"挑战 II"
	},
	{
		13,
		3,
		14,
		30403,
		300,
		"挑战 III",
		"挑战 III"
	},
	{
		13,
		4,
		15,
		30404,
		400,
		"挑战 IV",
		"挑战 IV"
	},
	{
		13,
		5,
		17,
		30405,
		500,
		"挑战V",
		"挑战V"
	},
	{
		14,
		1,
		12,
		30501,
		100,
		"挑战 I",
		"挑战 I"
	},
	{
		14,
		2,
		13,
		30502,
		200,
		"挑战 II",
		"挑战 II"
	},
	{
		14,
		3,
		14,
		30503,
		300,
		"挑战 III",
		"挑战 III"
	},
	{
		14,
		4,
		15,
		30504,
		400,
		"挑战 IV",
		"挑战 IV"
	},
	{
		14,
		5,
		17,
		30505,
		500,
		"挑战V",
		"挑战V"
	},
	{
		15,
		1,
		18,
		40101,
		400,
		"挑战 I",
		"挑战 I"
	},
	{
		15,
		2,
		19,
		40102,
		800,
		"挑战 II",
		"挑战 II"
	},
	{
		15,
		3,
		20,
		40103,
		1200,
		"挑战 III",
		"挑战 III"
	},
	{
		15,
		4,
		21,
		40104,
		1600,
		"挑战 IV",
		"挑战 IV"
	},
	{
		15,
		5,
		22,
		40105,
		2000,
		"挑战V",
		"挑战V"
	},
	{
		16,
		1,
		18,
		40201,
		400,
		"挑战 I",
		"挑战 I"
	},
	{
		16,
		2,
		19,
		40202,
		800,
		"挑战 II",
		"挑战 II"
	},
	{
		16,
		3,
		20,
		40203,
		1200,
		"挑战 III",
		"挑战 III"
	},
	{
		16,
		4,
		21,
		40204,
		1600,
		"挑战 IV",
		"挑战 IV"
	},
	{
		16,
		5,
		22,
		40205,
		2000,
		"挑战V",
		"挑战V"
	},
	{
		17,
		1,
		18,
		40301,
		400,
		"挑战 I",
		"挑战 I"
	},
	{
		17,
		2,
		19,
		40302,
		800,
		"挑战 II",
		"挑战 II"
	},
	{
		17,
		3,
		20,
		40303,
		1200,
		"挑战 III",
		"挑战 III"
	},
	{
		17,
		4,
		21,
		40304,
		1600,
		"挑战 IV",
		"挑战 IV"
	},
	{
		17,
		5,
		22,
		40305,
		2000,
		"挑战V",
		"挑战V"
	},
	{
		18,
		1,
		18,
		40401,
		400,
		"挑战 I",
		"挑战 I"
	},
	{
		18,
		2,
		19,
		40402,
		800,
		"挑战 II",
		"挑战 II"
	},
	{
		18,
		3,
		20,
		40403,
		1200,
		"挑战 III",
		"挑战 III"
	},
	{
		18,
		4,
		21,
		40404,
		1600,
		"挑战 IV",
		"挑战 IV"
	},
	{
		18,
		5,
		22,
		40405,
		2000,
		"挑战V",
		"挑战V"
	}
}
local t_moon_shadow_king_challenge_stage = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
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
		dataList[20]
	},
	{
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25]
	},
	{
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30]
	},
	{
		dataList[31],
		dataList[32],
		dataList[33],
		dataList[34],
		dataList[35]
	},
	{
		dataList[36],
		dataList[37],
		dataList[38],
		dataList[39],
		dataList[40]
	},
	{
		dataList[41],
		dataList[42],
		dataList[43],
		dataList[44],
		dataList[45]
	},
	{
		dataList[46],
		dataList[47],
		dataList[48],
		dataList[49],
		dataList[50]
	},
	{
		dataList[51],
		dataList[52],
		dataList[53],
		dataList[54],
		dataList[55]
	},
	{
		dataList[56],
		dataList[57],
		dataList[58],
		dataList[59],
		dataList[60]
	},
	{
		dataList[61],
		dataList[62],
		dataList[63],
		dataList[64],
		dataList[65]
	},
	{
		dataList[66],
		dataList[67],
		dataList[68],
		dataList[69],
		dataList[70]
	},
	{
		dataList[71],
		dataList[72],
		dataList[73],
		dataList[74],
		dataList[75]
	},
	{
		dataList[76],
		dataList[77],
		dataList[78],
		dataList[79],
		dataList[80]
	},
	{
		dataList[81],
		dataList[82],
		dataList[83],
		dataList[84],
		dataList[85]
	},
	{
		dataList[86],
		dataList[87],
		dataList[88],
		dataList[89],
		dataList[90]
	}
}

t_moon_shadow_king_challenge_stage.dataList = dataList

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

return t_moon_shadow_king_challenge_stage
