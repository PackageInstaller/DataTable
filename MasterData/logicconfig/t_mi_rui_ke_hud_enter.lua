-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mi_rui_ke_hud_enter.lua

module("logicconfig.config.t_mi_rui_ke_hud_enter", package.seeall)

local title = {
	raceId = 2,
	id = 1,
	jumpTo = 4,
	desc = 3
}
local dataList = {
	{
		1,
		16009,
		"极活跃活动",
		"func#551#1&&report_behavior#200922"
	},
	{
		2,
		16008,
		"蜜蕊可活动",
		"func#550#1&&report_behavior#200923"
	}
}
local t_mi_rui_ke_hud_enter = {
	dataList[1],
	dataList[2]
}

t_mi_rui_ke_hud_enter.dataList = dataList

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

return t_mi_rui_ke_hud_enter
