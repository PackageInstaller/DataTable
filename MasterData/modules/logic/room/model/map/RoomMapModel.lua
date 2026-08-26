-- chunkname: @modules/logic/room/model/map/RoomMapModel.lua

module("modules.logic.room.model.map.RoomMapModel", package.seeall)

local RoomMapModel = class("RoomMapModel", BaseModel)

function RoomMapModel:onInit()
	self:_clearData()
end

function RoomMapModel:reInit()
	self:_clearData()
end

function RoomMapModel:clear()
	RoomMapModel.super.clear(self)
	self:_clearData()
end

function RoomMapModel:_clearData()
	self._revertCameraParam = nil
	self._buildingConfigParamDict = nil
	self._otherLineLevelDict = nil
	self._roomLevel = 1
	self._roomLeveling = false
end

function RoomMapModel:init()
	self:clear()
end

function RoomMapModel:updateRoomLevel(roomLevel)
	self._roomLevel = roomLevel
end

function RoomMapModel:getRoomLevel()
	return self._roomLevel
end

function RoomMapModel:saveCameraParam(cameraParam)
	self._revertCameraParam = LuaUtil.deepCopy(cameraParam)
end

function RoomMapModel:getCameraParam()
	return self._revertCameraParam
end

function RoomMapModel:clearCameraParam()
	self._revertCameraParam = nil
end

function RoomMapModel:getBuildingConfigParam(buildingId)
	if not buildingId then
		return nil
	end

	self._buildingConfigParamDict = self._buildingConfigParamDict or {}

	local buildingConfigParam = self._buildingConfigParamDict[buildingId]

	if not buildingConfigParam then
		local buildingConfig = RoomConfig.instance:getBuildingConfig(buildingId)

		if not buildingConfig then
			return nil
		end

		buildingConfigParam = {}

		local centerParam = buildingConfig.center

		if not string.nilorempty(centerParam) then
			centerParam = string.splitToNumber(centerParam, "#")
			buildingConfigParam.onlyDirection = centerParam[3]
		end

		local costResource = buildingConfig.costResource

		if not string.nilorempty(costResource) then
			costResource = string.splitToNumber(costResource, "#")
			buildingConfigParam.costResource = costResource
		else
			buildingConfigParam.costResource = {}
		end

		local centerParam = buildingConfig.center

		if string.nilorempty(centerParam) then
			buildingConfigParam.centerPoint = HexPoint(0, 0)
		else
			centerParam = string.splitToNumber(centerParam, "#")
			buildingConfigParam.centerPoint = HexPoint(centerParam[1], centerParam[2])
		end

		buildingConfigParam.pointList = {}

		local buildingAreaConfig = RoomConfig.instance:getBuildingAreaConfig(buildingConfig.areaId)

		if not string.nilorempty(buildingAreaConfig.area) then
			local pointParamList = GameUtil.splitString2(buildingAreaConfig.area, true)

			for i, pointParam in ipairs(pointParamList) do
				local hexPoint = HexPoint(pointParam[1], pointParam[2])

				table.insert(buildingConfigParam.pointList, hexPoint)
			end
		end

		local tempResIdList = {}
		local tempPointDic = {}

		buildingConfigParam.crossloadResPointDic = tempPointDic
		buildingConfigParam.crossloadResIdList = tempResIdList

		if buildingConfig.crossload and buildingConfig.crossload ~= 0 and RoomBuildingEnum.Crossload[buildingId] then
			local crossCfg = RoomBuildingEnum.Crossload[buildingId]

			for i, coss in ipairs(crossCfg.AnimStatus) do
				table.insert(tempResIdList, coss.resId)

				for _, replaceRes in ipairs(coss.replaceBlockRes) do
					tempPointDic[replaceRes.x] = tempPointDic[replaceRes.x] or {}
					tempPointDic[replaceRes.x][replaceRes.y] = tempPointDic[replaceRes.x][replaceRes.y] or {}
					tempPointDic[replaceRes.x][replaceRes.y][coss.resId] = replaceRes.resPionts
				end
			end
		end

		local tempBlockDic = {}

		buildingConfigParam.replaceBlockDic = tempBlockDic
		buildingConfigParam.replaceBlockCount = 0

		if not string.nilorempty(buildingConfig.replaceBlock) then
			local blockParamList = GameUtil.splitString2(buildingConfig.replaceBlock, true)

			for i, blockParam in ipairs(blockParamList) do
				if #blockParam >= 3 then
					tempBlockDic[blockParam[1]] = tempBlockDic[blockParam[1]] or {}
					tempBlockDic[blockParam[1]][blockParam[2]] = blockParam[3]
					buildingConfigParam.replaceBlockCount = buildingConfigParam.replaceBlockCount + 1
				else
					logError(string.format("【小屋】建筑表中id:%s的[replaceBlack]字段配置有误", buildingId))
				end
			end
		end

		local tempCanPlaceBlockDic = {}

		buildingConfigParam.canPlaceBlockDic = tempCanPlaceBlockDic

		if not string.nilorempty(buildingConfig.canPlaceBlock) then
			local blockParamList = GameUtil.splitString2(buildingConfig.canPlaceBlock, true)

			for i, blockParam in ipairs(blockParamList) do
				if #blockParam >= 2 then
					tempCanPlaceBlockDic[blockParam[1]] = tempCanPlaceBlockDic[blockParam[1]] or {}
					tempCanPlaceBlockDic[blockParam[1]][blockParam[2]] = true
				else
					logError(string.format("【小屋】建筑表中id:%s的[canPlaceBlock]字段配置有误", buildingId))
				end
			end
		end

		local levelGroups = buildingConfig.levelGroups

		levelGroups = string.nilorempty(levelGroups) and {} or string.splitToNumber(levelGroups, "#")
		buildingConfigParam.levelGroups = levelGroups

		local offset = Vector3.zero

		if not string.nilorempty(buildingConfig.offset) then
			local offsetParam = string.splitToNumber(buildingConfig.offset, "#")

			offset = Vector3(offsetParam[1] or 0, offsetParam[2] or 0, offsetParam[3] or 0)
		end

		buildingConfigParam.offset = offset

		if #buildingConfigParam.pointList > 1 and buildingConfigParam.onlyDirection then
			logError("占多格的建筑配置了指定方向 约定没有这种情况")
		end

		self._buildingConfigParamDict[buildingId] = buildingConfigParam
	end

	return buildingConfigParam
end

function RoomMapModel:getBuildingPointList(buildingId, rotate)
	self._buildingRotatePointsDict = self._buildingRotatePointsDict or {}

	local rotateParams = self._buildingRotatePointsDict[buildingId]

	if not rotateParams then
		local params = self:getBuildingConfigParam(buildingId)

		if not params then
			return nil
		end

		rotateParams = {}
		self._buildingRotatePointsDict[buildingId] = rotateParams

		for ro = 0, 5 do
			rotateParams[ro] = self:_rotatePointList(params.pointList, params.centerPoint, ro)
		end
	end

	local tempRotate = RoomRotateHelper.getMod(rotate, 6)

	return rotateParams[tempRotate]
end

function RoomMapModel:_rotatePointList(hexPointList, centerPoint, rotate)
	local list = {}

	if rotate == 0 then
		tabletool.addValues(list, hexPointList)
	else
		for _, hexPoint in ipairs(hexPointList) do
			local worldHexPoint = hexPoint - centerPoint

			worldHexPoint = worldHexPoint:Rotate(HexPoint.Zero, rotate, true)

			table.insert(list, worldHexPoint)
		end
	end

	return list
end

function RoomMapModel:setOtherLineLevelDict(infos)
	self._otherLineLevelDict = {}

	if infos then
		for _, info in ipairs(infos) do
			self._otherLineLevelDict[info.id] = info.level
		end
	end
end

function RoomMapModel:getOtherLineLevelDict()
	return self._otherLineLevelDict
end

function RoomMapModel:getAllBuildDegree(temp)
	local buildDegreeInfoDict = {}
	local totalDegree = 0
	local blockDegreeInfo = {
		count = 0,
		degree = 0
	}

	totalDegree = totalDegree + RoomBlockEnum.InitBlockDegreeValue

	local blockMOList = RoomMapBlockModel.instance:getFullBlockMOList()

	for i, blockMO in ipairs(blockMOList) do
		if blockMO.blockState == RoomBlockEnum.BlockState.Map or blockMO.blockState == RoomBlockEnum.BlockState.Revert or temp and blockMO.blockState == RoomBlockEnum.BlockState.Temp then
			local blockId = blockMO.blockId
			local packageConfig = RoomConfig.instance:getPackageConfigByBlockId(blockId)

			if packageConfig then
				if not packageConfig.blockBuildDegree then
					local degree = 0

					totalDegree = totalDegree + degree
					blockDegreeInfo.count = blockDegreeInfo.count + (packageConfig and 1 or 0)
					blockDegreeInfo.degree = blockDegreeInfo.degree + degree
				end
			end
		end
	end

	local buildingMOList = RoomMapBuildingModel.instance:getList()

	for i, buildingMO in ipairs(buildingMOList) do
		if buildingMO.buildingState == RoomBuildingEnum.BuildingState.Map or buildingMO.buildingState == RoomBuildingEnum.BuildingState.Revert or temp and buildingMO.buildingState == RoomBuildingEnum.BuildingState.Temp then
			totalDegree = totalDegree + buildingMO.config.buildDegree
			buildDegreeInfoDict[buildingMO.buildingId] = buildDegreeInfoDict[buildingMO.buildingId] or {
				count = 0,
				config = buildingMO.config
			}
			buildDegreeInfoDict[buildingMO.buildingId].count = buildDegreeInfoDict[buildingMO.buildingId].count + 1
		end
	end

	local buildDegreeInfoList = {}

	for buildingId, buildDegreeInfo in pairs(buildDegreeInfoDict) do
		table.insert(buildDegreeInfoList, buildDegreeInfo)
	end

	return totalDegree, blockDegreeInfo, buildDegreeInfoList
end

function RoomMapModel:setRoomLeveling(roomLeveling)
	self._roomLeveling = roomLeveling
end

function RoomMapModel:isRoomLeveling()
	return self._roomLeveling
end

RoomMapModel.instance = RoomMapModel.New()

return RoomMapModel
