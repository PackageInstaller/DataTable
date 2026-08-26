-- chunkname: @modules/logic/versionactivity3_3/arcade/define/ArcadeHallEnum.lua

module("modules.logic.versionactivity3_3.arcade.define.ArcadeHallEnum", package.seeall)

local ArcadeHallEnum = _M

ArcadeHallEnum.Const = {
	GridSize = 0.813,
	StartY = -4.4,
	StartX = -4.4
}
ArcadeHallEnum.HallInteractiveId = {
	Level2 = 108,
	Task = 106,
	Level3 = 109,
	NPC = 103,
	Develop = 105,
	Level1 = 107,
	HandBook = 104
}
ArcadeHallEnum.ShowUI = {
	UITalk = 2,
	UIName = 1
}
ArcadeHallEnum.HallInteractiveParams = {
	[ArcadeHallEnum.HallInteractiveId.HandBook] = {
		isOpenTip = true,
		OpenFunc = ArcadeController.instance.openArcadeHandBookView,
		ViewName = ViewName.ArcadeHandBookView,
		ShowInfoUI = {
			ArcadeHallEnum.ShowUI.UIName
		},
		MO = ArcadeHallInteractiveMO,
		NameUIOffset = {
			x = 0,
			y = 0
		}
	},
	[ArcadeHallEnum.HallInteractiveId.Develop] = {
		isOpenTip = true,
		OpenFunc = ArcadeController.instance.openDevelopView,
		ViewName = ViewName.ArcadeDevelopView,
		ShowInfoUI = {
			ArcadeHallEnum.ShowUI.UIName
		},
		MO = ArcadeHallInteractiveMO,
		NameUIOffset = {
			x = -5,
			y = 0
		}
	},
	[ArcadeHallEnum.HallInteractiveId.Task] = {
		isOpenTip = true,
		Reddot = 3306,
		OpenFunc = ArcadeController.instance.openTaskView,
		ViewName = ViewName.ArcadeRewardView,
		ShowInfoUI = {
			ArcadeHallEnum.ShowUI.UIName
		},
		MO = ArcadeHallInteractiveMO,
		NameUIOffset = {
			x = -5.8,
			y = 0
		}
	},
	[ArcadeHallEnum.HallInteractiveId.Level1] = {
		isOpenTip = true,
		OpenFunc = ArcadeController.instance.openLevel1View,
		ShowInfoUI = {
			ArcadeHallEnum.ShowUI.UIName
		},
		MO = ArcadeHallInteractiveMO,
		NameUIOffset = {
			x = -16,
			y = 0
		}
	},
	[ArcadeHallEnum.HallInteractiveId.Level2] = {
		isOpenTip = true,
		OpenFunc = ArcadeController.instance.openLevel2View,
		ShowInfoUI = {
			ArcadeHallEnum.ShowUI.UIName
		},
		MO = ArcadeHallInteractiveMO,
		NameUIOffset = {
			x = -17,
			y = 0
		}
	},
	[ArcadeHallEnum.HallInteractiveId.Level3] = {
		isOpenTip = true,
		OpenFunc = ArcadeController.instance.openLevel3View,
		ShowInfoUI = {
			ArcadeHallEnum.ShowUI.UIName
		},
		MO = ArcadeHallInteractiveMO,
		NameUIOffset = {
			x = -22,
			y = 0
		}
	},
	[ArcadeHallEnum.HallInteractiveId.NPC] = {
		isOpenTip = false,
		OpenFunc = ArcadeController.instance.talkNPC,
		ShowInfoUI = {
			ArcadeHallEnum.ShowUI.UITalk
		},
		MO = ArcadeHallNPCMO
	}
}
ArcadeHallEnum.LevelScene = {
	[ArcadeHallEnum.HallInteractiveId.Level1] = {
		LockObj = "close3",
		Level = 1
	},
	[ArcadeHallEnum.HallInteractiveId.Level2] = {
		LockObj = "close2",
		Level = 2
	},
	[ArcadeHallEnum.HallInteractiveId.Level3] = {
		LockObj = "close1",
		Level = 3
	}
}
ArcadeHallEnum.ArcadLevelLockToast = {
	[2] = 331011,
	[3] = 331012
}
ArcadeHallEnum.ShowUIParam = {
	[ArcadeHallEnum.ShowUI.UIName] = {
		res = "ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_building_info.prefab",
		comp = ArcadeBuildingUIItem
	},
	[ArcadeHallEnum.ShowUI.UITalk] = {
		res = "ui/viewres/versionactivity_3_3/v3a3_eliminate/v3a3_eliminate_hero_talk.prefab",
		comp = ArcadHeroTalkItem
	}
}
ArcadeHallEnum.GameSceneName = "ArcadeHallScene"
ArcadeHallEnum.TalkCondition = {
	Trigger = "2",
	First = "1"
}
ArcadeHallEnum.LongPressArr = {
	0.3,
	0.3
}
ArcadeHallEnum.HeroMoveSpeed = 0.2
ArcadeHallEnum.DelayShowCharacterTime = 0.5
ArcadeHallEnum.Directions = {
	{
		x = 1,
		y = 0
	},
	{
		x = -1,
		y = 0
	},
	{
		x = 0,
		y = 1
	},
	{
		x = 0,
		y = -1
	}
}
ArcadeHallEnum.SceneUrl = "scenes/v3a3_m_s12_bf/prefab/v3a3_m_s12_background_a_p.prefab"

return ArcadeHallEnum
