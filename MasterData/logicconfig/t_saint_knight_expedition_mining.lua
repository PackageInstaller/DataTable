-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_expedition_mining.lua

module("logicconfig.config.t_saint_knight_expedition_mining", package.seeall)

local title = {
	index = 2,
	planId = 4,
	activityId = 1,
	times = 3
}
local dataList = {
	{
		481001,
		1,
		0,
		1
	},
	{
		481001,
		2,
		120,
		2
	},
	{
		481001,
		3,
		300,
		3
	},
	{
		481001,
		4,
		420,
		4
	},
	{
		481001,
		5,
		720,
		5
	}
}
local t_saint_knight_expedition_mining = {
	[481001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_saint_knight_expedition_mining.dataList = dataList

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

return t_saint_knight_expedition_mining
