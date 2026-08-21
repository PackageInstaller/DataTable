-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/shape/implement/BattleShapeCrossLine.lua

module("logic.battle.datadef.shape.implement.BattleShapeCrossLine", package.seeall)

local BattleShapeCrossLine = class("BattleShapeCrossLine", BattleShapeBase)

function BattleShapeCrossLine:parseServerShapeNO(crossLineNO)
	self._width = crossLineNO.width
	self._height = crossLineNO.height
end

function BattleShapeCrossLine:parseShapeConfig(shapeConfig)
	self._width = shapeConfig.width
	self._height = shapeConfig.height
end

function BattleShapeCrossLine:getType()
	return BattleEnum.Shape.CrossLine
end

function BattleShapeCrossLine:onInit()
	self._width = false
	self._height = false
end

function BattleShapeCrossLine:onReset()
	self._width = false
	self._height = false
end

function BattleShapeCrossLine:equals(other)
	return self:getType() == other:getType() and self._width == other._width and self._height == other._height
end

function BattleShapeCrossLine:calculateCoveredUnionIndexList(shapeContext, outUnionIndexList)
	local flagTable = BattleTableUtil.getTempList()
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)
	local halfWidth = (self._width - 1) / 2
	local halfHeight = (self._height - 1) / 2

	for dx = -halfWidth, halfWidth do
		for dz = -halfHeight, halfHeight do
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x + dx, z + dz)

			if not flagTable[unionIndex] then
				flagTable[unionIndex] = true

				table.insert(outUnionIndexList, unionIndex)
			end
		end
	end

	for dx = -halfHeight, halfHeight do
		for dz = -halfWidth, halfWidth do
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x + dx, z + dz)

			if not flagTable[unionIndex] then
				flagTable[unionIndex] = true

				table.insert(outUnionIndexList, unionIndex)
			end
		end
	end

	BattleTableUtil.releaseTempList(flagTable)
end

function BattleShapeCrossLine:calculateBoundingRectangleList(shapeContext, outRectangleList)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)
	local halfWidth = checkint((self._width - 1) / 2)
	local halfHeight = checkint((self._height - 1) / 2)
	local rectangle = Rectangle:createInstance(x - halfWidth, x + halfWidth, z - halfHeight, z + halfHeight)

	table.insert(outRectangleList, rectangle)

	rectangle = Rectangle:createInstance(x - halfHeight, x + halfHeight, z - halfWidth, z + halfWidth)

	table.insert(outRectangleList, rectangle)
end

function BattleShapeCrossLine:calculateBoundingCircleRadius(shapeContext)
	local widthOrHeight = math.max(self._width, self._height)

	return math.ceil(widthOrHeight / 2)
end

function BattleShapeCrossLine:contains(shapeContext, inputUnionIndex)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)
	local tx, tz = BoardIndexConverter.unionIndexToCoordinates(inputUnionIndex)
	local halfWidth = checkint((self._width - 1) / 2)
	local halfHeight = checkint((self._height - 1) / 2)

	return halfWidth >= math.abs(tx - x) and halfHeight >= math.abs(tz - z)
end

return BattleShapeCrossLine
