-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BoardIndexConverter.lua

module("logic.battle.util.BoardIndexConverter", package.seeall)

local BoardIndexConverter = {}
local kMaxxValue = 10000

function BoardIndexConverter.unionIndexToCoordinates(unionIndex)
	local x = math.floor(unionIndex / kMaxxValue)
	local z = unionIndex % kMaxxValue

	return x, z
end

function BoardIndexConverter.coordinatesToUnionIndex(x, z)
	return x * kMaxxValue + z
end

function BoardIndexConverter.cellNOToUnionIndex(cellNO)
	return BoardIndexConverter.coordinatesToUnionIndex(cellNO.x, cellNO.z)
end

function BoardIndexConverter.calculateManhattanDistance(fromUnionIndex, toUnionIndex)
	local x1, z1 = BoardIndexConverter.unionIndexToCoordinates(fromUnionIndex)
	local x2, z2 = BoardIndexConverter.unionIndexToCoordinates(toUnionIndex)

	return math.abs(x1 - x2) + math.abs(z1 - z2)
end

return BoardIndexConverter
