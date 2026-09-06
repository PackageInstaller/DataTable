-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_survival_king_prize.lua

module("logicconfig.config.t_survival_king_prize", package.seeall)

local title = {
	prize = 4,
	showRank = 5,
	lastRoundId = 3,
	id = 2,
	activityId = 1
}
local dataList = {
	{
		529001,
		1,
		{
			4
		},
		"10:17173:3200#10:529001:480",
		"1"
	},
	{
		529001,
		2,
		{
			2,
			3
		},
		"10:17173:2560#10:529001:400",
		"2-4"
	},
	{
		529001,
		3,
		{
			1
		},
		"10:17173:1920#10:529001:320",
		"5-8"
	},
	{
		529001,
		4,
		{
			0
		},
		"10:17173:1280#10:529001:320",
		"9-16"
	},
	{
		529002,
		1,
		{
			4
		},
		"10:529002:400#10:529003:100",
		"1"
	},
	{
		529002,
		2,
		{
			3
		},
		"10:529002:250#10:529003:100",
		"2"
	},
	{
		529002,
		3,
		{
			2
		},
		"10:529002:250#10:529003:100",
		"3-4"
	},
	{
		529002,
		4,
		{
			1
		},
		"10:529002:150#10:529003:100",
		"5-8"
	},
	{
		529002,
		5,
		{
			0
		},
		"10:529002:100#10:529003:100",
		"9-16"
	}
}
local t_survival_king_prize = {
	[529001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[529002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_survival_king_prize.dataList = dataList

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

return t_survival_king_prize
