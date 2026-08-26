-- chunkname: @modules/logic/turnback/define/TurnbackEnum.lua

module("modules.logic.turnback.define.TurnbackEnum", package.seeall)

local TurnbackEnum = {}

TurnbackEnum.ActivityId = {
	Turnback3SignInView = 111,
	NewSignIn = 106,
	DungeonShowView = 103,
	NewProgressView = 109,
	SignIn = 101,
	RecommendView = 105,
	Turnback4BPView = 118,
	Turnback4DoubleView = 119,
	Turnback4ProgressView = 121,
	NewBenfitView = 108,
	Turnback4ReviewView = 122,
	Turnback3ReviewView = 116,
	Turnback4RewardView = 123,
	Turnback4StoreView = 120,
	Turnback4SignInView = 117,
	ReviewView = 110,
	RewardShowView = 104,
	Turnback3DoubleView = 113,
	Turnback3ProgressView = 115,
	Turnback3BPView = 112,
	NewTaskView = 107,
	TaskView = 102,
	Turnback3StoreView = 114
}
TurnbackEnum.TaskLoopType = {
	HalfMonth = 4,
	Day = 1,
	Long = 3,
	Week = 2,
	Custom = 5
}
TurnbackEnum.SignInState = {
	CanGet = 1,
	HasGet = 2,
	NotFinish = 0
}
TurnbackEnum.SearchState = {
	CanGet = 1,
	HasGet = 2,
	NotFinish = 0
}
TurnbackEnum.showInPopup = {
	Hide = 0,
	Show = 1
}
TurnbackEnum.type = {
	New = 1,
	Old = 0
}
TurnbackEnum.TaskEnum = {
	Online = 2,
	Old = 0,
	New = 1
}
TurnbackEnum.DropInfoEnum = {
	Explore = 8,
	WeekWalk = 4,
	Room = 7,
	Guide = 5,
	MainEpisode = 2,
	HandbookCharacter = 10,
	Survival = 13,
	ActivityTask = 3,
	Tower = 9,
	Rouge2 = 12,
	Permanent = 6,
	MainAct = 1,
	Rouge = 11
}
TurnbackEnum.DropType = {
	Progress = 1,
	Jump = 2
}
TurnbackEnum.ConstId = {
	SurvivalReward = 4,
	GuideReward = 1,
	Rouge2Reward = 3,
	RougeReward = 2
}
TurnbackEnum.DropInfoParams = {
	[TurnbackEnum.DropInfoEnum.MainAct] = {
		ShowRewardItem = false
	},
	[TurnbackEnum.DropInfoEnum.MainEpisode] = {
		ShowRewardItem = true
	},
	[TurnbackEnum.DropInfoEnum.ActivityTask] = {
		ShowRewardItem = true,
		UnlockOpenId = OpenEnum.UnlockFunc.Task
	},
	[TurnbackEnum.DropInfoEnum.WeekWalk] = {
		ShowRewardItem = true,
		UnlockOpenId = OpenEnum.UnlockFunc.WeekWalk
	},
	[TurnbackEnum.DropInfoEnum.Guide] = {
		ShowRewardItem = true,
		UnlockOpenId = OpenEnum.UnlockFunc.RoleStory,
		OnlyShowReward = {
			"2#2",
			"5#302303",
			"1#140001"
		}
	},
	[TurnbackEnum.DropInfoEnum.Permanent] = {
		ShowRewardItem = false,
		UnlockOpenId = OpenEnum.UnlockFunc.Permanent
	},
	[TurnbackEnum.DropInfoEnum.Room] = {
		ShowRewardItem = true,
		UnlockOpenId = OpenEnum.UnlockFunc.Room
	},
	[TurnbackEnum.DropInfoEnum.Explore] = {
		ShowRewardItem = true,
		UnlockOpenId = OpenEnum.UnlockFunc.Explore
	},
	[TurnbackEnum.DropInfoEnum.Tower] = {
		ShowRewardItem = true,
		UnlockOpenId = OpenEnum.UnlockFunc.Tower
	},
	[TurnbackEnum.DropInfoEnum.HandbookCharacter] = {
		ShowRewardItem = false,
		UnlockOpenId = OpenEnum.UnlockFunc.Handbook
	},
	[TurnbackEnum.DropInfoEnum.Rouge] = {
		ShowRewardItem = true,
		OnlyShowReward = {
			"4#3091",
			"1#240002",
			"5#305203"
		}
	},
	[TurnbackEnum.DropInfoEnum.Rouge2] = {
		ShowRewardItem = true,
		OnlyShowReward = {
			"1#350003",
			"9#1570",
			"4#3136"
		}
	},
	[TurnbackEnum.DropInfoEnum.Survival] = {
		ShowRewardItem = true,
		UnlockOpenId = OpenEnum.UnlockFunc.Survival,
		OnlyShowReward = {
			"1#682802",
			"1#672801",
			"1#350102"
		}
	}
}
TurnbackEnum.SignInSpecialDays = {
	[3] = {
		[2] = true,
		[7] = true
	},
	[4] = {
		nil,
		true,
		true,
		nil,
		nil,
		nil,
		true
	}
}
TurnbackEnum.ChannelType = {
	eFun = 2,
	Global = 1,
	KO = 3
}
TurnbackEnum.BpBtn = {
	Bonus = 1,
	Task = 2
}
TurnbackEnum.TaskGetAnimTime = 0.5
TurnbackEnum.TaskGetAllAnimTime = 0.4
TurnbackEnum.TaskMaskTime = 0.65
TurnbackEnum.itemUptime = 0.15
TurnbackEnum.TaskGetBonusAnimTime = 1.367
TurnbackEnum.BonusPointIcon = 31
TurnbackEnum.RefreshCd = 10
TurnbackEnum.FirstSearchTask = 180035
TurnbackEnum.LastSearchTask = 180037
TurnbackEnum.Level2Count = 3
TurnbackEnum.Level3Count = 1
TurnbackEnum.ReadTaskId = 180013
TurnbackEnum.Version2ProgressId = {
	nil,
	180013,
	180053,
	180088
}
TurnbackEnum.SwapIndex = -1
TurnbackEnum.TaskType = {
	DailyRefresh = 2,
	DailyReset = 1
}
TurnbackEnum.TaskJumpType = {
	ViewName = 1,
	DungeopnChapterType = 2
}

return TurnbackEnum
