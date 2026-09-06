-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/config/TreasureRaiderConst.lua

module("logic.extensions.treasureraider.config.TreasureRaiderConst", package.seeall)

local TreasureRaiderConst = {}

TreasureRaiderConst.BuffType_UpgradePercent = "upgrade"
TreasureRaiderConst.BuffType_AttackPercent = "atkadd"
TreasureRaiderConst.TriggerType_AddRoll = 1
TreasureRaiderConst.TriggerType_AttackAwardAddition = 2
TreasureRaiderConst.TriggerType_NextUpgrade = 3
TreasureRaiderConst.TriggerType_AddMapEdit = 4
TreasureRaiderConst.TriggerType_AddFixedRoll = 5
TreasureRaiderConst.BuildingType_MainCamp = 1
TreasureRaiderConst.BuildingType_Effect = 2
TreasureRaiderConst.BuildingType_Resource = 3
TreasureRaiderConst.BuildingType_Offend = 4
TreasureRaiderConst.BuildingType_Defend = 5
TreasureRaiderConst.BuildingCanReconstructMap = {
	[TreasureRaiderConst.BuildingType_Offend] = true,
	[TreasureRaiderConst.BuildingType_Defend] = true
}
TreasureRaiderConst.BuildingCanBeAttackMap = {
	[TreasureRaiderConst.BuildingType_Resource] = true
}
TreasureRaiderConst.BuildingTypeEditDisableMap = {
	[TreasureRaiderConst.BuildingType_MainCamp] = true,
	[TreasureRaiderConst.BuildingType_Effect] = true
}
TreasureRaiderConst.BuildingClosestCanViewDescMap = {
	[TreasureRaiderConst.BuildingType_MainCamp] = true,
	[TreasureRaiderConst.BuildingType_Effect] = true
}
TreasureRaiderConst.BuildingUpgradeBuffNameMap = {
	[TreasureRaiderConst.BuildingType_Offend] = lang("精灵攻击效果"),
	[TreasureRaiderConst.BuildingType_Defend] = lang("精灵防御效果"),
	[TreasureRaiderConst.BuildingType_Resource] = lang("每10分钟产出")
}

function TreasureRaiderConst.getBuildingViewName(buildingType, isMyScene)
	if isMyScene then
		if buildingType == TreasureRaiderConst.BuildingType_MainCamp or buildingType == TreasureRaiderConst.BuildingType_Effect then
			return ViewName.TreasureraidedescView
		elseif buildingType == TreasureRaiderConst.BuildingType_Offend or buildingType == TreasureRaiderConst.BuildingType_Defend then
			return ViewName.TreasureraidedescView
		elseif buildingType == TreasureRaiderConst.BuildingType_Resource then
			return ViewName.TreasureraideresourcedescView
		end
	elseif buildingType == TreasureRaiderConst.BuildingType_MainCamp or buildingType == TreasureRaiderConst.BuildingType_Effect then
		return ViewName.TreasureraidedescView
	elseif buildingType == TreasureRaiderConst.BuildingType_Offend or buildingType == TreasureRaiderConst.BuildingType_Defend then
		return ViewName.TreasureraidedescView
	elseif buildingType == TreasureRaiderConst.BuildingType_Resource then
		return ViewName.TreasureraideattackView
	end
end

TreasureRaiderConst.ServerAction_Upgrade = 1
TreasureRaiderConst.ServerAction_Construct = 2
TreasureRaiderConst.ServerAction_Reconstruct = 3
TreasureRaiderConst.RandomDiceId = 11

return TreasureRaiderConst
