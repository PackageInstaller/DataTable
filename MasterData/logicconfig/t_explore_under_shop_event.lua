-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_explore_under_shop_event.lua

module("logicconfig.config.t_explore_under_shop_event", package.seeall)

local title = {
	planId = 1,
	itemPlanId = 2
}
local dataList = {
	{
		1,
		1
	},
	{
		1,
		2
	},
	{
		1,
		3
	},
	{
		1,
		4
	},
	{
		1,
		5
	}
}
local t_explore_under_shop_event = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_explore_under_shop_event.dataList = dataList

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

return t_explore_under_shop_event
