-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cute_pet_other_config.lua

module("logicconfig.config.t_cute_pet_other_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CutePetMaxStar",
		"6"
	},
	{
		"CutePetMaxLevel",
		"100"
	},
	{
		"CutePetMaxQuality",
		"5"
	},
	{
		"CutePetStarReturnMaterialWhenDeleted",
		"8:37"
	},
	{
		"CutePetLvlReturnRateWhenDeleted",
		"0.9"
	},
	{
		"CutePetQualityReturnRateWhenDeleted",
		"0.9"
	},
	{
		"CutePetStrengthenInitialPropCost",
		"8:1:100000"
	},
	{
		"CutePetInGardenSceneMaxCount",
		"10"
	},
	{
		"CutePetGardenFirstOpenPrize",
		"4:11004:16"
	},
	{
		"InteractHappinessInitValue",
		"80"
	},
	{
		"InteractHappinessMinValue",
		"0"
	},
	{
		"InteractHappinessMaxValue",
		"100"
	},
	{
		"InteractHappinessPrize",
		"9:80063:1"
	},
	{
		"InteractHappinessGainPrizeValue",
		"90"
	},
	{
		"InteractHappinessDecPerNSecd",
		"1000"
	},
	{
		"GuestHouseCapacity",
		"8"
	},
	{
		"GuestHouseSpeedUpPlanId",
		"1"
	},
	{
		"GuestHouseGenCutePetPerNSecd",
		"57600"
	},
	{
		"GuestHouseGenCutePetRacePlanId",
		"1"
	},
	{
		"GuestHouseGenCutePetQualityPlanId",
		"1"
	},
	{
		"TravelDailyMaxCount",
		"1"
	},
	{
		"TravelCountEachCutePet",
		"3"
	},
	{
		"TravelGenCutePetRacePlanId",
		"1"
	},
	{
		"TravelGenCutePetQualityPlanId",
		"1"
	},
	{
		"TravelBuddyPairingWaitInviteMsgTimeoutSecd",
		"20"
	},
	{
		"TravelBuddyPairingReceiverSelectCutePetTimeoutSecd",
		"60"
	},
	{
		"TravelBuddyPairingInviterConfirmTimeoutSecd",
		"60"
	},
	{
		"DoubleTravelSurprisePrize",
		"9:80064:1"
	},
	{
		"CommunityNewsCount",
		"40"
	},
	{
		"ShopJumpTo",
		"func#470#ExchangeCutePet"
	},
	{
		"QuickLevelUpTime",
		"10"
	},
	{
		"PropZdlToScore",
		"1"
	},
	{
		"AssistanceZdlToScore",
		"1"
	},
	{
		"MaxCutePet",
		"101:1101:5:100:6"
	},
	{
		"QuickStrengeInitPropTime",
		"10"
	},
	{
		"CommunityBroadcastTimes",
		"10"
	},
	{
		"PresetCutePetCount",
		"3"
	},
	{
		"QuickParingTravelTimeoutSec",
		"2"
	},
	{
		"GardenMaxCapacityLimit",
		"800"
	},
	{
		"MATERIAL_CAPACITY_PET_START_LINE",
		"100"
	},
	{
		"MATERIAL_CAPACITY_INCR_PET_GAP",
		"15"
	},
	{
		"MATERIAL_CAPACITY_GAP_ADD_PERCENT",
		"5"
	},
	{
		"MATERIAL_CAPACITY_MAX_VALUE",
		"3000"
	}
}
local t_cute_pet_other_config = {
	CutePetMaxStar = dataList[1],
	CutePetMaxLevel = dataList[2],
	CutePetMaxQuality = dataList[3],
	CutePetStarReturnMaterialWhenDeleted = dataList[4],
	CutePetLvlReturnRateWhenDeleted = dataList[5],
	CutePetQualityReturnRateWhenDeleted = dataList[6],
	CutePetStrengthenInitialPropCost = dataList[7],
	CutePetInGardenSceneMaxCount = dataList[8],
	CutePetGardenFirstOpenPrize = dataList[9],
	InteractHappinessInitValue = dataList[10],
	InteractHappinessMinValue = dataList[11],
	InteractHappinessMaxValue = dataList[12],
	InteractHappinessPrize = dataList[13],
	InteractHappinessGainPrizeValue = dataList[14],
	InteractHappinessDecPerNSecd = dataList[15],
	GuestHouseCapacity = dataList[16],
	GuestHouseSpeedUpPlanId = dataList[17],
	GuestHouseGenCutePetPerNSecd = dataList[18],
	GuestHouseGenCutePetRacePlanId = dataList[19],
	GuestHouseGenCutePetQualityPlanId = dataList[20],
	TravelDailyMaxCount = dataList[21],
	TravelCountEachCutePet = dataList[22],
	TravelGenCutePetRacePlanId = dataList[23],
	TravelGenCutePetQualityPlanId = dataList[24],
	TravelBuddyPairingWaitInviteMsgTimeoutSecd = dataList[25],
	TravelBuddyPairingReceiverSelectCutePetTimeoutSecd = dataList[26],
	TravelBuddyPairingInviterConfirmTimeoutSecd = dataList[27],
	DoubleTravelSurprisePrize = dataList[28],
	CommunityNewsCount = dataList[29],
	ShopJumpTo = dataList[30],
	QuickLevelUpTime = dataList[31],
	PropZdlToScore = dataList[32],
	AssistanceZdlToScore = dataList[33],
	MaxCutePet = dataList[34],
	QuickStrengeInitPropTime = dataList[35],
	CommunityBroadcastTimes = dataList[36],
	PresetCutePetCount = dataList[37],
	QuickParingTravelTimeoutSec = dataList[38],
	GardenMaxCapacityLimit = dataList[39],
	MATERIAL_CAPACITY_PET_START_LINE = dataList[40],
	MATERIAL_CAPACITY_INCR_PET_GAP = dataList[41],
	MATERIAL_CAPACITY_GAP_ADD_PERCENT = dataList[42],
	MATERIAL_CAPACITY_MAX_VALUE = dataList[43]
}

t_cute_pet_other_config.dataList = dataList

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

return t_cute_pet_other_config
