-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_knowledge_answer_score_prize.lua

module("logicconfig.config.t_knowledge_answer_score_prize", package.seeall)

local title = {
	prizeId = 2,
	score = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		449001,
		1,
		50,
		"8:1:500000"
	},
	{
		449001,
		2,
		100,
		"4:31:5"
	},
	{
		449001,
		3,
		150,
		"8:1:500000"
	},
	{
		449001,
		4,
		200,
		"4:90037:1"
	},
	{
		449001,
		5,
		250,
		"8:1:500000"
	},
	{
		449001,
		6,
		300,
		"4:111:5"
	},
	{
		449001,
		7,
		350,
		"8:1:500000"
	},
	{
		449001,
		8,
		400,
		"4:31:5"
	},
	{
		449001,
		9,
		500,
		"8:1:500000"
	},
	{
		449001,
		10,
		600,
		"4:111:5"
	},
	{
		449001,
		11,
		700,
		"8:1:500000"
	}
}
local t_knowledge_answer_score_prize = {
	[449001] = {
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
		dataList[11]
	}
}

t_knowledge_answer_score_prize.dataList = dataList

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

return t_knowledge_answer_score_prize
