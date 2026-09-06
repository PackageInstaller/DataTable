-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_dishitian_chapter.lua

module("logicconfig.config.t_dragon_dishitian_chapter", package.seeall)

local title = {
	starMapId = 5,
	name = 3,
	prize = 4,
	chapterId = 2,
	starNum = 6,
	openTime = 7,
	activityId = 1
}
local dataList = {
	{
		343001,
		1,
		"北斗七星1",
		"4:413:20",
		0,
		19,
		"2024-03-22T05:00:00"
	},
	{
		343001,
		2,
		"北斗七星2",
		"4:413:40",
		1,
		22,
		"2024-03-23T05:00:00"
	},
	{
		343001,
		3,
		"北斗七星3",
		"4:413:60",
		2,
		20,
		"2024-03-24T05:00:00"
	},
	{
		343002,
		1,
		"青龙天玑",
		"4:392:20",
		0,
		18,
		"2024-03-24T05:00:00"
	},
	{
		343002,
		2,
		"苍龙玉衡",
		"4:392:40",
		1,
		18,
		"2024-03-24T05:00:00"
	},
	{
		343002,
		3,
		"应龙开阳",
		"4:392:60",
		2,
		18,
		"2024-03-24T05:00:00"
	}
}
local t_dragon_dishitian_chapter = {
	[343001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[343002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_dragon_dishitian_chapter.dataList = dataList

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

return t_dragon_dishitian_chapter
