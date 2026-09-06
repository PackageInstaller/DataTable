-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mi_rui_ke_hud_tab.lua

module("logicconfig.config.t_mi_rui_ke_hud_tab", package.seeall)

local title = {
	funcId = 6,
	parameter = 9,
	reportBehavior = 11,
	tagColor = 4,
	redpointId = 7,
	title = 2,
	limitTime = 10,
	viewname = 5,
	dayRedpointId = 8,
	id = 1,
	tagName = 3
}
local dataList = {
	{
		1,
		"精灵获得",
		"",
		0,
		"miruikewelfareview",
		0,
		"",
		"",
		"",
		"",
		""
	},
	{
		2,
		"养成福利",
		"",
		0,
		"miruikebuyview",
		0,
		"",
		"",
		"",
		"",
		""
	}
}
local t_mi_rui_ke_hud_tab = {
	dataList[1],
	dataList[2]
}

t_mi_rui_ke_hud_tab.dataList = dataList

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

return t_mi_rui_ke_hud_tab
