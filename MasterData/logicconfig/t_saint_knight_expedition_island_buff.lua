-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_expedition_island_buff.lua

module("logicconfig.config.t_saint_knight_expedition_island_buff", package.seeall)

local title = {
	activityId = 1,
	islandBuffId = 2
}
local dataList = {
	{
		481001,
		1
	},
	{
		481001,
		2
	},
	{
		481001,
		3
	},
	{
		481001,
		4
	},
	{
		481001,
		5
	},
	{
		481001,
		6
	}
}
local t_saint_knight_expedition_island_buff = {
	[481001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_saint_knight_expedition_island_buff.dataList = dataList

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

return t_saint_knight_expedition_island_buff
