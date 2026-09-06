-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_isaac_clg_stage.lua

module("logicconfig.config.t_divine_isaac_clg_stage", package.seeall)

local title = {
	stageId = 3,
	phaseId = 2,
	buffId = 4,
	enemyAttr = 8,
	needMetalNum = 9,
	creepsMasterId = 7,
	metalId = 5,
	activityId = 1,
	metalLimit = 6
}
local dataList = {
	{
		491001,
		1,
		1,
		{
			20064503,
			20064504
		},
		1,
		6,
		1001,
		"水",
		0
	},
	{
		491001,
		1,
		2,
		{
			20064505
		},
		2,
		6,
		1002,
		"暗",
		0
	},
	{
		491001,
		1,
		3,
		{
			20064507
		},
		3,
		6,
		1003,
		"创",
		0
	},
	{
		491001,
		2,
		1,
		{
			20064502,
			20064504
		},
		1,
		6,
		1004,
		"火",
		0
	},
	{
		491001,
		2,
		2,
		{
			20064506
		},
		2,
		6,
		1005,
		"光",
		0
	},
	{
		491001,
		2,
		3,
		{
			20064508
		},
		3,
		6,
		1006,
		"空",
		0
	},
	{
		491001,
		2,
		4,
		{
			20064502,
			20064503
		},
		1,
		6,
		1007,
		"草",
		0
	},
	{
		491001,
		2,
		5,
		{
			20064505
		},
		2,
		6,
		1008,
		"暗",
		0
	},
	{
		491001,
		3,
		1,
		{
			20064503,
			20064504
		},
		1,
		6,
		1009,
		"水",
		2
	},
	{
		491001,
		3,
		2,
		{
			20064502,
			20064504
		},
		1,
		6,
		1010,
		"火",
		2
	},
	{
		491001,
		3,
		3,
		{
			20064502,
			20064503
		},
		1,
		6,
		1011,
		"草",
		2
	},
	{
		491001,
		3,
		4,
		{
			20064506
		},
		2,
		6,
		1012,
		"光",
		3
	},
	{
		491001,
		3,
		5,
		{
			20064505
		},
		2,
		6,
		1013,
		"暗",
		3
	},
	{
		491001,
		3,
		6,
		{
			20064508
		},
		3,
		6,
		1014,
		"空",
		3
	},
	{
		491001,
		3,
		7,
		{
			20064507
		},
		3,
		6,
		1015,
		"创",
		3
	}
}
local t_divine_isaac_clg_stage = {
	[491001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		},
		{
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15]
		}
	}
}

t_divine_isaac_clg_stage.dataList = dataList

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

return t_divine_isaac_clg_stage
