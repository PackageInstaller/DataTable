-- chunkname: @modules/logic/versionactivity1_6/dungeon/define/VersionActivity1_6DungeonEnum.lua

module("modules.logic.versionactivity1_6.dungeon.define.VersionActivity1_6DungeonEnum", package.seeall)

local VersionActivity1_6DungeonEnum = _M

VersionActivity1_6DungeonEnum.DungeonMapCameraSize = 5
VersionActivity1_6DungeonEnum.DungeonChapterId = {
	Story4 = 16201,
	Story = 16101,
	Hard = 16201,
	Story1 = 16101,
	BossFight = 16501,
	Story2 = 16301,
	Story3 = 16401
}
VersionActivity1_6DungeonEnum.SceneRootName = "VersionActivity1_6DungeonMapScene"
VersionActivity1_6DungeonEnum.EpisodeItemMinWidth = 300
VersionActivity1_6DungeonEnum.EpisodeStarType = {
	[VersionActivity1_6DungeonEnum.DungeonChapterId.Story1] = "v1a6_dungeon_star_2",
	[VersionActivity1_6DungeonEnum.DungeonChapterId.Story2] = "v1a6_dungeon_star_3",
	[VersionActivity1_6DungeonEnum.DungeonChapterId.Story3] = "v1a6_dungeon_star_4",
	[VersionActivity1_6DungeonEnum.DungeonChapterId.Story4] = "v1a6_dungeon_star_4"
}
VersionActivity1_6DungeonEnum.EpisodeStarEmptyType = {
	[VersionActivity1_6DungeonEnum.DungeonChapterId.Story1] = "v1a6_dungeon_star_1",
	[VersionActivity1_6DungeonEnum.DungeonChapterId.Story2] = "v1a6_dungeon_star_1",
	[VersionActivity1_6DungeonEnum.DungeonChapterId.Story3] = "v1a6_dungeon_star_5",
	[VersionActivity1_6DungeonEnum.DungeonChapterId.Story4] = "v1a6_dungeon_star_5"
}
VersionActivity1_6DungeonEnum.HardModeUnlockAnimDuration = 1.7
VersionActivity1_6DungeonEnum.ResPath = {
	BossScheduleItem = "ui/viewres/versionactivity_1_6/v1a6_activityboss/v1a6_activityboss_scheduleitem.prefab",
	BossFightScoreTips = "ui/viewres/versionactivity_1_6/v1a6_activityboss/v1a6_activityboss_ig_scoretips.prefab"
}
VersionActivity1_6DungeonEnum.DungeonBossMapElementId = 1610101
VersionActivity1_6DungeonEnum.DungeonBossEpisodeId = 1610119
VersionActivity1_6DungeonEnum.ModifyBgmEpisodeId = 1610119
VersionActivity1_6DungeonEnum.DungeonBossElementHideObjPaths = {
	"Obj-Plant/all/diffuse/m_s08_hddt_qz019_renqun"
}
VersionActivity1_6DungeonEnum.DungeonConstId = {
	skill3Icon = 8,
	GoldEffectSkillLv = 5,
	SilverEffectSkillLv = 4,
	MaxSkillLv = 2,
	skill1Icon = 6,
	MaxSkillPointNum = 1,
	skill2Icon = 7,
	skill4Icon = 9
}
VersionActivity1_6DungeonEnum.SkillOriginIcon = {
	VersionActivity1_6DungeonEnum.DungeonConstId.skill1Icon,
	VersionActivity1_6DungeonEnum.DungeonConstId.skill2Icon,
	VersionActivity1_6DungeonEnum.DungeonConstId.skill3Icon,
	VersionActivity1_6DungeonEnum.DungeonConstId.skill4Icon
}
VersionActivity1_6DungeonEnum.skillPointMinNum = 0
VersionActivity1_6DungeonEnum.skillPointMaxNum = 7
VersionActivity1_6DungeonEnum.skillMaxLv = 7
VersionActivity1_6DungeonEnum.skillTypeNum = 4
VersionActivity1_6DungeonEnum.SkillKeyPointIdxs = {
	true,
	nil,
	true,
	nil,
	nil,
	nil,
	true
}
VersionActivity1_6DungeonEnum.bossMaxOrder = 8

return VersionActivity1_6DungeonEnum
