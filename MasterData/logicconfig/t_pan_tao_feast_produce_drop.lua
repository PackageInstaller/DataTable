-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pan_tao_feast_produce_drop.lua

module("logicconfig.config.t_pan_tao_feast_produce_drop", package.seeall)

local title = {
	weight = 4,
	dropElementId = 3,
	activityId = 1,
	toolElementId = 2
}
local dataList = {
	{
		622001,
		21001,
		1,
		100
	},
	{
		622001,
		21001,
		2,
		100
	},
	{
		622001,
		21002,
		1,
		400
	},
	{
		622001,
		21002,
		2,
		300
	},
	{
		622001,
		21002,
		3,
		50
	},
	{
		622001,
		21002,
		4,
		20
	},
	{
		622001,
		21003,
		1,
		400
	},
	{
		622001,
		21003,
		2,
		300
	},
	{
		622001,
		21003,
		3,
		300
	},
	{
		622001,
		21003,
		4,
		160
	},
	{
		622001,
		21003,
		5,
		80
	},
	{
		622001,
		21003,
		6,
		30
	},
	{
		622001,
		21003,
		7,
		20
	},
	{
		622001,
		22001,
		8,
		200
	},
	{
		622001,
		22001,
		9,
		100
	},
	{
		622001,
		22001,
		10,
		80
	},
	{
		622001,
		22002,
		8,
		400
	},
	{
		622001,
		22002,
		9,
		300
	},
	{
		622001,
		22002,
		10,
		300
	},
	{
		622001,
		22002,
		11,
		120
	},
	{
		622001,
		22002,
		12,
		80
	},
	{
		622001,
		22002,
		13,
		50
	},
	{
		622001,
		22002,
		14,
		20
	},
	{
		622001,
		23001,
		15,
		100
	},
	{
		622001,
		23001,
		16,
		100
	},
	{
		622001,
		23001,
		17,
		50
	},
	{
		622001,
		23002,
		15,
		400
	},
	{
		622001,
		23002,
		16,
		300
	},
	{
		622001,
		23002,
		17,
		200
	},
	{
		622001,
		23002,
		18,
		100
	},
	{
		622001,
		23002,
		19,
		80
	},
	{
		622001,
		23002,
		20,
		50
	},
	{
		622001,
		23002,
		21,
		50
	},
	{
		622001,
		24001,
		22,
		100
	},
	{
		622001,
		24001,
		23,
		100
	},
	{
		622001,
		24002,
		22,
		500
	},
	{
		622001,
		24002,
		23,
		400
	},
	{
		622001,
		24002,
		24,
		200
	},
	{
		622001,
		24002,
		25,
		50
	},
	{
		622001,
		24001,
		26,
		70
	},
	{
		622001,
		24001,
		27,
		70
	},
	{
		622001,
		24002,
		26,
		300
	},
	{
		622001,
		24002,
		27,
		200
	},
	{
		622001,
		24002,
		28,
		100
	},
	{
		622001,
		24002,
		29,
		50
	},
	{
		622001,
		24002,
		34,
		50
	},
	{
		622001,
		22001,
		30,
		100
	},
	{
		622001,
		22001,
		31,
		100
	},
	{
		622001,
		22002,
		30,
		400
	},
	{
		622001,
		22002,
		31,
		300
	},
	{
		622001,
		22002,
		32,
		100
	},
	{
		622001,
		22002,
		33,
		10
	}
}
local t_pan_tao_feast_produce_drop = {
	[622001] = {
		[21001] = {
			dataList[1],
			dataList[2]
		},
		[21002] = {
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6]
		},
		[21003] = {
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12],
			dataList[13]
		},
		[22001] = {
			[8] = dataList[14],
			[9] = dataList[15],
			[10] = dataList[16],
			[30] = dataList[47],
			[31] = dataList[48]
		},
		[22002] = {
			[8] = dataList[17],
			[9] = dataList[18],
			[10] = dataList[19],
			[11] = dataList[20],
			[12] = dataList[21],
			[13] = dataList[22],
			[14] = dataList[23],
			[30] = dataList[49],
			[31] = dataList[50],
			[32] = dataList[51],
			[33] = dataList[52]
		},
		[23001] = {
			[15] = dataList[24],
			[16] = dataList[25],
			[17] = dataList[26]
		},
		[23002] = {
			[15] = dataList[27],
			[16] = dataList[28],
			[17] = dataList[29],
			[18] = dataList[30],
			[19] = dataList[31],
			[20] = dataList[32],
			[21] = dataList[33]
		},
		[24001] = {
			[22] = dataList[34],
			[23] = dataList[35],
			[26] = dataList[40],
			[27] = dataList[41]
		},
		[24002] = {
			[22] = dataList[36],
			[23] = dataList[37],
			[24] = dataList[38],
			[25] = dataList[39],
			[26] = dataList[42],
			[27] = dataList[43],
			[28] = dataList[44],
			[29] = dataList[45],
			[34] = dataList[46]
		}
	}
}

t_pan_tao_feast_produce_drop.dataList = dataList

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

return t_pan_tao_feast_produce_drop
