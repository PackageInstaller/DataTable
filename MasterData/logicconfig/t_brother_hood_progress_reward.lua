-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_brother_hood_progress_reward.lua

module("logicconfig.config.t_brother_hood_progress_reward", package.seeall)

local title = {
	reward = 4,
	rewardPlan = 1,
	matchNum = 3,
	progress = 2
}
local dataList = {
	{
		1,
		1,
		1,
		"4:31:2"
	},
	{
		1,
		2,
		2,
		"4:31:2"
	},
	{
		1,
		3,
		3,
		"4:31:3"
	},
	{
		1,
		4,
		4,
		"4:31:3"
	},
	{
		1,
		5,
		5,
		"4:31:10"
	}
}
local t_brother_hood_progress_reward = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_brother_hood_progress_reward.dataList = dataList

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

return t_brother_hood_progress_reward
