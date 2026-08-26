-- chunkname: @modules/logic/versionactivity1_2/yaxian/define/YaXianEnum.lua

module("modules.logic.versionactivity1_2.yaxian.define.YaXianEnum", package.seeall)

local YaXianEnum = _M

YaXianEnum.ActivityId = 11203
YaXianEnum.EpisodeId = 1260101
YaXianEnum.DefaultChapterId = 1
YaXianEnum.YaXianHeroId = 3051
YaXianEnum.HeroTrialId = 1005
YaXianEnum.MapViewChapterUnlockDuration = 1
YaXianEnum.RewardEnum = {
	RewardItemWidth = 170,
	HalfRewardItemWidth = 85,
	IntervalX = 165,
	RewardContentOffsetX = 60
}
YaXianEnum.ChapterStatus = {
	notOpen = 1,
	Lock = 3,
	Normal = 0
}

return YaXianEnum
