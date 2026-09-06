-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_empress_normal_clg_progress_prize.lua

module("logicconfig.config.t_divine_empress_normal_clg_progress_prize", package.seeall)

local title = {
	progressId = 2,
	immunityTimes = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		485001,
		1,
		3,
		"4:90004:1"
	},
	{
		485001,
		2,
		6,
		"4:295:5"
	},
	{
		485001,
		3,
		9,
		"8:1:1000000"
	},
	{
		485001,
		4,
		12,
		"4:295:5"
	},
	{
		485001,
		5,
		15,
		"4:295:10"
	}
}
local t_divine_empress_normal_clg_progress_prize = {
	[485001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_divine_empress_normal_clg_progress_prize.dataList = dataList

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

return t_divine_empress_normal_clg_progress_prize
