-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mi_rui_ke_hud_jump.lua

module("logicconfig.config.t_mi_rui_ke_hud_jump", package.seeall)

local title = {
	id = 1,
	title = 2,
	jumpTo = 4,
	desc = 3
}
local dataList = {
	{
		1,
		"页游签到",
		"免费得橙+1神器",
		"func#526#2"
	},
	{
		2,
		"精灵+满觉",
		"周年拼图活动",
		"func#526#2"
	}
}
local t_mi_rui_ke_hud_jump = {
	dataList[1],
	dataList[2]
}

t_mi_rui_ke_hud_jump.dataList = dataList

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

return t_mi_rui_ke_hud_jump
