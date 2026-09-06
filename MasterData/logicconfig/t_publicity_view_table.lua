-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_publicity_view_table.lua

module("logicconfig.config.t_publicity_view_table", package.seeall)

local title = {
	tabName = 2,
	sloganIcon = 6,
	boardIcon = 7,
	tabId = 1,
	tag = 4,
	icon = 3,
	planId = 5
}
local dataList = {
	{
		1,
		"星神",
		"bg_llzz_05",
		"",
		1,
		"icon_jlsj_01",
		"board_jlsj_01"
	},
	{
		2,
		"装备",
		"bg_llzz_06",
		"最新",
		2,
		"icon_jlsj_04",
		"board_jlsj_04"
	},
	{
		3,
		"收藏品",
		"bg_llzz_02",
		"最热",
		3,
		"icon_jlsj_02",
		"board_jlsj_02"
	},
	{
		4,
		"坐骑",
		"bg_llzz_04",
		"",
		4,
		"icon_jlsj_05",
		"board_jlsj_05"
	},
	{
		5,
		"日常",
		"bg_llzz_03",
		"",
		5,
		"icon_jlsj_03",
		"board_jlsj_03"
	}
}
local t_publicity_view_table = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_publicity_view_table.dataList = dataList

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

return t_publicity_view_table
