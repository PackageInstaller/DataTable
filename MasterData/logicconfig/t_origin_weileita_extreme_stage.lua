-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_weileita_extreme_stage.lua

module("logicconfig.config.t_origin_weileita_extreme_stage", package.seeall)

local title = {
	stageId = 2,
	winScoreRequirements = 5,
	creepsMasterId = 3,
	activityId = 1,
	selfPositionBuffs = 4
}
local dataList = {
	{
		561001,
		1,
		1001,
		{
			1,
			0,
			1,
			2,
			0,
			2,
			0,
			0,
			0
		},
		{
			2,
			3
		}
	},
	{
		561001,
		2,
		1002,
		{
			2,
			0,
			2,
			1,
			0,
			1,
			0,
			0,
			0
		},
		{
			3,
			1
		}
	},
	{
		561001,
		3,
		1003,
		{
			1,
			0,
			1,
			0,
			1,
			0,
			2,
			0,
			2
		},
		{
			2,
			3
		}
	},
	{
		561001,
		4,
		1004,
		{
			2,
			0,
			2,
			0,
			2,
			0,
			1,
			1,
			0
		},
		{
			3,
			1
		}
	},
	{
		561001,
		5,
		1005,
		{
			1,
			0,
			2,
			0,
			0,
			1,
			2,
			0,
			0
		},
		{
			2,
			3
		}
	},
	{
		561001,
		6,
		1006,
		{
			0,
			2,
			0,
			0,
			2,
			0,
			1,
			0,
			1
		},
		{
			3,
			1
		}
	}
}
local t_origin_weileita_extreme_stage = {
	[561001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_origin_weileita_extreme_stage.dataList = dataList

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

return t_origin_weileita_extreme_stage
