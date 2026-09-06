-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_script_killing_formula.lua

module("logicconfig.config.t_script_killing_formula", package.seeall)

local title = {
	triggerId = 3,
	activityId = 1,
	clueId = 2
}
local dataList = {
	{
		365001,
		10,
		7
	},
	{
		365001,
		11,
		8
	},
	{
		365001,
		12,
		9
	},
	{
		365001,
		13,
		10
	},
	{
		365001,
		14,
		11
	},
	{
		365001,
		22,
		0
	},
	{
		365001,
		23,
		0
	},
	{
		365001,
		24,
		1
	},
	{
		365001,
		25,
		2
	},
	{
		365001,
		31,
		3
	},
	{
		365001,
		32,
		4
	},
	{
		365001,
		33,
		5
	},
	{
		365001,
		34,
		6
	},
	{
		365001,
		39,
		0
	},
	{
		365001,
		40,
		12
	},
	{
		365001,
		41,
		13
	},
	{
		365001,
		42,
		0
	},
	{
		365001,
		43,
		0
	},
	{
		365001,
		51,
		14
	},
	{
		365001,
		52,
		15
	},
	{
		365001,
		53,
		16
	},
	{
		365001,
		54,
		0
	},
	{
		365001,
		55,
		0
	},
	{
		365001,
		56,
		17
	},
	{
		365001,
		57,
		18
	},
	{
		365001,
		58,
		0
	},
	{
		365001,
		65,
		0
	},
	{
		365001,
		66,
		0
	},
	{
		365001,
		67,
		0
	},
	{
		365001,
		68,
		0
	},
	{
		365001,
		72,
		19
	},
	{
		365001,
		73,
		20
	},
	{
		365001,
		74,
		21
	},
	{
		365001,
		75,
		22
	},
	{
		365001,
		76,
		23
	},
	{
		365001,
		70,
		0
	},
	{
		365001,
		71,
		0
	},
	{
		365001,
		83,
		0
	},
	{
		365001,
		84,
		0
	},
	{
		365001,
		85,
		24
	},
	{
		365001,
		86,
		0
	},
	{
		365001,
		89,
		0
	},
	{
		365001,
		95,
		0
	},
	{
		365001,
		97,
		0
	},
	{
		365001,
		98,
		0
	},
	{
		365001,
		105,
		0
	},
	{
		365001,
		106,
		0
	},
	{
		365001,
		113,
		0
	},
	{
		365001,
		114,
		0
	},
	{
		365001,
		115,
		0
	},
	{
		365001,
		116,
		0
	},
	{
		365001,
		117,
		0
	},
	{
		365001,
		122,
		0
	},
	{
		365001,
		128,
		0
	},
	{
		365001,
		131,
		0
	},
	{
		365001,
		137,
		0
	},
	{
		365002,
		9,
		0
	},
	{
		365002,
		10,
		0
	},
	{
		365002,
		11,
		0
	},
	{
		365002,
		12,
		0
	},
	{
		365002,
		13,
		0
	},
	{
		365002,
		14,
		0
	},
	{
		365002,
		15,
		0
	},
	{
		365003,
		15,
		0
	},
	{
		365003,
		16,
		0
	},
	{
		365003,
		17,
		0
	},
	{
		365003,
		18,
		0
	},
	{
		365003,
		19,
		0
	},
	{
		365003,
		20,
		0
	},
	{
		365003,
		21,
		0
	},
	{
		365003,
		22,
		5
	},
	{
		365003,
		23,
		1
	},
	{
		365003,
		24,
		3
	},
	{
		365003,
		25,
		2
	},
	{
		365003,
		26,
		6
	},
	{
		365003,
		27,
		4
	},
	{
		365003,
		28,
		7
	},
	{
		365003,
		29,
		0
	},
	{
		365003,
		30,
		0
	},
	{
		365003,
		31,
		0
	},
	{
		365003,
		46,
		8
	},
	{
		365003,
		47,
		0
	},
	{
		365003,
		48,
		0
	},
	{
		365003,
		49,
		0
	},
	{
		365003,
		50,
		0
	},
	{
		365003,
		51,
		0
	},
	{
		365003,
		52,
		14
	},
	{
		365003,
		53,
		9
	},
	{
		365003,
		54,
		10
	},
	{
		365003,
		55,
		11
	},
	{
		365003,
		56,
		12
	},
	{
		365003,
		57,
		13
	},
	{
		365003,
		58,
		0
	},
	{
		365003,
		59,
		0
	},
	{
		365003,
		74,
		15
	},
	{
		365003,
		75,
		16
	},
	{
		365003,
		76,
		17
	},
	{
		365003,
		77,
		18
	},
	{
		365003,
		78,
		19
	},
	{
		365003,
		79,
		0
	},
	{
		365003,
		80,
		0
	},
	{
		365003,
		81,
		0
	},
	{
		365003,
		82,
		0
	},
	{
		365003,
		83,
		20
	},
	{
		365003,
		84,
		21
	},
	{
		365003,
		85,
		0
	},
	{
		365003,
		86,
		0
	},
	{
		365003,
		87,
		0
	},
	{
		365003,
		88,
		0
	}
}
local t_script_killing_formula = {
	[365001] = {
		[10] = dataList[1],
		[11] = dataList[2],
		[12] = dataList[3],
		[13] = dataList[4],
		[14] = dataList[5],
		[22] = dataList[6],
		[23] = dataList[7],
		[24] = dataList[8],
		[25] = dataList[9],
		[31] = dataList[10],
		[32] = dataList[11],
		[33] = dataList[12],
		[34] = dataList[13],
		[39] = dataList[14],
		[40] = dataList[15],
		[41] = dataList[16],
		[42] = dataList[17],
		[43] = dataList[18],
		[51] = dataList[19],
		[52] = dataList[20],
		[53] = dataList[21],
		[54] = dataList[22],
		[55] = dataList[23],
		[56] = dataList[24],
		[57] = dataList[25],
		[58] = dataList[26],
		[65] = dataList[27],
		[66] = dataList[28],
		[67] = dataList[29],
		[68] = dataList[30],
		[72] = dataList[31],
		[73] = dataList[32],
		[74] = dataList[33],
		[75] = dataList[34],
		[76] = dataList[35],
		[70] = dataList[36],
		[71] = dataList[37],
		[83] = dataList[38],
		[84] = dataList[39],
		[85] = dataList[40],
		[86] = dataList[41],
		[89] = dataList[42],
		[95] = dataList[43],
		[97] = dataList[44],
		[98] = dataList[45],
		[105] = dataList[46],
		[106] = dataList[47],
		[113] = dataList[48],
		[114] = dataList[49],
		[115] = dataList[50],
		[116] = dataList[51],
		[117] = dataList[52],
		[122] = dataList[53],
		[128] = dataList[54],
		[131] = dataList[55],
		[137] = dataList[56]
	},
	[365002] = {
		[9] = dataList[57],
		[10] = dataList[58],
		[11] = dataList[59],
		[12] = dataList[60],
		[13] = dataList[61],
		[14] = dataList[62],
		[15] = dataList[63]
	},
	[365003] = {
		[15] = dataList[64],
		[16] = dataList[65],
		[17] = dataList[66],
		[18] = dataList[67],
		[19] = dataList[68],
		[20] = dataList[69],
		[21] = dataList[70],
		[22] = dataList[71],
		[23] = dataList[72],
		[24] = dataList[73],
		[25] = dataList[74],
		[26] = dataList[75],
		[27] = dataList[76],
		[28] = dataList[77],
		[29] = dataList[78],
		[30] = dataList[79],
		[31] = dataList[80],
		[46] = dataList[81],
		[47] = dataList[82],
		[48] = dataList[83],
		[49] = dataList[84],
		[50] = dataList[85],
		[51] = dataList[86],
		[52] = dataList[87],
		[53] = dataList[88],
		[54] = dataList[89],
		[55] = dataList[90],
		[56] = dataList[91],
		[57] = dataList[92],
		[58] = dataList[93],
		[59] = dataList[94],
		[74] = dataList[95],
		[75] = dataList[96],
		[76] = dataList[97],
		[77] = dataList[98],
		[78] = dataList[99],
		[79] = dataList[100],
		[80] = dataList[101],
		[81] = dataList[102],
		[82] = dataList[103],
		[83] = dataList[104],
		[84] = dataList[105],
		[85] = dataList[106],
		[86] = dataList[107],
		[87] = dataList[108],
		[88] = dataList[109]
	}
}

t_script_killing_formula.dataList = dataList

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

return t_script_killing_formula
