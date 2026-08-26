-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/model/PuzzleMazeDrawMO.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.model.PuzzleMazeDrawMO", package.seeall)

local PuzzleMazeDrawMO = pureTable("PuzzleMazeDrawMO")

function PuzzleMazeDrawMO:initByPos(x, y, objType, subType, group, priority, iconUrl, effects, interactLines)
	self.x, self.y = x, y
	self.objType = objType
	self.subType = subType or 0
	self.group = group or 0
	self.priority = priority or 0
	self.iconUrl = iconUrl
	self.effects = effects
	self.interactLines = interactLines
	self.positionType = PuzzleEnum.PositionType.Point
end

function PuzzleMazeDrawMO:initByLine(x1, y1, x2, y2, objType, subType, group, priority, iconUrl)
	self.x1, self.y1, self.x2, self.y2 = x1, y1, x2, y2
	self.objType = objType
	self.subType = subType or 0
	self.group = group or 0
	self.priority = priority or 0
	self.iconUrl = iconUrl
	self.positionType = PuzzleEnum.PositionType.Line
end

function PuzzleMazeDrawMO:getKey()
	return self.positionType == PuzzleEnum.PositionType.Point and PuzzleMazeHelper.getPosKey(self.x, self.y) or PuzzleMazeHelper.getLineKey(self.x1, self.y1, self.x2, self.y2)
end

return PuzzleMazeDrawMO
