-- chunkname: @modules/logic/dungeon/defines/DungeonEnum.lua

module("modules.logic.dungeon.defines.DungeonEnum", package.seeall)

local DungeonEnum = _M

DungeonEnum.StarType = {
	Ultra = 3,
	Advanced = 2,
	Normal = 1,
	None = 0
}
DungeonEnum.EpisodeType = {
	Season166Base = 125,
	WeekWalk_2 = 24,
	TowerBossTeach = 25,
	Act1_5Dungeon = 116,
	V2_8Boss = 28,
	Act1_3Role1Chess = 111,
	Act1_3Daily = 110,
	WeekWalk = 9,
	Daily1_2 = 103,
	Season123Retail = 121,
	Story = 4,
	Cachot = 17,
	AtomicDungeon = 36,
	Season166Teach = 127,
	TowerPermanent = 21,
	Act1_3Dungeon = 109,
	TowerBoss = 22,
	GameJumpFight = 42,
	Survival = 27,
	ToughBattle = 124,
	Explore = 14,
	Act1_4Role6 = 115,
	DreamTailNormal = 128,
	Equip = 7,
	Abyss = 142,
	V2_8BossAct = 29,
	Act183 = 130,
	Rouge2Boss = 35,
	TrialHero = 205,
	ToughBattleStory = 19,
	Act1_6DungeonBoss = 119,
	Act191 = 131,
	Assassin2Stealth = 133,
	V3_2ZongMao = 141,
	Act1_2Daily = 107,
	DreamTailHard = 129,
	Season = 11,
	BossRushActMode = 144,
	Sodache = 34,
	Rouge2 = 32,
	Adventure = 3,
	YaXian = 105,
	TowerCompose = 33,
	Normal = 1,
	SeasonTrial = 15,
	TowerDeep = 31,
	Dog = 102,
	Act1_6Dungeon = 118,
	Shelter = 26,
	V3_2SP = 140,
	TowerLimited = 23,
	SpecialEquip = 8,
	Boss = 2,
	Assassin2Outside = 132,
	Season123Trial = 122,
	Sp = 6,
	Jiexika = 104,
	Act1_3Operation = 112,
	Act1_3Role2Chess = 108,
	TeachNote = 10,
	SeasonSpecial = 13,
	SystemFightManual = 37,
	Season166Train = 126,
	Season123 = 120,
	Odyssey = 30,
	RoleStoryChallenge = 16,
	Act1_8Dungeon = 123,
	RoleTryFight = 18,
	Decrypt = 5,
	BossRush = 113,
	Meilanni = 101,
	SeasonRetail = 12,
	Rouge = 20
}
DungeonEnum.ChapterType = {
	Season166Base = 30,
	WeekWalk_2 = 37,
	Activity1_2DungeonHard = 122,
	TowerDeep = 44,
	JumpGame = 42,
	LeiMiTeBeiNew = 111,
	Survival = 40,
	Activity1_2DungeonNormal1 = 121,
	TowerPermanent = 34,
	Season123Retail = 24,
	WeekWalk = 9,
	Cachot = 22,
	Newbie = 3,
	Season166Teach = 32,
	AdvPlay = 12,
	Exp = 5,
	BossRushInfinite = 142,
	BossRushNormal = 141,
	TowerBoss = 35,
	ToughBattle = 191,
	Explore = 14,
	TowerCompose = 46,
	DreamTailNormal = 128,
	AtomicDungeon = 50,
	Abyss = 204,
	Act191 = 203,
	Act183 = 183,
	Rouge2Boss = 48,
	Assassin2Stealth = 3052,
	TowerBossTeach = 38,
	Hard = 2,
	Simple = 28,
	Season = 15,
	Sodache = 47,
	Rouge2 = 45,
	YaXian = 126,
	TrialHero = 202,
	Normal = 1,
	DreamTailHard = 129,
	Equip = 6,
	Dog = 116,
	Act1_6Dungeon = 161,
	Shelter = 39,
	RoleStory = 19,
	Break = 7,
	RoleActivityFight = 27,
	TowerLimited = 36,
	V3a2BossRush = 321,
	SpecialEquip = 8,
	Gold = 4,
	Assassin2Outside = 3051,
	Season123Trial = 25,
	Sp = 10,
	RoleActivityStory = 26,
	Activity1_2DungeonNormal2 = 123,
	Buildings = 13,
	Activity1_2DungeonNormal3 = 124,
	Teaching = 49,
	TeachNote = 11,
	SeasonSpecial = 17,
	Season166Train = 31,
	Season123 = 23,
	Odyssey = 43,
	RoleStoryChallenge = 21,
	Simulate = 99,
	Act1_8Dungeon = 181,
	PermanentActivity = 98,
	Meilanni = 115,
	SeasonRetail = 16,
	Rouge = 29
}
DungeonEnum.ChapterContainEpisodeType = {
	[DungeonEnum.ChapterType.Normal] = {
		DungeonEnum.EpisodeType.Normal,
		DungeonEnum.EpisodeType.Boss,
		DungeonEnum.EpisodeType.Story,
		DungeonEnum.EpisodeType.Decrypt
	},
	[DungeonEnum.ChapterType.Hard] = {
		DungeonEnum.EpisodeType.Normal
	},
	[DungeonEnum.ChapterType.Newbie] = {
		DungeonEnum.EpisodeType.Normal
	},
	[DungeonEnum.ChapterType.Gold] = {
		DungeonEnum.EpisodeType.Normal
	},
	[DungeonEnum.ChapterType.Exp] = {
		DungeonEnum.EpisodeType.Normal
	},
	[DungeonEnum.ChapterType.Equip] = {
		DungeonEnum.EpisodeType.Equip
	},
	[DungeonEnum.ChapterType.Break] = {
		DungeonEnum.EpisodeType.Normal
	},
	[DungeonEnum.ChapterType.SpecialEquip] = {
		DungeonEnum.EpisodeType.SpecialEquip
	},
	[DungeonEnum.ChapterType.WeekWalk] = {
		DungeonEnum.EpisodeType.WeekWalk
	},
	[DungeonEnum.ChapterType.Sp] = {
		DungeonEnum.EpisodeType.Sp
	},
	[DungeonEnum.ChapterType.TeachNote] = {
		DungeonEnum.EpisodeType.Sp
	},
	[DungeonEnum.ChapterType.Season] = {
		DungeonEnum.EpisodeType.Season
	},
	[DungeonEnum.ChapterType.RoleStoryChallenge] = {
		DungeonEnum.EpisodeType.RoleStoryChallenge
	},
	[DungeonEnum.ChapterType.Teaching] = {
		DungeonEnum.EpisodeType.Normal
	}
}
DungeonEnum.MazeGamePlayEpisode = {
	[11011] = true
}
DungeonEnum.ChapterListType = {
	WeekWalk = 4,
	Story = 1,
	Insight = 3,
	Resource = 2
}
DungeonEnum.Probability = {
	Flag1 = 1,
	Flag3 = 3,
	Flag2 = 2
}
DungeonEnum.TagType = {
	FirstPass = 100,
	SecondPass = 101,
	Fix = 1,
	FirstHardPass = 102,
	TurnBack = 103,
	Medium = 6,
	LargeProbability = 2,
	SmallProbability = 9,
	Act = 8,
	Probability = 3,
	Low = 5,
	VerySmallProbability = 4,
	High = 7,
	StoryFirst = 104,
	None = 0
}
DungeonEnum.RewardProbability = {
	dagailv = DungeonEnum.TagType.LargeProbability,
	gailv = DungeonEnum.TagType.Probability,
	xiaogailv = DungeonEnum.TagType.SmallProbability,
	guding = DungeonEnum.TagType.Fix,
	jixiaogailv = DungeonEnum.TagType.VerySmallProbability
}
DungeonEnum.RewardProbabilityToMaterialProbability = {
	dagailv = MaterialEnum.JumpProbability.Large,
	gailv = MaterialEnum.JumpProbability.Small,
	xiaogailv = MaterialEnum.JumpProbability.Little,
	guding = MaterialEnum.JumpProbability.Must,
	jixiaogailv = MaterialEnum.JumpProbability.VerySmall
}
DungeonEnum.ChallengeCountLimitType = {
	Daily = 1,
	Monthly = 3,
	Weekly = 2
}
DungeonEnum.AdditionRuleType = {
	TimeLimit = 3,
	Skill = 1,
	FightSkill = 6,
	AmountLimit = 4,
	Level = 2,
	DeadLimit = 5
}
DungeonEnum.UnlockContentType = {
	OpenGroup = 3,
	ActivityOpen = 4,
	Episode = 2,
	Open = 1
}
DungeonEnum.ElementType = {
	EnterDispatch = 501,
	Dispatch = 502,
	Fight = 2,
	Activity1_2Building_Repair = 102,
	JumpGame = 2802,
	ChangeColor = 10,
	V3a2Note = 3201,
	BossStory = 2801,
	Activity1_2Building_Trap = 104,
	FullScreenQuestion = 8,
	Investigate = 19,
	FairyLand = 902,
	EnterDialogue = 18,
	V3a2OptionFinish = 3204,
	V3a4BBS = 3401,
	PipeGame = 9,
	Story = 4,
	ToughBattle = 901,
	HeroInvitation = 904,
	V3a2Dialogue = 3203,
	UnlockEpisode = 6,
	Activity1_2Note = 107,
	Activity1_2Episode13Unlock = 106,
	V3a2Option = 3202,
	UnLockExplore = 17,
	None = 1,
	Question = 5,
	Graffiti = 503,
	Activity1_2Fight = 105,
	SpStory = 2601,
	V3a7Tower = 3701,
	PuzzleGame = 101,
	Activity1_2Building_Upgrade = 103,
	Task = 3,
	Guidepost = 7,
	ToughBattleBoss = 903,
	OuijaGame = 15,
	PutCubeGame = 13,
	MazeDraw = 12,
	CircuitGame = 14,
	DailyEpisode = 16
}
DungeonEnum.ImplicitElementType = {
	[DungeonEnum.ElementType.V3a7Tower] = true
}
DungeonEnum.FragmentType = {
	LeiMiTeBeiNew = 101,
	PlainText = 3,
	OptionsText = 2,
	AvgStory = 2601,
	Normal = 1
}
DungeonEnum.ElementTypeIconIndex = {
	["20"] = 2,
	["31"] = 5,
	["51"] = 9,
	["30"] = 4,
	["80"] = 10,
	["90"] = 10,
	["81"] = 11,
	["11"] = 1,
	["120"] = 10,
	["50"] = 8,
	["41"] = 7,
	["121"] = 11,
	["21"] = 3,
	["10"] = 0,
	["40"] = 6,
	["91"] = 11
}
DungeonEnum.ElementTypeUIResIdMap = {
	[DungeonEnum.ElementType.PipeGame] = DungeonEnum.ElementType.FullScreenQuestion,
	[DungeonEnum.ElementType.MazeDraw] = DungeonEnum.ElementType.FullScreenQuestion,
	[DungeonEnum.ElementType.PutCubeGame] = DungeonEnum.ElementType.FullScreenQuestion,
	[DungeonEnum.ElementType.OuijaGame] = DungeonEnum.ElementType.FullScreenQuestion,
	[DungeonEnum.ElementType.CircuitGame] = DungeonEnum.ElementType.FullScreenQuestion,
	[DungeonEnum.ElementType.UnLockExplore] = DungeonEnum.ElementType.FullScreenQuestion,
	[DungeonEnum.ElementType.Activity1_2Fight] = DungeonEnum.ElementType.Fight,
	[DungeonEnum.ElementType.Activity1_2Note] = DungeonEnum.ElementType.Fight,
	[DungeonEnum.ElementType.Activity1_2Episode13Unlock] = DungeonEnum.ElementType.Fight,
	[DungeonEnum.ElementType.EnterDialogue] = DungeonEnum.ElementType.None,
	[DungeonEnum.ElementType.EnterDispatch] = DungeonEnum.ElementType.None,
	[DungeonEnum.ElementType.ToughBattle] = DungeonEnum.ElementType.None,
	[DungeonEnum.ElementType.FairyLand] = DungeonEnum.ElementType.None,
	[DungeonEnum.ElementType.ToughBattleBoss] = DungeonEnum.ElementType.None,
	[DungeonEnum.ElementType.HeroInvitation] = DungeonEnum.ElementType.None,
	[DungeonEnum.ElementType.JumpGame] = DungeonEnum.ElementType.None,
	[DungeonEnum.ElementType.BossStory] = DungeonEnum.ElementType.None,
	[DungeonEnum.ElementType.V3a2Note] = DungeonEnum.ElementType.SpStory,
	[DungeonEnum.ElementType.V3a2Option] = DungeonEnum.ElementType.FullScreenQuestion,
	[DungeonEnum.ElementType.V3a2Dialogue] = DungeonEnum.ElementType.Story,
	[DungeonEnum.ElementType.V3a2OptionFinish] = DungeonEnum.ElementType.FullScreenQuestion,
	[DungeonEnum.ElementType.V3a4BBS] = DungeonEnum.ElementType.None
}
DungeonEnum.EquipDungeonChapterId = 601
DungeonEnum.ChapterId = {
	ResourceExp = 401,
	HarvestDungeonChapterId = 1001,
	InsightBrutes = 704,
	InsightMountain = 701,
	EquipDungeonChapterId = 601,
	ToughBattleStory = 19101,
	HeroInvitation = 311,
	Main1_13 = 113,
	Main1_8 = 108,
	Main1_7 = 107,
	InsightSylvanus = 703,
	RoleDuDuGu = 23501,
	BossStory = 28101,
	Main1_1 = 101,
	BossAct = 28102,
	InsightStarfall = 702,
	Main1_10 = 110,
	Main1_6 = 106,
	Main1_5 = 105,
	ResourceGold = 501,
	Main1_9 = 109,
	Main1_11 = 111,
	Main1_12 = 112
}
DungeonEnum.SpecialMainPlot = {
	[310] = "p_dungeonchapterminiitem_txt_Special",
	[DungeonEnum.ChapterId.HeroInvitation] = "dungeonchapterminiitem_txt_NewWorld"
}
DungeonEnum.ChapterWidth = {
	Special = 270,
	Normal = 415
}
DungeonEnum.DungeonViewTabEnum = {
	Rouge = 6,
	WeekWalk_2 = 4,
	Explore = 2,
	Permanent = 3,
	AdvPlay = 5,
	WeekWalk = 1
}
DungeonEnum.RefreshTimeAfterShowReward = 0
DungeonEnum.ShowNewElementsTimeAfterShowReward = 0.7
DungeonEnum.MoveEpisodeTimeAfterShowReward = 1.5
DungeonEnum.UpdateLockTimeAfterShowReward = 2.5
DungeonEnum.dungeonweekwalkviewPath = "ui/viewres/dungeon/dungeonweekwalkview.prefab"
DungeonEnum.dungeonweekwalk_2viewPath = "ui/viewres/dungeon/dungeonweekwalkdeepview.prefab"
DungeonEnum.dungeonexploreviewPath = "ui/viewres/explore/exploremainview.prefab"
DungeonEnum.DefaultTweenMapTime = 0.26
DungeonEnum.NotPopFragmentToastDict = {
	[5007] = true,
	[5004] = true,
	[5005] = true,
	[5002] = true,
	[5001] = true,
	[5003] = true,
	[5009] = true,
	[5010] = true,
	[5011] = true,
	[5006] = true,
	[5008] = true
}
DungeonEnum.AssistType = {
	Normal = PickAssistEnum.Type.Normal,
	Season123 = PickAssistEnum.Type.Activity123
}
DungeonEnum.ElementExEffectPath = {
	[100702] = "scenes/v1a9_m_s08_hddt/vx/prefab/vx_boss_effect1.prefab",
	[100709] = "scenes/v1a9_m_s08_hddt/vx/prefab/vx_boss_effect2.prefab"
}
DungeonEnum.MapExEffectPath = {
	[10712] = "scenes/v1a9_m_s08_hddt/vx/prefab/vx_boss_effect4.prefab"
}
DungeonEnum.EpisodeListVisibleSource = {
	ToughBattle = 1,
	Normal = 0
}
DungeonEnum.EndType = {
	Exit = 1,
	Restart = 2,
	None = 0
}
DungeonEnum.AdvPlayType = {
	Survival = 1,
	Explore = 2
}

return DungeonEnum
