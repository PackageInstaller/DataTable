-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dark_mm_challenge_stage.lua

module("logicconfig.config.t_origin_dark_mm_challenge_stage", package.seeall)

local title = {
	stageId = 2,
	activityId = 1,
	costPlanId = 5,
	creepsMasterId = 3,
	actionPoints = 4
}
local dataList = {
	{
		603001,
		1,
		1001,
		300,
		1
	},
	{
		603001,
		2,
		1002,
		300,
		1
	},
	{
		603001,
		3,
		1003,
		300,
		1
	},
	{
		603001,
		4,
		1004,
		300,
		1
	},
	{
		603001,
		5,
		1005,
		300,
		1
	},
	{
		603001,
		6,
		1006,
		300,
		1
	}
}
local t_origin_dark_mm_challenge_stage = {
	[603001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_origin_dark_mm_challenge_stage.dataList = dataList

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

return t_origin_dark_mm_challenge_stage
