-- chunkname: @modules/logic/room/utils/pathfinding/RoomAStarHelper.lua

module("modules.logic.room.utils.pathfinding.RoomAStarHelper", package.seeall)

local RoomAStarHelper = {}

RoomAStarHelper._walkableTagCondition = nil

function RoomAStarHelper.walkableTag(resId, tagId)
	RoomAStarHelper._walkableTagCondition = RoomAStarHelper._walkableTagCondition or {
		[RoomResourceEnum.ResourceId.Empty] = {
			RoomEnum.AStarLayerTag.Water,
			RoomEnum.AStarLayerTag.Default
		},
		[RoomResourceEnum.ResourceId.River] = {
			RoomEnum.AStarLayerTag.Water
		},
		[RoomResourceEnum.ResourceId.Road] = {
			RoomEnum.AStarLayerTag.Road
		},
		[RoomResourceEnum.ResourceId.Muddyway] = {
			RoomEnum.AStarLayerTag.Muddyway
		},
		[RoomResourceEnum.ResourceId.Railway] = {
			RoomEnum.AStarLayerTag.Railway
		},
		[RoomResourceEnum.ResourceId.Coast] = {
			RoomEnum.AStarLayerTag.Coast
		},
		[RoomResourceEnum.ResourceId.Road10] = {
			RoomEnum.AStarLayerTag.Road10,
			RoomEnum.AStarLayerTag.NoWalkRoad
		},
		[RoomResourceEnum.ResourceId.AirVehicle] = {
			RoomEnum.AStarLayerTag.AirVehicle,
			RoomEnum.AStarLayerTag.NoWalkRoad
		},
		[RoomResourceEnum.ResourceId.Road12] = {
			RoomEnum.AStarLayerTag.Road12,
			RoomEnum.AStarLayerTag.NoWalkRoad
		}
	}

	local list = RoomAStarHelper._walkableTagCondition[resId]

	if list and tabletool.indexOf(list, tagId) then
		return true
	end

	return false
end

function RoomAStarHelper.resourcePoint2HollowHexPoint(resourcePoint)
	local q = resourcePoint.x * 3
	local r = resourcePoint.y * 3
	local direction = resourcePoint.direction

	if direction == 1 then
		r = r - 1
	elseif direction == 2 then
		q = q + 1
		r = r - 1
	elseif direction == 3 then
		q = q + 1
	elseif direction == 4 then
		r = r + 1
	elseif direction == 5 then
		q = q - 1
		r = r + 1
	elseif direction == 6 then
		q = q - 1
	end

	return HexPoint(q, r)
end

function RoomAStarHelper.hollowHexPoint2ResourcePoint(hollowHexPoint)
	local x = math.floor(hollowHexPoint.q / 3)
	local y = math.floor(hollowHexPoint.r / 3)
	local direction = 0
	local modQ = RoomRotateHelper.getMod(hollowHexPoint.q, 3)
	local modR = RoomRotateHelper.getMod(hollowHexPoint.r, 3)

	if modQ == 0 then
		if modR == 1 then
			direction = 4
		elseif modR == 2 then
			y = y + 1
			direction = 1
		end
	elseif modQ == 1 then
		if modR == 0 then
			direction = 3
		elseif modR == 1 then
			return nil
		elseif modR == 2 then
			y = y + 1
			direction = 2
		end
	elseif modQ == 2 then
		if modR == 0 then
			x = x + 1
			direction = 6
		elseif modR == 1 then
			x = x + 1
			direction = 5
		elseif modR == 2 then
			return nil
		end
	end

	return ResourcePoint(HexPoint(x, y), direction)
end

function RoomAStarHelper.heuristic(point, targetPoint)
	local startHollowHexPoint = RoomAStarHelper.resourcePoint2HollowHexPoint(point)
	local targetHollowHexPoint = RoomAStarHelper.resourcePoint2HollowHexPoint(targetPoint)

	return (HexPoint.Distance(startHollowHexPoint, targetHollowHexPoint))
end

return RoomAStarHelper
