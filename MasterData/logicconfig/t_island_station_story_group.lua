-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_island_station_story_group.lua

module("logicconfig.config.t_island_station_story_group", package.seeall)

local title = {
	groupId = 2,
	groupName = 3,
	activityId = 1,
	girlId = 4
}
local dataList = {
	{
		487001,
		1,
		"开场",
		""
	},
	{
		487001,
		2,
		"空灵神女",
		"3"
	},
	{
		487001,
		3,
		"音织",
		"1"
	},
	{
		487001,
		4,
		"龙尊神女",
		"2"
	},
	{
		487001,
		5,
		"斐妮娅",
		"4"
	},
	{
		487001,
		6,
		"誓祖神女",
		"5"
	},
	{
		487001,
		7,
		"无烬神女",
		"6"
	},
	{
		487001,
		8,
		"结尾",
		""
	}
}
local t_island_station_story_group = {
	[487001] = {
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

t_island_station_story_group.dataList = dataList

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

return t_island_station_story_group
