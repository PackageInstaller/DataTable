-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/shape/implement/BattleShapeLine.lua

module("logic.battle.datadef.shape.implement.BattleShapeLine", package.seeall)

local BattleShapeLine = class("BattleShapeLine", BattleShapeBase)

function BattleShapeLine:parseServerShapeNO(lineNO)
	local startCellNO = lineNO.start
	local endCellNO = lineNO["end"]
	local lengthX = math.abs(endCellNO.x - startCellNO.x)
	local lengthZ = math.abs(endCellNO.z - startCellNO.z)

	self._length = math.max(lengthX, lengthZ)
end

function BattleShapeLine:parseShapeConfig(shapeConfig)
	self._length = shapeConfig.length
end

function BattleShapeLine:getType()
	return BattleEnum.Shape.Line
end

function BattleShapeLine:onInit()
	self._length = false
end

function BattleShapeLine:onReset()
	self._length = false
end

function BattleShapeLine:equals(other)
	return self:getType() == other:getType() and self._length == other._length
end

function BattleShapeLine:calculateCoveredUnionIndexList(shapeContext, outUnionIndexList)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local direction = shapeContext:getDirection()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)
	local length = self._length

	if direction.x == 0 then
		local dz = direction.z > 0 and 1 or -1

		for i = 0, length - 1 do
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, z + dz * i)

			table.insert(outUnionIndexList, unionIndex)
		end
	else
		local dx = direction.x > 0 and 1 or -1

		for i = 0, length - 1 do
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x + dx * i, z)

			table.insert(outUnionIndexList, unionIndex)
		end
	end
end

function BattleShapeLine:calculateBoundingRectangleList(shapeContext, outRectangleList)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local direction = shapeContext:getDirection()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)
	local length = self._length - 1

	if direction.x == 0 then
		if direction.z > 0 then
			table.insert(outRectangleList, Rectangle:createInstance(x, x, z, z + length))
		else
			table.insert(outRectangleList, Rectangle:createInstance(x, x, z - length, z))
		end
	elseif direction.x > 0 then
		table.insert(outRectangleList, Rectangle:createInstance(x, x + length, z, z))
	else
		table.insert(outRectangleList, Rectangle:createInstance(x - length, x, z, z))
	end
end

function BattleShapeLine:calculateBoundingCircleRadius(shapeContext)
	return self._length
end

function BattleShapeLine:contains(shapeContext, inputUnionIndex)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local direction = shapeContext:getDirection()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)
	local tx, tz = BoardIndexConverter.unionIndexToCoordinates(inputUnionIndex)
	local length = self._length - 1

	if direction.x == 0 then
		if direction.z > 0 then
			return x == tx and z <= tz and tz <= z + length
		else
			return x == tx and tz >= z - length and tz <= z
		end
	elseif direction.x > 0 then
		return z == tz and x <= tx and tx <= x + length
	else
		return z == tz and tx >= x - length and tx <= x
	end
end

return BattleShapeLine
