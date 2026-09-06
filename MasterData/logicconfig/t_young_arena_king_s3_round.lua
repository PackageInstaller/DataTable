-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_arena_king_s3_round.lua

module("logicconfig.config.t_young_arena_king_s3_round", package.seeall)

local title = {
	scoreRule1v1 = 9,
	roundType = 3,
	petActiveScore1v1 = 6,
	baseScore3v3 = 7,
	roundName = 4,
	scoreRule3v3 = 10,
	petActiveScore3v3 = 8,
	roundId = 2,
	baseScore1v1 = 5,
	activityId = 1
}
local dataList = {
	{
		624001,
		1,
		"QUALIFY",
		"战区预选赛",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		2,
		"SCORE_MATCH",
		"战区积分赛",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		3,
		"COMMON_KNOCKOUT",
		"冠军128进64",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		4,
		"COMMON_KNOCKOUT",
		"冠军64进32",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		5,
		"COMMON_KNOCKOUT",
		"冠军32进16",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		6,
		"TOP_16_KNOCKOUT",
		"冠军16进8",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		7,
		"TOP_8_SCORE_MATCH_1V1",
		"1v1-第1场",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		8,
		"TOP_8_SCORE_MATCH_1V1",
		"1v1-第2场",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		9,
		"TOP_8_SCORE_MATCH_1V1",
		"1v1-第3场",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		10,
		"TOP_8_SCORE_MATCH_1V1",
		"1v1-第4场",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		11,
		"TOP_8_SCORE_MATCH_1V1",
		"1v1-第5场",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		12,
		"TOP_8_SCORE_MATCH_1V1",
		"1v1-第6场",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		13,
		"TOP_8_SCORE_MATCH_1V1",
		"1v1-第7场",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		14,
		"TOP_8_SCORE_MATCH_3V3",
		"3v3-第1场",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		15,
		"TOP_8_SCORE_MATCH_3V3",
		"3v3-第2场",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		16,
		"TOP_8_SCORE_MATCH_3V3",
		"3v3-第3场",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		17,
		"TOP_8_SCORE_MATCH_3V3",
		"3v3-第4场",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		18,
		"TOP_8_SCORE_MATCH_3V3",
		"3v3-第5场",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		19,
		"TOP_8_SCORE_MATCH_3V3",
		"3v3-第6场",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		20,
		"TOP_8_SCORE_MATCH_3V3",
		"3v3-第7场",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	},
	{
		624001,
		21,
		"DISPLAY",
		"展示阶段",
		50,
		10,
		50,
		5,
		82058246,
		82058247
	}
}
local t_young_arena_king_s3_round = {
	[624001] = {
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
		dataList[21]
	}
}

t_young_arena_king_s3_round.dataList = dataList

local multiLanguageCells = {
	scoreRule1v1 = true,
	scoreRule3v3 = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_young_arena_king_s3_round
