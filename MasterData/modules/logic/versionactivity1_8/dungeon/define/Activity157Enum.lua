-- chunkname: @modules/logic/versionactivity1_8/dungeon/define/Activity157Enum.lua

module("modules.logic.versionactivity1_8.dungeon.define.Activity157Enum", package.seeall)

local Activity157Enum = _M

Activity157Enum.MissionType = {
	MainMission = 1,
	SideMission = 2
}
Activity157Enum.MissionStatus = {
	Locked = 2,
	DispatchFinish = 4,
	Finish = 5,
	Dispatching = 3,
	Normal = 1
}
Activity157Enum.MissionStatusShowSetting = {
	[Activity157Enum.MissionStatus.Normal] = {
		fight = "v1a8_dungeon_factory_btn_fight",
		normal = "v1a8_dungeon_factory_btn_finishing"
	},
	[Activity157Enum.MissionStatus.Locked] = "v1a8_dungeon_factory_btn_locked",
	[Activity157Enum.MissionStatus.Dispatching] = "v1a8_dungeon_factory_btn_finishing",
	[Activity157Enum.MissionStatus.DispatchFinish] = "v1a8_dungeon_factory_btn_reward",
	[Activity157Enum.MissionStatus.Finish] = {
		story = "v1a8_dungeon_factory_btn_review",
		normal = "v1a8_dungeon_factory_btn_finished"
	}
}
Activity157Enum.MissionLineStatusIcon = {
	[Activity157Enum.MissionStatus.Normal] = {
		point = "v1a8_dungeon_factory_point_unlocked"
	},
	[Activity157Enum.MissionStatus.Locked] = {
		point = "v1a8_dungeon_factory_point_locked"
	},
	[Activity157Enum.MissionStatus.Finish] = {
		point = "v1a8_dungeon_factory_point_finished"
	},
	[Activity157Enum.MissionStatus.Dispatching] = {
		point = "v1a8_dungeon_factory_point_unlocked"
	},
	[Activity157Enum.MissionStatus.DispatchFinish] = {
		point = "v1a8_dungeon_factory_point_unlocked"
	}
}
Activity157Enum.ConstId = {
	FactoryCompositeCost = 3,
	FirstFactoryComponent = 2,
	UnlockEntranceElement = 1,
	FactoryRepairPartItem = 4,
	FactoryCompositeFormula = 6,
	FactoryProductCapacity = 7,
	FactoryMapNodeLineOffsetY = 11,
	FactoryRepairGameMapSize = 10
}
Activity157Enum.UnlockBlueprintElement = 1811801
Activity157Enum.res = {
	[ArmPuzzlePipeEnum.type.straight] = {
		"",
		"v1a8_dungeon_factory_pipepath3"
	},
	[ArmPuzzlePipeEnum.type.corner] = {
		"",
		"v1a8_dungeon_factory_pipepath2"
	},
	[ArmPuzzlePipeEnum.type.t_shape] = {
		"",
		"v1a8_dungeon_factory_pipepath1"
	}
}
Activity157Enum.entryColor = {
	[0] = "#FFFFFF",
	"#77251e",
	"#8b603d"
}
Activity157Enum.entryTypeColor = {
	[ArmPuzzlePipeEnum.type.first] = {
		[1] = "#7e251f",
		[2] = "#a4693a"
	},
	[ArmPuzzlePipeEnum.type.last] = {
		[1] = "#7e251f",
		[2] = "#a4693a"
	}
}
Activity157Enum.pathColor = {
	[0] = "#FFFFFF",
	"#7e251f",
	"#aa7e58"
}

return Activity157Enum
