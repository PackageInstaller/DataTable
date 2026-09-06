-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_teen_champion_king_round.lua

module("logicconfig.config.t_teen_champion_king_round", package.seeall)

local title = {
	roundGuessCoin = 7,
	gussPlanId = 6,
	roundId = 2,
	roundType = 3,
	roundName = 4,
	activityId = 1,
	guessLimit = 5
}
local dataList = {
	{
		501001,
		1,
		"QUALIFY",
		"战区预选赛",
		0,
		0,
		0
	},
	{
		501001,
		2,
		"SCORE_MATCH",
		"战区积分赛",
		0,
		0,
		0
	},
	{
		501001,
		3,
		"COMMON_KNOCKOUT",
		"全服赛128进64",
		10000,
		1,
		500
	},
	{
		501001,
		4,
		"COMMON_KNOCKOUT",
		"全服赛64进32",
		10000,
		1,
		500
	},
	{
		501001,
		5,
		"COMMON_KNOCKOUT",
		"全服赛32进16",
		10000,
		1,
		500
	},
	{
		501001,
		6,
		"COMMON_KNOCKOUT",
		"全服赛16进8",
		10000,
		1,
		500
	},
	{
		501001,
		7,
		"CHAMPION_SCORE_MATCH",
		"冠军积分赛第1轮",
		0,
		0,
		1000
	},
	{
		501001,
		8,
		"CHAMPION_SCORE_MATCH",
		"冠军积分赛第2轮",
		0,
		0,
		1000
	},
	{
		501001,
		9,
		"CHAMPION_SCORE_MATCH",
		"冠军积分赛第3轮",
		0,
		0,
		1000
	},
	{
		501001,
		10,
		"CHAMPION_SCORE_MATCH",
		"冠军积分赛第4轮",
		0,
		0,
		1000
	},
	{
		501001,
		11,
		"CHAMPION_SCORE_MATCH",
		"冠军积分赛第5轮",
		0,
		0,
		0
	},
	{
		501001,
		12,
		"CHAMPION_SCORE_MATCH",
		"冠军积分赛第6轮",
		0,
		0,
		0
	},
	{
		501001,
		13,
		"CHAMPION_SCORE_MATCH",
		"冠军积分赛第7轮",
		0,
		0,
		0
	},
	{
		501001,
		14,
		"DISPLAY",
		"前4展示",
		0,
		0,
		0
	}
}
local t_teen_champion_king_round = {
	[501001] = {
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
		dataList[14]
	}
}

t_teen_champion_king_round.dataList = dataList

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

return t_teen_champion_king_round
