-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tian_yan_match_manual_prize.lua

module("logicconfig.config.t_tian_yan_match_manual_prize", package.seeall)

local title = {
	score = 5,
	name = 7,
	manualId = 2,
	matchToyIds = 3,
	manualType = 6,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		503001,
		1,
		{
			5,
			3
		},
		"10:503001:30",
		30,
		1,
		"少爷和我"
	},
	{
		503001,
		2,
		{
			7,
			3
		},
		"10:503001:30",
		30,
		1,
		"有钱任性"
	},
	{
		503001,
		3,
		{
			8,
			4
		},
		"10:503001:30",
		30,
		1,
		"不详预感"
	},
	{
		503001,
		4,
		{
			5,
			1
		},
		"10:503001:30",
		30,
		1,
		"看你表演"
	},
	{
		503001,
		5,
		{
			6,
			2
		},
		"10:503001:20",
		20,
		2,
		"意味不明"
	},
	{
		503001,
		6,
		{
			7,
			2
		},
		"10:503001:20",
		20,
		2,
		"谁惹你了"
	},
	{
		503001,
		7,
		{
			5,
			2
		},
		"10:503001:20",
		20,
		2,
		"与我无瓜"
	},
	{
		503001,
		8,
		{
			6,
			1
		},
		"10:503001:20",
		20,
		2,
		"我来助你"
	}
}
local t_tian_yan_match_manual_prize = {
	[503001] = {
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

t_tian_yan_match_manual_prize.dataList = dataList

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

return t_tian_yan_match_manual_prize
