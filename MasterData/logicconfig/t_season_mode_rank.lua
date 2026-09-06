-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_rank.lua

module("logicconfig.config.t_season_mode_rank", package.seeall)

local title = {
	topSize = 4,
	templateId = 6,
	rankType = 2,
	prizePlanId = 7,
	seasonId = 1,
	viewSize = 5,
	scorePlanId = 8,
	desc = 3
}
local dataList = {
	{
		1,
		1,
		"奖励榜",
		10000,
		200,
		171,
		1,
		0
	},
	{
		1,
		2,
		"挑战榜",
		10000,
		200,
		0,
		0,
		1
	},
	{
		1,
		3,
		"占领榜",
		10000,
		200,
		0,
		0,
		0
	},
	{
		2,
		1,
		"奖励榜",
		10000,
		200,
		171,
		2,
		0
	},
	{
		2,
		2,
		"挑战榜",
		10000,
		200,
		0,
		0,
		2
	},
	{
		2,
		3,
		"占领榜",
		10000,
		200,
		0,
		0,
		0
	},
	{
		3,
		1,
		"奖励榜",
		100000,
		200,
		171,
		3,
		0
	},
	{
		3,
		2,
		"挑战榜",
		100000,
		200,
		0,
		0,
		3
	},
	{
		3,
		3,
		"占领榜",
		100000,
		200,
		0,
		0,
		0
	}
}
local t_season_mode_rank = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_season_mode_rank.dataList = dataList

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

return t_season_mode_rank
