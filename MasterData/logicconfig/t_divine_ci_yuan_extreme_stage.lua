-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ci_yuan_extreme_stage.lua

module("logicconfig.config.t_divine_ci_yuan_extreme_stage", package.seeall)

local title = {
	stageId = 3,
	levelDescription = 6,
	passPrize = 5,
	tabId = 2,
	activityId = 1,
	teamIds = 4
}
local dataList = {
	{
		302001,
		1,
		1,
		{
			1001
		},
		"",
		"击败敌阵且存活至少3只精灵"
	},
	{
		302001,
		1,
		2,
		{
			1002
		},
		"",
		"击败敌阵且存活至少4只精灵"
	},
	{
		302001,
		1,
		3,
		{
			1003
		},
		"",
		"击败敌阵且存活至少5只精灵"
	},
	{
		302001,
		2,
		1,
		{
			1011,
			1012
		},
		"",
		"击败敌阵且己阵出手次数超过15次"
	},
	{
		302001,
		2,
		2,
		{
			1021,
			1022
		},
		"",
		"击败敌阵且己阵出手次数超过20次"
	},
	{
		302001,
		2,
		3,
		{
			1031,
			1032
		},
		"",
		"击败敌阵且己阵出手次数超过25次"
	},
	{
		302001,
		3,
		1,
		{
			1041,
			1042,
			1043
		},
		"",
		"击败敌阵，敌阵受到的群体伤害降低30%"
	},
	{
		302001,
		3,
		2,
		{
			1051,
			1052,
			1053
		},
		"",
		"击败敌阵，敌阵受到的群体伤害降低60%"
	},
	{
		302001,
		3,
		3,
		{
			1061,
			1062,
			1063
		},
		"",
		"击败敌阵，敌阵受到的群体伤害降低90%"
	},
	{
		302002,
		1,
		1,
		{
			1001
		},
		"",
		"击败敌阵且存活至少3只精灵"
	},
	{
		302002,
		1,
		2,
		{
			1002
		},
		"",
		"击败敌阵且存活至少4只精灵"
	},
	{
		302002,
		1,
		3,
		{
			1003
		},
		"",
		"击败敌阵且存活至少5只精灵"
	},
	{
		302002,
		2,
		1,
		{
			1011,
			1012
		},
		"",
		"击败敌阵且己阵出手次数超过15次"
	},
	{
		302002,
		2,
		2,
		{
			1021,
			1022
		},
		"",
		"击败敌阵且己阵出手次数超过20次"
	},
	{
		302002,
		2,
		3,
		{
			1031,
			1032
		},
		"",
		"击败敌阵且己阵出手次数超过25次"
	},
	{
		302002,
		3,
		1,
		{
			1041,
			1042,
			1043
		},
		"",
		"击败敌阵，敌阵受到的群体伤害降低30%"
	},
	{
		302002,
		3,
		2,
		{
			1051,
			1052,
			1053
		},
		"",
		"击败敌阵，敌阵受到的群体伤害降低60%"
	},
	{
		302002,
		3,
		3,
		{
			1061,
			1062,
			1063
		},
		"",
		"击败敌阵，敌阵受到的群体伤害降低90%"
	}
}
local t_divine_ci_yuan_extreme_stage = {
	[302001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9]
		}
	},
	[302002] = {
		{
			dataList[10],
			dataList[11],
			dataList[12]
		},
		{
			dataList[13],
			dataList[14],
			dataList[15]
		},
		{
			dataList[16],
			dataList[17],
			dataList[18]
		}
	}
}

t_divine_ci_yuan_extreme_stage.dataList = dataList

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

return t_divine_ci_yuan_extreme_stage
