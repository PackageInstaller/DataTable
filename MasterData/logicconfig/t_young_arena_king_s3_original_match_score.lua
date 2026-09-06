-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_arena_king_s3_original_match_score.lua

module("logicconfig.config.t_young_arena_king_s3_original_match_score", package.seeall)

local title = {
	zdl = 3,
	matchScorePlanId = 1,
	initMatchScore = 4,
	matchScoreId = 2
}
local dataList = {
	{
		1,
		1,
		0,
		1200
	},
	{
		1,
		2,
		60000,
		1400
	},
	{
		1,
		3,
		110000,
		1600
	},
	{
		1,
		4,
		160000,
		1800
	},
	{
		1,
		5,
		210000,
		2000
	},
	{
		1,
		6,
		260000,
		2200
	},
	{
		1,
		7,
		310000,
		2400
	},
	{
		1,
		8,
		360000,
		2600
	},
	{
		1,
		9,
		410000,
		2800
	},
	{
		1,
		10,
		460000,
		3000
	},
	{
		1,
		11,
		510000,
		3200
	},
	{
		1,
		12,
		560000,
		3400
	},
	{
		1,
		13,
		610000,
		3600
	},
	{
		1,
		14,
		660000,
		3800
	},
	{
		1,
		15,
		710000,
		4000
	},
	{
		1,
		16,
		760000,
		4200
	},
	{
		1,
		17,
		810000,
		4400
	},
	{
		1,
		18,
		910000,
		4600
	},
	{
		1,
		19,
		1010000,
		4800
	},
	{
		1,
		20,
		1110000,
		5000
	},
	{
		1,
		21,
		1210000,
		5200
	},
	{
		1,
		22,
		1310000,
		5400
	},
	{
		1,
		23,
		1410000,
		5600
	},
	{
		1,
		24,
		1510000,
		5800
	},
	{
		1,
		25,
		1610000,
		6000
	},
	{
		1,
		26,
		1710000,
		6200
	},
	{
		1,
		27,
		1810000,
		6400
	},
	{
		1,
		28,
		1910000,
		6600
	},
	{
		1,
		29,
		2010000,
		6800
	},
	{
		1,
		30,
		2110000,
		7000
	},
	{
		1,
		31,
		2210000,
		7200
	}
}
local t_young_arena_king_s3_original_match_score = {
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

t_young_arena_king_s3_original_match_score.dataList = dataList

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

return t_young_arena_king_s3_original_match_score
