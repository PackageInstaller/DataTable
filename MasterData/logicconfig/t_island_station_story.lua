-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_island_station_story.lua

module("logicconfig.config.t_island_station_story", package.seeall)

local title = {
	groupId = 2,
	storyName = 5,
	unLockFetter = 6,
	storyId = 4,
	id = 3,
	activityId = 1
}
local dataList = {
	{
		487001,
		1,
		1,
		4820001,
		"开场剧情",
		0
	},
	{
		487001,
		2,
		1,
		4830001,
		"好感剧情1",
		10
	},
	{
		487001,
		2,
		2,
		4830002,
		"好感剧情2",
		20
	},
	{
		487001,
		2,
		3,
		4830003,
		"好感剧情3",
		30
	},
	{
		487001,
		4,
		1,
		4840001,
		"好感剧情1",
		10
	},
	{
		487001,
		4,
		2,
		4840002,
		"好感剧情2",
		20
	},
	{
		487001,
		4,
		3,
		4840003,
		"好感剧情3",
		30
	},
	{
		487001,
		3,
		1,
		4850001,
		"好感剧情1",
		10
	},
	{
		487001,
		3,
		2,
		4850002,
		"好感剧情2",
		20
	},
	{
		487001,
		3,
		3,
		4850003,
		"好感剧情3",
		30
	},
	{
		487001,
		5,
		1,
		4880001,
		"好感剧情1",
		10
	},
	{
		487001,
		5,
		2,
		4880002,
		"好感剧情2",
		20
	},
	{
		487001,
		5,
		3,
		4880003,
		"好感剧情3",
		30
	},
	{
		487001,
		6,
		1,
		4870001,
		"好感剧情1",
		10
	},
	{
		487001,
		6,
		2,
		4870002,
		"好感剧情2",
		20
	},
	{
		487001,
		6,
		3,
		4870003,
		"好感剧情3",
		30
	},
	{
		487001,
		7,
		1,
		4890001,
		"好感剧情1",
		10
	},
	{
		487001,
		7,
		2,
		4890002,
		"好感剧情2",
		20
	},
	{
		487001,
		7,
		3,
		4890003,
		"好感剧情3",
		30
	},
	{
		487001,
		8,
		1,
		4820004,
		"结尾剧情",
		210
	}
}
local t_island_station_story = {
	[487001] = {
		{
			dataList[1]
		},
		{
			dataList[2],
			dataList[3],
			dataList[4]
		},
		[4] = {
			dataList[5],
			dataList[6],
			dataList[7]
		},
		{
			dataList[8],
			dataList[9],
			dataList[10]
		},
		[5] = {
			dataList[11],
			dataList[12],
			dataList[13]
		},
		[6] = {
			dataList[14],
			dataList[15],
			dataList[16]
		},
		[7] = {
			dataList[17],
			dataList[18],
			dataList[19]
		},
		[8] = {
			dataList[20]
		}
	}
}

t_island_station_story.dataList = dataList

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

return t_island_station_story
