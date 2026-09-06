-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_gate_sub_tab.lua

module("logicconfig.config.t_time_gate_sub_tab", package.seeall)

local title = {
	subTabId = 1,
	subTabName = 3,
	type = 2
}
local dataList = {
	{
		1,
		1,
		"源起精灵"
	},
	{
		2,
		2,
		"神曜精灵"
	},
	{
		3,
		3,
		"传说精灵"
	}
}
local t_time_gate_sub_tab = {
	{
		dataList[1]
	},
	{
		[2] = dataList[2]
	},
	{
		[3] = dataList[3]
	}
}

t_time_gate_sub_tab.dataList = dataList

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

return t_time_gate_sub_tab
