-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_vacation_power_surge_progress.lua

module("logicconfig.config.t_vacation_power_surge_progress", package.seeall)

local title = {
	id = 2,
	needScore = 3,
	prize = 4,
	progressPlanId = 1
}
local dataList = {
	{
		1,
		1,
		3,
		"4:20000:400"
	},
	{
		1,
		2,
		5,
		"4:4002:100"
	},
	{
		1,
		3,
		8,
		"4:4001:100"
	},
	{
		1,
		4,
		12,
		"4:4005:100"
	},
	{
		1,
		5,
		20,
		"4:90085:100"
	},
	{
		2,
		1,
		3,
		"4:502:25"
	},
	{
		2,
		2,
		5,
		"4:502:50"
	},
	{
		2,
		3,
		8,
		"4:503:10"
	},
	{
		2,
		4,
		12,
		"4:503:20"
	},
	{
		2,
		5,
		20,
		"4:41004:1"
	},
	{
		3,
		1,
		3,
		"4:30002:20"
	},
	{
		3,
		2,
		5,
		"4:30002:50"
	},
	{
		3,
		3,
		8,
		"4:30003:20"
	},
	{
		3,
		4,
		12,
		"4:30003:30"
	},
	{
		3,
		5,
		20,
		"4:90004:1"
	}
}
local t_vacation_power_surge_progress = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_vacation_power_surge_progress.dataList = dataList

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

return t_vacation_power_surge_progress
