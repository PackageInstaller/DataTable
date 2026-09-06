-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ling_shen_convene_tab.lua

module("logicconfig.config.t_ling_shen_convene_tab", package.seeall)

local title = {
	iconPlanId = 3,
	activityId = 1,
	tabId = 2
}
local dataList = {
	{
		376001,
		1,
		1
	},
	{
		376001,
		2,
		2
	},
	{
		376001,
		3,
		3
	}
}
local t_ling_shen_convene_tab = {
	[376001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_ling_shen_convene_tab.dataList = dataList

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

return t_ling_shen_convene_tab
