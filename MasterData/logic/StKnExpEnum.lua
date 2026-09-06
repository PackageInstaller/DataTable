-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/data/StKnExpEnum.lua

module("logic.extensions.stknexp.data.StKnExpEnum", package.seeall)

local StKnExpEnum = {}

StKnExpEnum.ClgType_Stage = 1
StKnExpEnum.ClgType_Boss = 2
StKnExpEnum.ClgTypeList = {
	StKnExpEnum.ClgType_Stage,
	StKnExpEnum.ClgType_Boss
}
StKnExpEnum.ClgTypeNames = {
	[StKnExpEnum.ClgType_Stage] = "区域守卫",
	[StKnExpEnum.ClgType_Boss] = "区域Boss"
}
StKnExpEnum.StageBgFields = {
	"nearBg",
	"middleBg",
	"farBg"
}
StKnExpEnum.CultType_Pet = "pet"
StKnExpEnum.CultType_EquipWeapon = "equipweapon"
StKnExpEnum.CultType_EquipClothes = "equipclothes"
StKnExpEnum.CultType_EquipHelmet = "equiphelmet"
StKnExpEnum.CultType_EquipShose = "equipshose"
StKnExpEnum.CultType_StarGod = "stargod"
StKnExpEnum.CultType_HolyStripe = "holystripe"
StKnExpEnum.CultType_CutePet = "cutepet"
StKnExpEnum.CultTypeList = {
	StKnExpEnum.CultType_Pet,
	StKnExpEnum.CultType_EquipWeapon,
	StKnExpEnum.CultType_EquipClothes,
	StKnExpEnum.CultType_EquipHelmet,
	StKnExpEnum.CultType_EquipShose,
	StKnExpEnum.CultType_StarGod,
	StKnExpEnum.CultType_HolyStripe,
	StKnExpEnum.CultType_CutePet
}
StKnExpEnum.CultNames = {
	[StKnExpEnum.CultType_Pet] = "精灵",
	[StKnExpEnum.CultType_EquipWeapon] = "武器",
	[StKnExpEnum.CultType_EquipClothes] = "衣服",
	[StKnExpEnum.CultType_EquipHelmet] = "头盔",
	[StKnExpEnum.CultType_EquipShose] = "靴子",
	[StKnExpEnum.CultType_StarGod] = "星神",
	[StKnExpEnum.CultType_HolyStripe] = "灵纹",
	[StKnExpEnum.CultType_CutePet] = "萌宠"
}
StKnExpEnum.CultExpFields = {
	[StKnExpEnum.CultType_Pet] = "petLevelExp",
	[StKnExpEnum.CultType_EquipWeapon] = "equipmentWeaponExp",
	[StKnExpEnum.CultType_EquipClothes] = "equipmentClothExp",
	[StKnExpEnum.CultType_EquipHelmet] = "equipmentHelmetExp",
	[StKnExpEnum.CultType_EquipShose] = "equipmentShoeExp",
	[StKnExpEnum.CultType_StarGod] = "starGodExp",
	[StKnExpEnum.CultType_HolyStripe] = "holyStripeExp",
	[StKnExpEnum.CultType_CutePet] = "cutePetExp"
}
StKnExpEnum.CultLevelFuncFields = {
	[StKnExpEnum.CultType_Pet] = "getPetLevelCfg",
	[StKnExpEnum.CultType_EquipWeapon] = "getEquExpCfg",
	[StKnExpEnum.CultType_EquipClothes] = "getEquExpCfg",
	[StKnExpEnum.CultType_EquipHelmet] = "getEquExpCfg",
	[StKnExpEnum.CultType_EquipShose] = "getEquExpCfg",
	[StKnExpEnum.CultType_StarGod] = "getStarGodLevelCfg",
	[StKnExpEnum.CultType_HolyStripe] = "getHolyStripeCfg",
	[StKnExpEnum.CultType_CutePet] = "getCutePetCfg"
}
StKnExpEnum.CultTypeEquips = {
	[PetEquipModel.EquipPos.EquipArms] = StKnExpEnum.CultType_EquipWeapon,
	[PetEquipModel.EquipPos.EquipClothes] = StKnExpEnum.CultType_EquipClothes,
	[PetEquipModel.EquipPos.EquipHelmet] = StKnExpEnum.CultType_EquipHelmet,
	[PetEquipModel.EquipPos.EquipShose] = StKnExpEnum.CultType_EquipShose
}
StKnExpEnum.GameCondType_IslandLevel = "islandLevel"

return StKnExpEnum
