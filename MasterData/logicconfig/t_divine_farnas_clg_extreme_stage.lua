-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_farnas_clg_extreme_stage.lua

module("logicconfig.config.t_divine_farnas_clg_extreme_stage", package.seeall)

local title = {
	stageId = 2,
	signBuffId = 6,
	buffNeedCount = 7,
	type = 3,
	creepsMasterId = 5,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		522001,
		1,
		1,
		"毁灭关卡-1",
		1001,
		0,
		0
	},
	{
		522001,
		2,
		1,
		"毁灭关卡-2",
		1002,
		0,
		0
	},
	{
		522001,
		3,
		1,
		"毁灭关卡-3",
		1003,
		0,
		0
	},
	{
		522001,
		4,
		1,
		"毁灭关卡-4",
		1004,
		0,
		0
	},
	{
		522001,
		5,
		2,
		"新生关卡-1",
		1005,
		20052502,
		12
	},
	{
		522001,
		6,
		2,
		"新生关卡-2",
		1006,
		20052502,
		12
	},
	{
		522001,
		7,
		2,
		"新生关卡-3",
		1007,
		20052502,
		12
	},
	{
		522001,
		8,
		2,
		"新生关卡-4",
		1008,
		20052502,
		12
	}
}
local t_divine_farnas_clg_extreme_stage = {
	[522001] = {
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

t_divine_farnas_clg_extreme_stage.dataList = dataList

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

return t_divine_farnas_clg_extreme_stage
