-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_richman_common.lua

module("logicconfig.config.t_richman_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MaxResourceBuilding",
		"10"
	},
	{
		"DailyFreeEdit",
		"1"
	},
	{
		"DailyFreeFixedRoll",
		"6"
	},
	{
		"DailyAttack",
		"3"
	},
	{
		"DailyRevenge",
		"1"
	},
	{
		"FirstMatchZDL",
		"-100000:200000"
	},
	{
		"FirstMatchLevel",
		"-2:2"
	},
	{
		"MaxMatchZDL",
		"-1000000:1000000"
	},
	{
		"MaxMatchLevel",
		"-10:10"
	},
	{
		"RollNumGetAttack",
		"3"
	},
	{
		"AttackRollNum",
		"9"
	},
	{
		"AttackFixedRollNum",
		"6"
	},
	{
		"AttackInitPos",
		"21"
	},
	{
		"MaxStopResourceMinute",
		"240"
	},
	{
		"StartResourceMinute",
		"10"
	},
	{
		"FirstRollResult",
		"3"
	},
	{
		"RollMaterialCost",
		"66:11:1"
	},
	{
		"ShopActivityType",
		"230"
	},
	{
		"ShopActivityId",
		"230002"
	},
	{
		"AddRoll",
		"1"
	},
	{
		"AttackAwardAddition",
		"1000"
	},
	{
		"NextUpgrade",
		"1"
	},
	{
		"AddMapEdit",
		"1"
	},
	{
		"AddFixedRoll",
		"1"
	},
	{
		"JumpBattle",
		"3"
	}
}
local t_richman_common = {
	MaxResourceBuilding = dataList[1],
	DailyFreeEdit = dataList[2],
	DailyFreeFixedRoll = dataList[3],
	DailyAttack = dataList[4],
	DailyRevenge = dataList[5],
	FirstMatchZDL = dataList[6],
	FirstMatchLevel = dataList[7],
	MaxMatchZDL = dataList[8],
	MaxMatchLevel = dataList[9],
	RollNumGetAttack = dataList[10],
	AttackRollNum = dataList[11],
	AttackFixedRollNum = dataList[12],
	AttackInitPos = dataList[13],
	MaxStopResourceMinute = dataList[14],
	StartResourceMinute = dataList[15],
	FirstRollResult = dataList[16],
	RollMaterialCost = dataList[17],
	ShopActivityType = dataList[18],
	ShopActivityId = dataList[19],
	AddRoll = dataList[20],
	AttackAwardAddition = dataList[21],
	NextUpgrade = dataList[22],
	AddMapEdit = dataList[23],
	AddFixedRoll = dataList[24],
	JumpBattle = dataList[25]
}

t_richman_common.dataList = dataList

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

return t_richman_common
