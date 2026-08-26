-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/define/GaoSiNiaoEnum.lua

module("modules.logic.versionactivity3_1.gaosiniao.define.GaoSiNiaoEnum", package.seeall)

local GaoSiNiaoEnum = _M
local _B = Bitwise

GaoSiNiaoEnum.Version = {
	V1_0_0 = "1_0_0"
}

local kResPathRoot = "ui/viewres/versionactivity_3_1/v3a1_gaosiniao/"

GaoSiNiaoEnum.ResPath = {
	v3a1_gaosiniao_levelviewstageitem = kResPathRoot .. "v3a1_gaosiniao_levelviewstageitem.prefab"
}
GaoSiNiaoEnum.EpisodeType = {
	SP = 1,
	Normal = 0
}
GaoSiNiaoEnum.dX = {
	0,
	1,
	0,
	-1
}
GaoSiNiaoEnum.dY = {
	-1,
	0,
	1,
	0
}

local _ZM = {
	None = 0,
	North = _B["<<"](1, 0),
	East = _B["<<"](1, 1),
	South = _B["<<"](1, 2),
	West = _B["<<"](1, 3)
}

_ZM.NE = _B["|"](_ZM.North, _ZM.East)
_ZM.NW = _B["|"](_ZM.North, _ZM.West)
_ZM.SE = _B["|"](_ZM.South, _ZM.East)
_ZM.SW = _B["|"](_ZM.South, _ZM.West)
_ZM.NS = _B["|"](_ZM.North, _ZM.South)
_ZM.EW = _B["|"](_ZM.East, _ZM.West)
_ZM.NEW = _B["|"](_ZM.NE, _ZM.West)
_ZM.NSW = _B["|"](_ZM.NS, _ZM.West)
_ZM.SEW = _B["|"](_ZM.SE, _ZM.West)
_ZM.NSE = _B["|"](_ZM.NS, _ZM.East)
_ZM.All = _B["|"](_ZM.NS, _ZM.EW)
GaoSiNiaoEnum.ZoneMask = _ZM

function GaoSiNiaoEnum.dirToStr(eZoneMask)
	for eName, eValue in pairs(_ZM) do
		if eZoneMask == eValue then
			return eName
		end
	end

	return "Unknown"
end

local k0xF = 15

function GaoSiNiaoEnum.flipDir(eZoneMask)
	local n = _B["&"](eZoneMask, _ZM.North)
	local e = _B["&"](eZoneMask, _ZM.East)
	local s = _B["&"](eZoneMask, _ZM.South)
	local w = _B["&"](eZoneMask, _ZM.West)
	local nsSwap = _B["|"](_B["<<"](n, 2), _B[">>"](s, 2))
	local ewSwap = _B["|"](_B["<<"](e, 2), _B[">>"](w, 2))
	local swapped = _B["|"](nsSwap, ewSwap)
	local tmp = _B["&"](eZoneMask, _B["~"](_ZM.All))

	tmp = _B["|"](tmp, swapped)

	return _B["&"](tmp, k0xF)
end

function GaoSiNiaoEnum.bitPos2Dir(bitPos)
	assert(bitPos >= 0 and bitPos <= 3)

	return _B["<<"](1, bitPos)
end

GaoSiNiaoEnum.GridType = {
	Path = 5,
	End = 3,
	__End = 6,
	Wall = 1,
	Portal = 2,
	Start = 4,
	Empty = 0
}

local _PSI = {
	Exit2_Straight = 2,
	Exit3 = 3,
	Exit4 = 4,
	Exit2_Angle = 1,
	__End = 5,
	None = 0
}

GaoSiNiaoEnum.PathSpriteId = _PSI

local _PT = {
	RTB = 8,
	LT = 1,
	TB = 5,
	LR = 6,
	RT = 3,
	RB = 4,
	LRB = 9,
	LB = 2,
	LRT = 10,
	LRTB = 11,
	__End = 12,
	LTB = 7,
	None = 0
}

GaoSiNiaoEnum.PathType = _PT

local _PI = {
	[_PT.None] = {
		zRot = 0,
		outZM = _ZM.None,
		spriteId = _PSI.None
	},
	[_PT.LT] = {
		zRot = -90,
		outZM = _ZM.NW,
		spriteId = _PSI.Exit2_Angle
	},
	[_PT.RT] = {
		zRot = 180,
		outZM = _ZM.NE,
		spriteId = _PSI.Exit2_Angle
	},
	[_PT.LB] = {
		zRot = 0,
		outZM = _ZM.SW,
		spriteId = _PSI.Exit2_Angle
	},
	[_PT.RB] = {
		zRot = 90,
		outZM = _ZM.SE,
		spriteId = _PSI.Exit2_Angle
	},
	[_PT.TB] = {
		zRot = 0,
		outZM = _ZM.NS,
		spriteId = _PSI.Exit2_Straight
	},
	[_PT.LR] = {
		zRot = 90,
		outZM = _ZM.EW,
		spriteId = _PSI.Exit2_Straight
	}
}

_PI[_PT.LTB] = {
	zRot = -90,
	outZM = _ZM.NSW,
	spriteId = _PSI.Exit3
}
_PI[_PT.RTB] = {
	zRot = 90,
	outZM = _ZM.NSE,
	spriteId = _PSI.Exit3
}
_PI[_PT.LRB] = {
	zRot = 0,
	outZM = _ZM.SEW,
	spriteId = _PSI.Exit3
}
_PI[_PT.LRT] = {
	zRot = 180,
	outZM = _ZM.NEW,
	spriteId = _PSI.Exit3
}
_PI[_PT.LRTB] = {
	zRot = 0,
	outZM = _ZM.All,
	spriteId = _PSI.Exit4
}

for _, v in pairs(_PI) do
	v.inZM = GaoSiNiaoEnum.flipDir(v.outZM)
end

GaoSiNiaoEnum.PathInfo = _PI
GaoSiNiaoEnum.operation_type = {
	finish = "finish",
	Unknown = "",
	reset = "reset",
	exit = "exit"
}

function GaoSiNiaoEnum.unitTest()
	local f = GaoSiNiaoEnum.flipDir

	assert(GaoSiNiaoEnum.flipDir(_ZM.None) == _ZM.None)
	assert(GaoSiNiaoEnum.flipDir(_ZM.North) == _ZM.South)
	assert(GaoSiNiaoEnum.flipDir(_ZM.NE) == _ZM.SW)
	assert(GaoSiNiaoEnum.flipDir(_ZM.EW) == _ZM.EW)
	assert(f(_B["|"](_ZM.NE, _ZM.South)) == _B["|"](_ZM.SW, _ZM.North))
end

return GaoSiNiaoEnum
