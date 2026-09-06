-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_ranking_score_plan.lua

module("logicconfig.config.t_timed_challenge_ranking_score_plan", package.seeall)

local title = {
	damageThreshold = 2,
	scorePlanId = 1,
	scorePer1W = 3
}
local dataList = {
	{
		1,
		0,
		15
	},
	{
		1,
		100,
		10
	},
	{
		1,
		200,
		9
	},
	{
		1,
		300,
		8
	},
	{
		1,
		400,
		7
	},
	{
		1,
		500,
		6
	},
	{
		1,
		600,
		5
	},
	{
		1,
		700,
		4
	},
	{
		1,
		800,
		3
	},
	{
		1,
		900,
		2
	},
	{
		1,
		1000,
		1
	}
}
local t_timed_challenge_ranking_score_plan = {
	{
		[0] = dataList[1],
		[100] = dataList[2],
		[200] = dataList[3],
		[300] = dataList[4],
		[400] = dataList[5],
		[500] = dataList[6],
		[600] = dataList[7],
		[700] = dataList[8],
		[800] = dataList[9],
		[900] = dataList[10],
		[1000] = dataList[11]
	}
}

t_timed_challenge_ranking_score_plan.dataList = dataList

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

return t_timed_challenge_ranking_score_plan
