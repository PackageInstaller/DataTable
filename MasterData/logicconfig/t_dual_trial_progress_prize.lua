-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dual_trial_progress_prize.lua

module("logicconfig.config.t_dual_trial_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	content = 4,
	activityId = 1,
	finishBlocks = 3
}
local dataList = {
	{
		468001,
		1,
		1,
		"4:36:10"
	},
	{
		468001,
		2,
		2,
		"4:90312:1"
	},
	{
		468001,
		3,
		3,
		"4:400002:50"
	},
	{
		468001,
		4,
		4,
		"4:30006:50"
	},
	{
		468001,
		5,
		5,
		"4:111:10"
	},
	{
		468001,
		6,
		6,
		"4:36:10"
	},
	{
		468001,
		7,
		7,
		"4:90312:1"
	},
	{
		468001,
		8,
		8,
		"4:400002:50"
	},
	{
		468001,
		9,
		9,
		"4:30006:50"
	}
}
local t_dual_trial_progress_prize = {
	[468001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_dual_trial_progress_prize.dataList = dataList

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

return t_dual_trial_progress_prize
