-- chunkname: @modules/logic/sp02/dungeonmap/define/AtomicDungeonEnum.lua

module("modules.logic.sp02.dungeonmap.define.AtomicDungeonEnum", package.seeall)

local AtomicDungeonEnum = _M

AtomicDungeonEnum.SceneRootName = "AtomicDungeonScene"
AtomicDungeonEnum.PolygonRoot = "polygon"
AtomicDungeonEnum.DungeonMapCameraSize = 5
AtomicDungeonEnum.CameraFocusTime = 0.75
AtomicDungeonEnum.FarClipPlane = 1000
AtomicDungeonEnum.NearClipPlane = 1
AtomicDungeonEnum.FieldOfView = 17.07151
AtomicDungeonEnum.RotateSpeed = 10
AtomicDungeonEnum.PolygonElementScale = 0.01
AtomicDungeonEnum.MaxDragMoveUp = 10
AtomicDungeonEnum.MaxDragMoveDown = 5
AtomicDungeonEnum.TalentChapterId = 385601
AtomicDungeonEnum.TalentChapterId2 = 9970
AtomicDungeonEnum.DelayRefrashMapTime = 0.1
AtomicDungeonEnum.AlarmBarWidth = 600
AtomicDungeonEnum.InteractDescMaxH = 550
AtomicDungeonEnum.InteractRewardH = 130
AtomicDungeonEnum.InteractOptionH = 130
AtomicDungeonEnum.PolygonElementTouchDistance = 0.98
AtomicDungeonEnum.HardFightType = 2
AtomicDungeonEnum.ShowPolygonElementNameValue = 0.3
AtomicDungeonEnum.SendEmergencyAddSecondTime = 5
AtomicDungeonEnum.PolygonNeedTwoKeyElementId = 101009
AtomicDungeonEnum.LocalPrefsKey = {
	CurFightMapId = "curFightMapId",
	PolygonKeyElementData = "polygonKeyElementMap",
	PolygonSelectUnlockIdList = "PolygonSelectUnlockIdList",
	PolygonSelectHard = "polygonSelectHard",
	PolygonSelectData = "PolygonSelectData"
}
AtomicDungeonEnum.MapType = {
	Polygon = 2,
	Normal = 1
}
AtomicDungeonEnum.ElementType = {
	Fight = 2,
	Dialog = 4,
	KeyDoor = 6,
	Option = 1,
	DataBase = 5,
	PolygonEnter = 7,
	Puzzle = 3
}
AtomicDungeonEnum.ElementStatus = {
	Finish = 1,
	Delete = -1,
	Normal = 0
}
AtomicDungeonEnum.ConditionType = {
	Explore = "explore",
	Finish = "finish",
	Empty = ""
}
AtomicDungeonEnum.ElementTypeRoot = {
	[AtomicDungeonEnum.ElementType.Option] = "option",
	[AtomicDungeonEnum.ElementType.Fight] = "fight",
	[AtomicDungeonEnum.ElementType.Puzzle] = "puzzle",
	[AtomicDungeonEnum.ElementType.Dialog] = "dialog",
	[AtomicDungeonEnum.ElementType.DataBase] = "dataBase",
	[AtomicDungeonEnum.ElementType.KeyDoor] = "keyDoor",
	[AtomicDungeonEnum.ElementType.PolygonEnter] = "polygonEnter"
}
AtomicDungeonEnum.PolygonElementTypeRoot = {
	[AtomicDungeonEnum.ElementType.Option] = "option",
	[AtomicDungeonEnum.ElementType.Fight] = "fight",
	[AtomicDungeonEnum.ElementType.Puzzle] = "puzzle",
	[AtomicDungeonEnum.ElementType.KeyDoor] = "keyDoor"
}
AtomicDungeonEnum.ElementAnimName = {
	Tips = "tips",
	Close = "close",
	Idle = "idle",
	Select = "select",
	Open = "open"
}
AtomicDungeonEnum.TipToastType = {
	AlarmChange = 2,
	EmergencyShow = 1,
	UnlockElement = 3,
	EmergencyExpired = 4
}
AtomicDungeonEnum.FightType = {
	Polygon = 2,
	PolygonBoss = 3,
	Normal = 1
}
AtomicDungeonEnum.JumpType = {
	Talent = 2,
	DungeonMap = 1
}
AtomicDungeonEnum.PolygonKeyDoorType = {
	Door = 0,
	Key = 1
}
AtomicDungeonEnum.PuzzleType = {
	Color = 2,
	Rhythm = 3,
	Line = 1
}
AtomicDungeonEnum.LineType = {
	Plus = 1,
	Minus = -1
}
AtomicDungeonEnum.ShootType = {
	ForwardDown = 4,
	Minus = 2,
	Plus = 1,
	ForwardUp = 3,
	Normal = 5
}
AtomicDungeonEnum.ColorType = {
	Type1 = 1,
	Type2 = 2,
	Type0 = 0
}
AtomicDungeonEnum.CircleType = {
	Inner = 2,
	Outer = 1
}
AtomicDungeonEnum.RhythmType = {
	Unlock = 1,
	Normal = 0
}
AtomicDungeonEnum.lockAnimTime = 0.47
AtomicDungeonEnum.OptionType = {
	Unlock = "解锁",
	Install = "安装",
	Reset = "重置",
	UnInstall = "卸下"
}

return AtomicDungeonEnum
