-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_teshamu_stage.lua

module("logicconfig.config.t_teshamu_stage", package.seeall)

local title = {
	stageId = 2,
	levelPlanId = 6,
	bgName = 7,
	mapPlanId = 4,
	mapMonsterPlanId = 5,
	openDays = 3,
	activityId = 1
}
local dataList = {
	{
		288001,
		1,
		0,
		1,
		1,
		1,
		"bg_teshamu_02"
	},
	{
		288001,
		2,
		0,
		2,
		2,
		1,
		"bg_teshamu_03"
	},
	{
		288001,
		3,
		0,
		3,
		3,
		1,
		"bg_teshamu_04"
	},
	{
		288002,
		1,
		0,
		28800201,
		28800201,
		288002,
		"bg_guangantianshi_02"
	},
	{
		288002,
		2,
		0,
		28800202,
		28800202,
		288002,
		"bg_guangantianshi_03"
	},
	{
		288002,
		3,
		0,
		28800203,
		28800203,
		288002,
		"bg_guangantianshi_04"
	}
}
local t_teshamu_stage = {
	[288001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[288002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_teshamu_stage.dataList = dataList

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

return t_teshamu_stage
