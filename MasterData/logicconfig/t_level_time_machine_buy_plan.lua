-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_level_time_machine_buy_plan.lua

module("logicconfig.config.t_level_time_machine_buy_plan", package.seeall)

local title = {
	costMp = 3,
	label = 4,
	planId = 1,
	times = 2
}
local dataList = {
	{
		1,
		1,
		"4:36:30",
		""
	},
	{
		1,
		2,
		"4:36:30",
		""
	},
	{
		1,
		3,
		"4:36:30",
		""
	},
	{
		2,
		1,
		"4:36:5",
		""
	},
	{
		2,
		2,
		"4:36:5",
		""
	},
	{
		2,
		3,
		"4:36:5",
		""
	},
	{
		2,
		4,
		"4:36:5",
		""
	}
}
local t_level_time_machine_buy_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_level_time_machine_buy_plan.dataList = dataList

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

return t_level_time_machine_buy_plan
