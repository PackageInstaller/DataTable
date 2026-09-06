-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_gate_tab.lua

module("logicconfig.config.t_time_gate_tab", package.seeall)

local title = {
	tabId = 2,
	tabName = 3,
	type = 1
}
local dataList = {
	{
		1,
		1,
		"普通挑战"
	},
	{
		2,
		1,
		"高阶挑战"
	}
}
local t_time_gate_tab = {
	{
		dataList[1]
	},
	{
		dataList[2]
	}
}

t_time_gate_tab.dataList = dataList

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

return t_time_gate_tab
