-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luingard_clg_stage.lua

module("logicconfig.config.t_luingard_clg_stage", package.seeall)

local title = {
	stageId = 2,
	signBuffId = 4,
	specialScoreRatio = 5,
	circleLimit = 6,
	creepsMasterId = 3,
	areaName = 7,
	activityId = 1
}
local dataList = {
	{
		465001,
		1,
		1001,
		0,
		0.1,
		99,
		"时之领域"
	},
	{
		465001,
		2,
		1002,
		0,
		0.2,
		99,
		"魂之领域"
	},
	{
		465001,
		3,
		1003,
		0,
		0.3,
		99,
		"契之领域"
	}
}
local t_luingard_clg_stage = {
	[465001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_luingard_clg_stage.dataList = dataList

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

return t_luingard_clg_stage
