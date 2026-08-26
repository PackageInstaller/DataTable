-- chunkname: @modules/logic/versionactivity3_5/lamona/define/LamonaEnum.lua

module("modules.logic.versionactivity3_5.lamona.define.LamonaEnum", package.seeall)

local LamonaEnum = _M

LamonaEnum.Direction = {
	Down = 2,
	Up = 1,
	Left = 3,
	Right = 4
}
LamonaEnum.Const = {
	FogPropId = 402,
	TrapPropId = 401,
	DefaultDirection = LamonaEnum.Direction.Down
}
LamonaEnum.ConstId = {
	GridSize = 1,
	MaxRound = 4,
	MaxRollbackNum = 5,
	GhostMoveTime = 3,
	TwoGhostPoint = 6,
	ThreeGhostPoint = 7,
	PlayerMoveTime = 2
}
LamonaEnum.GhostAnim = {
	Trap = "candle",
	Idle = "idle",
	Catch = "catch"
}
LamonaEnum.GhostEmoji = {
	Fog = "fog",
	Sweat = "sweat",
	Shocked = "shocked"
}
LamonaEnum.GhostEmojiAnim = {
	[LamonaEnum.GhostEmoji.Fog] = {
		Out = "out",
		In = "in"
	}
}
LamonaEnum.DirectionSuffix = {
	[LamonaEnum.Direction.Up] = "u",
	[LamonaEnum.Direction.Down] = "d",
	[LamonaEnum.Direction.Left] = "l",
	[LamonaEnum.Direction.Right] = "r"
}
LamonaEnum.DirOrderClock = {
	LamonaEnum.Direction.Up,
	LamonaEnum.Direction.Right,
	LamonaEnum.Direction.Down,
	LamonaEnum.Direction.Left
}
LamonaEnum.OppositeDir = {
	[LamonaEnum.Direction.Up] = LamonaEnum.Direction.Down,
	[LamonaEnum.Direction.Down] = LamonaEnum.Direction.Up,
	[LamonaEnum.Direction.Left] = LamonaEnum.Direction.Right,
	[LamonaEnum.Direction.Right] = LamonaEnum.Direction.Left
}
LamonaEnum.DirChangeGridX = {
	[LamonaEnum.Direction.Left] = -1,
	[LamonaEnum.Direction.Right] = 1
}
LamonaEnum.DirChangeGridY = {
	[LamonaEnum.Direction.Up] = 1,
	[LamonaEnum.Direction.Down] = -1
}
LamonaEnum.UnitType = {
	Ghost = 2,
	Player = 1,
	Obstacle = 3,
	Fog = 5,
	Prop = 4
}
LamonaEnum.UnitAttrKey = {
	EffectRange = "effectRange",
	ViewRange = "viewRange",
	Step = "step"
}

return LamonaEnum
