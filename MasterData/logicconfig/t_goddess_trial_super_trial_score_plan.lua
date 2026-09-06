-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_trial_super_trial_score_plan.lua

module("logicconfig.config.t_goddess_trial_super_trial_score_plan", package.seeall)

local title = {
	id = 2,
	filterPetCount = 3,
	score = 4,
	superTrialScorePlanId = 1
}
local dataList = {
	{
		1,
		1,
		0,
		0
	},
	{
		1,
		2,
		1,
		50
	},
	{
		1,
		3,
		2,
		100
	},
	{
		1,
		4,
		3,
		150
	},
	{
		1,
		5,
		4,
		250
	},
	{
		1,
		6,
		5,
		350
	},
	{
		1,
		7,
		6,
		500
	}
}
local t_goddess_trial_super_trial_score_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_goddess_trial_super_trial_score_plan.dataList = dataList

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

return t_goddess_trial_super_trial_score_plan
