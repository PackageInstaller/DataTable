-- chunkname: @modules/logic/room/utils/RoomDistributionHelper.lua

module("modules.logic.room.utils.RoomDistributionHelper", package.seeall)

local RoomDistributionHelper = {}

function RoomDistributionHelper.matchType(type, resourceList, rotate)
	rotate = rotate or 0

	local typeValue = RoomDistributionEnum.DistributionTypeValue[type]

	for i = 1, 6 do
		local offset = RoomRotateHelper.rotateDirection(i, rotate)
		local flag = true

		for j = 1, 6 do
			if resourceList[RoomRotateHelper.rotateDirection(j, rotate)] ~= typeValue[j] then
				flag = false

				break
			end
		end

		if flag then
			return true, offset
		end

		resourceList = RoomDistributionHelper._moveForward(resourceList)
	end

	return false, 0
end

function RoomDistributionHelper._moveForward(resourceList)
	local newResourceList = {}

	for i = 1, 6 do
		newResourceList[i] = resourceList[RoomRotateHelper.rotateDirection(i, 1)]
	end

	return newResourceList
end

function RoomDistributionHelper.getIndex(resourceList, rotate)
	local index = 0

	for i = 1, 6 do
		local rotated = RoomRotateHelper.rotateDirection(i, rotate)

		index = rotated

		if not resourceList[rotated] then
			break
		end
	end

	return index
end

return RoomDistributionHelper
