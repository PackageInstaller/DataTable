-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/shape/implement/BattleShapeRhombus.lua

module("logic.battle.datadef.shape.implement.BattleShapeRhombus", package.seeall)

local BattleShapeRhombus = class("BattleShapeRhombus", BattleShapeBase)

function BattleShapeRhombus:parseServerShapeNO(rhombusNO)
	self._radius = rhombusNO.radius
end

function BattleShapeRhombus:parseShapeConfig(shapeConfig)
	self._radius = shapeConfig.range
end

function BattleShapeRhombus:getType()
	return BattleEnum.Shape.Rhombus
end

function BattleShapeRhombus:onInit()
	self._radius = false
end

function BattleShapeRhombus:onReset()
	self._radius = false
end

function BattleShapeRhombus:equals(other)
	return self:getType() == other:getType() and self._radius == other._radius
end

function BattleShapeRhombus:calculateCoveredUnionIndexList(shapeContext, outUnionIndexList)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local radius = self._radius

	if radius <= 0 then
		table.insert(outUnionIndexList, centerUnionIndex)
	else
		local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)

		for dx = -radius, radius do
			for dz = -radius, radius do
				local length = math.abs(dx) + math.abs(dz)

				if length <= radius then
					local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x + dx, z + dz)

					table.insert(outUnionIndexList, unionIndex)
				end
			end
		end
	end
end

function BattleShapeRhombus:calculateBoundingRectangleList(shapeContext, outRectangleList)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)
	local radius = self._radius

	table.insert(outRectangleList, Rectangle:createInstance(x - radius, x + radius, z - radius, z + radius))
end

function BattleShapeRhombus:contains(shapeContext, inputUnionIndex)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)
	local tx, tz = BoardIndexConverter.unionIndexToCoordinates(inputUnionIndex)

	return math.abs(tx - x) + math.abs(tz - z) <= self._radius
end

function BattleShapeRhombus:calculateBoundingCircleRadius(shapeContext)
	return self._radius
end

return BattleShapeRhombus
