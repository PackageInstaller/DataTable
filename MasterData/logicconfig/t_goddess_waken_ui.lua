-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_waken_ui.lua

module("logicconfig.config.t_goddess_waken_ui", package.seeall)

local title = {
	color8 = 11,
	goddessId = 2,
	color5 = 8,
	color3 = 6,
	color6 = 9,
	taskBgName = 3,
	planId = 1,
	color9 = 12,
	color4 = 7,
	color1 = 4,
	color2 = 5,
	color7 = 10
}
local dataList = {
	{
		1,
		1,
		"board_ns_01",
		"263268FF",
		"ACF0FFFF",
		"FFFFFFFF",
		"FFFFFF00",
		"FFFFFFFF",
		"FFFFFFFF",
		"FFFFFF00",
		"FFFFFFFF",
		"FFFFFFFF"
	},
	{
		1,
		2,
		"board_ns_08",
		"C50000FF",
		"FFFFB3FF",
		"FFFFE9FF",
		"FFF9B6FF",
		"C11A44FF",
		"E42C2CFF",
		"FFF9B6FF",
		"C11A44FF",
		"E42C2CFF"
	}
}
local t_goddess_waken_ui = {
	{
		dataList[1],
		dataList[2]
	}
}

t_goddess_waken_ui.dataList = dataList

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

return t_goddess_waken_ui
