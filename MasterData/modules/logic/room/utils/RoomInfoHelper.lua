-- chunkname: @modules/logic/room/utils/RoomInfoHelper.lua

module("modules.logic.room.utils.RoomInfoHelper", package.seeall)

local RoomInfoHelper = {}

function RoomInfoHelper.serverInfoToBlockInfo(info)
	local blockInfo = {}
	local blockCfg

	if info.fishingBlockId then
		blockInfo.fishingBlockId = info.fishingBlockId
	else
		blockCfg = RoomConfig.instance:getBlock(info.blockId)

		if not blockCfg and not RoomController.instance:isDebugMode() then
			logError(string.format("can not find blockCfg [blockId:%s]", info.blockId))
		end

		blockInfo.blockId = info.blockId
	end

	local var_1_0 = info.defineId

	if not info.defineId then
		if blockCfg then
			var_1_0 = blockCfg.defineId or RoomBlockEnum.EmptyDefineId
		end
	end

	blockInfo.defineId = var_1_0

	local var_1_1 = info.mainRes

	if not info.mainRes then
		if blockCfg then
			var_1_1 = blockCfg.mainRes or -1
		end
	end

	blockInfo.mainRes = var_1_1

	local var_1_2 = info.packageId

	if not info.packageId then
		if blockCfg then
			var_1_2 = blockCfg.packageId or 0
		end
	end

	blockInfo.packageId = var_1_2

	local var_1_3 = info.packageOrder

	if not info.packageOrder then
		if blockCfg then
			var_1_3 = blockCfg.packageOrder or 0
		end
	end

	blockInfo.packageOrder = var_1_3
	blockInfo.rotate = info.rotate or 0
	blockInfo.waterType = info.waterType
	blockInfo.blockColor = info.blockColor

	if info.use ~= false then
		blockInfo.blockState = RoomBlockEnum.BlockState.Map
		blockInfo.x = info.x
		blockInfo.y = info.y
	else
		blockInfo.blockState = RoomBlockEnum.BlockState.Inventory
	end

	return blockInfo
end

function RoomInfoHelper.blockMOToBlockInfo(blockMO)
	local blockInfo = {}

	blockInfo.blockId = blockMO.blockId
	blockInfo.defineId = blockMO.defineId
	blockInfo.mainRes = blockMO.mainRes
	blockInfo.packageId = blockMO.packageId
	blockInfo.rotate = blockMO.rotate
	blockInfo.blockState = blockMO.blockState
	blockInfo.blockColor = blockMO.blockColor

	if blockMO:isInMap() then
		blockInfo.x = blockMO.hexPoint.x
		blockInfo.y = blockMO.hexPoint.y
	end

	return blockInfo
end

function RoomInfoHelper.generateEmptyMapBlockInfo(blockId, x, y, distanceStyle)
	local blockInfo = {}

	blockInfo.blockId = blockId
	blockInfo.defineId = RoomResourceEnum.EmptyDefineId
	blockInfo.mainRes = RoomResourceEnum.ResourceId.Empty
	blockInfo.rotate = 0
	blockInfo.blockState = RoomBlockEnum.BlockState.Water
	blockInfo.distanceStyle = distanceStyle
	blockInfo.x = x
	blockInfo.y = y

	return blockInfo
end

function RoomInfoHelper.generateFakeMapBlockInfo(blockId)
	local blockInfo = {}

	blockInfo.blockId = blockId
	blockInfo.defineId = RoomResourceEnum.EmptyDefineId
	blockInfo.mainRes = RoomResourceEnum.ResourceId.Empty
	blockInfo.rotate = 0
	blockInfo.blockState = RoomBlockEnum.BlockState.Fake

	return blockInfo
end

function RoomInfoHelper.serverInfoToBuildingInfo(info)
	local buildingInfo = {}

	buildingInfo.uid = info.uid
	buildingInfo.buildingId = info.defineId
	buildingInfo.rotate = info.rotate

	if info.use then
		buildingInfo.buildingState = RoomBuildingEnum.BuildingState.Map
		buildingInfo.x = info.x
		buildingInfo.y = info.y
	else
		buildingInfo.buildingState = RoomBuildingEnum.BuildingState.Inventory
	end

	buildingInfo.resAreaDirection = info.resAreaDirection
	buildingInfo.use = info.use
	buildingInfo.level = info.level
	buildingInfo.belongUserId = info.belongUserId

	return buildingInfo
end

function RoomInfoHelper.buildingMOToBuildingInfo(buildingMO)
	local buildingInfo = {}

	buildingInfo.uid = buildingMO.uid
	buildingInfo.buildingId = buildingMO.buildingId
	buildingInfo.rotate = buildingMO.rotate
	buildingInfo.buildingState = buildingMO.buildingState

	if buildingMO:isInMap() then
		buildingInfo.x = buildingMO.hexPoint.x
		buildingInfo.y = buildingMO.hexPoint.y
	end

	buildingInfo.resAreaDirection = buildingMO.resAreaDirection
	buildingInfo.level = buildingMO.level

	return buildingInfo
end

function RoomInfoHelper.serverInfoToCharacterInfo(info)
	local characterInfo = {}

	characterInfo.heroId = info.heroId
	characterInfo.currentFaith = info.currentFaith
	characterInfo.currentMinute = info.currentMinute
	characterInfo.nextRefreshTime = info.nextRefreshTime
	characterInfo.skinId = info.skin
	characterInfo.currentPosition = Vector3.zero
	characterInfo.characterState = RoomCharacterEnum.CharacterState.Map

	return characterInfo
end

function RoomInfoHelper.generateTempCharacterInfo(heroId, position, skinId)
	local characterInfo = {}

	characterInfo.heroId = heroId
	characterInfo.currentFaith = 0
	characterInfo.currentMinute = 0
	characterInfo.nextRefreshTime = 0
	characterInfo.skinId = skinId
	characterInfo.currentPosition = position
	characterInfo.characterState = RoomCharacterEnum.CharacterState.Temp

	return characterInfo
end

function RoomInfoHelper.generateTrainCharacterInfo(heroId, position, skinId)
	local characterInfo = RoomInfoHelper.generateTempCharacterInfo(heroId, position, skinId)

	characterInfo.characterState = RoomCharacterEnum.CharacterState.Map
	characterInfo.sourceState = RoomCharacterEnum.SourceState.Train

	return characterInfo
end

return RoomInfoHelper
