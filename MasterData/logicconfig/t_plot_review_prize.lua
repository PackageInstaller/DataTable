-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_plot_review_prize.lua

module("logicconfig.config.t_plot_review_prize", package.seeall)

local title = {
	prizeId = 1,
	prize = 2
}
local dataList = {
	{
		1,
		"4:10:30"
	},
	{
		2,
		"4:10:30"
	},
	{
		3,
		"4:10:30"
	},
	{
		4,
		"4:10:30"
	},
	{
		5,
		"4:10:30"
	},
	{
		6,
		"4:90062:30"
	},
	{
		7,
		"4:90062:30"
	},
	{
		8,
		"4:90062:30"
	},
	{
		9,
		"4:90062:30"
	},
	{
		10,
		"4:90062:30"
	},
	{
		11,
		"4:25:5"
	},
	{
		12,
		"4:25:5"
	},
	{
		13,
		"4:25:5"
	},
	{
		14,
		"4:30003:5"
	},
	{
		15,
		"4:30003:5"
	},
	{
		16,
		"4:30003:5"
	},
	{
		17,
		"4:503:5"
	},
	{
		18,
		"4:503:5"
	},
	{
		19,
		"4:503:5"
	},
	{
		20,
		"104:2:100"
	},
	{
		21,
		"104:2:100"
	},
	{
		22,
		"104:2:100"
	},
	{
		23,
		"4:31:1"
	},
	{
		24,
		"4:31:1"
	},
	{
		25,
		"4:31:1"
	},
	{
		26,
		"4:112:1"
	},
	{
		27,
		"4:112:1"
	},
	{
		28,
		"4:112:1"
	},
	{
		29,
		"4:112:1"
	},
	{
		30,
		"4:112:1"
	},
	{
		101,
		"4:3:10"
	},
	{
		102,
		"4:3:10"
	},
	{
		103,
		"4:30002:10"
	},
	{
		104,
		"4:30002:10"
	},
	{
		105,
		"4:502:10"
	},
	{
		106,
		"4:502:10"
	},
	{
		107,
		"4:36:1"
	},
	{
		108,
		"4:3:10"
	},
	{
		109,
		"4:3:10"
	},
	{
		110,
		"4:30002:10"
	},
	{
		111,
		"4:30002:10"
	},
	{
		112,
		"4:502:10"
	},
	{
		113,
		"4:502:10"
	},
	{
		114,
		"4:36:1"
	},
	{
		115,
		"4:3:10"
	},
	{
		116,
		"4:3:10"
	},
	{
		117,
		"4:30002:10"
	},
	{
		118,
		"4:30002:10"
	},
	{
		119,
		"4:502:10"
	},
	{
		120,
		"4:502:10"
	},
	{
		121,
		"4:36:1"
	},
	{
		122,
		"4:3:10"
	},
	{
		123,
		"4:3:10"
	},
	{
		124,
		"4:30002:10"
	},
	{
		125,
		"4:30002:10"
	},
	{
		126,
		"4:502:10"
	},
	{
		127,
		"4:502:10"
	},
	{
		128,
		"4:36:1"
	},
	{
		129,
		"4:3:10"
	},
	{
		130,
		"4:3:10"
	},
	{
		131,
		"4:30002:10"
	},
	{
		132,
		"4:30002:10"
	},
	{
		133,
		"4:502:10"
	},
	{
		134,
		"4:502:10"
	}
}
local t_plot_review_prize = {
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
	[101] = dataList[31],
	[102] = dataList[32],
	[103] = dataList[33],
	[104] = dataList[34],
	[105] = dataList[35],
	[106] = dataList[36],
	[107] = dataList[37],
	[108] = dataList[38],
	[109] = dataList[39],
	[110] = dataList[40],
	[111] = dataList[41],
	[112] = dataList[42],
	[113] = dataList[43],
	[114] = dataList[44],
	[115] = dataList[45],
	[116] = dataList[46],
	[117] = dataList[47],
	[118] = dataList[48],
	[119] = dataList[49],
	[120] = dataList[50],
	[121] = dataList[51],
	[122] = dataList[52],
	[123] = dataList[53],
	[124] = dataList[54],
	[125] = dataList[55],
	[126] = dataList[56],
	[127] = dataList[57],
	[128] = dataList[58],
	[129] = dataList[59],
	[130] = dataList[60],
	[131] = dataList[61],
	[132] = dataList[62],
	[133] = dataList[63],
	[134] = dataList[64]
}

t_plot_review_prize.dataList = dataList

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

return t_plot_review_prize
