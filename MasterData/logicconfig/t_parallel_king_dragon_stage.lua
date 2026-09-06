-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_parallel_king_dragon_stage.lua

module("logicconfig.config.t_parallel_king_dragon_stage", package.seeall)

local title = {
	stageId = 2,
	activityId = 1,
	creepsMasterId = 3,
	treasurePosition = 5,
	prize = 4
}
local dataList = {
	{
		519001,
		1,
		1001,
		"",
		{
			0,
			0,
			0,
			1,
			0,
			0,
			0,
			0,
			0
		}
	},
	{
		519001,
		2,
		1002,
		"",
		{
			0,
			0,
			0,
			0,
			0,
			2,
			0,
			0,
			0
		}
	},
	{
		519001,
		3,
		1003,
		"",
		{
			3,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	{
		519001,
		4,
		1004,
		"4:426:20",
		{
			0,
			0,
			0,
			0,
			0,
			0,
			4,
			0,
			0
		}
	},
	{
		519001,
		5,
		1005,
		"",
		{
			1,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			4
		}
	},
	{
		519001,
		6,
		1006,
		"",
		{
			0,
			0,
			2,
			0,
			0,
			3,
			0,
			0,
			0
		}
	},
	{
		519001,
		7,
		1007,
		"",
		{
			0,
			1,
			0,
			0,
			0,
			0,
			0,
			2,
			0
		}
	},
	{
		519001,
		8,
		1008,
		"4:426:40",
		{
			4,
			0,
			3,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	{
		519001,
		9,
		1009,
		"",
		{
			0,
			0,
			2,
			0,
			0,
			0,
			1,
			3,
			4
		}
	},
	{
		519001,
		10,
		1010,
		"",
		{
			0,
			2,
			0,
			0,
			1,
			0,
			0,
			4,
			3
		}
	},
	{
		519001,
		11,
		1011,
		"",
		{
			1,
			0,
			3,
			0,
			0,
			4,
			2,
			0,
			0
		}
	},
	{
		519001,
		12,
		1012,
		"4:426:60",
		{
			2,
			0,
			0,
			0,
			1,
			0,
			3,
			4,
			0
		}
	}
}
local t_parallel_king_dragon_stage = {
	[519001] = {
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
		dataList[12]
	}
}

t_parallel_king_dragon_stage.dataList = dataList

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

return t_parallel_king_dragon_stage
