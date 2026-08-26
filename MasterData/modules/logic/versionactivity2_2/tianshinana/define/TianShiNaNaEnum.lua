-- chunkname: @modules/logic/versionactivity2_2/tianshinana/define/TianShiNaNaEnum.lua

module("modules.logic.versionactivity2_2.tianshinana.define.TianShiNaNaEnum", package.seeall)

local TianShiNaNaEnum = _M

TianShiNaNaEnum.Dir = {
	Down = -1,
	Up = 1,
	Right = -2,
	Forward = 3,
	Back = -3,
	Left = 2
}
TianShiNaNaEnum.OperDir = {
	Left = 1,
	Back = -2,
	Right = -1,
	Forward = 2
}
TianShiNaNaEnum.ResDirPath = {
	[TianShiNaNaEnum.OperDir.Left] = "size/dir_4",
	[TianShiNaNaEnum.OperDir.Right] = "size/dir_6",
	[TianShiNaNaEnum.OperDir.Forward] = "size/dir_8",
	[TianShiNaNaEnum.OperDir.Back] = "size/dir_2"
}
TianShiNaNaEnum.UnitType = {
	Born = 2,
	Obstacle = 5,
	Player = 1,
	NPC = 3,
	Destination = 6,
	Hunter = 4
}
TianShiNaNaEnum.TianShiNaNaDieReason = {
	Collapse = 1,
	NoCube = 2,
	CantPlace = 3,
	InFog = 5,
	BeHunter = 4
}
TianShiNaNaEnum.UnitTypeToName = {}

for name, index in pairs(TianShiNaNaEnum.UnitType) do
	TianShiNaNaEnum.UnitTypeToName[index] = name
end

TianShiNaNaEnum.NodeType = {
	Fog = 2,
	Swamp = 3,
	Normal = 1
}
TianShiNaNaEnum.GridXOffset = 1.0593750000000002
TianShiNaNaEnum.GridYOffset = 0.6900000000000001
TianShiNaNaEnum.GridZOffset = 0.005
TianShiNaNaEnum.OperDragBegin = 10
TianShiNaNaEnum.OperDragVaild = 0.45
TianShiNaNaEnum.OperDragMax = 100
TianShiNaNaEnum.EffectType = {
	Dialog = 4,
	Story = 1,
	Hide = 3,
	Guide = 2,
	Die = 6,
	Win = 5
}
TianShiNaNaEnum.CurState = {
	SelectDir = 1,
	DoStep = 3,
	Rotate = 2,
	None = 0
}
TianShiNaNaEnum.CubeType = {
	Type1 = 1,
	Type2 = 2
}
TianShiNaNaEnum.EpisodeType = {
	Hard = 3,
	Story = 1,
	Normal = 2
}
TianShiNaNaEnum.StepType = {
	Win = 6,
	Story = 4,
	Guide = 5,
	Die = 7,
	UpdateRound = 1,
	Hide = 3,
	Dialog = 9,
	DialogAndMove = 8,
	Move = 2
}
TianShiNaNaEnum.StepTypeToName = {}

for name, index in pairs(TianShiNaNaEnum.StepType) do
	TianShiNaNaEnum.StepTypeToName[index] = name
end

TianShiNaNaEnum.OperEffect = {
	[TianShiNaNaEnum.OperDir.Left] = {
		[TianShiNaNaEnum.Dir.Left] = TianShiNaNaEnum.Dir.Down,
		[TianShiNaNaEnum.Dir.Right] = TianShiNaNaEnum.Dir.Up,
		[TianShiNaNaEnum.Dir.Up] = TianShiNaNaEnum.Dir.Left,
		[TianShiNaNaEnum.Dir.Down] = TianShiNaNaEnum.Dir.Right
	},
	[TianShiNaNaEnum.OperDir.Right] = {
		[TianShiNaNaEnum.Dir.Left] = TianShiNaNaEnum.Dir.Up,
		[TianShiNaNaEnum.Dir.Right] = TianShiNaNaEnum.Dir.Down,
		[TianShiNaNaEnum.Dir.Up] = TianShiNaNaEnum.Dir.Right,
		[TianShiNaNaEnum.Dir.Down] = TianShiNaNaEnum.Dir.Left
	},
	[TianShiNaNaEnum.OperDir.Forward] = {
		[TianShiNaNaEnum.Dir.Forward] = TianShiNaNaEnum.Dir.Down,
		[TianShiNaNaEnum.Dir.Back] = TianShiNaNaEnum.Dir.Up,
		[TianShiNaNaEnum.Dir.Up] = TianShiNaNaEnum.Dir.Forward,
		[TianShiNaNaEnum.Dir.Down] = TianShiNaNaEnum.Dir.Back
	},
	[TianShiNaNaEnum.OperDir.Back] = {
		[TianShiNaNaEnum.Dir.Forward] = TianShiNaNaEnum.Dir.Up,
		[TianShiNaNaEnum.Dir.Back] = TianShiNaNaEnum.Dir.Down,
		[TianShiNaNaEnum.Dir.Up] = TianShiNaNaEnum.Dir.Back,
		[TianShiNaNaEnum.Dir.Down] = TianShiNaNaEnum.Dir.Forward
	}
}
TianShiNaNaEnum.DirToQuaternion = {
	[TianShiNaNaEnum.Dir.Up] = {
		[TianShiNaNaEnum.Dir.Back] = Quaternion.Euler(0, 0, 0),
		[TianShiNaNaEnum.Dir.Left] = Quaternion.Euler(0, 90, 0),
		[TianShiNaNaEnum.Dir.Right] = Quaternion.Euler(0, -90, 0),
		[TianShiNaNaEnum.Dir.Forward] = Quaternion.Euler(0, 180, 0)
	},
	[TianShiNaNaEnum.Dir.Down] = {
		[TianShiNaNaEnum.Dir.Back] = Quaternion.Euler(-180, 180, 0),
		[TianShiNaNaEnum.Dir.Left] = Quaternion.Euler(-180, -90, 0),
		[TianShiNaNaEnum.Dir.Right] = Quaternion.Euler(-180, 90, 0),
		[TianShiNaNaEnum.Dir.Forward] = Quaternion.Euler(-180, 0, 0)
	},
	[TianShiNaNaEnum.Dir.Left] = {
		[TianShiNaNaEnum.Dir.Back] = Quaternion.Euler(0, 0, 90),
		[TianShiNaNaEnum.Dir.Up] = Quaternion.Euler(90, 0, 90),
		[TianShiNaNaEnum.Dir.Down] = Quaternion.Euler(270, 0, 90),
		[TianShiNaNaEnum.Dir.Forward] = Quaternion.Euler(180, 0, 90)
	},
	[TianShiNaNaEnum.Dir.Right] = {
		[TianShiNaNaEnum.Dir.Back] = Quaternion.Euler(0, 0, -90),
		[TianShiNaNaEnum.Dir.Up] = Quaternion.Euler(90, 0, -90),
		[TianShiNaNaEnum.Dir.Down] = Quaternion.Euler(270, 0, -90),
		[TianShiNaNaEnum.Dir.Forward] = Quaternion.Euler(180, 0, -90)
	},
	[TianShiNaNaEnum.Dir.Forward] = {
		[TianShiNaNaEnum.Dir.Up] = Quaternion.Euler(90, 90, 90),
		[TianShiNaNaEnum.Dir.Left] = Quaternion.Euler(0, 90, 90),
		[TianShiNaNaEnum.Dir.Right] = Quaternion.Euler(180, 90, 90),
		[TianShiNaNaEnum.Dir.Down] = Quaternion.Euler(-90, 90, 90)
	},
	[TianShiNaNaEnum.Dir.Back] = {
		[TianShiNaNaEnum.Dir.Up] = Quaternion.Euler(-270, -90, 90),
		[TianShiNaNaEnum.Dir.Left] = Quaternion.Euler(-180, -90, 90),
		[TianShiNaNaEnum.Dir.Right] = Quaternion.Euler(0, -90, 90),
		[TianShiNaNaEnum.Dir.Down] = Quaternion.Euler(-90, -90, 90)
	}
}

return TianShiNaNaEnum
