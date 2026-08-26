-- chunkname: @modules/logic/room/utils/RoomTransportPathLinkHelper.lua

module("modules.logic.room.utils.RoomTransportPathLinkHelper", package.seeall)

local RoomTransportPathLinkHelper = {}

RoomTransportPathLinkHelper._neighborMODict = {}
RoomTransportPathLinkHelper._neighborLinkResIdDict = {}

function RoomTransportPathLinkHelper.getPtahLineType(hexPoint, prevHexPoint, nextHexPoint)
	if not hexPoint then
		return nil
	end

	if prevHexPoint == nil and nextHexPoint == nil then
		return RoomTransportPathEnum.PathLineType.Line00, 0
	end

	if not prevHexPoint or HexPoint.Distance(hexPoint, prevHexPoint) ~= 1 then
		return RoomTransportPathLinkHelper._getLine10(hexPoint, nextHexPoint)
	end

	if not nextHexPoint or HexPoint.Distance(hexPoint, nextHexPoint) ~= 1 then
		return RoomTransportPathLinkHelper._getLine10(hexPoint, prevHexPoint)
	end

	local dir = RoomTransportPathLinkHelper.findLinkDirection(hexPoint, prevHexPoint)
	local dir2 = RoomTransportPathLinkHelper.findLinkDirection(hexPoint, nextHexPoint)
	local abs = math.abs(dir - dir2)

	if abs == 1 then
		return RoomTransportPathLinkHelper._getLineAbs1(dir, dir2)
	elseif abs == 2 then
		return RoomTransportPathLinkHelper._getLineAbs2(dir, dir2)
	elseif abs == 3 then
		return RoomTransportPathLinkHelper._getLineAbs3(dir, dir2)
	elseif abs == 4 then
		return RoomTransportPathLinkHelper._getLineAbs4(dir, dir2)
	elseif abs == 5 then
		return RoomTransportPathLinkHelper._getLineAbs5(dir, dir2)
	end
end

function RoomTransportPathLinkHelper._getLine10(hexPoint, nextHexPoint)
	if not nextHexPoint or HexPoint.Distance(hexPoint, nextHexPoint) ~= 1 then
		return nil
	end

	local dir = RoomTransportPathLinkHelper.findLinkDirection(hexPoint, nextHexPoint)

	if dir then
		local rotate = dir - 1

		return RoomTransportPathEnum.PathLineType.Line10, rotate
	end
end

function RoomTransportPathLinkHelper._getLineAbs1(dir, dir2)
	local rotate = math.max(dir, dir2) - 2

	return RoomTransportPathEnum.PathLineType.Line12, rotate
end

function RoomTransportPathLinkHelper._getLineAbs5(dir, dir2)
	return RoomTransportPathEnum.PathLineType.Line12, 5
end

function RoomTransportPathLinkHelper._getLineAbs2(dir, dir2)
	local rotate = math.max(dir, dir2) - 3

	return RoomTransportPathEnum.PathLineType.Line13, rotate
end

function RoomTransportPathLinkHelper._getLineAbs4(dir, dir2)
	local rotate = math.max(dir, dir2) - 1

	return RoomTransportPathEnum.PathLineType.Line13, rotate
end

function RoomTransportPathLinkHelper._getLineAbs3(dir, dir2)
	local rotate = math.max(dir, dir2) - 4

	return RoomTransportPathEnum.PathLineType.Line14, rotate
end

function RoomTransportPathLinkHelper.findLinkDirection(hexPoint, nextHexPoint)
	local x = nextHexPoint.x - hexPoint.x
	local y = nextHexPoint.y - hexPoint.y

	if x == 0 and y == 0 then
		return 0
	end

	for dir = 1, 6 do
		local dirPoint = HexPoint.directions[dir]

		if x == dirPoint.x and y == dirPoint.y then
			return dir
		end
	end

	return nil
end

return RoomTransportPathLinkHelper
