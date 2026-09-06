-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xiu_er_extreme_clg_stage.lua

module("logicconfig.config.t_divine_xiu_er_extreme_clg_stage", package.seeall)

local title = {
	dataBitId = 3,
	activityId = 1,
	creepsMasterId = 4,
	stageType = 5,
	tierId = 2,
	tureFalseStageId = 6
}
local dataList = {
	{
		329001,
		1,
		1,
		1001,
		0,
		0
	},
	{
		329001,
		1,
		2,
		1002,
		0,
		0
	},
	{
		329001,
		1,
		3,
		1003,
		0,
		0
	},
	{
		329001,
		2,
		1,
		2001,
		1,
		0
	},
	{
		329001,
		2,
		2,
		2002,
		1,
		0
	},
	{
		329001,
		2,
		3,
		2003,
		1,
		0
	},
	{
		329001,
		3,
		1,
		3001,
		1,
		1
	},
	{
		329001,
		3,
		2,
		3002,
		1,
		2
	},
	{
		329001,
		3,
		3,
		3003,
		1,
		3
	},
	{
		329001,
		3,
		4,
		3004,
		0,
		4
	},
	{
		329001,
		3,
		5,
		3005,
		0,
		5
	},
	{
		329001,
		3,
		6,
		3006,
		0,
		6
	}
}
local t_divine_xiu_er_extreme_clg_stage = {
	[329001] = {
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
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		}
	}
}

t_divine_xiu_er_extreme_clg_stage.dataList = dataList

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

return t_divine_xiu_er_extreme_clg_stage
