-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/model/EquipEnum.lua

module("logic.extensions.equipment.model.EquipEnum", package.seeall)

local EquipEnum = {}

EquipEnum.QualityName = {
	"d",
	"c",
	"b",
	"a",
	"s"
}
EquipEnum.EquipD6Quality2IconNum = {
	nil,
	"1",
	"2",
	"3",
	"4"
}
EquipEnum.QualityEnum = {
	[GameEnum.QualityEnum.C] = "tip_recyccle_green_name",
	[GameEnum.QualityEnum.B] = "tip_recyccle_blue_name",
	[GameEnum.QualityEnum.A] = "tip_recyccle_purple_name",
	[GameEnum.QualityEnum.S] = "tip_recyccle_orange_name"
}
EquipEnum.diceFiterTips = "DiceFiterTips"
EquipEnum.goldPerExp = "GoldPerExp"
EquipEnum.materialQuantityForBreak = "materialQuantityForBreak"
EquipEnum.equipmentBackpackLimit = "EquipmentBackpackCapacity"
EquipEnum.ReRollCostGoldBase = "ReRollCostGoldBase"
EquipEnum.RollCostGold = "RollCostGold"
EquipEnum.EquipExtraDecomposedItem = "EquipExtraDecomposedItem"
EquipEnum.MaxPartType = 3
EquipEnum.MaxAttrCount = 6
EquipEnum.MaxSuitCount = 3
EquipEnum.MaxDiceCount = 4
EquipEnum.MaxD6AttrHoleCount = 6
EquipEnum.FackAttrType = {
	ShowType = 2,
	RecycleType = 1,
	Recommended = 3
}
EquipEnum.DiceStatus = {
	Lock = 1,
	Unlocking = 4,
	Unlock = 2,
	CanUnLock = 3
}
EquipEnum.PartTypeList = {
	CommEnum.EquipPartType.Assist,
	CommEnum.EquipPartType.Defense,
	CommEnum.EquipPartType.Special
}
EquipEnum.PartTypeList2Index = {
	[CommEnum.EquipPartType.Assist] = 1,
	[CommEnum.EquipPartType.Defense] = 2,
	[CommEnum.EquipPartType.Special] = 3
}
EquipEnum.ColorMap = {
	White = Astral.ColorUtil.ParseColor("#D5D4D4"),
	Green = Astral.ColorUtil.ParseColor("#90A89F"),
	Blue = Astral.ColorUtil.ParseColor("#929FAE"),
	Purple = Astral.ColorUtil.ParseColor("#9F98AD"),
	Golden = Astral.ColorUtil.ParseColor("#CAA86D")
}
EquipEnum.AttrLevel2Color = {
	"#3c9056",
	"#3c89a5",
	"#3c89a5",
	"#9052E7",
	"#9052E7",
	"#d2833a",
	"#d2833a",
	"#d2833a",
	"#d2833a"
}
EquipEnum.AttrLevel2DiceIndex = {
	"01",
	"02",
	"02",
	"03",
	"03",
	"04",
	"04",
	"04",
	"04"
}
EquipEnum.d6Quality2DiceModel = {
	nil,
	"01",
	"02",
	"03",
	"04"
}
EquipEnum.HoleStatus = {
	Unalterable = 1,
	Unknown = 6,
	Unlock = 4,
	Seal = 5,
	Lock = 2,
	NoCalibration = 3
}
EquipEnum.IntensifyViewPage = {
	Intensify = 2,
	Detail = 1
}
EquipEnum.ModelStatus = {
	Gray = 3,
	Bright = 2,
	Normal = 1
}
EquipEnum.MainUIStatus = {
	Timing = 2,
	LvUp = 1,
	Retiming = 3
}
EquipEnum.IntensifySortType = {
	Quality = 2,
	Experience = 1,
	Level = 3
}
EquipEnum.LocalStorageKey = {
	QuickSelect = "QuickSelect"
}

return EquipEnum
