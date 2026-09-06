-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_order_clg_stage.lua

module("logicconfig.config.t_divine_king_order_clg_stage", package.seeall)

local title = {
	stageId = 2,
	openTime = 4,
	firstPassPrize = 5,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		357001,
		1,
		101,
		"2024-04-30T05:00:00",
		"4:234:5"
	},
	{
		357001,
		2,
		102,
		"2024-04-30T05:00:00",
		"4:234:5"
	},
	{
		357001,
		3,
		103,
		"2024-04-30T05:00:00",
		"4:234:5"
	},
	{
		357001,
		4,
		104,
		"2024-04-30T05:00:00",
		"4:234:10"
	},
	{
		357001,
		5,
		105,
		"2024-05-01T05:00:00",
		"4:234:5"
	},
	{
		357001,
		6,
		106,
		"2024-05-01T05:00:00",
		"4:234:5"
	},
	{
		357001,
		7,
		107,
		"2024-05-01T05:00:00",
		"4:234:5"
	},
	{
		357001,
		8,
		108,
		"2024-05-01T05:00:00",
		"4:234:10"
	},
	{
		357001,
		9,
		109,
		"2024-05-02T05:00:00",
		"4:234:10"
	},
	{
		357001,
		10,
		110,
		"2024-05-02T05:00:00",
		"4:234:10"
	},
	{
		357001,
		11,
		111,
		"2024-05-02T05:00:00",
		"4:234:10"
	},
	{
		357001,
		12,
		112,
		"2024-05-02T05:00:00",
		"4:234:20"
	},
	{
		357002,
		1,
		101,
		"2024-04-30T05:00:00",
		"8:1:1"
	},
	{
		357002,
		2,
		102,
		"2024-04-30T05:00:00",
		"8:1:1"
	},
	{
		357002,
		3,
		103,
		"2024-04-30T05:00:00",
		"8:1:1"
	},
	{
		357002,
		4,
		104,
		"2024-04-30T05:00:00",
		"8:1:1"
	},
	{
		357002,
		5,
		105,
		"2024-05-01T05:00:00",
		"8:1:1"
	},
	{
		357002,
		6,
		106,
		"2024-05-01T05:00:00",
		"8:1:1"
	},
	{
		357002,
		7,
		107,
		"2024-05-01T05:00:00",
		"8:1:1"
	},
	{
		357002,
		8,
		108,
		"2024-05-01T05:00:00",
		"8:1:1"
	},
	{
		357002,
		9,
		109,
		"2024-05-02T05:00:00",
		"8:1:1"
	},
	{
		357002,
		10,
		110,
		"2024-05-02T05:00:00",
		"8:1:1"
	},
	{
		357002,
		11,
		111,
		"2024-05-02T05:00:00",
		"8:1:1"
	},
	{
		357002,
		12,
		112,
		"2024-05-02T05:00:00",
		"8:1:1"
	}
}
local t_divine_king_order_clg_stage = {
	[357001] = {
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
	},
	[357002] = {
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	}
}

t_divine_king_order_clg_stage.dataList = dataList

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

return t_divine_king_order_clg_stage
