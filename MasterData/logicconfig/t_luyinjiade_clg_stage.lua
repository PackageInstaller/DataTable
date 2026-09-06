-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyinjiade_clg_stage.lua

module("logicconfig.config.t_luyinjiade_clg_stage", package.seeall)

local title = {
	stageId = 2,
	signBuffId = 4,
	specialScoreRatio = 5,
	buffName = 8,
	creepsMasterId = 3,
	areaName = 7,
	activityId = 1,
	circleLimit = 6
}
local dataList = {
	{
		465001,
		1,
		1001,
		20062804,
		1,
		5,
		"时之领域",
		"时之痕"
	},
	{
		465001,
		2,
		1002,
		20062806,
		1,
		5,
		"魂之领域",
		"魂之痕"
	},
	{
		465001,
		3,
		1003,
		20062809,
		1,
		5,
		"契之领域",
		"契之痕"
	}
}
local t_luyinjiade_clg_stage = {
	[465001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_luyinjiade_clg_stage.dataList = dataList

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

return t_luyinjiade_clg_stage
