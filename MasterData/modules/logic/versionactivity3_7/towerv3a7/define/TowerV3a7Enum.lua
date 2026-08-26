-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/define/TowerV3a7Enum.lua

module("modules.logic.versionactivity3_7.towerv3a7.define.TowerV3a7Enum", package.seeall)

local TowerV3a7Enum = _M

TowerV3a7Enum.GuideId = 37400
TowerV3a7Enum.FirstMapId = 1001
TowerV3a7Enum.MaxRoomCount = 8
TowerV3a7Enum.MaxChessNum = 9
TowerV3a7Enum.AppearDialogTime = 2
TowerV3a7Enum.RecoverHpValue = 1
TowerV3a7Enum.ChessFindTime = 1
TowerV3a7Enum.ManualTriggerStoryId = 100605
TowerV3a7Enum.ShowID = false
TowerV3a7Enum.StoryTriggerType = {
	Appear = 2,
	FinishTarget = 3,
	Die = 1
}
TowerV3a7Enum.StoryFinishTarget = {
	Survival = 1,
	KillAllEnemy = 2
}
TowerV3a7Enum.Camp = {
	Enemy = 2,
	Own = 1
}
TowerV3a7Enum.ChessAppearType = {
	Delay = 2,
	AfterDie = 3,
	Init = 1
}
TowerV3a7Enum.ChessState = {
	Moving = 5,
	SrcMoving = 3,
	Select = 2,
	DstMoving = 4,
	Drag = 6,
	Normal = 1
}
TowerV3a7Enum.SkillType = {
	Type1 = 1,
	Type3 = 3,
	Type2 = 2,
	Type4 = 4
}
TowerV3a7Enum.PassiveSkillType = {
	Type1 = 1,
	Type2 = 2
}
TowerV3a7Enum.SpecialStage1 = {
	[100605] = 5,
	[100603] = 5,
	[100606] = 5
}
TowerV3a7Enum.Audio = {
	Audio1 = 25001030,
	Audio8 = 370601,
	Audio7 = 20260136,
	Audio2 = 20250819,
	Audio9 = 370602,
	EndBattle = 20301016,
	Audio4 = 20190011,
	Audio3 = 340126,
	Audio10 = 313005,
	StartBattle = 20301015
}
TowerV3a7Enum.PathDir = {
	Down = 2,
	Up = 1,
	Right = 4,
	UpRight = 5,
	UpLeft = 8,
	LeftDown = 7,
	Left = 3,
	RightDown = 6
}
TowerV3a7Enum.PathStatus = {
	WB = 10,
	BB = 0,
	WW = 11,
	BW = 1
}

return TowerV3a7Enum
