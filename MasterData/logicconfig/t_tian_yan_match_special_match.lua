-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tian_yan_match_special_match.lua

module("logicconfig.config.t_tian_yan_match_special_match", package.seeall)

local title = {
	matchToyIds = 3,
	matchPrize = 4,
	matchScore = 5,
	activityId = 1,
	matchId = 2
}
local dataList = {
	{
		503001,
		1,
		{
			5,
			3
		},
		"10:503001:10",
		10
	},
	{
		503001,
		2,
		{
			7,
			3
		},
		"10:503001:10",
		10
	},
	{
		503001,
		3,
		{
			8,
			4
		},
		"10:503001:10",
		10
	},
	{
		503001,
		4,
		{
			5,
			1
		},
		"10:503001:10",
		10
	},
	{
		503001,
		5,
		{
			6,
			2
		},
		"10:503001:10",
		10
	},
	{
		503001,
		6,
		{
			7,
			2
		},
		"10:503001:10",
		10
	},
	{
		503001,
		7,
		{
			5,
			2
		},
		"10:503001:10",
		10
	},
	{
		503001,
		8,
		{
			6,
			1
		},
		"10:503001:10",
		10
	}
}
local t_tian_yan_match_special_match = {
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

t_tian_yan_match_special_match.dataList = dataList

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

return t_tian_yan_match_special_match
