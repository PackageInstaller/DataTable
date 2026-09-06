-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_five_year_recap_data_ids.lua

module("logicconfig.config.t_five_year_recap_data_ids", package.seeall)

local title = {
	id = 1,
	handleType = 2,
	params = 3
}
local dataList = {
	{
		1,
		"Client",
		""
	},
	{
		2,
		"",
		""
	},
	{
		3,
		"",
		""
	},
	{
		4,
		"",
		""
	},
	{
		5,
		"",
		""
	},
	{
		6,
		"Mat",
		"8:1"
	},
	{
		7,
		"",
		""
	},
	{
		8,
		"",
		""
	},
	{
		9,
		"Client",
		""
	},
	{
		10,
		"",
		""
	},
	{
		11,
		"",
		""
	},
	{
		12,
		"",
		""
	},
	{
		13,
		"Client",
		""
	},
	{
		14,
		"Client",
		""
	},
	{
		15,
		"",
		""
	},
	{
		16,
		"",
		""
	},
	{
		17,
		"",
		""
	},
	{
		18,
		"",
		""
	},
	{
		19,
		"",
		""
	},
	{
		21,
		"",
		""
	},
	{
		22,
		"",
		""
	},
	{
		23,
		"",
		""
	},
	{
		24,
		"",
		""
	},
	{
		25,
		"",
		""
	},
	{
		26,
		"",
		""
	},
	{
		27,
		"",
		""
	},
	{
		28,
		"",
		""
	},
	{
		29,
		"",
		""
	},
	{
		30,
		"",
		""
	},
	{
		31,
		"",
		""
	},
	{
		32,
		"",
		""
	},
	{
		33,
		"",
		""
	},
	{
		34,
		"",
		""
	},
	{
		35,
		"",
		""
	},
	{
		36,
		"Client",
		""
	},
	{
		37,
		"",
		""
	},
	{
		38,
		"",
		""
	},
	{
		39,
		"",
		""
	},
	{
		40,
		"",
		""
	},
	{
		41,
		"",
		""
	},
	{
		42,
		"",
		""
	},
	{
		43,
		"",
		""
	},
	{
		44,
		"",
		""
	},
	{
		45,
		"",
		""
	},
	{
		46,
		"",
		""
	},
	{
		47,
		"",
		""
	},
	{
		48,
		"",
		""
	},
	{
		49,
		"",
		""
	},
	{
		50,
		"",
		""
	},
	{
		51,
		"",
		""
	},
	{
		52,
		"",
		""
	},
	{
		53,
		"",
		""
	},
	{
		54,
		"",
		""
	},
	{
		55,
		"",
		""
	},
	{
		56,
		"",
		""
	},
	{
		57,
		"",
		""
	},
	{
		58,
		"MatType",
		"19"
	},
	{
		59,
		"MatType",
		"30"
	},
	{
		60,
		"MatType",
		"29"
	},
	{
		61,
		"MatType",
		"28"
	},
	{
		62,
		"MatType",
		"32"
	},
	{
		63,
		"MatType",
		"33"
	},
	{
		64,
		"MatType",
		"34"
	},
	{
		65,
		"Dress",
		"7"
	},
	{
		66,
		"Dress",
		"5"
	},
	{
		67,
		"Dress",
		"1#2#3#4#6"
	}
}
local t_five_year_recap_data_ids = {
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
	[21] = dataList[20],
	[22] = dataList[21],
	[23] = dataList[22],
	[24] = dataList[23],
	[25] = dataList[24],
	[26] = dataList[25],
	[27] = dataList[26],
	[28] = dataList[27],
	[29] = dataList[28],
	[30] = dataList[29],
	[31] = dataList[30],
	[32] = dataList[31],
	[33] = dataList[32],
	[34] = dataList[33],
	[35] = dataList[34],
	[36] = dataList[35],
	[37] = dataList[36],
	[38] = dataList[37],
	[39] = dataList[38],
	[40] = dataList[39],
	[41] = dataList[40],
	[42] = dataList[41],
	[43] = dataList[42],
	[44] = dataList[43],
	[45] = dataList[44],
	[46] = dataList[45],
	[47] = dataList[46],
	[48] = dataList[47],
	[49] = dataList[48],
	[50] = dataList[49],
	[51] = dataList[50],
	[52] = dataList[51],
	[53] = dataList[52],
	[54] = dataList[53],
	[55] = dataList[54],
	[56] = dataList[55],
	[57] = dataList[56],
	[58] = dataList[57],
	[59] = dataList[58],
	[60] = dataList[59],
	[61] = dataList[60],
	[62] = dataList[61],
	[63] = dataList[62],
	[64] = dataList[63],
	[65] = dataList[64],
	[66] = dataList[65],
	[67] = dataList[66]
}

t_five_year_recap_data_ids.dataList = dataList

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

return t_five_year_recap_data_ids
