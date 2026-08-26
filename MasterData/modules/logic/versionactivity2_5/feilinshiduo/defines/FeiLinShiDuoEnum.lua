-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/defines/FeiLinShiDuoEnum.lua

module("modules.logic.versionactivity2_5.feilinshiduo.defines.FeiLinShiDuoEnum", package.seeall)

local FeiLinShiDuoEnum = _M

FeiLinShiDuoEnum.TestMapId = 101
FeiLinShiDuoEnum.GameSceneRootName = "FeiLinShiDuoGame"
FeiLinShiDuoEnum.ColorIconName = "colorIcon"
FeiLinShiDuoEnum.PlayerMoveSpeed = 250
FeiLinShiDuoEnum.PlayerPushBoxSpeed = 125
FeiLinShiDuoEnum.SceneMoveSpeed = 0.2
FeiLinShiDuoEnum.FallSpeed = 50
FeiLinShiDuoEnum.jumpAnimTime = 0.4
FeiLinShiDuoEnum.climbSpeed = 150
FeiLinShiDuoEnum.MinTimeDeltaTime = 0.04
FeiLinShiDuoEnum.SceneDefaultScale = 2
FeiLinShiDuoEnum.SlotWidth = 100
FeiLinShiDuoEnum.HalfSlotWidth = FeiLinShiDuoEnum.SlotWidth / 2
FeiLinShiDuoEnum.RoleResPath = "roles/v2a5_act185/act185_ui.prefab"
FeiLinShiDuoEnum.PlayerScale = 0.3
FeiLinShiDuoEnum.startMoveAddSpeed = 0.5
FeiLinShiDuoEnum.endMoveAddSpeed = 1
FeiLinShiDuoEnum.touchCheckRange = 4
FeiLinShiDuoEnum.touchElementRange = 20
FeiLinShiDuoEnum.doorTouchCheckRang = 15
FeiLinShiDuoEnum.stairsTouchCheckRange = 40
FeiLinShiDuoEnum.BlindnessModeKey = "FeiLinShiDuoBlindnessMode"
FeiLinShiDuoEnum.checkDir = {
	Top = 2,
	Right = 3,
	Left = 1,
	Bottom = 4
}
FeiLinShiDuoEnum.ObjectType = {
	Option = 6,
	ColorPlane = 2,
	Door = 7,
	Target = 10,
	Wall = 1,
	Trap = 4,
	Start = 9,
	Box = 3,
	Jump = 5,
	Stairs = 8
}
FeiLinShiDuoEnum.ColorType = {
	Blue = 3,
	Green = 2,
	Red = 1,
	Yellow = 4,
	None = 0
}
FeiLinShiDuoEnum.ColorStr = {
	[FeiLinShiDuoEnum.ColorType.None] = "#808080",
	[FeiLinShiDuoEnum.ColorType.Red] = "#995558",
	[FeiLinShiDuoEnum.ColorType.Green] = "#648E83",
	[FeiLinShiDuoEnum.ColorType.Blue] = "#5D6D97",
	[FeiLinShiDuoEnum.ColorType.Yellow] = "#8E8C64"
}
FeiLinShiDuoEnum.playerColor = UnityEngine.Shader.PropertyToID("_Color")
FeiLinShiDuoEnum.GroupName = {
	[FeiLinShiDuoEnum.ObjectType.Wall] = "Walls",
	[FeiLinShiDuoEnum.ObjectType.ColorPlane] = "ColorPlanes",
	[FeiLinShiDuoEnum.ObjectType.Box] = "Boxs",
	[FeiLinShiDuoEnum.ObjectType.Trap] = "Traps",
	[FeiLinShiDuoEnum.ObjectType.Jump] = "Jumps",
	[FeiLinShiDuoEnum.ObjectType.Option] = "Options",
	[FeiLinShiDuoEnum.ObjectType.Door] = "Doors",
	[FeiLinShiDuoEnum.ObjectType.Stairs] = "Stairs",
	[FeiLinShiDuoEnum.ObjectType.Start] = "Start",
	[FeiLinShiDuoEnum.ObjectType.Target] = "Target"
}
FeiLinShiDuoEnum.ParentName = {
	[FeiLinShiDuoEnum.ObjectType.Wall] = "wallItem",
	[FeiLinShiDuoEnum.ObjectType.ColorPlane] = "colorplaneItem",
	[FeiLinShiDuoEnum.ObjectType.Box] = "boxItem",
	[FeiLinShiDuoEnum.ObjectType.Trap] = "trapItem",
	[FeiLinShiDuoEnum.ObjectType.Jump] = "jumpItem",
	[FeiLinShiDuoEnum.ObjectType.Option] = "optionItem",
	[FeiLinShiDuoEnum.ObjectType.Door] = "doorItem",
	[FeiLinShiDuoEnum.ObjectType.Stairs] = "stairItem",
	[FeiLinShiDuoEnum.ObjectType.Start] = "startItem",
	[FeiLinShiDuoEnum.ObjectType.Target] = "targetItem"
}
FeiLinShiDuoEnum.ItemName = {
	[FeiLinShiDuoEnum.ObjectType.Wall] = "wall",
	[FeiLinShiDuoEnum.ObjectType.ColorPlane] = "colorplane",
	[FeiLinShiDuoEnum.ObjectType.Box] = "box",
	[FeiLinShiDuoEnum.ObjectType.Trap] = "trap",
	[FeiLinShiDuoEnum.ObjectType.Jump] = "jump",
	[FeiLinShiDuoEnum.ObjectType.Option] = "option",
	[FeiLinShiDuoEnum.ObjectType.Door] = "door",
	[FeiLinShiDuoEnum.ObjectType.Stairs] = "stair",
	[FeiLinShiDuoEnum.ObjectType.Start] = "start",
	[FeiLinShiDuoEnum.ObjectType.Target] = "target"
}
FeiLinShiDuoEnum.GuideDataList = {
	{
		mapId = 101,
		guideId = 25101,
		guideList = {
			{
				rangeX = 20,
				id = 1,
				posY = 200,
				rangeY = 10,
				posX = -253
			},
			{
				rangeX = 100,
				id = 2,
				posY = -400,
				rangeY = 10,
				posX = -200
			},
			{
				rangeX = 90,
				id = 3,
				posY = -400,
				rangeY = 10,
				posX = 612
			}
		}
	},
	{
		mapId = 103,
		guideId = 25102,
		guideList = {
			{
				rangeX = 150,
				id = 4,
				posY = -500,
				rangeY = 10,
				posX = -380
			}
		}
	},
	{
		mapId = 105,
		guideId = 25103,
		guideList = {
			{
				rangeX = 100,
				id = 5,
				posY = -500,
				rangeY = 10,
				posX = 530
			}
		}
	}
}

return FeiLinShiDuoEnum
