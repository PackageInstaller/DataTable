-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hot_search_note.lua

module("logicconfig.config.t_hot_search_note", package.seeall)

local title = {
	progressId = 3,
	activityId = 1,
	noteId = 2,
	desc = 4
}
local dataList = {
	{
		443001,
		1,
		1,
		"六艺之风席卷奥奇大陆"
	},
	{
		443001,
		2,
		2,
		"神秘外来飞行物降落奥奇大陆"
	},
	{
		443001,
		3,
		3,
		"阿瑞参与制作的美食节目即将播出"
	},
	{
		443001,
		4,
		4,
		"最新直播技术即将开放试用"
	},
	{
		443001,
		5,
		5,
		"资深记者蜜西西空降直播间"
	},
	{
		443001,
		6,
		6,
		"小天参与奥奇城最强大脑节目"
	},
	{
		443001,
		7,
		7,
		"网购下单风潮占领砂之城"
	},
	{
		443001,
		8,
		8,
		"王者竞技场最强训练师即将诞生"
	},
	{
		443001,
		9,
		9,
		"下届女神大赛即将火热开启"
	}
}
local t_hot_search_note = {
	[443001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_hot_search_note.dataList = dataList

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

return t_hot_search_note
