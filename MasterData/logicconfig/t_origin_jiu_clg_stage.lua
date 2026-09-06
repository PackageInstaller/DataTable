-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_jiu_clg_stage.lua

module("logicconfig.config.t_origin_jiu_clg_stage", package.seeall)

local title = {
	stageId = 4,
	nameA = 6,
	phaseId = 3,
	creepsMasterIdA = 5,
	creepsMasterIdB = 7,
	modelId = 2,
	activityId = 1,
	nameB = 8
}
local dataList = {
	{
		577001,
		1,
		1,
		1,
		1001,
		"关卡1",
		0,
		""
	},
	{
		577001,
		1,
		1,
		2,
		1002,
		"关卡2",
		0,
		""
	},
	{
		577001,
		1,
		2,
		1,
		1003,
		"关卡1",
		0,
		""
	},
	{
		577001,
		1,
		2,
		2,
		1004,
		"关卡2",
		0,
		""
	},
	{
		577001,
		1,
		3,
		1,
		1005,
		"关卡1",
		0,
		""
	},
	{
		577001,
		1,
		3,
		2,
		1006,
		"关卡2",
		0,
		""
	},
	{
		577001,
		2,
		1,
		1,
		1008,
		"关卡1",
		0,
		""
	},
	{
		577001,
		2,
		1,
		2,
		1009,
		"关卡2",
		0,
		""
	},
	{
		577001,
		2,
		2,
		1,
		1010,
		"关卡1",
		0,
		""
	},
	{
		577001,
		2,
		2,
		2,
		1011,
		"关卡2",
		0,
		""
	},
	{
		577001,
		2,
		3,
		1,
		1012,
		"关卡1",
		0,
		""
	},
	{
		577001,
		2,
		3,
		2,
		1013,
		"关卡2",
		0,
		""
	}
}
local t_origin_jiu_clg_stage = {
	[577001] = {
		{
			{
				dataList[1],
				dataList[2]
			},
			{
				dataList[3],
				dataList[4]
			},
			{
				dataList[5],
				dataList[6]
			}
		},
		{
			{
				dataList[7],
				dataList[8]
			},
			{
				dataList[9],
				dataList[10]
			},
			{
				dataList[11],
				dataList[12]
			}
		}
	}
}

t_origin_jiu_clg_stage.dataList = dataList

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

return t_origin_jiu_clg_stage
