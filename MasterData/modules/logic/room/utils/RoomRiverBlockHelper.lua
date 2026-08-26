-- chunkname: @modules/logic/room/utils/RoomRiverBlockHelper.lua

module("modules.logic.room.utils.RoomRiverBlockHelper", package.seeall)

local RoomRiverBlockHelper = {}

RoomRiverBlockHelper.TypeToFunction = nil

function RoomRiverBlockHelper._getFunctionByType(type)
	RoomRiverBlockHelper.TypeToFunction = RoomRiverBlockHelper.TypeToFunction or {
		[RoomDistributionEnum.DistributionType.C1TA] = RoomRiverBlockHelper._getRiverBlockType_C1TA,
		[RoomDistributionEnum.DistributionType.C2TA] = RoomRiverBlockHelper._getRiverBlockType_C2TA,
		[RoomDistributionEnum.DistributionType.C2TB] = RoomRiverBlockHelper._getRiverBlockType_C2TB,
		[RoomDistributionEnum.DistributionType.C2TC] = RoomRiverBlockHelper._getRiverBlockType_C2TC,
		[RoomDistributionEnum.DistributionType.C3TA] = RoomRiverBlockHelper._getRiverBlockType_C3TA,
		[RoomDistributionEnum.DistributionType.C3TB] = RoomRiverBlockHelper._getRiverBlockType_C3TB,
		[RoomDistributionEnum.DistributionType.C3TC] = RoomRiverBlockHelper._getRiverBlockType_C3TC,
		[RoomDistributionEnum.DistributionType.C3TD] = RoomRiverBlockHelper._getRiverBlockType_C3TD,
		[RoomDistributionEnum.DistributionType.C4TA] = RoomRiverBlockHelper._getRiverBlockType_C4TA,
		[RoomDistributionEnum.DistributionType.C4TB] = RoomRiverBlockHelper._getRiverBlockType_C4TB,
		[RoomDistributionEnum.DistributionType.C4TC] = RoomRiverBlockHelper._getRiverBlockType_C4TC,
		[RoomDistributionEnum.DistributionType.C5TA] = RoomRiverBlockHelper._getRiverBlockType_C5TA,
		[RoomDistributionEnum.DistributionType.C6TA] = RoomRiverBlockHelper._getRiverBlockType_C6TA
	}

	return RoomRiverBlockHelper.TypeToFunction[type]
end

function RoomRiverBlockHelper.getRiverBlockTypeByMO(mo)
	local resourceList = {}

	for i = 1, 6 do
		table.insert(resourceList, mo:getResourceId(i, false, true))
	end

	local neighborsResourceList = {}

	if mo:isInMap() then
		for i = 1, 6 do
			local neighbor = mo.hexPoint:getNeighbor(i)
			local neighborMO = RoomMapBlockModel.instance:getBlockMO(neighbor.x, neighbor.y)

			if neighborMO then
				neighborsResourceList[i] = {}

				for j = 1, 6 do
					table.insert(neighborsResourceList[i], neighborMO:getResourceId(j, false, true))
				end
			end
		end
	end

	local defineBlockType = mo:getDefineBlockType()
	local defineWaterType = mo:getDefineWaterType()

	return RoomRiverBlockHelper.getRiverBlockType(resourceList, neighborsResourceList, mo:getRotate(), defineBlockType, defineWaterType)
end

function RoomRiverBlockHelper.getRiverBlockType(resourceList, neighborsResourceList, rotate, defineBlockType, defineWaterType)
	local riverList = {}
	local neighborRiverList = {}
	local neighborFullRiverList = {}
	local count = 0

	for i = 1, 6 do
		local isRiver = resourceList[i] == RoomResourceEnum.ResourceId.River

		if isRiver then
			count = count + 1
		end

		table.insert(riverList, isRiver)
	end

	for i = 1, 6 do
		local neighborResourceList = neighborsResourceList[i]

		if neighborResourceList then
			local isFullRiver = true
			local oppositeDirection = RoomRotateHelper.oppositeDirection(i)

			for j = 1, 6 do
				local isRiver = neighborResourceList[j] == RoomResourceEnum.ResourceId.River or neighborResourceList[j] == RoomResourceEnum.ResourceId.Empty

				if not isRiver then
					isFullRiver = false
				end

				if j == oppositeDirection then
					table.insert(neighborRiverList, isRiver)
				end
			end

			table.insert(neighborFullRiverList, isFullRiver)
		else
			table.insert(neighborRiverList, true)
			table.insert(neighborFullRiverList, true)
		end
	end

	if count > 0 then
		local typeList = RoomDistributionEnum.CountToTypeList[count]

		for _, type in ipairs(typeList) do
			local match, offset = RoomDistributionHelper.matchType(type, riverList, rotate)

			if match then
				local typeFunction = RoomRiverBlockHelper._getFunctionByType(type)
				local riverBlockType, blockOffset = typeFunction(riverList, neighborRiverList, neighborFullRiverList)
				local riverFloolPath, riverFloolPathAb, riverPath, riverPathAb

				blockOffset = blockOffset or 0

				if riverBlockType then
					riverPath, riverPathAb = RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, riverBlockType, defineWaterType)
					riverFloolPath, riverFloolPathAb = RoomResHelper.getMapRiverFloorResPath(riverBlockType, defineBlockType)
				end

				offset = RoomRotateHelper.rotateRotate(offset, -rotate)
				offset = RoomRotateHelper.rotateRotate(offset, blockOffset)

				return riverPath, offset, riverFloolPath, riverPathAb, riverFloolPathAb
			end
		end
	end
end

function RoomRiverBlockHelper._getRiverX(key, condition)
	return (not condition or nil) and (key .. "x" or key)
end

function RoomRiverBlockHelper._getRiverBlockType_C1TA(riverList, neighborRiverList, neighborFullRiverList)
	return RoomRiverEnum.RiverBlockType["4000"], -1
end

function RoomRiverBlockHelper._getRiverBlockType_C2TA(riverList, neighborRiverList, neighborFullRiverList)
	return RoomRiverEnum.RiverBlockType["4002"], -1
end

function RoomRiverBlockHelper._getRiverBlockType_C2TB(riverList, neighborRiverList, neighborFullRiverList)
	return RoomRiverEnum.RiverBlockType["4003"], -1
end

function RoomRiverBlockHelper._getRiverBlockType_C2TC(riverList, neighborRiverList, neighborFullRiverList)
	return RoomRiverEnum.RiverBlockType["4001"], -1
end

function RoomRiverBlockHelper._getRiverBlockType_C3TA(riverList, neighborRiverList, neighborFullRiverList)
	return RoomRiverEnum.RiverBlockType["4004"], 0
end

function RoomRiverBlockHelper._getRiverBlockType_C3TB(riverList, neighborRiverList, neighborFullRiverList)
	return RoomRiverEnum.RiverBlockType["4006"], 0
end

function RoomRiverBlockHelper._getRiverBlockType_C3TC(riverList, neighborRiverList, neighborFullRiverList)
	return RoomRiverEnum.RiverBlockType["4005"], -1
end

function RoomRiverBlockHelper._getRiverBlockType_C3TD(riverList, neighborRiverList, neighborFullRiverList)
	return RoomRiverEnum.RiverBlockType["4007"], -1
end

function RoomRiverBlockHelper._getRiverBlockType_C4TA(riverList, neighborRiverList, neighborFullRiverList)
	return RoomRiverEnum.RiverBlockType["4008"], 1
end

function RoomRiverBlockHelper._getRiverBlockType_C4TB(riverList, neighborRiverList, neighborFullRiverList)
	return RoomRiverEnum.RiverBlockType["4009"], 0
end

function RoomRiverBlockHelper._getRiverBlockType_C4TC(riverList, neighborRiverList, neighborFullRiverList)
	return RoomRiverEnum.RiverBlockType["4010"], -1
end

function RoomRiverBlockHelper._getRiverBlockType_C5TA(riverList, neighborRiverList, neighborFullRiverList)
	return RoomRiverEnum.RiverBlockType["4011"], -1
end

function RoomRiverBlockHelper._getRiverBlockType_C6TA(riverList, neighborRiverList, neighborFullRiverList)
	return nil
end

return RoomRiverBlockHelper
