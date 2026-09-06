-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xieyi_item_popup.lua

module("logicconfig.config.t_xieyi_item_popup", package.seeall)

local title = {
	id = 1,
	isPopup = 2
}
local dataList = {
	{
		1,
		1
	},
	{
		2,
		1
	},
	{
		3,
		1
	},
	{
		4,
		1
	},
	{
		5,
		1
	},
	{
		6,
		1
	},
	{
		7,
		0
	},
	{
		9,
		1
	},
	{
		11,
		1
	},
	{
		12,
		1
	},
	{
		13,
		0
	},
	{
		14,
		1
	},
	{
		15,
		1
	},
	{
		16,
		1
	},
	{
		17,
		1
	},
	{
		18,
		1
	},
	{
		20,
		0
	},
	{
		22,
		1
	},
	{
		23,
		1
	},
	{
		24,
		0
	},
	{
		25,
		0
	},
	{
		26,
		1
	},
	{
		27,
		1
	},
	{
		29,
		0
	},
	{
		30,
		0
	},
	{
		31,
		1
	},
	{
		32,
		0
	},
	{
		34,
		1
	},
	{
		35,
		1
	},
	{
		36,
		1
	},
	{
		37,
		1
	},
	{
		40,
		0
	},
	{
		41,
		1
	},
	{
		42,
		1
	},
	{
		43,
		0
	},
	{
		44,
		1
	},
	{
		45,
		1
	},
	{
		46,
		1
	},
	{
		47,
		0
	},
	{
		50,
		0
	},
	{
		51,
		0
	},
	{
		52,
		0
	},
	{
		53,
		0
	},
	{
		54,
		0
	},
	{
		55,
		1
	},
	{
		56,
		0
	},
	{
		58,
		1
	},
	{
		59,
		1
	},
	{
		60,
		0
	},
	{
		61,
		1
	},
	{
		62,
		1
	},
	{
		63,
		1
	},
	{
		65,
		0
	},
	{
		66,
		1
	},
	{
		67,
		0
	},
	{
		68,
		0
	},
	{
		69,
		0
	},
	{
		70,
		1
	},
	{
		71,
		0
	},
	{
		72,
		0
	},
	{
		73,
		0
	},
	{
		74,
		0
	},
	{
		76,
		1
	},
	{
		77,
		1
	},
	{
		78,
		0
	},
	{
		79,
		1
	},
	{
		80,
		1
	},
	{
		81,
		1
	},
	{
		82,
		0
	},
	{
		83,
		0
	},
	{
		84,
		0
	},
	{
		85,
		0
	},
	{
		87,
		0
	},
	{
		88,
		0
	},
	{
		93,
		0
	},
	{
		94,
		0
	},
	{
		95,
		0
	},
	{
		96,
		0
	},
	{
		126,
		1
	},
	{
		178,
		1
	},
	{
		254,
		1
	},
	{
		463,
		1
	},
	{
		542,
		1
	}
}
local t_xieyi_item_popup = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	[9] = dataList[8],
	[11] = dataList[9],
	[12] = dataList[10],
	[13] = dataList[11],
	[14] = dataList[12],
	[15] = dataList[13],
	[16] = dataList[14],
	[17] = dataList[15],
	[18] = dataList[16],
	[20] = dataList[17],
	[22] = dataList[18],
	[23] = dataList[19],
	[24] = dataList[20],
	[25] = dataList[21],
	[26] = dataList[22],
	[27] = dataList[23],
	[29] = dataList[24],
	[30] = dataList[25],
	[31] = dataList[26],
	[32] = dataList[27],
	[34] = dataList[28],
	[35] = dataList[29],
	[36] = dataList[30],
	[37] = dataList[31],
	[40] = dataList[32],
	[41] = dataList[33],
	[42] = dataList[34],
	[43] = dataList[35],
	[44] = dataList[36],
	[45] = dataList[37],
	[46] = dataList[38],
	[47] = dataList[39],
	[50] = dataList[40],
	[51] = dataList[41],
	[52] = dataList[42],
	[53] = dataList[43],
	[54] = dataList[44],
	[55] = dataList[45],
	[56] = dataList[46],
	[58] = dataList[47],
	[59] = dataList[48],
	[60] = dataList[49],
	[61] = dataList[50],
	[62] = dataList[51],
	[63] = dataList[52],
	[65] = dataList[53],
	[66] = dataList[54],
	[67] = dataList[55],
	[68] = dataList[56],
	[69] = dataList[57],
	[70] = dataList[58],
	[71] = dataList[59],
	[72] = dataList[60],
	[73] = dataList[61],
	[74] = dataList[62],
	[76] = dataList[63],
	[77] = dataList[64],
	[78] = dataList[65],
	[79] = dataList[66],
	[80] = dataList[67],
	[81] = dataList[68],
	[82] = dataList[69],
	[83] = dataList[70],
	[84] = dataList[71],
	[85] = dataList[72],
	[87] = dataList[73],
	[88] = dataList[74],
	[93] = dataList[75],
	[94] = dataList[76],
	[95] = dataList[77],
	[96] = dataList[78],
	[126] = dataList[79],
	[178] = dataList[80],
	[254] = dataList[81],
	[463] = dataList[82],
	[542] = dataList[83]
}

t_xieyi_item_popup.dataList = dataList

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

return t_xieyi_item_popup
