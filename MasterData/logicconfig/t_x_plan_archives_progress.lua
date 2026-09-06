-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_x_plan_archives_progress.lua

module("logicconfig.config.t_x_plan_archives_progress", package.seeall)

local title = {
	prizeId = 2,
	need = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		378001,
		1,
		3,
		"104:2:88"
	},
	{
		378001,
		2,
		7,
		"104:2:88"
	},
	{
		378001,
		3,
		9,
		"104:2:88"
	},
	{
		378001,
		4,
		11,
		"13:283:1"
	},
	{
		378001,
		5,
		13,
		"104:2:88"
	},
	{
		378001,
		6,
		15,
		"104:2:88"
	},
	{
		378001,
		7,
		17,
		"104:2:88"
	},
	{
		378001,
		8,
		20,
		"14:276:1"
	}
}
local t_x_plan_archives_progress = {
	[378001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_x_plan_archives_progress.dataList = dataList

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

return t_x_plan_archives_progress
