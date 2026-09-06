-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fire_works_display_scene_time.lua

module("logicconfig.config.t_fire_works_display_scene_time", package.seeall)

local title = {
	id = 2,
	openTime = 3,
	sceneTimePlanId = 1,
	sceneId = 4
}
local dataList = {
	{
		1,
		1,
		"09:00:00-09:59:59",
		1001
	},
	{
		1,
		2,
		"10:00:00-10:59:59",
		106
	},
	{
		1,
		3,
		"11:00:00-11:59:59",
		107
	},
	{
		1,
		4,
		"12:00:00-12:59:59",
		114
	},
	{
		1,
		5,
		"13:00:00-13:59:59",
		117
	},
	{
		1,
		6,
		"14:00:00-14:59:59",
		118
	},
	{
		1,
		7,
		"15:00:00-15:59:59",
		119
	},
	{
		1,
		8,
		"16:00:00-16:59:59",
		120
	},
	{
		1,
		9,
		"17:00:00-17:59:59",
		126
	},
	{
		1,
		10,
		"18:00:00-18:59:59",
		1001
	},
	{
		1,
		11,
		"19:00:00-19:59:59",
		106
	},
	{
		1,
		12,
		"20:00:00-20:59:59",
		107
	},
	{
		1,
		13,
		"21:00:00-21:59:59",
		114
	}
}
local t_fire_works_display_scene_time = {
	{
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
		dataList[13]
	}
}

t_fire_works_display_scene_time.dataList = dataList

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

return t_fire_works_display_scene_time
