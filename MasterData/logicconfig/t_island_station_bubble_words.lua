-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_island_station_bubble_words.lua

module("logicconfig.config.t_island_station_bubble_words", package.seeall)

local title = {
	activityId = 1,
	bubbleId = 2,
	bubbleWord = 3
}
local dataList = {
	{
		487001,
		1,
		"这会是你最难忘的夜晚吗？"
	},
	{
		487001,
		2,
		"又见面了，你来得正是时候。"
	},
	{
		487001,
		3,
		"等你好久啦！"
	},
	{
		487001,
		4,
		"还不快点坐到我身边来。"
	},
	{
		487001,
		5,
		"泳池水温正好，要一起游么？"
	},
	{
		487001,
		6,
		"来一杯冰凉果饮么？"
	}
}
local t_island_station_bubble_words = {
	[487001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_island_station_bubble_words.dataList = dataList

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

return t_island_station_bubble_words
