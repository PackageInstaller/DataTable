-- chunkname: @modules/logic/versionactivity4_0/concertlimit/define/MusicGameEnum.lua

module("modules.logic.versionactivity4_0.concertlimit.define.MusicGameEnum", package.seeall)

local MusicGameEnum = _M

MusicGameEnum.BlockNoteType = {
	Sol = 5,
	Doi = 8,
	Ti = 7,
	Mi = 3,
	La = 6,
	Re = 2,
	Fa = 4,
	Do = 1,
	None = 0
}
MusicGameEnum.MusicNoteCount = 8
MusicGameEnum.BlockType = {
	NoDisturb = 3,
	Branch = 4,
	Main = 5,
	Random = 1,
	Disturb = 2
}
MusicGameEnum.Direction = {
	Down = 3,
	Up = 1,
	Right = 2,
	Left = 4
}
MusicGameEnum.ConstId = {
	DisturbLength = 8,
	ComboScore = 11,
	MainPathLength = 4,
	BaseScore = 10,
	MaxFillNote1Count = 2,
	MaxSameDirCount = 13,
	MaxStraightLength = 5,
	MapSize = 9,
	BranchLength = 7,
	MaxFillNoteICount = 3,
	FinishTipLength = 12,
	BranchStartPoint = 6
}
MusicGameEnum.ResultType = {
	Sing = 1,
	Score = 2
}
MusicGameEnum.GuideId = 40014

return MusicGameEnum
