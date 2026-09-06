-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_event_define.lua

module("logicconfig.config.t_rich_man_x_plan_event_define", package.seeall)

local title = {
	iconRes = 3,
	name = 2,
	eventType = 1
}
local dataList = {
	{
		1,
		"土地格",
		"com_icon_fangzi"
	},
	{
		2,
		"商铺格",
		"com_icon_shangpuge"
	},
	{
		3,
		"博弈格",
		"com_icon_boyige"
	},
	{
		4,
		"摇奖格",
		"com_icon_yaojiangge"
	},
	{
		5,
		"占卜格",
		"com_icon_zhanbuge"
	},
	{
		6,
		"招募格",
		"com_icon_zhaomuqiyuge"
	},
	{
		7,
		"资源格",
		"icon_lihe"
	},
	{
		8,
		"爆冲格",
		"com_icon_baochongge"
	},
	{
		9,
		"幸运格",
		"com_icon_xingyunge"
	}
}
local t_rich_man_x_plan_event_define = {
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

t_rich_man_x_plan_event_define.dataList = dataList

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

return t_rich_man_x_plan_event_define
