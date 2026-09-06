-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiaonuo_assistant_tab.lua

module("logicconfig.config.t_xiaonuo_assistant_tab", package.seeall)

local title = {
	tabName = 2,
	tabId = 1
}
local dataList = {
	{
		1,
		"资源"
	},
	{
		2,
		"玩法"
	},
	{
		3,
		"休闲"
	},
	{
		4,
		"商城"
	}
}
local t_xiaonuo_assistant_tab = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_xiaonuo_assistant_tab.dataList = dataList

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

return t_xiaonuo_assistant_tab
