-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dual_trial_block.lua

module("logicconfig.config.t_dual_trial_block", package.seeall)

local title = {
	eventPlanId = 3,
	blockId = 2,
	activityId = 1
}
local dataList = {
	{
		468001,
		1,
		1
	},
	{
		468001,
		2,
		2
	},
	{
		468001,
		3,
		3
	},
	{
		468001,
		4,
		4
	},
	{
		468001,
		5,
		5
	},
	{
		468001,
		6,
		6
	},
	{
		468001,
		7,
		7
	},
	{
		468001,
		8,
		8
	},
	{
		468001,
		9,
		9
	}
}
local t_dual_trial_block = {
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

t_dual_trial_block.dataList = dataList

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

return t_dual_trial_block
