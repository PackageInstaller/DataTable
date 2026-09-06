-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_red_point_set_view.lua

module("logicconfig.config.t_red_point_set_view", package.seeall)

local title = {
	tipsImagPath = 6,
	name = 2,
	tipsDesc = 5,
	detailId = 1,
	tipsTitle = 4,
	commandIdList = 3
}
local dataList = {
	{
		"1",
		"主界面活动图标红点隐藏",
		{
			1,
			2
		},
		"系统设置",
		"打开之后则隐藏主界面活动入口区域的红点，如下图中的活动入口按钮等，但不影响活动内的红点。",
		"ui/bigbg/redset/board_shezhi04"
	},
	{
		"2",
		"主界面功能图标红点隐藏",
		{
			3,
			4
		},
		"系统设置",
		"打开之后则隐藏主界面基础功能区域的红点，如下图中的功能入口按钮等，但不影响功能内的红点。",
		"ui/bigbg/redset/board_shezhi02"
	},
	{
		"3",
		"背包内红点隐藏",
		{
			6
		},
		"系统设置",
		"打开之后则隐藏背包内的红点。",
		"ui/bigbg/redset/board_shezhi01"
	},
	{
		"4",
		"快捷入口隐藏",
		{
			5
		},
		"系统设置",
		"打开之后则隐藏主界面快捷入口区域，如下图中的活动提示入口等。",
		"ui/bigbg/redset/board_shezhi03"
	}
}
local t_red_point_set_view = {
	["1"] = dataList[1],
	["2"] = dataList[2],
	["3"] = dataList[3],
	["4"] = dataList[4]
}

t_red_point_set_view.dataList = dataList

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

return t_red_point_set_view
