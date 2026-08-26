-- chunkname: @modules/logic/versionactivity3_4/chg/model/ChgMapObj_Vertex.lua

module("modules.logic.versionactivity3_4.chg.model.ChgMapObj_Vertex", package.seeall)

local ChgMapObj_Vertex = class("ChgMapObj_Vertex", ChgMapObjBase)
local kDir = ChgMapObjBase.kDir

function ChgMapObj_Vertex:ctor(mapMO, PuzzleMazeObjInfo)
	ChgMapObj_Vertex.super.ctor(self, mapMO, PuzzleMazeObjInfo)

	local posList = string.splitToNumber(self:key(), "_")

	self._x = posList[1]
	self._y = posList[2]
end

function ChgMapObj_Vertex:x()
	return self._x
end

function ChgMapObj_Vertex:y()
	return self._y
end

function ChgMapObj_Vertex:objIsPoint()
	return true
end

function ChgMapObj_Vertex:objIsLine()
	return false
end

function ChgMapObj_Vertex:keyOfUp()
	local x1 = self:x()
	local y1 = self:y()
	local x2 = x1 + ChgEnum.dX[kDir.Up]
	local y2 = y1 + ChgEnum.dY[kDir.Up]

	return PuzzleMazeHelper.getLineKey(x1, y1, x2, y2), x1, y1, x2, y2
end

function ChgMapObj_Vertex:keyOfRight()
	local x1 = self:x()
	local y1 = self:y()
	local x2 = x1 + ChgEnum.dX[kDir.Right]
	local y2 = y1 + ChgEnum.dY[kDir.Right]

	return PuzzleMazeHelper.getLineKey(x1, y1, x2, y2), x1, y1, x2, y2
end

function ChgMapObj_Vertex:keyOfDown()
	local x1 = self:x()
	local y1 = self:y()
	local x2 = x1 + ChgEnum.dX[kDir.Down]
	local y2 = y1 + ChgEnum.dY[kDir.Down]

	return PuzzleMazeHelper.getLineKey(x1, y1, x2, y2), x1, y1, x2, y2
end

function ChgMapObj_Vertex:keyOfLeft()
	local x1 = self:x()
	local y1 = self:y()
	local x2 = x1 + ChgEnum.dX[kDir.Left]
	local y2 = y1 + ChgEnum.dY[kDir.Left]

	return PuzzleMazeHelper.getLineKey(x1, y1, x2, y2), x1, y1, x2, y2
end

function ChgMapObj_Vertex:stepOfUp(step)
	step = step or 1

	local newX = self:x() + ChgEnum.dX[kDir.Up] * step
	local newY = self:y() + ChgEnum.dY[kDir.Up] * step

	return PuzzleMazeHelper.getPosKey(newX, newY), newX, newY
end

function ChgMapObj_Vertex:stepOfDown(step)
	step = step or 1

	local newX = self:x() + ChgEnum.dX[kDir.Down] * step
	local newY = self:y() + ChgEnum.dY[kDir.Down] * step

	return PuzzleMazeHelper.getPosKey(newX, newY), newX, newY
end

function ChgMapObj_Vertex:stepOfLeft(step)
	step = step or 1

	local newX = self:x() + ChgEnum.dX[kDir.Left] * step
	local newY = self:y() + ChgEnum.dY[kDir.Left] * step

	return PuzzleMazeHelper.getPosKey(newX, newY), newX, newY
end

function ChgMapObj_Vertex:stepOfRight(step)
	step = step or 1

	local newX = self:x() + ChgEnum.dX[kDir.Right] * step
	local newY = self:y() + ChgEnum.dY[kDir.Right] * step

	return PuzzleMazeHelper.getPosKey(newX, newY), newX, newY
end

return ChgMapObj_Vertex
