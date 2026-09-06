-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_meng_meng_challenge_score_prize.lua

module("logicconfig.config.t_king_meng_meng_challenge_score_prize", package.seeall)

local title = {
	prizeId = 2,
	score = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		278001,
		1,
		200,
		"8:1:1000000"
	},
	{
		278001,
		2,
		500,
		"4:30006:40"
	},
	{
		278001,
		3,
		1000,
		"4:194:5"
	},
	{
		278001,
		4,
		2000,
		"4:40008:2"
	},
	{
		278001,
		5,
		3000,
		"4:194:5"
	},
	{
		278001,
		6,
		4000,
		"4:194:10"
	},
	{
		278002,
		1,
		200,
		"8:1:1"
	},
	{
		278002,
		2,
		500,
		"8:1:1"
	},
	{
		278002,
		3,
		1000,
		"8:1:1"
	},
	{
		278002,
		4,
		2000,
		"8:1:1"
	},
	{
		278002,
		5,
		3000,
		"8:1:1"
	},
	{
		278002,
		6,
		4000,
		"8:1:1"
	}
}
local t_king_meng_meng_challenge_score_prize = {
	[278001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[278002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_king_meng_meng_challenge_score_prize.dataList = dataList

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

return t_king_meng_meng_challenge_score_prize
