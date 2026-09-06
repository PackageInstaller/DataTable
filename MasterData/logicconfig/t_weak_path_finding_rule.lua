-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_weak_path_finding_rule.lua

module("logicconfig.config.t_weak_path_finding_rule", package.seeall)

local title = {
	id = 1,
	resPath = 3,
	desc = 2
}
local dataList = {
	{
		1,
		"点击两侧火焰晶石，即可为精灵注入能量",
		"weakpathfinding/board_05"
	},
	{
		2,
		"在倒计时结束前，为精灵注入指定数值区间的能量，即为成功",
		"weakpathfinding/board_06"
	}
}
local t_weak_path_finding_rule = {
	dataList[1],
	dataList[2]
}

t_weak_path_finding_rule.dataList = dataList

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

return t_weak_path_finding_rule
