-- chunkname: @modules/logic/bossrush/config/V3a9BossRushEnum.lua

module("modules.logic.bossrush.config.V3a9BossRushEnum", package.seeall)

local V3a9BossRushEnum = _M

V3a9BossRushEnum.Mode = {
	Act = 2,
	Normal = 1
}
V3a9BossRushEnum.ModeParam = {
	[V3a9BossRushEnum.Mode.Normal] = {
		HelpId = HelpEnum.HelpId.BossRushViewHelp
	},
	[V3a9BossRushEnum.Mode.Act] = {
		HelpId = HelpEnum.HelpId.V3a9BossRushActMode
	}
}
V3a9BossRushEnum.HeroCount = 8
V3a9BossRushEnum.HeroTeamType = {
	back = 2,
	front = 1
}
V3a9BossRushEnum.MileStoneId = 390002
V3a9BossRushEnum.ExpandBondsBgRes = {
	[0] = "v3a9_bossrush_bondsbg4",
	"v3a9_bossrush_bondsbg3",
	"v3a9_bossrush_bondsbg2",
	"v3a9_bossrush_bondsbg1",
	"v3a9_bossrush_bondsbg5"
}
V3a9BossRushEnum.PlayerPrefKey = {
	LastScore = "LastScore",
	FirstOpenAct = "FirstOpenAct",
	NewUnlockStage = "NewUnlockStage",
	FirstEnterAnim = "FirstEnterAnim"
}
V3a9BossRushEnum.SpecialExpandBondGroupId = 10021
V3a9BossRushEnum.TagType = {
	Special = 3,
	Career = 1,
	BattleTag = 2
}
V3a9BossRushEnum.ActReddot = {
	[13919] = {
		NewBoss = RedDotEnum.DotNode.V3a9BossRushActNewBoss
	}
}
V3a9BossRushEnum.SearchFilterType = {
	HeroGroup = 1,
	Asssit = 2
}
V3a9BossRushEnum.SearchFilterTagType = {
	[CharacterBackpackEnum.TagId.System] = CharacterBackpackEnum.TagId.System,
	[CharacterBackpackEnum.TagId.CharacterFeaturesHigh] = CharacterBackpackEnum.TagId.CharacterFeaturesHigh,
	[CharacterBackpackEnum.TagId.CharacterFeaturesLow] = CharacterBackpackEnum.TagId.CharacterFeaturesHigh,
	[CharacterBackpackEnum.TagId.Core] = CharacterBackpackEnum.TagId.CharacterFeaturesHigh
}
V3a9BossRushEnum.ExpandBondsTriggerType = {
	open = "open",
	switch = "switch"
}
V3a9BossRushEnum.ExpandBondsTriggerAudio = {
	[V3a9BossRushEnum.ExpandBondsTriggerType.open] = BossRushAudioEnum.Audio.play_ui_dungeon3_2_click,
	[V3a9BossRushEnum.ExpandBondsTriggerType.switch] = BossRushAudioEnum.Audio.play_ui_molu_exit_appear
}
V3a9BossRushEnum.HeightScoreEffectConst = 3901
V3a9BossRushEnum.HeightScoreEffect = {
	[0] = {
		txtColor = "#E99B56"
	},
	{
		txtColor = "#3A2F56",
		bg = "v3a9_bossrush_btn_scorebg1"
	},
	{
		txtColor = "#5C3710",
		bg = "v3a9_bossrush_btn_scorebg4"
	},
	{
		txtColor = "#33343A",
		bg = "v3a9_bossrush_btn_scorebg5"
	}
}

return V3a9BossRushEnum
