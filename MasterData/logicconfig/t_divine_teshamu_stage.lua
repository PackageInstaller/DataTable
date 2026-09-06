-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_teshamu_stage.lua

module("logicconfig.config.t_divine_teshamu_stage", package.seeall)

local title = {
	stageId = 3,
	canJumpId = 5,
	floorId = 2,
	supportPetPosition = 7,
	creepsMasterId = 4,
	soldierCount = 6,
	activityId = 1,
	supportPetCreepsId = 8
}
local dataList = {
	{
		504001,
		1,
		1,
		1001,
		{
			2,
			3
		},
		10,
		7,
		100000001
	},
	{
		504001,
		1,
		2,
		1002,
		{
			4
		},
		20,
		1,
		100000001
	},
	{
		504001,
		1,
		3,
		1003,
		{
			5
		},
		50,
		8,
		100000001
	},
	{
		504001,
		1,
		4,
		1004,
		{
			5
		},
		30,
		9,
		100000001
	},
	{
		504001,
		1,
		5,
		1005,
		{
			6
		},
		80,
		3,
		100000001
	},
	{
		504001,
		1,
		6,
		1006,
		nil,
		160,
		5,
		100000001
	},
	{
		504001,
		2,
		1,
		1007,
		{
			2,
			3
		},
		10,
		2,
		100000002
	},
	{
		504001,
		2,
		2,
		1008,
		{
			4
		},
		20,
		6,
		100000002
	},
	{
		504001,
		2,
		3,
		1009,
		{
			4
		},
		40,
		3,
		100000002
	},
	{
		504001,
		2,
		4,
		1010,
		{
			5,
			6
		},
		50,
		8,
		100000002
	},
	{
		504001,
		2,
		5,
		1011,
		{
			7
		},
		80,
		8,
		100000002
	},
	{
		504001,
		2,
		6,
		1012,
		{
			7
		},
		120,
		9,
		100000002
	},
	{
		504001,
		2,
		7,
		1013,
		nil,
		200,
		2,
		100000002
	},
	{
		504001,
		3,
		1,
		1014,
		{
			2,
			3
		},
		10,
		3,
		100000003
	},
	{
		504001,
		3,
		2,
		1015,
		{
			4,
			5
		},
		20,
		7,
		100000003
	},
	{
		504001,
		3,
		3,
		1016,
		{
			4,
			5
		},
		100,
		2,
		100000003
	},
	{
		504001,
		3,
		4,
		1017,
		{
			3,
			6
		},
		50,
		4,
		100000003
	},
	{
		504001,
		3,
		5,
		1018,
		{
			2,
			6
		},
		200,
		5,
		100000003
	},
	{
		504001,
		3,
		6,
		1019,
		nil,
		400,
		4,
		100000003
	}
}
local t_divine_teshamu_stage = {
	[504001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
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
			dataList[12],
			dataList[13]
		},
		{
			dataList[14],
			dataList[15],
			dataList[16],
			dataList[17],
			dataList[18],
			dataList[19]
		}
	}
}

t_divine_teshamu_stage.dataList = dataList

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

return t_divine_teshamu_stage
