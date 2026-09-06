-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_tian_shan_clg_extreme_stage.lua

module("logicconfig.config.t_divine_tian_shan_clg_extreme_stage", package.seeall)

local title = {
	buffProgress = 8,
	stagePlanId = 1,
	phaseId = 3,
	stageId = 2,
	teamId = 4,
	clientBuffId = 7,
	signBuffId = 6,
	creepsMasterId = 5,
	exTips = 9
}
local dataList = {
	{
		1,
		1,
		1,
		1,
		1001,
		20063822,
		20063801,
		3,
		"风暴领域"
	},
	{
		1,
		2,
		1,
		2,
		1002,
		20063822,
		20063801,
		3,
		"风暴领域"
	},
	{
		1,
		3,
		2,
		1,
		1003,
		20063822,
		20063825,
		3,
		"雷电领域"
	},
	{
		1,
		4,
		2,
		2,
		1004,
		20063822,
		20063825,
		3,
		"雷电领域"
	},
	{
		1,
		5,
		3,
		1,
		1005,
		20063822,
		20063826,
		3,
		"骤雨领域"
	},
	{
		1,
		6,
		3,
		2,
		1006,
		20063822,
		20063826,
		3,
		"骤雨领域"
	},
	{
		1,
		7,
		4,
		1,
		1007,
		20063822,
		20063827,
		3,
		"冰雹领域"
	},
	{
		1,
		8,
		4,
		2,
		1008,
		20063822,
		20063827,
		3,
		"冰雹领域"
	}
}
local t_divine_tian_shan_clg_extreme_stage = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_divine_tian_shan_clg_extreme_stage.dataList = dataList

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

return t_divine_tian_shan_clg_extreme_stage
