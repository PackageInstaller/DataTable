-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_collector_main_tab.lua

module("logicconfig.config.t_goddess_collector_main_tab", package.seeall)

local title = {
	id = 1,
	name = 2,
	viewName = 3,
	redPointType = 4
}
local dataList = {
	{
		1,
		"收集女神",
		"goddesscollectorpetsview",
		1
	},
	{
		2,
		"收集女皮",
		"goddesscollectorpetskinsview",
		2
	}
}
local t_goddess_collector_main_tab = {
	dataList[1],
	dataList[2]
}

t_goddess_collector_main_tab.dataList = dataList

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

return t_goddess_collector_main_tab
