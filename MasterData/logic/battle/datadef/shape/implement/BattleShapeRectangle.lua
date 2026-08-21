-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/shape/implement/BattleShapeRectangle.lua

module("logic.battle.datadef.shape.implement.BattleShapeRectangle", package.seeall)

local BattleShapeRectangle = class("BattleShapeRectangle", BattleShapeBase)

function BattleShapeRectangle:parseServerShapeNO(rectangleNO)
	self._width = rectangleNO.width
	self._height = rectangleNO.height
end

function BattleShapeRectangle:parseShapeConfig(shapeConfig)
	self._width = shapeConfig.width
	self._height = shapeConfig.height
end

function BattleShapeRectangle:getType()
	return BattleEnum.Shape.Rectangle
end

function BattleShapeRectangle:onInit()
	self._width = false
	self._height = false
end

function BattleShapeRectangle:onReset()
	self._width = false
	self._height = false
end

function BattleShapeRectangle:equals(other)
	return self:getType() == other:getType() and self._width == other._width and self._height == other._height
end

function BattleShapeRectangle:calculateCoveredUnionIndexList(shapeContext, outUnionIndexList)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)
	local width = self._width
	local height = self._height

	if width % 2 == 0 or height % 2 == 0 then
		for dx = 0, width - 1 do
			for dz = 0, height - 1 do
				local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x + dx, z + dz)

				table.insert(outUnionIndexList, unionIndex)
			end
		end
	else
		local halfWidth = (width - 1) / 2
		local halfHeight = (height - 1) / 2

		for dx = -halfWidth, halfWidth do
			for dz = -halfHeight, halfHeight do
				local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x + dx, z + dz)

				table.insert(outUnionIndexList, unionIndex)
			end
		end
	end
end

function BattleShapeRectangle:calculateBoundingRectangleList(shapeContext, outRectangleList)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)
	local width = self._width
	local height = self._height

	if width % 2 == 0 or height % 2 == 0 then
		table.insert(outRectangleList, Rectangle:createInstance(x, x + width - 1, z, z + height - 1))
	else
		local halfWidth = (width - 1) / 2
		local halfHeight = (height - 1) / 2

		table.insert(outRectangleList, Rectangle:createInstance(x - halfWidth, x + halfWidth, z - halfHeight, z + halfHeight))
	end
end

function BattleShapeRectangle:calculateBoundingCircleRadius(shapeContext)
	local widthOrHeight = math.max(self._width, self._height)

	return math.ceil(widthOrHeight / 2)
end

return BattleShapeRectangle
