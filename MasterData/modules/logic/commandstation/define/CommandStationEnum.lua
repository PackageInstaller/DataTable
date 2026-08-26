-- chunkname: @modules/logic/commandstation/define/CommandStationEnum.lua

module("modules.logic.commandstation.define.CommandStationEnum", package.seeall)

local CommandStationEnum = _M

CommandStationEnum.EventType = {
	Dialogue = 3,
	Dispatch = 4,
	Normal = 2,
	Main = 1
}
CommandStationEnum.EventCategory = {
	Character = 1,
	Normal = 2
}
CommandStationEnum.DispatchTabView = {
	Process = 2,
	Normal = 1
}
CommandStationEnum.EventState = {
	NotDispatch = -1,
	GetReward = 1
}
CommandStationEnum.DispatchState = {
	NotStart = 1,
	Completed = 3,
	GetReward = 4,
	InProgress = 2
}
CommandStationEnum.ChainState = {
	Dead = 2,
	Alive = 1
}
CommandStationEnum.EventCategoryKey = {
	Character = "chaEventId",
	Normal = "eventId"
}
CommandStationEnum.DialogueType = {
	Click = 3,
	Enter = 1,
	Idle = 2
}
CommandStationEnum.ConstId = {
	ChapterList = 1,
	ActParam2 = 5,
	RelationShipUnlockDungeon = 8,
	RelationShipUnlockAct = 7,
	VersionEndDt = 3,
	ActParam = 2,
	VersionName = 4
}
CommandStationEnum.PrefsKey = {
	Version = 3,
	RelationShipBoardFirstOpenLine = 8,
	MainViewEntryAnim = 9,
	CampNewFlag = 10,
	RelationShipBoardFirstOpenCha = 7,
	NewMapTip = 1,
	RelationShipBoardFirstOpenTeam = 6,
	DungeonMapLoopEffect = 4,
	DungeonMapLightEffect = 5,
	TimeId = 2
}
CommandStationEnum.TaskType = {
	Catch = 2,
	Normal = 1
}
CommandStationEnum.TaskShowType = {
	Parade = 1,
	Overseas = 2,
	Spring = 3,
	Normal = 0
}
CommandStationEnum.PaperViewType = {
	Uid = 1
}
CommandStationEnum.CharacterClickState = {
	Default = 0,
	NoClick = 1
}
CommandStationEnum.CharacterRelationColor = {
	SLFramework.UGUI.GuiHelper.ParseColor("#FFFFFF"),
	SLFramework.UGUI.GuiHelper.ParseColor("#154c98"),
	(SLFramework.UGUI.GuiHelper.ParseColor("#981528"))
}
CommandStationEnum.RelationShipBoardPage = {
	Default = 1,
	Chapter13 = 2
}
CommandStationEnum.CameraFov = 21
CommandStationEnum.CameraRotation = -35
CommandStationEnum.CameraRotaionMax = -90
CommandStationEnum.TimelineOpenTime = 1
CommandStationEnum.TimelineCloseTime = 0.5
CommandStationEnum.TimeItemDelay = 0.03
CommandStationEnum.BuoyMoveTime = 0.5
CommandStationEnum.AllVersion = 1
CommandStationEnum.FirstTimeId = 100
CommandStationEnum.DispatchCharacterNum = 4
CommandStationEnum.TimeItemWidth = 88
CommandStationEnum.TimeItemSpace = 48
CommandStationEnum.ClickOffset = 30
CommandStationEnum.NoRelationShipChapterId = 111
CommandStationEnum.UnlockRelationShipChapterId = 112
CommandStationEnum.UnlockRelationShipChapterId2 = 113
CommandStationEnum.ConstId_CurVersion = 300
CommandStationEnum.ConstId_PaperItemId = 299
CommandStationEnum.Page2_ChainId = 200000
CommandStationEnum.MaxCampLocationIndex = 7
CommandStationEnum.ForceHideCommandStation = true

return CommandStationEnum
