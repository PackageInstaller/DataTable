-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_richman_building_tab.lua

module("logicconfig.config.t_richman_building_tab", package.seeall)

local title = {
	name = 3,
	types = 2,
	tabId = 1
}
local dataList = {
	{
		1,
		{
			3
		},
		"资源建筑"
	},
	{
		2,
		{
			4
		},
		"进攻建筑"
	},
	{
		3,
		{
			5
		},
		"防御建筑"
	}
}
local t_richman_building_tab = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_richman_building_tab.dataList = dataList

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

return t_richman_building_tab
