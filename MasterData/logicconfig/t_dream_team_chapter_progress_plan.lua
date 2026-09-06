-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_team_chapter_progress_plan.lua

module("logicconfig.config.t_dream_team_chapter_progress_plan", package.seeall)

local title = {
	progressId = 3,
	activityId = 1,
	prize = 5,
	progress = 4,
	progressType = 2
}
local dataList = {
	{
		595001,
		1,
		1,
		"20",
		"10:595001:20"
	},
	{
		595001,
		1,
		2,
		"40",
		"10:595001:20"
	},
	{
		595001,
		1,
		3,
		"60",
		"10:595001:20"
	},
	{
		595001,
		1,
		4,
		"80",
		"10:595001:20"
	},
	{
		595001,
		1,
		5,
		"100",
		"10:595001:20"
	},
	{
		595001,
		2,
		1,
		"2",
		"10:595003:20"
	},
	{
		595001,
		2,
		2,
		"4",
		"10:595003:20"
	},
	{
		595001,
		2,
		3,
		"6",
		"10:595003:20"
	},
	{
		595001,
		2,
		4,
		"8",
		"10:595003:20"
	},
	{
		595001,
		2,
		5,
		"10",
		"10:595003:20"
	},
	{
		595001,
		3,
		1,
		"1000000000",
		"10:595007:500"
	},
	{
		595001,
		3,
		2,
		"2000000000",
		"10:595007:500"
	},
	{
		595001,
		3,
		3,
		"3000000000",
		"10:595007:500"
	},
	{
		595001,
		3,
		4,
		"4000000000",
		"10:595007:500"
	},
	{
		595001,
		3,
		5,
		"5000000000",
		"10:595007:500"
	},
	{
		595001,
		3,
		6,
		"6000000000",
		"10:595007:500"
	}
}
local t_dream_team_chapter_progress_plan = {
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
			dataList[15],
			dataList[16]
		}
	}
}

t_dream_team_chapter_progress_plan.dataList = dataList

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

return t_dream_team_chapter_progress_plan
