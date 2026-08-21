-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/util/GuideEnum.lua

module("logic.extensions.guide.util.GuideEnum", package.seeall)

local GuideEnum = {}

GuideEnum.Category = {
	Guide = 1,
	ImageGuide = 2,
	None = 0
}
GuideEnum.TriggerType = {
	BeforeCampAdjustment = 10,
	PageActive = 5,
	RoguelikeInPos = 1001,
	CloseUI = 4,
	EnterDungeon = 1,
	RoguelikeInEvent = 1002,
	RoguelikeWithMonster = 1003,
	EquipLevelUp = 7,
	OpenView = 2,
	RoguelikeActiveUI = 1005,
	WaitBattleStart = 9,
	RoguelikeCalcReultByType = 1004,
	ActiveStoryArrtOption = 6,
	FinishStory = 8,
	PlayerLevel = 3
}
GuideEnum.CompleteType = {
	ClickAnywhere = 1,
	CloseUI = 8,
	ShowEnemyHint = 14,
	EnterScene = 10,
	ShowOpenFunctionAnim = 9,
	AutoFinishWhenShowControl = 5,
	DragBeforeBattle = 3,
	WaitForAactionFinish = 1002,
	OpenView = 11,
	WaitForPlotFinish = 1003,
	WaitForTime = 1004,
	WaitForLoadScene = 1001,
	CloseFullImageGuide = 4,
	ClickTargetControl = 2,
	WaitCreateRole = 13,
	WaitUIViewClose = 12,
	AgreeAirWorkProtocol = 15,
	ClickAnywhereWithPassEvent = 7,
	SwipeTo = 6,
	WaitUICloseBySpecial = 1005
}
GuideEnum.GuideControlType = {
	ShowFullScreenImageGuide = 5,
	ControlUI = 1,
	CurPosInDungeon = 2,
	NpcId = 3,
	ReadyBeforeBattle = 4,
	MoveCamera = 7,
	SceneObject = 9,
	SwipeToUI = 8,
	ActiveUI = 6,
	None = 0
}
GuideEnum.ArrowDirection = {
	LeftTop = 3,
	RightBottom = 1,
	LeftBottom = 4,
	RightTop = 2
}
GuideEnum.GuideRoguelikeTriggerType = {
	Event = 2,
	ActiveUI = 5,
	Coordinate = 1,
	JudgeType = 4,
	Monster = 3
}

return GuideEnum
