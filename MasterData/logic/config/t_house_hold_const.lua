-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_hold_const.lua

module("logic.config.t_house_hold_const", package.seeall)

local title = {
	floatValue = 3,
	key = 1,
	numValues = 5,
	strValue = 4,
	numValue = 2
}
local dataList = {
	{
		"BaseDefaultProduction",
		20,
		0,
		""
	},
	{
		"CharacterDefaultProduction",
		10,
		0,
		""
	},
	{
		"InitActiveRooms",
		0,
		0,
		"",
		{
			1101
		}
	},
	{
		"UnlockRoomCost_2",
		0,
		0,
		"{1100001:2,1100001:2}"
	},
	{
		"UnlockRoomCost_3",
		0,
		0,
		"{1100001:2}"
	},
	{
		"UnlockRoomCost_4",
		0,
		0,
		"{1100001:2}"
	},
	{
		"UnlockRoomCost_5",
		0,
		0,
		"{1100001:2}"
	},
	{
		"UnlockRoomCost_6",
		0,
		0,
		"{1100001:2}"
	},
	{
		"TouchWayWeight",
		0,
		0,
		"{1:100,2:100,3:100,4:100,5:100,6:100}"
	},
	{
		"TouchWayWeightAdd",
		200,
		0,
		""
	},
	{
		"TouchWayWeightDec",
		0,
		0,
		""
	},
	{
		"BillboardCount",
		3,
		0,
		""
	},
	{
		"EchoRewardAdd",
		0,
		0,
		"[研究点数加成/级,奖励数量加成/级,回响产出概率加成/级]",
		{
			10,
			10,
			10
		}
	},
	{
		"MaxReportCount",
		10,
		0,
		""
	},
	{
		"ReportSpeedUpCostItem",
		1701001,
		0,
		""
	},
	{
		"ReportSpeedUpMinute",
		5,
		0,
		""
	},
	{
		"MaxResearchPoint",
		99999,
		0,
		""
	},
	{
		"ReportRetainDay",
		1,
		0,
		""
	},
	{
		"MaxScore",
		30,
		0,
		""
	},
	{
		"FullEvaluateSchedule",
		10,
		0,
		""
	}
}
local t_house_hold_const = {}

t_house_hold_const.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_house_hold_const[v[1]] = v

	setmetatable(v, mt)
end

return t_house_hold_const
