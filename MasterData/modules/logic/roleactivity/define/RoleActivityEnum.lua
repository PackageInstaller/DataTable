-- chunkname: @modules/logic/roleactivity/define/RoleActivityEnum.lua

module("modules.logic.roleactivity.define.RoleActivityEnum", package.seeall)

local RoleActivityEnum = _M

RoleActivityEnum.AnimEvt = {
	OnGoStoryEnd = "goStoryEnd",
	OnStoryOpenEnd = "storyOpenEnd",
	OnFightOpenEnd = "fightOpenEnd"
}
RoleActivityEnum.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
RoleActivityEnum.LevelView = {
	[VersionActivity1_9Enum.ActivityId.Lucy] = ViewName.ActLucyLevelView,
	[VersionActivity1_9Enum.ActivityId.KaKaNia] = ViewName.ActKaKaNiaLevelView,
	[VersionActivity2_0Enum.ActivityId.Mercuria] = ViewName.ActMercuriaLevelView,
	[VersionActivity2_0Enum.ActivityId.Joe] = ViewName.ActJoeLevelView,
	[VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr] = ViewName.ZhiXinQuanErLevelView,
	[VersionActivity2_3Enum.ActivityId.DuDuGu] = ViewName.ActDuDuGuLevelView,
	[VersionActivity3_0Enum.ActivityId.KaRong] = ViewName.KaRongLevelView,
	[VersionActivity3_8Enum.ActivityId.EchoSong] = ViewName.V3a8EchoSongLevelView,
	[VersionActivity2_4Enum.ActivityId.Pinball] = ViewName.PinballCityView,
	[VersionActivity2_4Enum.ActivityId.MusicGame] = ViewName.VersionActivity2_4MusicChapterView,
	[VersionActivity2_2Enum.ActivityId.TianShiNaNa] = ViewName.TianShiNaNaMainView,
	[VersionActivity2_2Enum.ActivityId.Lopera] = ViewName.LoperaMainView,
	[VersionActivity2_5Enum.ActivityId.LiangYue] = ViewName.LiangYueLevelView,
	[VersionActivity2_5Enum.ActivityId.FeiLinShiDuo] = ViewName.FeiLinShiDuoEpisodeLevelView,
	[VersionActivity2_6Enum.ActivityId.Xugouji] = ViewName.XugoujiLevelView,
	[VersionActivity2_6Enum.ActivityId.DiceHero] = ViewName.DiceHeroMainView,
	[VersionActivity2_7Enum.ActivityId.CooperGarland] = ViewName.CooperGarlandLevelView,
	[VersionActivity2_7Enum.ActivityId.LengZhou6] = ViewName.LengZhou6LevelView,
	[VersionActivity2_8Enum.ActivityId.NuoDiKa] = ViewName.NuoDiKaLevelView,
	[VersionActivity2_8Enum.ActivityId.MoLiDeEr] = ViewName.MoLiDeErLevelView,
	[VersionActivity3_1Enum.ActivityId.YeShuMei] = ViewName.YeShuMeiLevelView,
	[VersionActivity3_1Enum.ActivityId.GaoSiNiao] = ViewName.V3a1_GaoSiNiao_LevelView
}

return RoleActivityEnum
