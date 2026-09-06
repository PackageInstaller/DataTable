-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ao_jiu_clg_extreme_stage.lua

module("logicconfig.config.t_divine_ao_jiu_clg_extreme_stage", package.seeall)

local title = {
	stageId = 2,
	systemPetPosPlan = 5,
	creepsMasterId = 3,
	buffIds = 4,
	activityId = 1
}
local dataList = {
	{
		511001,
		1,
		1001,
		{
			1,
			2,
			3,
			4
		},
		1
	},
	{
		511001,
		2,
		1002,
		{
			1,
			2,
			3,
			4
		},
		1
	},
	{
		511001,
		3,
		1003,
		{
			1,
			2,
			3,
			4
		},
		1
	},
	{
		511001,
		4,
		1004,
		{
			1,
			2,
			3,
			4
		},
		1
	},
	{
		511001,
		5,
		1005,
		{
			1,
			2,
			3,
			4
		},
		1
	},
	{
		511001,
		6,
		1006,
		{
			1,
			2,
			3,
			4
		},
		1
	},
	{
		511001,
		7,
		1007,
		{
			1,
			2,
			3,
			4
		},
		1
	},
	{
		511001,
		8,
		1008,
		{
			1,
			2,
			3,
			4
		},
		1
	},
	{
		511001,
		9,
		1009,
		{
			1,
			2,
			3,
			4
		},
		2
	},
	{
		511001,
		10,
		1010,
		{
			1,
			2,
			3,
			4
		},
		2
	},
	{
		511001,
		11,
		1011,
		{
			1,
			2,
			3,
			4
		},
		2
	},
	{
		511001,
		12,
		1012,
		{
			1,
			2,
			3,
			4
		},
		2
	},
	{
		511001,
		13,
		1013,
		{
			1,
			2,
			3,
			4
		},
		2
	},
	{
		511001,
		14,
		1014,
		{
			1,
			2,
			3,
			4
		},
		2
	},
	{
		511001,
		15,
		1015,
		{
			1,
			2,
			3,
			4
		},
		2
	},
	{
		511001,
		16,
		1016,
		{
			1,
			2,
			3,
			4
		},
		2
	}
}
local t_divine_ao_jiu_clg_extreme_stage = {
	[511001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_divine_ao_jiu_clg_extreme_stage.dataList = dataList

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

return t_divine_ao_jiu_clg_extreme_stage
