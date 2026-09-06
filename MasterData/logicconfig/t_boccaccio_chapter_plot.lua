-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_chapter_plot.lua

module("logicconfig.config.t_boccaccio_chapter_plot", package.seeall)

local title = {
	plotId = 2,
	unlockType = 5,
	storyId = 4,
	unlockParams = 6,
	title = 3,
	activityId = 1
}
local dataList = {
	{
		580001,
		1,
		"执笔之神",
		4920032,
		"first_enter",
		"boccacciochapterhomeview"
	},
	{
		580001,
		2,
		"生息盈绿",
		4920033,
		"pass_C1_stage",
		"6"
	},
	{
		580001,
		3,
		"圣心求祷",
		4920034,
		"pass_C1_stage",
		"12"
	},
	{
		580001,
		4,
		"灵感新篇",
		4920035,
		"is_C2_all_right",
		"1"
	},
	{
		580001,
		5,
		"枯竭之始",
		4920043,
		"eat_C3_pet_Count",
		"3"
	},
	{
		580001,
		6,
		"新的希望",
		4920044,
		"eat_C3_pet_Count",
		"6"
	},
	{
		580001,
		7,
		"笔耕不辍",
		4920045,
		"total_C4_damage",
		"450000000"
	},
	{
		580001,
		8,
		"妙笔生花",
		4920046,
		"total_C4_damage",
		"2000000000"
	}
}
local t_boccaccio_chapter_plot = {
	[580001] = {
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

t_boccaccio_chapter_plot.dataList = dataList

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

return t_boccaccio_chapter_plot
