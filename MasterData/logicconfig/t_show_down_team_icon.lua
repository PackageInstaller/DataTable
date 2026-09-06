-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_show_down_team_icon.lua

module("logicconfig.config.t_show_down_team_icon", package.seeall)

local title = {
	iconId = 2,
	teamIconPlanId = 1,
	iconPath = 3
}
local dataList = {
	{
		1,
		1,
		"icon_zhanduihuizhang_01"
	},
	{
		1,
		2,
		"icon_zhanduihuizhang_02"
	},
	{
		1,
		3,
		"icon_zhanduihuizhang_03"
	},
	{
		1,
		4,
		"icon_zhanduihuizhang_04"
	},
	{
		1,
		5,
		"icon_zhanduihuizhang_05"
	},
	{
		1,
		6,
		"icon_zhanduihuizhang_06"
	}
}
local t_show_down_team_icon = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_show_down_team_icon.dataList = dataList

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

return t_show_down_team_icon
