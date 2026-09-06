-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_share_lottery_prize.lua

module("logicconfig.config.t_share_lottery_prize", package.seeall)

local title = {
	prizeId = 2,
	gainTimesLimit = 4,
	activityId = 1,
	pos = 5,
	qualityShowIdx = 6,
	prize = 3
}
local dataList = {
	{
		448001,
		1,
		"4:510022:5",
		1,
		{
			-275,
			56
		},
		0
	},
	{
		448001,
		2,
		"4:90316:1",
		1,
		{
			-170,
			52
		},
		0
	},
	{
		448001,
		3,
		"29:23:1",
		1,
		{
			-75,
			51
		},
		1
	},
	{
		448001,
		4,
		"104:2:888",
		1,
		{
			26,
			68
		},
		0
	},
	{
		448001,
		5,
		"4:510446:1",
		1,
		{
			-217,
			135
		},
		1
	}
}
local t_share_lottery_prize = {
	[448001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_share_lottery_prize.dataList = dataList

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

return t_share_lottery_prize
