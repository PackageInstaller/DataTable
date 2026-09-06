-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_ji_extreme_stage.lua

module("logicconfig.config.t_summon_master_ji_extreme_stage", package.seeall)

local title = {
	stageId = 2,
	name = 5,
	stageScorePlanId = 3,
	openTime = 6,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		348001,
		1,
		1,
		2003,
		"水",
		"2024-04-03T05:00:00"
	},
	{
		348001,
		2,
		1,
		2004,
		"火",
		"2024-04-03T05:00:00"
	},
	{
		348001,
		3,
		1,
		2005,
		"草",
		"2024-04-04T05:00:00"
	},
	{
		348001,
		4,
		1,
		2001,
		"光",
		"2024-04-04T05:00:00"
	},
	{
		348001,
		5,
		1,
		2002,
		"暗",
		"2024-04-05T05:00:00"
	}
}
local t_summon_master_ji_extreme_stage = {
	[348001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_summon_master_ji_extreme_stage.dataList = dataList

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

return t_summon_master_ji_extreme_stage
