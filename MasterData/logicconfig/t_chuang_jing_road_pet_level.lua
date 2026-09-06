-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_jing_road_pet_level.lua

module("logicconfig.config.t_chuang_jing_road_pet_level", package.seeall)

local title = {
	cost = 5,
	lv = 3,
	talentLv = 4,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		396001,
		0,
		1,
		0,
		""
	},
	{
		396001,
		1,
		10,
		0,
		"10:396001:100"
	},
	{
		396001,
		2,
		20,
		1,
		"10:396001:300"
	},
	{
		396001,
		3,
		30,
		2,
		"10:396001:500"
	},
	{
		396001,
		4,
		40,
		3,
		"10:396001:1000"
	},
	{
		396001,
		5,
		50,
		5,
		"10:396001:2000"
	},
	{
		396001,
		6,
		60,
		7,
		"10:396001:3000"
	},
	{
		396001,
		7,
		70,
		9,
		"10:396001:4000"
	},
	{
		396001,
		8,
		80,
		11,
		"10:396001:5000"
	},
	{
		396001,
		9,
		90,
		13,
		"10:396001:6000"
	},
	{
		396001,
		10,
		100,
		15,
		"10:396001:8000"
	}
}
local t_chuang_jing_road_pet_level = {
	[396001] = {
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

t_chuang_jing_road_pet_level.dataList = dataList

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

return t_chuang_jing_road_pet_level
