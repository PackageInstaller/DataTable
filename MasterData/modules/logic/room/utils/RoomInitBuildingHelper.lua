-- chunkname: @modules/logic/room/utils/RoomInitBuildingHelper.lua

module("modules.logic.room.utils.RoomInitBuildingHelper", package.seeall)

local RoomInitBuildingHelper = {}

function RoomInitBuildingHelper.canLevelUp()
	local maxRoomLevel = RoomConfig.instance:getMaxRoomLevel()
	local roomLevel = RoomModel.instance:getRoomLevel()

	if maxRoomLevel <= roomLevel then
		return false, RoomInitBuildingEnum.CanLevelUpErrorCode.MaxLevel
	end

	local nextRoomLevel = roomLevel + 1
	local roomLevelConfig = RoomConfig.instance:getRoomLevelConfig(nextRoomLevel)
	local enough = RoomInitBuildingHelper.hasLevelUpItemEnough()

	if not enough then
		return false, RoomInitBuildingEnum.CanLevelUpErrorCode.NotEnoughItem
	end

	local needBlockCount = roomLevelConfig.needBlockCount
	local confirmBlockCount = RoomMapBlockModel.instance:getConfirmBlockCount()

	if confirmBlockCount < needBlockCount then
		return false, RoomInitBuildingEnum.CanLevelUpErrorCode.NotEnoughBlock
	end

	return true
end

function RoomInitBuildingHelper.hasLevelUpItemEnough()
	local roomLevel = RoomModel.instance:getRoomLevel()
	local nextRoomLevel = roomLevel + 1
	local roomLevelConfig = RoomConfig.instance:getRoomLevelConfig(nextRoomLevel)
	local costItemParamList = RoomProductionHelper.getFormulaItemParamList(roomLevelConfig.cost)
	local _, enough = ItemModel.instance:hasEnoughItems(costItemParamList)

	return enough
end

function RoomInitBuildingHelper.getModelPath(partId)
	local result
	local showSkinId = RoomSkinModel.instance:getShowSkin(partId)
	local isDefaultRoomSkin = RoomSkinModel.instance:isDefaultRoomSkin(partId, showSkinId)

	if isDefaultRoomSkin then
		result = RoomInitBuildingHelper.getDefaultSkinModelPath(partId)
	else
		local modelPath = RoomConfig.instance:getRoomSkinModelPath(showSkinId)

		result = modelPath or RoomInitBuildingHelper.getDefaultSkinModelPath(partId)
	end

	return result
end

function RoomInitBuildingHelper.getDefaultSkinModelPath(partId)
	local partConfig = RoomConfig.instance:getProductionPartConfig(partId)

	if not partConfig then
		return nil
	end

	local lineIds = partConfig.productionLines
	local maxLevel = 0
	local maxLevelLineId

	for i, lineId in ipairs(lineIds) do
		local level = 0

		if RoomController.instance:isVisitMode() then
			local otherLineLevelDict = RoomMapModel.instance:getOtherLineLevelDict()

			level = otherLineLevelDict[lineId] or 0
		elseif RoomController.instance:isDebugMode() then
			maxLevelLineId = lineId
			maxLevel = 1

			break
		else
			local lineMO = RoomProductionModel.instance:getLineMO(lineId)

			level = lineMO and lineMO.level or 0
		end

		if (not maxLevelLineId or maxLevel < level) and level > 0 then
			maxLevelLineId = lineId
			maxLevel = level
		end
	end

	if not maxLevelLineId then
		return nil
	end

	local lineConfig = RoomConfig.instance:getProductionLineConfig(maxLevelLineId)
	local levelCO = RoomConfig.instance:getProductionLineLevelConfig(lineConfig.levelGroup, maxLevel)
	local modulePart = levelCO and levelCO.modulePart

	if string.nilorempty(modulePart) then
		return nil
	end

	return string.format("scenes/m_s07_xiaowu/prefab/jianzhu/a_rukou/%s.prefab", modulePart)
end

function RoomInitBuildingHelper.getPartRealCameraParam(partId)
	local cameraParam

	if partId == 0 then
		cameraParam = CommonConfig.instance:getConstStr(ConstEnum.RoomInitBuildingCameraParam)
	else
		local partConfig = RoomConfig.instance:getProductionPartConfig(partId)

		cameraParam = partConfig.cameraParam
	end

	if not string.nilorempty(cameraParam) then
		local paramList = string.splitToNumber(cameraParam, "#")

		return {
			rotate = paramList[1],
			angle = paramList[2],
			distance = paramList[3],
			height = paramList[4]
		}
	end
end

return RoomInitBuildingHelper
