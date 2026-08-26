-- chunkname: @modules/logic/critter/utils/CritterEnum.lua

module("modules.logic.critter.utils.CritterEnum", package.seeall)

local CritterEnum = _M

CritterEnum.InvalidCritterUid = "0"
CritterEnum.MoodFactor = 100
CritterEnum.CritterBuildingChangeBuildingAnimTime = 0.2
CritterEnum.ConstId = {
	HeroMoveRate = 15,
	DecomposeResult = 14,
	CritterTrainKeepTime = 16,
	SummonCost = 9,
	LowMood = 12,
	CritterBackpackCapacity = 8,
	IncubationFormula = 1,
	MaxPreviewCount = 13,
	DecomposeCountLimit = 17
}
CritterEnum.AttributeType = {
	Patience = 2,
	Efficiency = 1,
	MoodRestore = 10001,
	Lucky = 3
}
CritterEnum.OrderType = {
	MoodDown = 4,
	MoodUp = 3,
	RareDown = 2,
	RareUp = 1
}
CritterEnum.MatureFilterType = {
	Mature = 2,
	All = 1,
	NotMature = 3
}
CritterEnum.FilterType = {
	Race = 1,
	SkillTag = 2
}
CritterEnum.MatureFilterTypeName = {
	[CritterEnum.MatureFilterType.All] = "critter_mature_filter_all",
	[CritterEnum.MatureFilterType.Mature] = "critter_mature_filter_mature",
	[CritterEnum.MatureFilterType.NotMature] = "critter_mature_filter_not_mature"
}
CritterEnum.TagType = {
	Common = 2,
	Race = 3,
	Base = 1
}
CritterEnum.DecomposeMaxCount = 100
CritterEnum.CritterDecomposeMinRare = 3
CritterEnum.CritterDecomposeMaxRare = 5
CritterEnum.CritterMaxSeatCount = 6
CritterEnum.CritterScaleInSeatSlot = 0.06
CritterEnum.CritterPressingEffectScaleInSeatSlot = 0.7
CritterEnum.SeatSlotOperation = {
	Exchange = 1,
	Change = 0
}
CritterEnum.OneKeyType = {
	Manufacture = 1,
	Transport = 2
}
CritterEnum.EventType = {
	ActiveTime = 2,
	Special = 3,
	Normal = 1
}
CritterEnum.CritterItemEventType = {
	SurpriseCollect = 4,
	TrainEventComplete = 2,
	HasTrainEvent = 1,
	NoMoodWork = 3
}
CritterEnum.NormalEventId = {
	NormalGrow = 101
}
CritterEnum.NeedActionEventTypeDict = {
	[CritterEnum.EventType.ActiveTime] = true,
	[CritterEnum.EventType.Special] = true
}
CritterEnum.SkilTagType = {
	Common = 2,
	Race = 3,
	Base = 1
}
CritterEnum.PosType = {
	Right = 3,
	Middle = 2,
	Left = 1
}
CritterEnum.PreferenceType = {
	Catalogue = 2,
	All = 1,
	Critter = 3
}
CritterEnum.CatalogueType = {
	SubClass = 3,
	Class = 2,
	Genus = 6,
	Phylum = 1,
	Family = 5,
	Order = 4
}
CritterEnum.QualityImageNameMap = {
	"critter_manufacture_quality3",
	"critter_manufacture_quality3",
	"critter_manufacture_quality3",
	"critter_manufacture_quality4",
	"critter_manufacture_quality5"
}
CritterEnum.QualityEggImageNameMap = {
	"room_summon_egg_1",
	"room_summon_egg_1",
	"room_summon_egg_1",
	"room_summon_egg_2",
	"room_summon_egg_3"
}
CritterEnum.QualityEggLightImageNameMap = {
	"room_summon_egglight_1",
	"room_summon_egglight_1",
	"room_summon_egglight_1",
	"room_summon_egglight_2",
	"room_summon_egglight_3"
}
CritterEnum.QualityEggSummomResNameMap = {
	"roomcrittersummonresult_egg1",
	"roomcrittersummonresult_egg1",
	"roomcrittersummonresult_egg1",
	"roomcrittersummonresult_egg2",
	"roomcrittersummonresult_egg3"
}
CritterEnum.LangKey = {
	AgeChildhood = "critter_age_childhood_txt",
	AgeAult = "critter_age_adult_txt",
	HeroTrainLevel = "critter_hero_train_level_txt"
}
CritterEnum.TrainOPState = {
	PairOP = 2,
	Normal = 1
}
CritterEnum.Summon = {
	Ten = 10,
	One = 1
}
CritterEnum.OppenFuncGuide = {
	RoomManufacture = 414,
	RoomTrade = 414,
	Critter = 414
}

return CritterEnum
