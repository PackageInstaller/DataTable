-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_prince_liyang_building.lua

module("logicconfig.config.t_prince_liyang_building", package.seeall)

local title = {
	itemId = 4,
	typeIdx = 6,
	buildingId = 2,
	cost = 3,
	activityId = 1,
	posAndScale = 5
}
local dataList = {
	{
		509001,
		1,
		0,
		0,
		{
			-14.6,
			110.9,
			0,
			0.8
		},
		0
	},
	{
		509001,
		2,
		0,
		0,
		{
			-255.4,
			1,
			0,
			0.8
		},
		1
	},
	{
		509001,
		3,
		0,
		0,
		{
			-113,
			-96,
			0,
			0.8
		},
		5
	},
	{
		509001,
		4,
		0,
		0,
		{
			216,
			112,
			0,
			0.8
		},
		3
	},
	{
		509001,
		5,
		0,
		0,
		{
			385,
			39,
			0,
			0.8
		},
		4
	},
	{
		509001,
		6,
		0,
		0,
		{
			555,
			-87,
			0,
			0.8
		},
		2
	},
	{
		509001,
		7,
		0,
		0,
		{
			173.7,
			-106.4,
			0,
			0.8
		},
		1
	},
	{
		509001,
		8,
		0,
		0,
		{
			15,
			-230,
			0,
			0.8
		},
		2
	},
	{
		509001,
		9,
		0,
		0,
		{
			318,
			-217,
			0,
			0.8
		},
		4
	},
	{
		509001,
		10,
		0,
		0,
		{
			163,
			-324,
			0,
			0.8
		},
		5
	}
}
local t_prince_liyang_building = {
	[509001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_prince_liyang_building.dataList = dataList

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

return t_prince_liyang_building
