-- chunkname: @modules/logic/herogrouppreset/define/HeroGroupPresetEnum.lua

module("modules.logic.herogrouppreset.define.HeroGroupPresetEnum", package.seeall)

local HeroGroupPresetEnum = _M

HeroGroupPresetEnum.MaxNum = 10
HeroGroupPresetEnum.MinNum = 1
HeroGroupPresetEnum.ShowType = {
	Fight = 2,
	Copy = 3,
	Normal = 1
}
HeroGroupPresetEnum.HeroGroupType = {
	AtomicDungeon = 21,
	Abyss = 23,
	Common = 2,
	TowerPermanentAndLimit = 10,
	BossRushActMode = 22,
	AbyssPreset = 19
}
HeroGroupPresetEnum.HeroGroupType2SnapshotAllType = {
	[HeroGroupPresetEnum.HeroGroupType.Common] = ModuleEnum.HeroGroupSnapshotType.Common,
	[HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit] = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit,
	[HeroGroupPresetEnum.HeroGroupType.Abyss] = ModuleEnum.HeroGroupSnapshotType.Abyss,
	[HeroGroupPresetEnum.HeroGroupType.AbyssPreset] = ModuleEnum.HeroGroupSnapshotType.AbyssPreset,
	[HeroGroupPresetEnum.HeroGroupType.AtomicDungeon] = ModuleEnum.HeroGroupSnapshotType.AtomicDungeon,
	[HeroGroupPresetEnum.HeroGroupType.BossRushActMode] = ModuleEnum.HeroGroupSnapshotType.BossRushActMode
}
HeroGroupPresetEnum.HeroGroupType2SnapshotType = {
	[HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit] = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit,
	[HeroGroupPresetEnum.HeroGroupType.Abyss] = ModuleEnum.HeroGroupSnapshotType.Abyss,
	[HeroGroupPresetEnum.HeroGroupType.AbyssPreset] = ModuleEnum.HeroGroupSnapshotType.AbyssPreset,
	[HeroGroupPresetEnum.HeroGroupType.AtomicDungeon] = ModuleEnum.HeroGroupSnapshotType.AtomicDungeon,
	[HeroGroupPresetEnum.HeroGroupType.BossRushActMode] = ModuleEnum.HeroGroupSnapshotType.BossRushActMode
}
HeroGroupPresetEnum.HeroGroupSnapshotTypeOpen = {
	[HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit] = true,
	[HeroGroupPresetEnum.HeroGroupType.Abyss] = true,
	[HeroGroupPresetEnum.HeroGroupType.AbyssPreset] = true,
	[HeroGroupPresetEnum.HeroGroupType.AtomicDungeon] = true,
	[HeroGroupPresetEnum.HeroGroupType.BossRushActMode] = false
}
HeroGroupPresetEnum.HeroGroupSnapshotTypeShowBoss = {
	[HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit] = true
}
HeroGroupPresetEnum.HideInThumbnailHeroGroupType = {
	[HeroGroupPresetEnum.HeroGroupType.AtomicDungeon] = true,
	[HeroGroupPresetEnum.HeroGroupType.BossRushActMode] = true
}

return HeroGroupPresetEnum
