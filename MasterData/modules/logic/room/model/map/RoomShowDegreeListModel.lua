-- chunkname: @modules/logic/room/model/map/RoomShowDegreeListModel.lua

module("modules.logic.room.model.map.RoomShowDegreeListModel", package.seeall)

local RoomShowDegreeListModel = class("RoomShowDegreeListModel", ListScrollModel)

function RoomShowDegreeListModel:onInit()
	self:clear()
end

function RoomShowDegreeListModel:reInit()
	self:clear()
end

function RoomShowDegreeListModel:setShowDegreeList(temp)
	local showMOList = {}
	local showMODict = {}
	local blockDegreeId = -1001
	local bshowDegreeMO = self:getById(blockDegreeId) or RoomShowDegreeMO.New()

	bshowDegreeMO:init(blockDegreeId, 1)
	table.insert(showMOList, bshowDegreeMO)

	local blockMOList = RoomMapBlockModel.instance:getFullBlockMOList()
	local tRoomConfig = RoomConfig.instance

	for i, blockMO in ipairs(blockMOList) do
		if blockMO.blockState == RoomBlockEnum.BlockState.Map or blockMO.blockState == RoomBlockEnum.BlockState.Revert or temp and blockMO.blockState == RoomBlockEnum.BlockState.Temp then
			local packageConfig = tRoomConfig:getPackageConfigByBlockId(blockMO.blockId)

			if packageConfig then
				if not packageConfig.blockBuildDegree then
					local degree = 0

					bshowDegreeMO.degree = bshowDegreeMO.degree + degree
					bshowDegreeMO.count = bshowDegreeMO.count + (packageConfig and 1 or 0)
				end
			end
		end
	end

	bshowDegreeMO.degree = bshowDegreeMO.degree + RoomBlockEnum.InitBlockDegreeValue

	local buildingMOList = RoomMapBuildingModel.instance:getList()

	for i, buildingMO in ipairs(buildingMOList) do
		if buildingMO.buildingState == RoomBuildingEnum.BuildingState.Map or buildingMO.buildingState == RoomBuildingEnum.BuildingState.Revert or temp and buildingMO.buildingState == RoomBuildingEnum.BuildingState.Temp then
			local showDegreeMO = showMODict[buildingMO.buildingId]

			if not showDegreeMO then
				showDegreeMO = self:getById(buildingMO.buildingId) or RoomShowDegreeMO.New()

				showDegreeMO:init(buildingMO.buildingId, 2, buildingMO.config.name)

				showMODict[buildingMO.buildingId] = showDegreeMO

				table.insert(showMOList, showDegreeMO)
			end

			showDegreeMO.count = showDegreeMO.count + 1
			showDegreeMO.degree = showDegreeMO.degree + buildingMO.config.buildDegree
		end
	end

	table.sort(showMOList, self._sortFunction)
	self:setList(showMOList)
end

function RoomShowDegreeListModel._sortFunction(x, y)
	if x.degreeType ~= y.degreeType then
		return x.degreeType < y.degreeType
	end

	if x.degree ~= y.degree then
		return x.degree > y.degree
	end
end

RoomShowDegreeListModel.instance = RoomShowDegreeListModel.New()

return RoomShowDegreeListModel
