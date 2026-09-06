-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_ji_extreme_stage_score.lua

module("logicconfig.config.t_summon_master_ji_extreme_stage_score", package.seeall)

local title = {
	itemId = 2,
	difficultyBuffs = 4,
	stageScorePlanId = 1,
	difficultyScores = 3
}
local dataList = {
	{
		1,
		1,
		{
			1,
			3,
			5
		},
		{
			7,
			8,
			9
		}
	},
	{
		1,
		2,
		{
			1,
			3,
			5
		},
		{
			10,
			11,
			12
		}
	},
	{
		1,
		3,
		{
			1,
			3,
			5
		},
		{
			13,
			14,
			15
		}
	}
}
local t_summon_master_ji_extreme_stage_score = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_summon_master_ji_extreme_stage_score.dataList = dataList

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

return t_summon_master_ji_extreme_stage_score
