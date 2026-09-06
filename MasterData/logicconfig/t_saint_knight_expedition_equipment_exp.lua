-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_expedition_equipment_exp.lua

module("logicconfig.config.t_saint_knight_expedition_equipment_exp", package.seeall)

local title = {
	exp = 3,
	showLevel = 4,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		481001,
		0,
		0,
		0
	},
	{
		481001,
		1,
		300,
		1
	},
	{
		481001,
		2,
		1200,
		2
	},
	{
		481001,
		3,
		2400,
		3
	},
	{
		481001,
		4,
		6000,
		4
	},
	{
		481001,
		5,
		12000,
		5
	}
}
local t_saint_knight_expedition_equipment_exp = {
	[481001] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_saint_knight_expedition_equipment_exp.dataList = dataList

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

return t_saint_knight_expedition_equipment_exp
