-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/game/JumpFloorCellData.lua

module("logic.extensions.jumpfloor.view.game.JumpFloorCellData", package.seeall)

local JumpFloorCellData = class("JumpFloorCellData")

JumpFloorCellData.ECellType = {
	Shield = 3,
	Normal = 1,
	SkipCell = 4,
	Trap = 2,
	Empty = 0
}

function JumpFloorCellData:ctor(col, row, index, cellType, skipCellStep)
	self.col = col
	self.row = row
	self.index = index > 0 and index or col * (col - 1) / 2 + row
	self.cellType = cellType
	self.skipCellStep = skipCellStep
	self.isDestination = false
	self._isBuffAvailable = true
end

function JumpFloorCellData:setColAndRow(col, row)
	self.col = col
	self.row = row
	self.index = col * (col - 1) / 2 + row
end

function JumpFloorCellData:setIsDestination(isDestination)
	self.isDestination = isDestination
end

function JumpFloorCellData:getCol()
	return self.col
end

function JumpFloorCellData:getRow()
	return self.row
end

function JumpFloorCellData:getIndex()
	return self.index
end

function JumpFloorCellData:getCellType()
	return self.cellType
end

function JumpFloorCellData:getSkipCellStep()
	return self.skipCellStep
end

function JumpFloorCellData:getIsDestination()
	return self.isDestination
end

function JumpFloorCellData:setBuffUnAvailable()
	self._isBuffAvailable = false
end

function JumpFloorCellData:isBuffAvailable()
	return self._isBuffAvailable
end

return JumpFloorCellData
