-- chunkname: @modules/logic/room/utils/RoomRiverHelper.lua

module("modules.logic.room.utils.RoomRiverHelper", package.seeall)

local RoomRiverHelper = {}

RoomRiverHelper._neighborMODict = {}
RoomRiverHelper._neighborLinkResIdDict = {}

function RoomRiverHelper.getRiverTypeDictByMO(roomBlockMO)
	local riverTypeDict = {}
	local blockTypeDict = {}
	local blockBTypeDict = {}

	if not roomBlockMO:isFullWater() then
		return riverTypeDict, blockTypeDict, blockBTypeDict
	end

	if not roomBlockMO:isInMapBlock() or RoomRiverHelper._isNotLink(roomBlockMO) then
		local tergetBlockType = roomBlockMO:getDefineBlockType()

		for direction = 1, 6 do
			riverTypeDict[direction] = RoomRiverEnum.LakeOutLinkType.NoLink
			blockTypeDict[direction] = tergetBlockType
		end

		return riverTypeDict, blockTypeDict
	end

	local neighborMODict = RoomRiverHelper._neighborMODict
	local linkResIdDict = RoomRiverHelper._neighborLinkResIdDict
	local tRoomMapBlockModel = RoomMapBlockModel.instance
	local hexPoint = roomBlockMO.hexPoint

	for direction = 1, 6 do
		local neighbor = HexPoint.directions[direction]
		local nearBlockMO = tRoomMapBlockModel:getBlockMO(hexPoint.x + neighbor.x, hexPoint.y + neighbor.y)

		if nearBlockMO and nearBlockMO:isInMapBlock() and not RoomRiverHelper._isNotLink(nearBlockMO) then
			neighborMODict[direction] = nearBlockMO
			linkResIdDict[direction] = nearBlockMO:getResourceId(RoomRotateHelper.rotateDirection(direction, 3), false, true)
		else
			neighborMODict[direction] = nil
			linkResIdDict[direction] = nil
		end
	end

	local tergetBlockType = roomBlockMO:getDefineBlockType()

	for direction = 1, 6 do
		local riverType, blockType, blockBType = RoomRiverHelper._getRiverTypeByDirection(roomBlockMO, direction, neighborMODict, linkResIdDict)

		riverTypeDict[direction] = riverType
		blockTypeDict[direction] = blockType or tergetBlockType
		blockBTypeDict[direction] = blockBType
	end

	return riverTypeDict, blockTypeDict, blockBTypeDict
end

function RoomRiverHelper._isNotLink(roomBlockMO)
	if roomBlockMO then
		local defineCfg = roomBlockMO:getBlockDefineCfg()

		return defineCfg and defineCfg.waterLink == 1
	end

	return false
end

function RoomRiverHelper._getRiverTypeByDirection(roomBlockMO, direction, neighborMODict, linkResIdDict)
	local resId = roomBlockMO:getResourceId(direction, false, true)

	if resId ~= RoomResourceEnum.ResourceId.River or not roomBlockMO:isInMapBlock() then
		return RoomRiverEnum.LakeOutLinkType.NoLink
	end

	local linkBlockMO = neighborMODict[direction]
	local linkResId = linkResIdDict[direction]

	if linkBlockMO then
		if linkResId ~= RoomResourceEnum.ResourceId.River then
			return RoomRiverEnum.LakeOutLinkType.Floor, linkBlockMO:getDefineBlockType()
		end

		if not linkBlockMO:isFullWater() then
			return RoomRiverEnum.LakeOutLinkType.River, linkBlockMO:getDefineBlockType()
		end
	end

	local left = RoomRotateHelper.rotateDirection(direction, 1)
	local right = RoomRotateHelper.rotateDirection(direction, -1)
	local leftLinkMO = neighborMODict[left]
	local rightLinkMO = neighborMODict[right]
	local leftLinkResId = linkResIdDict[left]
	local rightLinkResId = linkResIdDict[right]
	local leftResId = RoomResourceEnum.ResourceId.River
	local rightResId = RoomResourceEnum.ResourceId.River
	local hasLeftFloor = RoomRiverHelper._checkSideFloor(leftResId, leftLinkMO, leftLinkResId)
	local hasRightFloor = RoomRiverHelper._checkSideFloor(rightResId, rightLinkMO, rightLinkResId)

	if not hasLeftFloor and not hasRightFloor then
		return RoomRiverEnum.LakeOutLinkType.NoLink
	end

	if hasLeftFloor and not hasRightFloor then
		return RoomRiverEnum.LakeOutLinkType.Left, leftLinkMO:getDefineBlockType()
	end

	if not hasLeftFloor and hasRightFloor then
		return RoomRiverEnum.LakeOutLinkType.Right, rightLinkMO:getDefineBlockType()
	end

	local leftBlockType = leftLinkMO:getDefineBlockType()
	local rightBlockType = rightLinkMO:getDefineBlockType()

	return RoomRiverEnum.LakeOutLinkType.RightLeft, rightBlockType, leftBlockType
end

function RoomRiverHelper._checkSideFloor(selfResId, linkBlockMO, linkResId)
	if selfResId ~= RoomResourceEnum.ResourceId.River or not linkBlockMO or linkBlockMO:isFullWater() and linkResId == RoomResourceEnum.ResourceId.River then
		return false
	end

	return true
end

return RoomRiverHelper
