-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_psychic_ji_ext_stage.lua

module("logicconfig.config.t_origin_psychic_ji_ext_stage", package.seeall)

local title = {
	connectStage = 3,
	settlePlan = 6,
	stageId = 2,
	activityId = 1,
	creepsMasterId = 5,
	originEnergy = 4
}
local dataList = {
	{
		542001,
		1,
		{
			3,
			4
		},
		0,
		1001,
		{
			1
		}
	},
	{
		542001,
		2,
		{
			4,
			5
		},
		0,
		1002,
		{
			3
		}
	},
	{
		542001,
		3,
		{
			5,
			1
		},
		0,
		1003,
		{
			2
		}
	},
	{
		542001,
		4,
		{
			1,
			2
		},
		0,
		1004,
		{
			3
		}
	},
	{
		542001,
		5,
		{
			2,
			3
		},
		0,
		1005,
		{
			1
		}
	}
}
local t_origin_psychic_ji_ext_stage = {
	[542001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_origin_psychic_ji_ext_stage.dataList = dataList

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

return t_origin_psychic_ji_ext_stage
