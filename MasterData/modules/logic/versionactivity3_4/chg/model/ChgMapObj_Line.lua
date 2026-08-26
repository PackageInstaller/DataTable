-- chunkname: @modules/logic/versionactivity3_4/chg/model/ChgMapObj_Line.lua

module("modules.logic.versionactivity3_4.chg.model.ChgMapObj_Line", package.seeall)

local ChgMapObj_Line = class("ChgMapObj_Line", ChgMapObjBase)
local kDir = ChgMapObjBase.kDir

function ChgMapObj_Line:ctor(mapMO, PuzzleMazeObjInfo)
	ChgMapObj_Line.super.ctor(self, mapMO, PuzzleMazeObjInfo)

	local posList = string.splitToNumber(self:key(), "_")

	self._x1 = posList[1]
	self._y1 = posList[2]
	self._x2 = posList[3]
	self._y2 = posList[4]
end

function ChgMapObj_Line:x1()
	return self._x1
end

function ChgMapObj_Line:y1()
	return self._y1
end

function ChgMapObj_Line:x2()
	return self._x2
end

function ChgMapObj_Line:y2()
	return self._y2
end

function ChgMapObj_Line:center()
	local cx = (self:x1() + self:x2()) * 0.5
	local cy = (self:y1() + self:y2()) * 0.5

	return cx, cy
end

function ChgMapObj_Line:objIsPoint()
	return false
end

function ChgMapObj_Line:objIsLine()
	return true
end

function ChgMapObj_Line:isH()
	return self:y1() == self:y2()
end

function ChgMapObj_Line:isV()
	return self:x1() == self:x2()
end

function ChgMapObj_Line:keyOfUp()
	return self:isV() and PuzzleMazeHelper.getPosKey(self:x2(), self:y2()) or ""
end

function ChgMapObj_Line:keyOfDown()
	return self:isV() and PuzzleMazeHelper.getPosKey(self:x1(), self:y1()) or ""
end

function ChgMapObj_Line:keyOfLeft()
	return self:isH() and PuzzleMazeHelper.getPosKey(self:x1(), self:y1()) or ""
end

function ChgMapObj_Line:keyOfRight()
	return self:isH() and PuzzleMazeHelper.getPosKey(self:x2(), self:y2()) or ""
end

function ChgMapObj_Line:stepOfUp(step)
	step = step or 1

	local dx = ChgEnum.dX[kDir.Up]
	local dy = ChgEnum.dY[kDir.Up]
	local x1 = self:x1() + dx * step
	local y1 = self:y1() + dy * step
	local x2 = self:x2() + dx * step
	local y2 = self:y2() + dy * step

	return PuzzleMazeHelper.getLineKey(x1, y1, x2, y2)
end

function ChgMapObj_Line:stepOfDown(step)
	step = step or 1

	local dx = ChgEnum.dX[kDir.Down]
	local dy = ChgEnum.dY[kDir.Down]
	local x1 = self:x1() + dx * step
	local y1 = self:y1() + dy * step
	local x2 = self:x2() + dx * step
	local y2 = self:y2() + dy * step

	return PuzzleMazeHelper.getLineKey(x1, y1, x2, y2)
end

function ChgMapObj_Line:stepOfLeft(step)
	step = step or 1

	local dx = ChgEnum.dX[kDir.Left]
	local dy = ChgEnum.dY[kDir.Left]
	local x1 = self:x1() + dx * step
	local y1 = self:y1() + dy * step
	local x2 = self:x2() + dx * step
	local y2 = self:y2() + dy * step

	return PuzzleMazeHelper.getLineKey(x1, y1, x2, y2)
end

function ChgMapObj_Line:stepOfRight(step)
	step = step or 1

	local dx = ChgEnum.dX[kDir.Right]
	local dy = ChgEnum.dY[kDir.Right]
	local x1 = self:x1() + dx * step
	local y1 = self:y1() + dy * step
	local x2 = self:x2() + dx * step
	local y2 = self:y2() + dy * step

	return PuzzleMazeHelper.getLineKey(x1, y1, x2, y2)
end

return ChgMapObj_Line
