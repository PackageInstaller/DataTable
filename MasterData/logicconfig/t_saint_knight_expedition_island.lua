-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_expedition_island.lua

module("logicconfig.config.t_saint_knight_expedition_island", package.seeall)

local title = {
	cost = 3,
	activityId = 1,
	pos = 5,
	skinId = 4,
	sorting = 6,
	islandId = 2,
	unlockUpgardeTime = 7
}
local dataList = {
	{
		481001,
		1,
		"10:479002:1",
		11007,
		{
			-283,
			200
		},
		1
	},
	{
		481001,
		2,
		"10:479004:1",
		14008,
		{
			560,
			145
		},
		2
	},
	{
		481001,
		3,
		"10:479003:1",
		13001,
		{
			-490,
			-65
		},
		11,
		"2025-06-06T05:00:00"
	},
	{
		481001,
		4,
		"10:479001:1",
		12008,
		{
			306,
			-149
		},
		13,
		"2025-06-13T05:00:00"
	},
	{
		481001,
		5,
		"10:479005:1",
		15011,
		{
			-124,
			-125
		},
		12,
		"2025-06-20T05:00:00"
	}
}
local t_saint_knight_expedition_island = {
	[481001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_saint_knight_expedition_island.dataList = dataList

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

return t_saint_knight_expedition_island
