-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_dragon_stage.lua

module("logicconfig.config.t_dark_dragon_stage", package.seeall)

local title = {
	score = 5,
	stageDes = 7,
	bestBubble = 12,
	baseDesc = 11,
	unlockTips = 9,
	stageId = 2,
	baseName = 10,
	stageName = 6,
	bestElves = 13,
	seasonId = 1,
	creepsMasterId = 4,
	mainElves = 8,
	startTime = 3
}
local dataList = {
	{
		1,
		1,
		"2021-08-19T09:00:00",
		10101,
		100,
		"挑战 I",
		"潜龙勿用",
		"board_lysj_14",
		"该挑战将于2021-08-19 09:00:00开启",
		"基础评分",
		"基本通关评分",
		"只有成为强者，才是这个世界的真理！",
		"img_10320_yanmielongzun"
	},
	{
		1,
		2,
		"2021-08-20T09:00:00",
		10201,
		100,
		"挑战 II",
		"见龙在田",
		"board_lysj_13",
		"该挑战将于2021-08-20 09:00:00开启",
		"基础评分",
		"基本通关评分",
		"哈哈，你真是越来越强了。",
		"img_10098_binglingwang"
	},
	{
		1,
		3,
		"2021-08-21T09:00:00",
		10301,
		100,
		"挑战 III",
		"终日乾乾",
		"board_lysj_12",
		"该挑战将于2021-08-21 09:00:00开启",
		"基础评分",
		"基本通关评分",
		"好……好厉害……",
		"img_10345_longnv"
	},
	{
		1,
		4,
		"2021-08-22T09:00:00",
		10401,
		100,
		"挑战 IV",
		"或跃在渊",
		"board_lysj_14",
		"该挑战将于2021-08-22 09:00:00开启",
		"基础评分",
		"基本通关评分",
		"只有成为强者，才是这个世界的真理！",
		"img_10320_yanmielongzun"
	},
	{
		1,
		5,
		"2021-08-23T09:00:00",
		10501,
		100,
		"挑战 V",
		"飞龙在天",
		"board_lysj_13",
		"该挑战将于2021-08-23 09:00:00开启",
		"基础评分",
		"基本通关评分",
		"哈哈，你真是越来越强了。",
		"img_10098_binglingwang"
	},
	{
		1,
		6,
		"2021-08-24T09:00:00",
		10601,
		100,
		"挑战 VI",
		"亢龙有悔",
		"board_lysj_12",
		"该挑战将于2021-08-24 09:00:00开启",
		"基础评分",
		"基本通关评分",
		"好……好厉害……",
		"img_10345_longnv"
	},
	{
		1,
		7,
		"2021-08-25T09:00:00",
		10701,
		100,
		"挑战 VII",
		"见群龙无首",
		"board_lysj_15",
		"该挑战将于2021-08-25 09:00:00开启",
		"基础评分",
		"基本通关评分",
		"只有成为强者，才是这个世界的真理！",
		"img_10320_yanmielongzun"
	}
}
local t_dark_dragon_stage = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_dark_dragon_stage.dataList = dataList

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

return t_dark_dragon_stage
