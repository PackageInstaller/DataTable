-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/shape/implement/BattleShapeSector.lua

module("logic.battle.datadef.shape.implement.BattleShapeSector", package.seeall)

local BattleShapeSector = class("BattleShapeSector", BattleShapeBase)

function BattleShapeSector:parseServerShapeNO(shapeNO)
	self._radius = shapeNO.radius
end

function BattleShapeSector:parseShapeConfig(shapeConfig)
	self._radius = shapeConfig.range
end

function BattleShapeSector:getType()
	return BattleEnum.Shape.Sector
end

function BattleShapeSector:onInit()
	self._radius = false
end

function BattleShapeSector:onReset()
	self._radius = false
end

function BattleShapeSector:equals(other)
	return self:getType() == other:getType() and self._radius == other._radius
end

function BattleShapeSector:calculateCoveredUnionIndexList(shapeContext, outUnionIndexList)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local direction = shapeContext:getDirection()
	local radius = self._radius
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)

	if direction.x == 0 then
		local dz = direction.z > 0 and 1 or -1

		for r = 0, radius - 1 do
			local tz = z + dz * r

			for dx = -r, r do
				local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x + dx, tz)

				table.insert(outUnionIndexList, unionIndex)
			end
		end
	else
		local dx = direction.x > 0 and 1 or -1

		for r = 0, radius - 1 do
			local tx = x + dx * r

			for dz = -r, r do
				local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(tx, z + dz)

				table.insert(outUnionIndexList, unionIndex)
			end
		end
	end
end

function BattleShapeSector:calculateBoundingRectangleList(shapeContext, outRectangleList)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local direction = shapeContext:getDirection()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)
	local radius = self._radius
	local halfRadius = checkint(radius / 2)

	if direction.x == 0 then
		if direction.z > 0 then
			table.insert(outRectangleList, Rectangle:createInstance(x - radius, x + radius, z, z + radius - 1))
		else
			table.insert(outRectangleList, Rectangle:createInstance(x - radius, x + radius, z - radius + 1, z))
		end
	elseif direction.x > 0 then
		table.insert(outRectangleList, Rectangle:createInstance(x, x + radius - 1, z - radius, z + radius))
	else
		table.insert(outRectangleList, Rectangle:createInstance(x - radius + 1, x, z - radius, z + radius))
	end
end

function BattleShapeSector:calculateBoundingCircleRadius(shapeContext)
	return self._radius
end

return BattleShapeSector
