-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tarot_lottery_progress.lua

module("logicconfig.config.t_tarot_lottery_progress", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	number = 3
}
local dataList = {
	{
		345001,
		1,
		1,
		"4:11002:15000"
	},
	{
		345001,
		2,
		2,
		"4:510022:2"
	},
	{
		345001,
		3,
		3,
		"4:12102:5"
	},
	{
		345001,
		4,
		4,
		"4:36:10"
	},
	{
		345001,
		5,
		5,
		"4:30006:40"
	},
	{
		345001,
		6,
		6,
		"8:25:600"
	},
	{
		345001,
		7,
		7,
		"4:11002:15000"
	},
	{
		345001,
		8,
		8,
		"4:510022:3"
	},
	{
		345001,
		9,
		9,
		"4:12102:5"
	},
	{
		345001,
		10,
		10,
		"4:112:10"
	},
	{
		345001,
		11,
		11,
		"4:30006:60"
	},
	{
		345001,
		12,
		12,
		"8:25:600"
	}
}
local t_tarot_lottery_progress = {
	[345001] = {
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
		dataList[12]
	}
}

t_tarot_lottery_progress.dataList = dataList

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

return t_tarot_lottery_progress
