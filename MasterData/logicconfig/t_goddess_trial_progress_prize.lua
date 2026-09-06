-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_trial_progress_prize.lua

module("logicconfig.config.t_goddess_trial_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	needScore = 3
}
local dataList = {
	{
		574001,
		1,
		"1000",
		"4:36:10"
	},
	{
		574001,
		2,
		"3000",
		"8:1:1000000"
	},
	{
		574001,
		3,
		"5000",
		"4:12102:5"
	},
	{
		574001,
		4,
		"7000",
		"10:453003:2000"
	},
	{
		574001,
		5,
		"10000",
		"4:510022:5"
	},
	{
		574001,
		6,
		"13000",
		"4:11002:15000"
	},
	{
		574001,
		7,
		"16000",
		"10:453003:2000"
	},
	{
		574001,
		8,
		"19000",
		"4:510022:5"
	},
	{
		574001,
		9,
		"22000",
		"4:30006:100"
	},
	{
		574001,
		10,
		"25000",
		"4:400002:150"
	},
	{
		574001,
		11,
		"29000",
		"10:453003:4000"
	},
	{
		574001,
		12,
		"34000",
		"4:30006:100"
	},
	{
		574001,
		13,
		"38000",
		"4:400002:150"
	},
	{
		574001,
		14,
		"42000",
		"4:90102:1"
	}
}
local t_goddess_trial_progress_prize = {
	[574001] = {
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
		dataList[14]
	}
}

t_goddess_trial_progress_prize.dataList = dataList

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

return t_goddess_trial_progress_prize
