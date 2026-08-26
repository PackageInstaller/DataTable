-- chunkname: @modules/logic/versionactivity3_0/karong/model/KaRongDrawMO.lua

module("modules.logic.versionactivity3_0.karong.model.KaRongDrawMO", package.seeall)

local KaRongDrawMO = pureTable("KaRongDrawMO")

function KaRongDrawMO:initByPos(x, y, objType, subType, group, priority, iconUrl, effects, interactLines)
	self.key = PuzzleMazeHelper.getPosKey(x, y)
	self.x, self.y = x, y
	self.objType = objType
	self.subType = subType or 1
	self.group = group or 0
	self.priority = priority or 0
	self.iconUrl = iconUrl
	self.effects = effects
	self.interactLines = interactLines
	self.positionType = KaRongDrawEnum.PositionType.Point
	self.obstacle = objType == KaRongDrawEnum.MazeObjType.Block
end

function KaRongDrawMO:initByLine(x1, y1, x2, y2, objType, subType, group, priority, iconUrl)
	self.key = PuzzleMazeHelper.getLineKey(x1, y1, x2, y2)
	self.x1, self.y1, self.x2, self.y2 = x1, y1, x2, y2
	self.objType = objType
	self.subType = subType or 1
	self.group = group or 0
	self.priority = priority or 0
	self.iconUrl = iconUrl
	self.positionType = KaRongDrawEnum.PositionType.Line
end

function KaRongDrawMO:removeObstacle()
	if self.objType ~= KaRongDrawEnum.MazeObjType.Block then
		logError("该类型不可以使用removeObstacle方法" .. self.objType)

		return
	end

	self.obstacle = false
end

return KaRongDrawMO
