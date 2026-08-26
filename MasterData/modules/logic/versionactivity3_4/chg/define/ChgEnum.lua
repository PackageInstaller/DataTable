-- chunkname: @modules/logic/versionactivity3_4/chg/define/ChgEnum.lua

module("modules.logic.versionactivity3_4.chg.define.ChgEnum", package.seeall)

local ChgEnum = _M
local kResPathRoot = "ui/viewres/versionactivity_3_4/v3a4_chg/"

ChgEnum.ResPath = {
	v3a4_chg_levelitem = kResPathRoot .. "v3a4_chg_levelitem.prefab",
	v3a4_chg_gameitem = kResPathRoot .. "v3a4_chg_gameitem.prefab"
}
ChgEnum.PuzzleMazeObjType = {
	End = 2,
	Obstacle = 3,
	CheckPoint = 4,
	Start = 1,
	None = 0
}
ChgEnum.PuzzleMazeEffectType = {
	Guide = 3,
	Story = 2,
	Dialog = 1,
	PopView = 4,
	V3a4_AddStartHp = 5
}
ChgEnum.PuzzleMazeObjSubType = {
	Two = 2,
	Default = 1,
	Three = 3
}
ChgEnum.dX = {
	0,
	1,
	0,
	-1
}
ChgEnum.dY = {
	1,
	0,
	-1,
	0
}
ChgEnum.Dir = UIGlobalDragHelper.Dir
ChgEnum.isVertical = UIGlobalDragHelper.isVertical
ChgEnum.isHorizontal = UIGlobalDragHelper.isHorizontal
ChgEnum.deltaV2ToDeltaDistance = UIGlobalDragHelper.deltaV2ToDeltaDistance
ChgEnum.deltaDistanceToDeltaV2 = UIGlobalDragHelper.deltaDistanceToDeltaV2
ChgEnum.flipDir = GaoSiNiaoEnum.flipDir
ChgEnum.bitPos2Dir = GaoSiNiaoEnum.bitPos2Dir

function ChgEnum.isParallelDir(lhsDir, rhsDir)
	if lhsDir == rhsDir then
		return true
	end

	return lhsDir == ChgEnum.flipDir(rhsDir)
end

function ChgEnum.isFlipDir(lhsDir, rhsDir)
	return lhsDir == ChgEnum.simpleFlipDir(rhsDir)
end

function ChgEnum.isSameFlipDir(lhsDir, rhsDir)
	local isSame = lhsDir == rhsDir
	local isFlip = ChgEnum.isFlipDir(lhsDir, rhsDir)

	return isSame, isFlip
end

function ChgEnum.simpleFlipDir(eDir)
	if not eDir then
		return ChgEnum.Dir.None
	end

	if eDir == ChgEnum.Dir.None then
		return eDir
	end

	if eDir == ChgEnum.Dir.Left then
		return ChgEnum.Dir.Right
	end

	if eDir == ChgEnum.Dir.Up then
		return ChgEnum.Dir.Down
	end

	if eDir == ChgEnum.Dir.Left then
		return ChgEnum.Dir.Right
	end

	if eDir == ChgEnum.Dir.Right then
		return ChgEnum.Dir.Left
	end

	if eDir == ChgEnum.Dir.Down then
		return ChgEnum.Dir.Up
	end

	if isDebugBuild then
		assert(false, "unexpected eDir=" .. tostring(eDir))
	end
end

ChgEnum.OperationType = {
	FailExit = "失败主动退出",
	FailReset = "失败主动重置",
	FinishRound = "完成地图",
	Exit = "中途主动放弃",
	Pass = "成功通关",
	Reset = "中途主动重置"
}

return ChgEnum
