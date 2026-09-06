-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_badge_level_plan_item.lua

module("logicconfig.config.t_badge_level_plan_item", package.seeall)

local title = {
	count = 3,
	planId = 1,
	level = 2
}
local dataList = {
	{
		1,
		1,
		200
	},
	{
		2,
		1,
		200
	},
	{
		2,
		2,
		300
	},
	{
		2,
		3,
		400
	},
	{
		2,
		4,
		500
	},
	{
		2,
		5,
		600
	},
	{
		2,
		6,
		800
	}
}
local t_badge_level_plan_item = {
	{
		dataList[1]
	},
	{
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_badge_level_plan_item.dataList = dataList

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

return t_badge_level_plan_item
