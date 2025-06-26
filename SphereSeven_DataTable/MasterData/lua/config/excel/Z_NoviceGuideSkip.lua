return {
	{
		Id = 1,
		GuideCompleteId = 0,
		Skip = {
			4,
			25,
		},
		NoSkip = {},
		CloseUI = {},
		SkipCode = "Game.Scene:GetComponent(\"BattleComponent\").fsm:Switch(BattleState.BattleEnd)",
		IsEndGuide = 0,
	},
	[5] = {
		Id = 5,
		GuideCompleteId = 1,
		Skip = {
			4,
			15,
		},
		NoSkip = {},
		CloseUI = {
			"UIReward",
			"UISummonStage2",
			"UISummonStage3",
			"UISummonStage1",
			"UISummon",
		},
		SkipCode = "Game.Scene:GetComponent(\"GuideComponent\"):JumpGuide(14)",
		IsEndGuide = 0,
	},
	[6] = {
		Id = 6,
		GuideCompleteId = 2,
		Skip = {
			9,
			56,
		},
		NoSkip = {
			23,
			33,
			34,
		},
		CloseUI = {
			"UICardList",
			"UICardIntens",
			"UICardLvUp",
			"UICardLvUpStage1",
			"UICardEvolve",
			"UICardEvolveStage1",
			"UICardEvolveStage2",
		},
		SkipCode = "Game.Scene:GetComponent(\"GuideComponent\"):SkipLogic()",
		IsEndGuide = 0,
	},
	[7] = {
		Id = 7,
		GuideCompleteId = 3,
		Skip = {
			1,
			13,
		},
		NoSkip = {},
		CloseUI = {
			"UIFormatNew",
		},
		SkipCode = "Game.Scene:GetComponent(\"GuideComponent\"):JumpGuide(13)",
		IsEndGuide = 0,
	},
	[8] = {
		Id = 8,
		GuideCompleteId = 4,
		Skip = {
			1,
			9,
		},
		NoSkip = {},
		CloseUI = {
			"UIBattleMode",
		},
		SkipCode = "",
		IsEndGuide = 1,
	},
}