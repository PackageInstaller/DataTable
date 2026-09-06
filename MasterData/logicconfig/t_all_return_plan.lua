-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_all_return_plan.lua

module("logicconfig.config.t_all_return_plan", package.seeall)

local title = {
	prize = 5,
	endTime = 4,
	id = 2,
	activityId = 1,
	startTime = 3
}
local dataList = {
	{
		107001,
		1,
		"2022-01-14T05:00:00",
		"2022-01-28T05:00:00",
		"8:1:5000"
	},
	{
		107001,
		2,
		"2022-01-28T05:00:00",
		"2022-02-04T05:00:00",
		"8:1:5000"
	},
	{
		107001,
		3,
		"2022-02-04T05:00:00",
		"2022-02-11T05:00:00",
		"8:1:5000"
	},
	{
		107001,
		4,
		"2022-02-11T05:00:00",
		"2022-02-18T05:00:00",
		"8:1:5000"
	}
}
local t_all_return_plan = {
	[107001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_all_return_plan.dataList = dataList

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

return t_all_return_plan
