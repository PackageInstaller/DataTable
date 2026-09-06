-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_answer_problem_plot.lua

module("logicconfig.config.t_answer_problem_plot", package.seeall)

local title = {
	typePlanId = 5,
	timeout = 3,
	timeDes = 6,
	dailyTimes = 2,
	activityId = 1,
	scoreLimit = 4
}
local dataList = {
	{
		212001,
		3,
		60,
		30,
		1,
		"活动时间：<color=#20B376FF><size=18>11.04 5:00 - 11.25 5:00</size></color>"
	},
	{
		212002,
		3,
		60,
		30,
		2,
		"活动时间：<color=#20B376FF><size=18>03.03 5:00 - 03.10 5:00</size></color>"
	}
}
local t_answer_problem_plot = {
	[212001] = dataList[1],
	[212002] = dataList[2]
}

t_answer_problem_plot.dataList = dataList

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

return t_answer_problem_plot
