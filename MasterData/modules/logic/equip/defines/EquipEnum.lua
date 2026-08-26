-- chunkname: @modules/logic/equip/defines/EquipEnum.lua

module("modules.logic.equip.defines.EquipEnum", package.seeall)

local EquipEnum = _M

EquipEnum.StrengthenMaxCount = 8
EquipEnum.RefineMaxCount = 5
EquipEnum.AnimationDurationTime = 0.167
EquipEnum.ChooseEquipStatus = {
	Lock = 5,
	BeyondEquipHadNum = 1,
	ReduceNotSelectedEquip = 2,
	BeyondMaxStrengthenExperience = 4,
	BeyondMaxSelectEquip = 3,
	Success = 0
}
EquipEnum.FromViewEnum = {
	FromOdysseyHeroGroupFightView = 9,
	FromCharacterView = 2,
	FromCachotHeroGroupView = 4,
	FromSeason123HeroGroupFightView = 6,
	FromAssassinHeroView = 10,
	FromSeason166HeroGroupFightView = 8,
	FromSeasonFightView = 3,
	FromHeroGroupFightView = 1,
	FromTowerComposeHeroGroupView = 12,
	FromTwinssychubeEquipInfoView = 13,
	FromRougeHeroGroupFightView = 7,
	FromCachotHeroGroupFightView = 5,
	FromPresetPreviewView = 11,
	V3a9_BossRush_HeroGroupListView = 14
}
EquipEnum.ConstId = {
	equipNotShowRefineRare = 16
}
EquipEnum.ClientEquipType = {
	Config = 3,
	TrialEquip = 2,
	OtherPlayer = 4,
	RecommedNot = 5,
	TrialHero = 1,
	Normal = 0
}
EquipEnum.DecomposeMaxCount = 100
EquipEnum.DecomposeTxtAnimDuration = 0.5
EquipEnum.DecomposeAnimDuration = 0.9
EquipEnum.EquipEnterAnimWaitTime = 0.2
EquipEnum.EquipDecomposeMinRare = 2
EquipEnum.EquipDecomposeMaxRare = 3
EquipEnum.sp02TwinssychubeUnlockKey = "sp02TwinssychubeUnlockKey"

return EquipEnum
