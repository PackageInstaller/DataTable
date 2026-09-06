-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mi_rui_ke_hud_jump2.lua

module("logicconfig.config.t_mi_rui_ke_hud_jump2", package.seeall)

local title = {
	id = 1,
	item = 3,
	desc = 2
}
local dataList = {
	{
		1,
		"璨光之心",
		"7:216008109:1"
	},
	{
		2,
		"梦想成真",
		"7:216008209:1"
	}
}
local t_mi_rui_ke_hud_jump2 = {
	dataList[1],
	dataList[2]
}

t_mi_rui_ke_hud_jump2.dataList = dataList

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

return t_mi_rui_ke_hud_jump2
