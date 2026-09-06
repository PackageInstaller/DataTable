-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_team_chapter_battle_stage.lua

module("logicconfig.config.t_dream_team_chapter_battle_stage", package.seeall)

local title = {
	stageId = 3,
	challengeId = 2,
	formConditionId = 5,
	supportPetPlan = 7,
	creepsMasterId = 4,
	isLinear = 6,
	activityId = 1,
	prize = 8
}
local dataList = {
	{
		595001,
		1,
		1,
		1001,
		0,
		true,
		1,
		""
	},
	{
		595001,
		1,
		2,
		1002,
		0,
		true,
		1,
		""
	},
	{
		595001,
		1,
		3,
		1003,
		0,
		true,
		1,
		""
	},
	{
		595001,
		1,
		4,
		1004,
		0,
		true,
		1,
		""
	},
	{
		595001,
		1,
		5,
		1005,
		0,
		true,
		1,
		""
	},
	{
		595001,
		2,
		1,
		1006,
		234,
		false,
		1,
		"10:595004:20"
	},
	{
		595001,
		2,
		2,
		1007,
		235,
		false,
		1,
		"10:595004:20"
	},
	{
		595001,
		2,
		3,
		1008,
		236,
		false,
		1,
		"10:595004:20"
	},
	{
		595001,
		2,
		4,
		1009,
		237,
		false,
		1,
		"10:595004:20"
	},
	{
		595001,
		2,
		5,
		1010,
		238,
		false,
		1,
		"10:595004:20"
	},
	{
		595001,
		3,
		1,
		1011,
		0,
		true,
		1,
		"10:595005:20"
	},
	{
		595001,
		3,
		2,
		1012,
		0,
		true,
		1,
		"10:595005:20"
	},
	{
		595001,
		3,
		3,
		1013,
		0,
		true,
		1,
		"10:595005:20"
	},
	{
		595001,
		3,
		4,
		1014,
		0,
		true,
		1,
		"10:595005:20"
	},
	{
		595001,
		3,
		5,
		1015,
		0,
		true,
		1,
		"10:595005:20"
	},
	{
		595001,
		4,
		1,
		1016,
		0,
		true,
		1,
		"10:595006:20"
	},
	{
		595001,
		4,
		2,
		1017,
		0,
		true,
		1,
		"10:595006:20"
	},
	{
		595001,
		4,
		3,
		1018,
		0,
		true,
		1,
		"10:595006:20"
	},
	{
		595001,
		4,
		4,
		1019,
		0,
		true,
		1,
		"10:595006:20"
	},
	{
		595001,
		4,
		5,
		1020,
		0,
		true,
		1,
		"10:595006:20"
	}
}
local t_dream_team_chapter_battle_stage = {
	[595001] = {
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
		}
	}
}

t_dream_team_chapter_battle_stage.dataList = dataList

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

return t_dream_team_chapter_battle_stage
