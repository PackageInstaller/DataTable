-- chunkname: @modules/logic/versionactivity3_7/wmz/define/WmzEnum.lua

module("modules.logic.versionactivity3_7.wmz.define.WmzEnum", package.seeall)

local WmzEnum = _M
local _B = Bitwise
local kResPathRoot = "ui/viewres/versionactivity_3_7/v3a7_wmz/"

WmzEnum.ResPath = {
	v3a7_wmz_levelitem = kResPathRoot .. "v3a7_wmz_levelitem.prefab",
	v3a7_wmz_taskitem = kResPathRoot .. "v3a7_wmz_taskitem.prefab"
}
WmzEnum.dX = GaoSiNiaoEnum.dX
WmzEnum.dY = GaoSiNiaoEnum.dY
WmzEnum.dirToStr = GaoSiNiaoEnum.dirToStr
WmzEnum.flipDir = GaoSiNiaoEnum.flipDir
WmzEnum.bitPos2Dir = GaoSiNiaoEnum.bitPos2Dir
WmzEnum.Dir = {
	Down = 3,
	Up = 1,
	Right = 2,
	__Start = 0,
	__End = 5,
	Left = 4
}
WmzEnum.Corner = {
	LT = 5,
	__Start = 4,
	RT = 6,
	RB = 8,
	__End = 9,
	LB = 7
}
WmzEnum.DirV2 = {}

for eDir = 1, 4 do
	local dx = WmzEnum.dX[eDir]
	local dy = WmzEnum.dY[eDir]

	WmzEnum.DirV2[eDir] = Vector2.New(dx, dy)
end

WmzEnum.diagX = {
	-1,
	1,
	-1,
	1
}
WmzEnum.diagY = {
	-1,
	-1,
	1,
	1
}

for i = 1, 4 do
	local eCorner = WmzEnum.Corner.__Start + i
	local dx = WmzEnum.diagX[i]
	local dy = WmzEnum.diagY[i]

	WmzEnum.DirV2[eCorner] = Vector2.New(dx, dy)
end

WmzEnum.ConvexZRot = {
	[WmzEnum.Corner.LT] = 180,
	[WmzEnum.Corner.RT] = 180,
	[WmzEnum.Corner.LB] = 180,
	[WmzEnum.Corner.RB] = 180
}
WmzEnum.ConcaveZRot = {
	[WmzEnum.Corner.LT] = 90,
	[WmzEnum.Corner.RT] = -90,
	[WmzEnum.Corner.LB] = -90,
	[WmzEnum.Corner.RB] = 90
}

local _ZM = GaoSiNiaoEnum.ZoneMask

WmzEnum.ZoneMask = _ZM
WmzEnum.dydxToMask = {
	[-1] = {
		[0] = _ZM.North
	},
	{
		[0] = _ZM.South
	},
	[0] = {
		[-1] = _ZM.West,
		_ZM.East
	}
}
WmzEnum.FloorType = {
	Passable = 0,
	PassableEmpty = 4,
	Void = 2,
	Wall = 1,
	_edit_MoveableEmpty = 3
}

local _PSI = {
	Exit2_Straight = 1,
	Exit3 = 3,
	Exit4 = 4,
	Exit2_Angle = 2,
	__End = 5,
	None = 0
}

WmzEnum.PathSpriteId = _PSI

local _PT = {
	MoveableNone = -1,
	LRB = 13,
	TB = 9,
	RT = 7,
	RB = 8,
	LRT = 14,
	None = 0,
	LB = 6,
	LRTB = 15,
	__End = 16,
	RTB = 12,
	LT = 5,
	LR = 10,
	T = 2,
	L = 1,
	R = 3,
	LTB = 11,
	B = 4
}

WmzEnum.PathType = _PT

local _PI = {
	[_PT.None] = {
		zRot = 0,
		outZM = _ZM.None,
		spriteId = _PSI.None
	},
	[_PT.LT] = {
		zRot = 90,
		outZM = _ZM.NW,
		spriteId = _PSI.Exit2_Angle
	},
	[_PT.RT] = {
		zRot = 0,
		outZM = _ZM.NE,
		spriteId = _PSI.Exit2_Angle
	},
	[_PT.LB] = {
		zRot = 180,
		outZM = _ZM.SW,
		spriteId = _PSI.Exit2_Angle
	},
	[_PT.RB] = {
		zRot = -90,
		outZM = _ZM.SE,
		spriteId = _PSI.Exit2_Angle
	},
	[_PT.TB] = {
		zRot = 90,
		outZM = _ZM.NS,
		spriteId = _PSI.Exit2_Straight
	},
	[_PT.LR] = {
		zRot = 0,
		outZM = _ZM.EW,
		spriteId = _PSI.Exit2_Straight
	},
	[_PT.L] = {
		zRot = 180,
		outZM = _ZM.West
	},
	[_PT.T] = {
		zRot = 90,
		outZM = _ZM.North
	},
	[_PT.R] = {
		zRot = 0,
		outZM = _ZM.East
	},
	[_PT.B] = {
		zRot = -90,
		outZM = _ZM.South
	}
}

_PI[_PT.LTB] = {
	zRot = 180,
	outZM = _ZM.NSW,
	spriteId = _PSI.Exit3
}
_PI[_PT.RTB] = {
	zRot = 0,
	outZM = _ZM.NSE,
	spriteId = _PSI.Exit3
}
_PI[_PT.LRB] = {
	zRot = -90,
	outZM = _ZM.SEW,
	spriteId = _PSI.Exit3
}
_PI[_PT.LRT] = {
	zRot = 90,
	outZM = _ZM.NEW,
	spriteId = _PSI.Exit3
}
_PI[_PT.LRTB] = {
	zRot = 0,
	outZM = _ZM.All,
	spriteId = _PSI.Exit4
}
_PI[_PT.__End] = _PI[_PT.None]
_PI[_PT.MoveableNone] = _PI[_PT.None]

for _, v in pairs(_PI) do
	v.inZM = WmzEnum.flipDir(v.outZM)
end

WmzEnum.PathInfo = _PI

function WmzEnum.unitTest()
	local f = WmzEnum.flipDir

	assert(WmzEnum.flipDir(_ZM.None) == _ZM.None)
	assert(WmzEnum.flipDir(_ZM.NE) == _ZM.SW)
	assert(WmzEnum.flipDir(_ZM.EW) == _ZM.EW)
	assert(WmzEnum.flipDir(_ZM.West) == _ZM.East)
	assert(WmzEnum.flipDir(_ZM.North) == _ZM.South)
	assert(WmzEnum.flipDir(_ZM.East) == _ZM.West)
	assert(WmzEnum.flipDir(_ZM.South) == _ZM.North)
	assert(f(_B["|"](_ZM.NE, _ZM.South)) == _B["|"](_ZM.SW, _ZM.North))
end

WmzEnum.OperationType = {
	FailReset = "失败主动重置",
	Reset = "中途主动重置",
	FailExit = "失败主动退出",
	Exit = "中途主动放弃",
	Pass = "成功通关地图"
}

return WmzEnum
