-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pan_tao_feast_building.lua

module("logicconfig.config.t_pan_tao_feast_building", package.seeall)

local title = {
	buildingId = 2,
	prize = 4,
	storyId = 5,
	costScore = 3,
	posId = 6,
	activityId = 1
}
local dataList = {
	{
		622001,
		1,
		300,
		"104:2:100",
		0,
		1
	},
	{
		622001,
		2,
		400,
		"60:1:2000",
		0,
		2
	},
	{
		622001,
		3,
		500,
		"4:36:2",
		0,
		3
	},
	{
		622001,
		4,
		600,
		"104:2:100",
		0,
		4
	},
	{
		622001,
		5,
		750,
		"4:36:2",
		0,
		5
	},
	{
		622001,
		6,
		900,
		"104:2:200",
		0,
		6
	},
	{
		622001,
		7,
		1050,
		"4:36:2",
		4930014,
		7
	},
	{
		622001,
		8,
		1200,
		"104:2:200",
		0,
		8
	},
	{
		622001,
		9,
		1350,
		"4:36:2",
		0,
		9
	},
	{
		622001,
		10,
		1500,
		"60:1:3000",
		0,
		10
	},
	{
		622001,
		11,
		1650,
		"4:36:2",
		0,
		11
	},
	{
		622001,
		12,
		1800,
		"104:2:200",
		0,
		12
	},
	{
		622001,
		13,
		1950,
		"60:1:5000",
		0,
		13
	},
	{
		622001,
		14,
		2100,
		"104:2:200",
		0,
		14
	},
	{
		622001,
		15,
		2500,
		"4:400004:10",
		4930015,
		15
	},
	{
		622001,
		16,
		3000,
		"4:400004:10",
		0,
		16
	}
}
local t_pan_tao_feast_building = {
	[622001] = {
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
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_pan_tao_feast_building.dataList = dataList

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

return t_pan_tao_feast_building
