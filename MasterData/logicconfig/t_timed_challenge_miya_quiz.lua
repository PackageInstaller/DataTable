-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_miya_quiz.lua

module("logicconfig.config.t_timed_challenge_miya_quiz", package.seeall)

local title = {
	weight = 4,
	gameTime = 5,
	passNeedNum = 6,
	quizId = 1,
	totalNum = 7,
	quizIdNew = 3,
	difficulty = 2
}
local dataList = {
	{
		1,
		1,
		1,
		25,
		55,
		3,
		10
	},
	{
		2,
		1,
		2,
		25,
		55,
		3,
		10
	},
	{
		3,
		1,
		3,
		25,
		55,
		3,
		10
	},
	{
		4,
		1,
		4,
		25,
		55,
		3,
		10
	},
	{
		5,
		2,
		5,
		25,
		50,
		3,
		8
	},
	{
		6,
		2,
		6,
		25,
		50,
		3,
		8
	},
	{
		7,
		2,
		7,
		25,
		50,
		3,
		8
	},
	{
		8,
		2,
		8,
		25,
		50,
		3,
		8
	},
	{
		9,
		3,
		9,
		25,
		45,
		4,
		7
	},
	{
		10,
		3,
		10,
		25,
		45,
		4,
		7
	},
	{
		11,
		3,
		11,
		25,
		45,
		4,
		7
	},
	{
		12,
		3,
		12,
		25,
		45,
		4,
		7
	},
	{
		13,
		4,
		13,
		25,
		40,
		5,
		6
	},
	{
		14,
		4,
		14,
		25,
		40,
		5,
		6
	},
	{
		15,
		4,
		15,
		25,
		40,
		5,
		6
	},
	{
		16,
		4,
		16,
		25,
		40,
		5,
		6
	}
}
local t_timed_challenge_miya_quiz = {
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
	dataList[16]
}

t_timed_challenge_miya_quiz.dataList = dataList

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

return t_timed_challenge_miya_quiz
