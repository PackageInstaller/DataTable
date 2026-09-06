-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_expedition_stargod_level.lua

module("logicconfig.config.t_saint_knight_expedition_stargod_level", package.seeall)

local title = {
	starGodLv = 3,
	showLevel = 5,
	exp = 4,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		481001,
		0,
		1,
		0,
		1
	},
	{
		481001,
		1,
		5,
		60,
		5
	},
	{
		481001,
		2,
		10,
		180,
		10
	},
	{
		481001,
		3,
		15,
		300,
		15
	},
	{
		481001,
		4,
		20,
		600,
		20
	},
	{
		481001,
		5,
		25,
		1200,
		25
	},
	{
		481001,
		6,
		30,
		1800,
		30
	},
	{
		481001,
		7,
		35,
		3600,
		35
	},
	{
		481001,
		8,
		40,
		6000,
		40
	},
	{
		481001,
		9,
		45,
		9000,
		45
	},
	{
		481001,
		10,
		50,
		12000,
		50
	}
}
local t_saint_knight_expedition_stargod_level = {
	[481001] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	}
}

t_saint_knight_expedition_stargod_level.dataList = dataList

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

return t_saint_knight_expedition_stargod_level
