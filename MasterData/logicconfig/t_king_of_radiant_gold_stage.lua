-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_of_radiant_gold_stage.lua

module("logicconfig.config.t_king_of_radiant_gold_stage", package.seeall)

local title = {
	param = 8,
	scorePlanId = 5,
	challengeId = 2,
	type = 7,
	stageId = 3,
	desc = 9,
	conPath = 6,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		462001,
		1,
		1,
		1001,
		1,
		"goddessshop/board_ns_aoqi_01",
		"BUFF_NUM",
		"30000078",
		"暴击次数"
	},
	{
		462001,
		1,
		2,
		1002,
		1,
		"goddessshop/board_ns_aoqi_01",
		"BUFF_NUM",
		"30000031",
		"连击次数"
	},
	{
		462001,
		1,
		3,
		1003,
		1,
		"goddessshop/board_ns_aoqi_01",
		"BUFF_NUM",
		"30000080",
		"超杀次数"
	},
	{
		462001,
		2,
		1,
		1004,
		2,
		"goddessshop/board_ns_aoqi_02",
		"ACTIVE_NUM",
		"",
		"存活数量"
	},
	{
		462001,
		2,
		2,
		1005,
		2,
		"goddessshop/board_ns_aoqi_02",
		"ACTIVE_NUM",
		"",
		"存活数量"
	},
	{
		462001,
		2,
		3,
		1006,
		2,
		"goddessshop/board_ns_aoqi_02",
		"ACTIVE_NUM",
		"",
		"存活数量"
	},
	{
		462001,
		3,
		1,
		1007,
		0,
		"goddessshop/board_ns_aoqi_03",
		"",
		"",
		""
	},
	{
		462001,
		3,
		2,
		1008,
		0,
		"goddessshop/board_ns_aoqi_03",
		"",
		"",
		""
	},
	{
		462001,
		3,
		3,
		1009,
		0,
		"goddessshop/board_ns_aoqi_03",
		"",
		"",
		""
	}
}
local t_king_of_radiant_gold_stage = {
	[462001] = {
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
	}
}

t_king_of_radiant_gold_stage.dataList = dataList

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

return t_king_of_radiant_gold_stage
