-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_brother_hood_plot_play.lua

module("logicconfig.config.t_brother_hood_plot_play", package.seeall)

local title = {
	reward = 5,
	iconName = 4,
	titleName = 3,
	plotPlan = 1,
	story = 2
}
local dataList = {
	{
		1,
		4360001,
		"情谊恒久",
		"brotherhood_1",
		"8:1:100000"
	},
	{
		2,
		4360003,
		"雷沙之契",
		"brotherhood_2",
		"8:1:100000"
	},
	{
		5,
		4360005,
		"信仰羁绊",
		"brotherhood_5",
		"8:1:100000"
	},
	{
		4,
		4360004,
		"生命之约",
		"brotherhood_4",
		"8:1:100000"
	},
	{
		3,
		4360002,
		"欢喜冤家",
		"brotherhood_3",
		"8:1:100000"
	},
	{
		6,
		0,
		"醒狮文化-演",
		"brotherhood_5",
		"8:1:100000"
	}
}
local t_brother_hood_plot_play = {
	dataList[1],
	dataList[2],
	[5] = dataList[3],
	[4] = dataList[4],
	dataList[5],
	[6] = dataList[6]
}

t_brother_hood_plot_play.dataList = dataList

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

return t_brother_hood_plot_play
