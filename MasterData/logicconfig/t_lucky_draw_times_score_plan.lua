-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lucky_draw_times_score_plan.lua

module("logicconfig.config.t_lucky_draw_times_score_plan", package.seeall)

local title = {
	activityId = 1,
	startTimes = 2
}
local dataList = {
	{
		25005,
		1
	},
	{
		25005,
		3
	},
	{
		25005,
		7
	},
	{
		25005,
		11
	},
	{
		25005,
		15
	},
	{
		25005,
		18
	},
	{
		25009,
		1
	},
	{
		25009,
		3
	},
	{
		25009,
		7
	},
	{
		25009,
		11
	},
	{
		25009,
		15
	},
	{
		25009,
		18
	}
}
local t_lucky_draw_times_score_plan = {
	[25005] = {
		dataList[1],
		[3] = dataList[2],
		[7] = dataList[3],
		[11] = dataList[4],
		[15] = dataList[5],
		[18] = dataList[6]
	},
	[25009] = {
		dataList[7],
		[3] = dataList[8],
		[7] = dataList[9],
		[11] = dataList[10],
		[15] = dataList[11],
		[18] = dataList[12]
	}
}

t_lucky_draw_times_score_plan.dataList = dataList

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

return t_lucky_draw_times_score_plan
