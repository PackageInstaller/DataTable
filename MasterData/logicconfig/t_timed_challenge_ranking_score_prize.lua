-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_ranking_score_prize.lua

module("logicconfig.config.t_timed_challenge_ranking_score_prize", package.seeall)

local title = {
	prizeId = 2,
	challengeId = 1,
	prize = 4,
	score = 3
}
local dataList = {
	{
		27,
		1,
		5000,
		"8:1:500000"
	},
	{
		27,
		2,
		10000,
		"4:30003:10"
	},
	{
		27,
		3,
		20000,
		"4:3:50"
	},
	{
		27,
		4,
		30000,
		"4:31:5"
	},
	{
		27,
		5,
		50000,
		"104:2:300"
	},
	{
		27,
		6,
		70000,
		"4:40008:1"
	},
	{
		27,
		7,
		90000,
		"4:31:5"
	},
	{
		27,
		8,
		120000,
		"4:41004:1"
	}
}
local t_timed_challenge_ranking_score_prize = {
	[27] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_timed_challenge_ranking_score_prize.dataList = dataList

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

return t_timed_challenge_ranking_score_prize
