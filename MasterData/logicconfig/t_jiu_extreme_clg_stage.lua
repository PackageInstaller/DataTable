-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jiu_extreme_clg_stage.lua

module("logicconfig.config.t_jiu_extreme_clg_stage", package.seeall)

local title = {
	stageId = 3,
	name = 4,
	phaseId = 2,
	balanceType = 6,
	creepsMasterId = 5,
	lockPetPlanId = 7,
	activityId = 1
}
local dataList = {
	{
		386001,
		1,
		1,
		"摄魂 Ⅰ-1",
		1001,
		1,
		1
	},
	{
		386001,
		1,
		2,
		"摄魂 Ⅰ-2",
		1002,
		1,
		1
	},
	{
		386001,
		1,
		3,
		"摄魂 Ⅰ-3",
		1003,
		1,
		1
	},
	{
		386001,
		1,
		4,
		"摄魂 Ⅰ-4",
		1004,
		1,
		1
	},
	{
		386001,
		1,
		5,
		"摄魂 Ⅰ-5",
		1005,
		1,
		1
	},
	{
		386001,
		2,
		1,
		"摄魂 Ⅰ-1",
		1006,
		2,
		2
	},
	{
		386001,
		2,
		2,
		"摄魂 Ⅱ-2",
		1007,
		2,
		2
	},
	{
		386001,
		2,
		3,
		"摄魂 Ⅱ-3",
		1008,
		2,
		2
	},
	{
		386001,
		2,
		4,
		"摄魂 Ⅱ-4",
		1009,
		2,
		2
	},
	{
		386001,
		2,
		5,
		"摄魂 Ⅱ-5",
		1010,
		2,
		2
	},
	{
		386001,
		3,
		1,
		"摄魂 Ⅲ-1",
		1011,
		1,
		1
	},
	{
		386001,
		3,
		2,
		"摄魂 Ⅲ-2",
		1012,
		2,
		2
	},
	{
		386001,
		3,
		3,
		"摄魂 Ⅲ-3",
		1013,
		1,
		1
	},
	{
		386001,
		3,
		4,
		"摄魂 Ⅲ-4",
		1014,
		2,
		2
	},
	{
		386001,
		3,
		5,
		"摄魂 Ⅲ-5",
		1015,
		1,
		1
	},
	{
		386002,
		1,
		1,
		"摄魂 Ⅰ-1",
		1001,
		1,
		1
	},
	{
		386002,
		1,
		2,
		"摄魂 Ⅰ-2",
		1002,
		1,
		1
	},
	{
		386002,
		1,
		3,
		"摄魂 Ⅰ-3",
		1003,
		1,
		1
	},
	{
		386002,
		1,
		4,
		"摄魂 Ⅰ-4",
		1004,
		1,
		1
	},
	{
		386002,
		1,
		5,
		"摄魂 Ⅰ-5",
		1005,
		1,
		1
	},
	{
		386002,
		2,
		1,
		"摄魂 Ⅰ-1",
		1006,
		2,
		2
	},
	{
		386002,
		2,
		2,
		"摄魂 Ⅱ-2",
		1007,
		2,
		2
	},
	{
		386002,
		2,
		3,
		"摄魂 Ⅱ-3",
		1008,
		2,
		2
	},
	{
		386002,
		2,
		4,
		"摄魂 Ⅱ-4",
		1009,
		2,
		2
	},
	{
		386002,
		2,
		5,
		"摄魂 Ⅱ-5",
		1010,
		2,
		2
	},
	{
		386002,
		3,
		1,
		"摄魂 Ⅲ-1",
		1011,
		1,
		1
	},
	{
		386002,
		3,
		2,
		"摄魂 Ⅲ-2",
		1012,
		2,
		2
	},
	{
		386002,
		3,
		3,
		"摄魂 Ⅲ-3",
		1013,
		1,
		1
	},
	{
		386002,
		3,
		4,
		"摄魂 Ⅲ-4",
		1014,
		2,
		2
	},
	{
		386002,
		3,
		5,
		"摄魂 Ⅲ-5",
		1015,
		1,
		1
	}
}
local t_jiu_extreme_clg_stage = {
	[386001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5]
		},
		{
			dataList[6],
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10]
		},
		{
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15]
		}
	},
	[386002] = {
		{
			dataList[16],
			dataList[17],
			dataList[18],
			dataList[19],
			dataList[20]
		},
		{
			dataList[21],
			dataList[22],
			dataList[23],
			dataList[24],
			dataList[25]
		},
		{
			dataList[26],
			dataList[27],
			dataList[28],
			dataList[29],
			dataList[30]
		}
	}
}

t_jiu_extreme_clg_stage.dataList = dataList

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

return t_jiu_extreme_clg_stage
