-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_contest_popularity_frenzy.lua

module("logicconfig.config.t_goddess_contest_popularity_frenzy", package.seeall)

local title = {
	popularityFrenzyPlanId = 1,
	triggerTime = 3,
	roundId = 2,
	rate = 4
}
local dataList = {
	{
		1,
		1,
		"2023-03-24 11:00:00#2023-03-24 13:00:00",
		2
	},
	{
		1,
		2,
		"2023-03-24 18:00:00#2023-03-24 20:00:00",
		2
	},
	{
		1,
		3,
		"2023-03-25 11:00:00#2023-03-25 13:00:00",
		2
	},
	{
		1,
		4,
		"2023-03-25 18:00:00#2023-03-25 20:00:00",
		2
	},
	{
		1,
		5,
		"2023-03-26 11:00:00#2023-03-26 13:00:00",
		2
	},
	{
		1,
		6,
		"2023-03-26 18:00:00#2023-03-26 19:00:00",
		2
	},
	{
		2,
		1,
		"2024-03-22 11:00:00#2024-03-22 13:00:00",
		2
	},
	{
		2,
		2,
		"2024-03-22 18:00:00#2024-03-22 20:00:00",
		2
	},
	{
		2,
		3,
		"2024-03-23 11:00:00#2024-03-23 13:00:00",
		2
	},
	{
		2,
		4,
		"2024-03-23 18:00:00#2024-03-23 20:00:00",
		2
	},
	{
		2,
		5,
		"2024-03-24 11:00:00#2024-03-24 13:00:00",
		2
	},
	{
		2,
		6,
		"2024-03-24 18:00:00#2024-03-24 19:00:00",
		2
	}
}
local t_goddess_contest_popularity_frenzy = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_goddess_contest_popularity_frenzy.dataList = dataList

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

return t_goddess_contest_popularity_frenzy
