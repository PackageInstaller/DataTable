-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_tarot_item_icon.lua

module("logicconfig.config.t_rich_man_x_plan_tarot_item_icon", package.seeall)

local title = {
	itemId = 2,
	iconRes = 3,
	activityId = 1
}
local dataList = {
	{
		373001,
		-1,
		"icon_zhadan"
	},
	{
		373001,
		1,
		"icon_taluoguiwei_03"
	},
	{
		373001,
		2,
		"icon_taluoguiwei_04"
	},
	{
		373001,
		3,
		"icon_taluoguiwei_08"
	}
}
local t_rich_man_x_plan_tarot_item_icon = {
	[373001] = {
		[-1] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_rich_man_x_plan_tarot_item_icon.dataList = dataList

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

return t_rich_man_x_plan_tarot_item_icon
