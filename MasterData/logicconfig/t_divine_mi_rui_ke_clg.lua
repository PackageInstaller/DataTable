-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mi_rui_ke_clg.lua

module("logicconfig.config.t_divine_mi_rui_ke_clg", package.seeall)

local title = {
	challengeId = 2,
	jumpTo2 = 4,
	jumpTo1 = 3,
	activityId = 1,
	jumpTo3 = 5
}
local dataList = {
	{
		381001,
		175,
		"func#618#16025",
		"mibao#qijijianglin1",
		"mibao#shenyaolibao"
	}
}
local t_divine_mi_rui_ke_clg = {
	[381001] = dataList[1]
}

t_divine_mi_rui_ke_clg.dataList = dataList

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

return t_divine_mi_rui_ke_clg
