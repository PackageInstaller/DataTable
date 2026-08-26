-- chunkname: @modules/logic/versionactivity2_8/nuodika/define/NuoDiKaEnum.lua

module("modules.logic.versionactivity2_8.nuodika.define.NuoDiKaEnum", package.seeall)

local NuoDiKaEnum = _M

NuoDiKaEnum.MapPassType = {
	ClearEnemy = 1,
	UnlockItem = 2
}
NuoDiKaEnum.EpisodeStatus = {
	BeforeStory = 0,
	MapGame = 1,
	Finished = 3,
	AfterStory = 2
}
NuoDiKaEnum.NodeType = {
	Random = 2,
	Normal = 1
}
NuoDiKaEnum.EventType = {
	Item = 2,
	Enemy = 3,
	Start = 1,
	Null = 0
}
NuoDiKaEnum.EnemyType = {
	MainRole = 1,
	Normal = 0
}
NuoDiKaEnum.EnemyState = {
	Disappear = 4,
	Freeze = 2,
	Hurt = 5,
	Selected = 3,
	Normal = 1
}
NuoDiKaEnum.SkillType = {
	Halo = 5,
	AttackRandom = 3,
	UnlockAllNodes = 7,
	AttackSelected = 2,
	ReplaceHurt = 6,
	AttackReflect = 9,
	WarnEnemyNodes = 8,
	AttackAll = 4,
	RestoreLife = 1
}
NuoDiKaEnum.TriggerTimingType = {
	Interact = 1,
	Active = 3,
	InteractTimes = 4,
	Death = 2
}
NuoDiKaEnum.TriggerRangeType = {
	All = 4,
	SquareLength = 3,
	RhombusLength = 2,
	MainRole = 0,
	TargetNode = 1
}
NuoDiKaEnum.ItemDragType = {
	CanMove = 1,
	NoMove = 0
}
NuoDiKaEnum.ItemPlaceType = {
	AllEnemy = 0,
	AllNode = 1
}
NuoDiKaEnum.ResultTipType = {
	Quit = 2,
	Restart = 1,
	None = 0
}
NuoDiKaEnum.OnLineOffsetX = -50
NuoDiKaEnum.OnLineOffsetY = 38
NuoDiKaEnum.UnlockEventId = 10008
NuoDiKaEnum.MapOffset = {
	NoOdd = {
		21,
		-24
	},
	XOdd = {
		-47,
		15
	},
	YOdd = {
		-46,
		-67
	},
	XYOdd = {
		-109,
		-25
	}
}

return NuoDiKaEnum
