-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityConfig.lua

require("dm.gameplay.activity.model.TaskActivity")
require("dm.gameplay.activity.model.CarnivalActivity")
require("dm.gameplay.activity.model.LoginActivity")
require("dm.gameplay.activity.model.ExchangeActivity")
require("dm.gameplay.activity.model.BannerActivity")
require("dm.gameplay.activity.model.BoardActivity")
require("dm.gameplay.activity.model.FreeStaminaActivity")
require("dm.gameplay.activity.model.QuestionActivity")
require("dm.gameplay.activity.model.ActivityTaskMonthCard")
require("dm.gameplay.activity.model.ActivityTaskStageStar")
require("dm.gameplay.activity.model.ActivityFocusOn")
require("dm.gameplay.activity.model.ActivityHeroCollect")
require("dm.gameplay.activity.model.ActivityFateEncounters")
require("dm.gameplay.activity.model.ActivityBlockActivity")
require("dm.gameplay.activity.model.ActivityEggActivity")
require("dm.gameplay.activity.model.ActivityBlockMapActivity")
require("dm.gameplay.activity.model.ActivitySupport")
require("dm.gameplay.activity.model.ActivityClubBoss")
require("dm.gameplay.activity.model.PassActivity")
require("dm.gameplay.activity.model.RecheargeActivity")
require("dm.gameplay.activity.model.ActivityDrawCardFeedback")
require("dm.gameplay.activity.model.MonsterShopActivity")
require("dm.gameplay.activity.model.ActivityColorEggActivity")
require("dm.gameplay.activity.model.ActivityTpurchase")
require("dm.gameplay.activity.model.MiniGameActivity")
require("dm.gameplay.activity.model.DailyChargeActivity")
require("dm.gameplay.activity.model.zero.ActivityZero")
require("dm.gameplay.activity.model.PuzzleGameActivity")
require("dm.gameplay.cooperateBoss.model.CooperateBoss")
require("dm.gameplay.activity.model.return.ActivityReturn")
require("dm.gameplay.activity.model.return.ActivityReturnLetter")
require("dm.gameplay.activity.model.return.ActivityReturnCarnival")
require("dm.gameplay.activity.model.ActivityBlockMapNewActivity")
require("dm.gameplay.activity.model.LimitRecruitActivity")
require("dm.gameplay.activity.model.ActivityDrawCardSp")
require("dm.gameplay.activity.model.ActivityMail")
require("dm.gameplay.activity.model.AthenaGoActivity")
require("dm.gameplay.activity.model.BentoActivity")
require("dm.gameplay.activity.model.WorldBossActivity")
require("dm.gameplay.activity.model.AIShopActivity")
require("dm.gameplay.activity.model.ResourceDoubleActivity")

ActivityShowTab = {
	kInAll = 3,
	kNotShow = 0,
	kInActivity = 1,
	kInHome = 2
}
ActivityBannerType = {
	kCooperateBoss = "COOPERATEBOSS",
	kPackageShop = "PackageShop",
	kActivity = "Activity"
}
ActivityBannerImportant = {
	kIsNotImportant = 0,
	kIsImportant = 1
}
ActivityTaskStatus = {
	kUnfinish = 0,
	kGet = 2,
	kFinishNotGet = 1,
	kInvalid = -1
}
kTaskStatusPriorityMap = {
	[ActivityTaskStatus.kFinishNotGet] = 1,
	[ActivityTaskStatus.kUnfinish] = 2,
	[ActivityTaskStatus.kGet] = 3
}
ActivityModel = {
	TASK = TaskActivity,
	CarnivalMainland = CarnivalActivity,
	ContinueLogin = LoginActivity,
	BANNER = BannerActivity,
	IMG_BOARD = BoardActivity,
	GAME_BOARD = BoardActivity,
	TEXT_BOARD = BoardActivity,
	FreeStamina = FreeStaminaActivity,
	ExtraReward = BoardActivity,
	Questionnaire = QuestionActivity,
	[ActivityType.KEXCHANGE] = ExchangeActivity,
	[ActivityType.kBLOCKSPOPEN] = BoardActivity,
	[ActivityType.kDRAWCARDOPEN] = BoardActivity,
	[ActivityType.KTASKMONTHCARD] = ActivityTaskMonthCard,
	[ActivityType.KActivityPass] = PassActivity,
	[ActivityType.KTASKMONTHCARDSTAGE] = ActivityTaskMonthCard,
	[ActivityType.KTASKSTAGESTAR] = ActivityTaskStageStar,
	[ActivityType.KKuaiShouApp] = ActivityFocusOn,
	[ActivityType.KAZhanApp] = ActivityFocusOn,
	[ActivityType.KTASKHEROCOLLECT] = ActivityHeroCollect,
	[ActivityType.KTASKCHOICE] = ActivityFateEncounters,
	[ActivityType.KActivityBlock] = ActivityBlockActivity,
	[ActivityType.KActivityBlockMap] = ActivityBlockMapActivity,
	[ActivityType.kActivityBlockEgg] = ActivityEggActivity,
	[ActivityType.KActivityClubBoss] = ActivityClubBoss,
	[ActivityType.KActivitySupport] = ActivitySupport,
	[ActivityType.KRechargeActivity] = RecheargeActivity,
	[ActivityType.KDrawCardFeedbackActivity] = ActivityDrawCardFeedback,
	[ActivityType.KColourEgg] = ActivityColorEggActivity,
	[ActivityType.KMonsterShop] = MonsterShopActivity,
	[ActivityType.KTPURCHASE] = ActivityTpurchase,
	[ActivityType.KMiniGame] = MiniGameActivity,
	[ActivityType.KDailyCharge] = DailyChargeActivity,
	[ActivityType.kActivityZero] = ActivityZero,
	[ActivityType.KPuzzleGame] = PuzzleGameActivity,
	[ActivityType.KReturn] = ActivityReturn,
	[ActivityType.KLetter] = ActivityReturnLetter,
	[ActivityType.KReturnCarnival] = ActivityReturnCarnival,
	[ActivityType.KActivityBlockMapNew] = ActivityBlockMapNewActivity,
	[ActivityType.KReturnCarnival] = ActivityReturnCarnival,
	[ActivityType.kDRAWCARDSP] = LimitRecruitActivity,
	[ActivityType.kDRAWCARDUR] = BoardActivity,
	[ActivityType.KActivityMail] = ActivityMail,
	[ActivityType.KActivityTrialRoad] = AthenaGoActivity,
	[ActivityType.kDRAWCARDTS] = BoardActivity,
	[ActivityType.KActivityBento] = BentoActivity,
	[ActivityType.KWorldBoss] = WorldBossActivity,
	[ActivityType.kAIShop] = AIShopActivity,
	RESOURCEDOUBLE = ResourceDoubleActivity
}
ActivityUI = {
	ACTIVITYBLOCKEGG = "ActivityBlockEggView",
	TaskElite = "eliteTaskView",
	Gameboard = "GameBoardActivityView",
	MONSTERSHOPDetective = "ActivityBlockMonsterShopView",
	Exchange = "ActivityExchangeView",
	Login_Halloween = "LoginActivityWsjView",
	Carnival = "CarnivalView",
	ZERODAILYTASK = "ActivityZeroTaskDailyView",
	Login_Detective = "LoginActivityView",
	Login_Holiday = "LoginActivityView",
	Login_Music = "LoginActivityView",
	RESOURCEDOUBLE = "ResourceDoubleActivityView",
	Community = "CommunityActivityView",
	MINI_TrialRoad = "TrialRoadMainView",
	Login14 = "ActivityLogin14CommonView",
	Task = "TaskActivityView",
	FreeStamina = "FreeStaminaActivityView",
	ABACHIEVEMENTTASK = "ActivityTaskAchievementView",
	Banner = "BannerActivityView",
	Login = "LoginActivityView",
	Imgboard = "ImageBoardActivityView",
	Questionnaire = "QuestionActivityView",
	ABDAILYTASK = "ActivityTaskDailyView",
	ExtraRewardBoard = "ExtraRewardActivityView",
	AISHOP = "ActivityAIShopView",
	ZEROACHIEVEMENTTASK = "ActivityZeroTaskAchievementView",
	[ActivityType.KEightLogin] = "eightDayLoginView",
	[ActivityType.KEightLoginCommon] = "commonEightDayLoginView",
	[ActivityType.KTASKMONTHCARD] = "ActivityTaskMonthCardView",
	[ActivityType.KTASKCOMMON] = "ActivityTaskReachedView",
	[ActivityType.KTASKCOLLECT] = "ActivityTaskCollectView",
	[ActivityType.KTASKCOLLECTSTAR] = "ActivityTaskCollectStarView",
	[ActivityType.KLOGINTIME] = "LoginActivityView",
	[ActivityType.KTASKSTAGESTAR] = "ActivityTaskStageStarView",
	[ActivityType.KTASKMONTHCARDSTAGE] = "ActivityTaskMonthCardView",
	[ActivityType.KKuaiShouApp] = "ActivityFocusOnView",
	[ActivityType.KAZhanApp] = "ActivityFocusOnView",
	[ActivityType.KTASKHEROCOLLECT] = "ActivityHeroCollectView",
	[ActivityType.KTASKCHOICE] = "ActivityFateEncountersView",
	[ActivityType.KRechargeActivity] = "RechargeActivityView",
	[ActivityType.KDrawCardFeedbackActivity] = "ActivityDrawCardFeedbackView",
	[ActivityType.KColourEgg] = "TaskActivityView",
	[ActivityType.KMonsterShop] = "ActivityBlockMonsterShopView",
	[ActivityType.KDailyCharge] = "ActivityDailyChargeView",
	[ActivityType.KPuzzleGame] = "ActivityPuzzleGameView"
}
ActivityMark = {
	kWonderful2 = "WONDERFUL2",
	kRecommend = "RECOMMEND",
	kMonday = "MONDAY",
	kWonderful = "WONDERFUL"
}
ActivityMarkImg = {
	[ActivityMark.kWonderful] = "icon_energy_small.png",
	[ActivityMark.kMonday] = "icon_energy_small.png",
	[ActivityMark.kWonderful2] = "icon_energy_small.png",
	[ActivityMark.kRecommend] = "icon_energy_small.png"
}
ActivityComplexUI = {
	tryEnterComplexMainView = {
		[ActivityType_UI.kActivityBlockWsj] = "ActivityBlockWsjView",
		[ActivityType_UI.kActivityWxh] = "ActivityBlockSupportWxhView",
		[ActivityType_UI.kActivityBlockZuoHe] = "ActivityBlockSupportView",
		[ActivityType_UI.kActivityBlockSummer] = "ActivityBlockSummerView",
		[ActivityType_UI.kActivityBlock] = "ActivityBlockView",
		[ActivityType_UI.KActivityBlockSnowflake] = "ActivityBlockView",
		[ActivityType_UI.KActivityBlockHoliday] = "ActivityBlockHolidayView",
		[ActivityType_UI.KActivityBlockDetetive] = "ActivityBlockDetectiveView",
		[ActivityType_UI.KActivityBlockMusic] = "ActivityBlockMusicView",
		[ActivityType_UI.KActivityBlockBaking] = "ActivityBakingMainView",
		[ActivityType_UI.KActivityCollapsed] = "ActivityCollapsedMainView",
		[ActivityType_UI.KActivityKnight] = "ActivityKnightMainView",
		[ActivityType_UI.KActivitySunflower] = "ActivitySunflowerMainView",
		[ActivityType_UI.KActivityFire] = "ActivityFireMainView",
		[ActivityType_UI.kActivityZero] = "ActivityZeroMainView",
		[ActivityType_UI.KActivityFemale] = "ActivityFemaleMainView",
		[ActivityType_UI.KActivityStoryBook] = "ActivityStoryBookMainView",
		[ActivityType_UI.kActivityReZero] = "ActivityReZeroMainView",
		[ActivityType_UI.KActivityDeepSea] = "ActivityDeepSeaMainView",
		[ActivityType_UI.KActivitySummerRe] = "ActivitySummerReMainView",
		[ActivityType_UI.KActivityFireWorks] = "ActivityFireWorksMainView",
		[ActivityType_UI.KActivityTerror] = "ActivityTerrorMainView",
		[ActivityType_UI.KActivityRiddle] = "ActivityRiddleMainView",
		[ActivityType_UI.KActivityAnimal] = "ActivityAnimalMainView",
		[ActivityType_UI.KActivityDusk] = "ActivityDuskMainView",
		[ActivityType_UI.KActivitySilentNight] = "ActivitySilentNightMainView",
		[ActivityType_UI.KActivityDrama] = "ActivityDramaMainView",
		[ActivityType_UI.KActivityFamily] = "ActivityFamilyMainView",
		[ActivityType_UI.KActivityMagic] = "ActivityMagicMainView",
		[ActivityType_UI.KActivitySamurai] = "ActivitySamuraiMainView",
		[ActivityType_UI.KActivitySpring] = "ActivitySpringMainView",
		[ActivityType_UI.KActivityEaster] = "ActivityEasterMainView",
		[ActivityType_UI.KActivityReZhan] = "ActivityBlockSupportNewView"
	},
	enterBlockMonsterShopView = {
		[ActivityType_UI.kActivityBlockWsj] = "ActivityBlockMonsterShopView",
		[ActivityType_UI.KActivityBlockHoliday] = "ActivityBlockMonsterShopView",
		[ActivityType_UI.KActivityBlockDetetive] = "ActivityBlockMonsterShopView"
	},
	enterSupportStageView = {
		[ActivityType_UI.kActivityWxh] = "ActivitySagaSupportMapView",
		[ActivityType_UI.kActivityBlockZuoHe] = "ActivitySagaSupportMapView",
		[ActivityType_UI.kActivityBlockSummer] = "ActivitySagaSupportMapView",
		[ActivityType_UI.kActivityBlockWsj] = "ActivityBlockMapWsjView",
		[ActivityType_UI.KActivityBlockSnowflake] = "ActivitySagaSupportMapView",
		[ActivityType_UI.kActivityBlock] = "ActivitySagaSupportMapView",
		[ActivityType_UI.KActivityBlockHoliday] = "ActivityBlockMapWsjView",
		[ActivityType_UI.KActivityBlockDetetive] = "ActivitySagaSupportMapView",
		[ActivityType_UI.KActivityBlockMusic] = "ActivitySagaSupportMapView",
		[ActivityType_UI.KActivityBlockBaking] = "ActivitySagaSupportMapView",
		[ActivityType_UI.KActivityCollapsed] = "ActivitySagaSupportMapView",
		[ActivityType_UI.KActivityKnight] = "ActivitySagaSupportMapView",
		[ActivityType_UI.KActivitySunflower] = "ActivitySagaSupportMapView",
		[ActivityType_UI.KActivityFire] = "ActivitySagaSupportMapView",
		[ActivityType_UI.kActivityZero] = "ActivityZeroeMapView",
		[ActivityType_UI.KActivityFemale] = "ActivitySagaSupportMapView",
		[ActivityType_UI.KActivityStoryBook] = "ActivitySagaSupportMapView",
		[ActivityType_UI.kActivityReZero] = "ActivitySagaSupportMapView",
		[ActivityType_UI.KActivityDeepSea] = "ActivityMapNewView",
		[ActivityType_UI.KActivitySummerRe] = "ActivitySagaSupportMapView",
		[ActivityType_UI.KActivityFireWorks] = "ActivityMapNewView",
		[ActivityType_UI.KActivityTerror] = "ActivityMapNewView",
		[ActivityType_UI.KActivityRiddle] = "ActivityMapNewView",
		[ActivityType_UI.KActivityAnimal] = "ActivityMapNewView",
		[ActivityType_UI.KActivityDusk] = "ActivityMapNewView",
		[ActivityType_UI.KActivitySilentNight] = "ActivityMapNewView",
		[ActivityType_UI.KActivityDrama] = "ActivityMapNewView",
		[ActivityType_UI.KActivityFamily] = "ActivityOrientMapView",
		[ActivityType_UI.KActivityMagic] = "ActivityMapNewView",
		[ActivityType_UI.KActivitySamurai] = "ActivityMapNewView",
		[ActivityType_UI.KActivitySpring] = "ActivityMapNewView",
		[ActivityType_UI.KActivityEaster] = "ActivityMapNewView"
	},
	enterSagaSupportStageView = {
		[ActivityType_UI.kActivityWxh] = "ActivitySagaSupportStageWxhView",
		[ActivityType_UI.kActivityBlockZuoHe] = "ActivitySagaSupportStageView",
		[ActivityType_UI.KActivitySupportHoliday] = "ActivitySupportHolidayView",
		[ActivityType_UI.KActivityReZhan] = "ActivitySagaSupportStageWxhView"
	},
	enterSagaSupportScheduleView = {
		[ActivityType_UI.kActivityWxh] = "ActivitySagaSupportScheduleWxhView",
		[ActivityType_UI.kActivityBlockZuoHe] = "ActivitySagaSupportScheduleView",
		[ActivityType_UI.KActivityReZhan] = "ActivitySagaSupportScheduleWxhView"
	},
	enterSupportTaskView = {
		[ActivityType_UI.kActivityWxh] = "ActivityBlockTaskView",
		[ActivityType_UI.kActivityBlockZuoHe] = "ActivityBlockTaskView",
		[ActivityType_UI.kActivityBlockSummer] = "ActivityBlockTaskView",
		[ActivityType_UI.kActivityBlockWsj] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityBlockSnowflake] = "ActivityBlockTaskView",
		[ActivityType_UI.kActivityBlock] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityBlockHoliday] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityBlockDetetive] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityBlockMusic] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityBlockBaking] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityCollapsed] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityKnight] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivitySunflower] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityFire] = "ActivityBlockTaskView",
		[ActivityType_UI.kActivityZero] = "ActivityBlockZeroTaskView",
		[ActivityType_UI.KActivityFemale] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityStoryBook] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityDeepSea] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityStoryBook] = "ActivityBlockTaskView",
		[ActivityType_UI.kActivityReZero] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivitySummerRe] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityFireWorks] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityTerror] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityRiddle] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityAnimal] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityDusk] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivitySilentNight] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityDrama] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityFamily] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityMagic] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivitySamurai] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivitySpring] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityEaster] = "ActivityBlockTaskView",
		[ActivityType_UI.KActivityReZhan] = "ActivityBlockTaskView"
	},
	enterSagaSupportRankRewardView = {
		[ActivityType_UI.kActivityWxh] = "ActivitySagaSupportRankRewardWxhView",
		[ActivityType_UI.kActivityBlockZuoHe] = "ActivitySagaSupportRankRewardView",
		[ActivityType_UI.KActivitySupportHoliday] = "ActivitySupportRankHolidayView",
		[ActivityType_UI.KActivityReZhan] = "ActivitySagaSupportRankRewardWxhView"
	},
	enterSagaWinView = {
		[ActivityType_UI.kActivityWxh] = "ActivitySagaWinWxhView",
		[ActivityType_UI.kActivityBlockZuoHe] = "ActivitySagaWinView",
		[ActivityType_UI.KActivitySupportHoliday] = "ActivitySupportWinHolidayView",
		[ActivityType_UI.KActivityReZhan] = "ActivitySagaWinWxhView"
	}
}
ActivityLogin14Config = {
	EightDays_Baking = {
		resFile = "asset/ui/ActivityBakingLogin14.csb",
		textPattern = {
			cc.c4b(255, 254, 249, 255),
			cc.c4b(255, 213, 133, 255)
		}
	},
	EightDays_Collapsed = {
		resFile = "asset/ui/ActivityCollapsedLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(212, 197, 255, 255)
		}
	},
	EightDays_Knight = {
		resFile = "asset/ui/ActivityKnightLogin14.csb",
		textPattern = {
			cc.c4b(255, 252, 238, 255),
			cc.c4b(255, 234, 177, 255)
		}
	},
	EightDays_Sunflower = {
		resFile = "asset/ui/ActivitySunflowerLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(176, 228, 254, 255)
		}
	},
	EightDays_Fire = {
		resFile = "asset/ui/ActivityFireLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(176, 228, 254, 255)
		}
	},
	EightDays_Female = {
		resFile = "asset/ui/ActivityFemaleLogin14.csb",
		textPattern = {
			cc.c4b(255, 165, 218, 255),
			cc.c4b(255, 239, 163, 255)
		}
	},
	EightDays_StoryBook = {
		resFile = "asset/ui/ActivityStoryBookLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(255, 233, 133, 255)
		}
	},
	EightDays_ReZero = {
		resFile = "asset/ui/ActivityReZeroLogin14.csb"
	},
	EightDays_StoryBook = {
		resFile = "asset/ui/ActivityStoryBookLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(255, 233, 133, 255)
		}
	},
	EightDays_DeepSea = {
		resFile = "asset/ui/ActivityDeepSeaLogin.csb"
	},
	EightDays_DeepSea_Re = {
		resFile = "asset/ui/ActivityDeepSeaLogin.csb"
	},
	EightDays_SummerRe = {
		resFile = "asset/ui/ActivitySummerReLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(144, 183, 255, 255)
		}
	},
	EightDays_FireWorks = {
		resFile = "asset/ui/ActivityFireWorksLogin14.csb",
		textPattern = {
			cc.c4b(204, 184, 255, 255),
			cc.c4b(255, 255, 255, 255)
		}
	},
	EightDays_Terror = {
		resFile = "asset/ui/ActivityTerrorLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(130, 130, 130, 255)
		}
	},
	EightDays_Riddle = {
		resFile = "asset/ui/ActivityRiddleLogin14.csb"
	},
	EightDays_Female_Re = {
		resFile = "asset/ui/ActivityFemaleLogin14.csb",
		textPattern = {
			cc.c4b(255, 165, 218, 255),
			cc.c4b(255, 239, 163, 255)
		}
	},
	EightDays_Animal = {
		resFile = "asset/ui/ActivityAnimalLogin14.csb"
	},
	EightDays_Dusk = {
		resFile = "asset/ui/ActivityDuskLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(202, 247, 252, 255)
		}
	},
	EightDays_Dusk_Re = {
		resFile = "asset/ui/ActivityDuskLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(202, 247, 252, 255)
		}
	},
	EightDays_SilentNight = {
		resFile = "asset/ui/ActivitySilentNightLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(255, 251, 189, 255)
		}
	},
	EightDays_Drama = {
		resFile = "asset/ui/ActivityDramaLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(145, 143, 198, 255)
		}
	},
	EightDays_Drama_Re = {
		resFile = "asset/ui/ActivityDramaLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(145, 143, 198, 255)
		}
	},
	EightDays_Family = {
		resFile = "asset/ui/ActivityFamilyLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(255, 249, 198, 255)
		}
	},
	EightDays_Animal_Re = {
		resFile = "asset/ui/ActivityAnimalLogin14.csb"
	},
	EightDays_Magic = {
		resFile = "asset/ui/ActivityMagicLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(255, 242, 184, 255)
		}
	},
	EightDays_Samurai = {
		resFile = "asset/ui/ActivitySamuraiLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(255, 242, 184, 255)
		}
	},
	EightDays_Spring = {
		resFile = "asset/ui/ActivitySpringLogin14.csb",
		textPattern = {
			cc.c4b(232, 244, 254, 255),
			cc.c4b(210, 226, 248, 255)
		}
	},
	EightDays_Family_Re = {
		resFile = "asset/ui/ActivityFamilyLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(255, 249, 198, 255)
		}
	},
	EightDays_Easter = {
		resFile = "asset/ui/ActivityEasterLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(255, 249, 198, 255)
		}
	},
	EightDays_Summer_Re = {
		resFile = "asset/ui/ActivitySummerReLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(144, 183, 255, 255)
		}
	},
	EightDays_Magic_Re = {
		resFile = "asset/ui/ActivityMagicLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(255, 242, 184, 255)
		}
	},
	EightDays_ReZero_Re = {
		resFile = "asset/ui/ActivityReZeroLogin14.csb"
	},
	EightDays_Fireworks_Re = {
		resFile = "asset/ui/ActivityFireWorksLogin14.csb",
		textPattern = {
			cc.c4b(204, 184, 255, 255),
			cc.c4b(255, 255, 255, 255)
		}
	},
	EightDays_Samurai_Re = {
		resFile = "asset/ui/ActivitySamuraiLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(255, 242, 184, 255)
		}
	},
	EightDays_Baking_Re = {
		resFile = "asset/ui/ActivityBakingLogin14.csb",
		textPattern = {
			cc.c4b(255, 254, 249, 255),
			cc.c4b(255, 213, 133, 255)
		}
	},
	EightDays_Spring_Re = {
		resFile = "asset/ui/ActivitySpringLogin14.csb",
		textPattern = {
			cc.c4b(232, 244, 254, 255),
			cc.c4b(210, 226, 248, 255)
		}
	},
	EightDays_Knight_2nd = {
		resFile = "asset/ui/ActivityKnightLogin14.csb",
		textPattern = {
			cc.c4b(255, 252, 238, 255),
			cc.c4b(255, 234, 177, 255)
		}
	},
	EightDays_Fire_2nd = {
		resFile = "asset/ui/ActivityFireLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(176, 228, 254, 255)
		}
	},
	EightDays_StoryBook_2nd = {
		resFile = "asset/ui/ActivityStoryBookLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(255, 233, 133, 255)
		}
	},
	EightDays_SilentNight_2nd = {
		resFile = "asset/ui/ActivitySilentNightLogin14.csb",
		textPattern = {
			cc.c4b(255, 255, 255, 255),
			cc.c4b(255, 251, 189, 255)
		}
	}
}
ActivityMainMapTitleConfig = {
	title = {
		[ActivityType_UI.KActivityFemale] = {
			title = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 240, 147, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 157, 159, 255)
				}
			},
			title_0 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 240, 147, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 157, 159, 255)
				}
			},
			title_2 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 240, 147, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 157, 159, 255)
				}
			}
		},
		[ActivityType_UI.KActivityStoryBook] = {
			title = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(254, 255, 157, 255)
				}
			}
		},
		[ActivityType_UI.KActivityDeepSea] = {
			title_0 = {
				{
					ratio = 0.3,
					color = cc.c4b(0, 0, 0, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(33, 97, 83, 255)
				}
			}
		},
		[ActivityType_UI.KActivityFireWorks] = {
			title = {
				{
					ratio = 0.3,
					color = cc.c4b(210, 186, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 255, 255, 255)
				}
			},
			title_0 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 248, 129, 255)
				}
			}
		},
		[ActivityType_UI.KActivityTerror] = {
			title = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(130, 130, 130, 255)
				}
			}
		},
		[ActivityType_UI.KActivityRiddle] = {
			title_0 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 255, 0, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 252, 208, 255)
				}
			}
		},
		[ActivityType_UI.KActivityDusk] = {
			title = {
				{
					ratio = 0.3,
					color = cc.c4b(153, 255, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(254, 255, 144, 255)
				}
			}
		},
		[ActivityType_UI.KActivityMagic] = {
			title = {
				{
					ratio = 0.3,
					color = cc.c4b(216, 253, 138, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(242, 208, 134, 255)
				}
			},
			title_0 = {
				{
					ratio = 0.3,
					color = cc.c4b(216, 253, 138, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(242, 208, 134, 255)
				}
			},
			title_2 = {
				{
					ratio = 0.3,
					color = cc.c4b(216, 253, 138, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(242, 208, 134, 255)
				}
			}
		},
		[ActivityType_UI.KActivitySamurai] = {
			title = {
				{
					ratio = 0.3,
					color = cc.c4b(216, 253, 138, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 3570, 172, 255)
				}
			},
			title_0 = {
				{
					ratio = 0.3,
					color = cc.c4b(216, 253, 138, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 3570, 172, 255)
				}
			}
		}
	},
	anim = {
		[ActivityType_UI.KActivityFemale] = {
			name = "zhu_biannvshengzhuye",
			position = cc.p(134, 135)
		},
		[ActivityType_UI.KActivityStoryBook] = {
			name = "zhu_beimoufubenrukou",
			position = cc.p(54, 155)
		},
		[ActivityType_UI.KActivityDeepSea] = {
			name = "fubenrukou_shenhaihuodongrukou",
			position = cc.p(-165, 63)
		},
		[ActivityType_UI.KActivitySummerRe] = {
			name = "shuijingqiu_xiarihuodong",
			position = cc.p(160, 140)
		},
		[ActivityType_UI.KActivityTerror] = {
			name = "eff_zhuyerukou_kongbubenrukou",
			position = cc.p(-145, 72),
			runAction = function(node)
				node:addCallbackAtFrame(75, function()
					node:stop()
				end)
			end
		},
		[ActivityType_UI.KActivityFireWorks] = {
			name = "eff_Z_hdjm_huohuadahuirukou",
			position = cc.p(-137, 62)
		},
		[ActivityType_UI.KActivityRiddle] = {
			name = "zhuyemianZ__zhentanduijuerukouzhuye",
			position = cc.p(-151, 50)
		},
		[ActivityType_UI.KActivityAnimal] = {
			name = "zhuye_xinyuanyimiaochangjing",
			position = cc.p(-131, 60)
		},
		[ActivityType_UI.KActivityDusk] = {
			name = "ZSfuben_TX_zhushenhuanghunfuben",
			position = cc.p(130, 128)
		},
		[ActivityType_UI.KActivitySilentNight] = {
			name = "fuben_shengdanzhuyefubenrukou",
			position = cc.p(178, 120)
		},
		[ActivityType_UI.KActivityDrama] = {
			name = "fubenrukou_gudianxijufuben",
			position = cc.p(175, 140)
		},
		[ActivityType_UI.kActivityReZero] = {
			{
				"rukou_1_clkaishieff",
				cc.p(109, 70)
			},
			{
				"rukou_2_clkaishieff",
				cc.p(109, 70)
			},
			{
				"rukou_3_clkaishieff",
				cc.p(78, 140)
			}
		},
		[ActivityType_UI.KActivityMagic] = {
			showDiImg = true,
			name = "main_wuzuizhiyufubenrukou",
			position = cc.p(-127, 56)
		},
		[ActivityType_UI.KActivitySamurai] = {
			showDiImg = true,
			name = "rukou_wujinxiarukou",
			bgAnim = "main_wujinxiarukou",
			position = cc.p(172, 141),
			bgAnimPos = cc.p(695, 428)
		}
	}
}
ActivitySupportScheduleId = {
	[ActivityType_UI.kActivityBlockZuoHe] = "ABS_ZuoHe",
	[ActivityType_UI.kActivityWxh] = "ABS_WuXiuHui",
	[ActivityType_UI.KActivityReZhan] = "ABS_ReZhan"
}
OrientActivityMainConfig = {
	anim = {
		[ActivityType_UI.KActivityFamily] = {
			name = "fubenrukou_huijiadeluzhuyefuben",
			position = cc.p(410, 150)
		}
	}
}
