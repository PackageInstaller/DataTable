-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/model/TreasureRaiderSceneModel.lua

module("logic.extensions.treasureraider.model.TreasureRaiderSceneModel", package.seeall)

local TreasureRaiderSceneModel = class("TreasureRaiderSceneModel", BaseModel)

function TreasureRaiderSceneModel:ctor()
	self:onReset()
end

function TreasureRaiderSceneModel:onInit()
	self:onReset()
end

function TreasureRaiderSceneModel:onReset()
	self._pathFindingData = nil
	self._buildingSlotMap = {}
	self._buildingSlots = {}
	self._grid2IdCache = {}
	self._id2GridCache = {}
	self._grid2PosCache = {}
	self._mapCenterCache = nil
	self._isInited = false
	self._internalFinder = nil
end

function TreasureRaiderSceneModel:initAll()
	if not self._isInited then
		self._isInited = true
		self._grid2IdCache = {}
		self._id2GridCache = {}
		self._grid2PosCache = {}

		self:_initBuildingData()
		self:_decodePathFindingData()
		self:_initPathFinder()
	end
end

function TreasureRaiderSceneModel:_initBuildingData()
	local config = TreasureRaiderConfig.instance:getPathConfig()
	local buildingGridIds = config.buildingGridIds

	self._buildingSlotMap = {}
	self._buildingSlots = {}

	for _, v in ipairs(buildingGridIds) do
		self._buildingSlotMap[v] = true

		table.insert(self._buildingSlots, v)
	end
end

function TreasureRaiderSceneModel:_decodePathFindingData()
	local config = TreasureRaiderConfig.instance:getPathConfig()

	self._pathFindingData = config.mapJson
	self._scenePreNum = 10

	if self._pathFindingData then
		self._rows, self._cols = self._pathFindingData.rows, self._pathFindingData.cols
		self._halfCellSizeX, self._halfCellSizeY = self._pathFindingData.cellSizeX * 0.5, self._pathFindingData.cellSizeY * 0.5

		local rows, cols = self._pathFindingData.rows, self._pathFindingData.cols
		local str = tostring(rows * cols)
		local len = #str

		self._scenePreNum = math.pow(10, len + 1)
	end

	local grids = self:getSceneGridsData()

	if self._rows > 0 and self._cols > 0 and grids then
		local blockType, array, index
		local data = {}

		for i = 1, self._rows do
			array = {}
			data[i - 1] = array

			for j = 1, self._cols do
				blockType = grids[(i - 1) * self._cols + j] > 0 and LuaPathfinder_Const.BlockType_None or LuaPathfinder_Const.BlockType_Wall
				array[j - 1] = {
					x = i - 1,
					y = j - 1,
					blockType = blockType
				}
			end
		end

		self._pathFindingGridData = data
	end
end

function TreasureRaiderSceneModel:_initPathFinder()
	local rows, cols = self:getSceneGridsDimension()
	local data = self:getScenePathFindingGridData()

	self._internalFinder = LuaAStarPathfinder.New()

	self._internalFinder:reload(data, rows, cols, LuaPathfinder_Const.CostFlag_Dir_8to6, LuaPathfinder_Const.HeuristicFlag_Manhattan)

	local grids = self:getSceneGridsData()

	if rows > 0 and cols > 0 and grids then
		local x, y, index

		for i = 1, rows do
			for j = 1, cols do
				if grids[(i - 1) * cols + j] == 18 then
					self._internalFinder:setBlockState(i - 1, j - 1, true)
				end
			end
		end
	end
end

function TreasureRaiderSceneModel:printData()
	local grids = self:getSceneGridsData()
	local title = "\t"

	for i = 0, self._cols - 1 do
		title = string.format("%s\t%s", title, i)
	end

	print(title)

	local index

	for i = 1, self._rows do
		local str = "\t" .. i - 1

		for j = 1, self._cols do
			str = string.format("%s\t%s", str, grids[(i - 1) * self._cols + j])
		end

		printInfo(str)
	end
end

function TreasureRaiderSceneModel:getSceneGridsDimension()
	if not self._pathFindingData then
		return 1, 1
	end

	return self._pathFindingData.rows, self._pathFindingData.cols
end

function TreasureRaiderSceneModel:getScenePreNum()
	return self._scenePreNum
end

function TreasureRaiderSceneModel:getSceneGridsData()
	if self._pathFindingData then
		return self._pathFindingData.grids
	end
end

function TreasureRaiderSceneModel:getSceneGridVersion()
	if self._pathFindingData then
		return self._pathFindingData.exportTime
	end
end

function TreasureRaiderSceneModel:getScenePathFindingGridData()
	return self._pathFindingGridData
end

function TreasureRaiderSceneModel:pos2Grid(posX, posY)
	local gridX = posX / (1.5 * self._halfCellSizeX)

	gridX = math.round(gridX)

	local gridY = (posY - gridX % 2 * self._halfCellSizeY) / (self._halfCellSizeY * 2)

	return gridX, math.round(gridY)
end

function TreasureRaiderSceneModel:grid2Pos(gridX, gridY)
	if self._grid2PosCache[gridX] and self._grid2PosCache[gridX][gridY] then
		return self._grid2PosCache[gridX][gridY][1], self._grid2PosCache[gridX][gridY][2]
	end

	local gridXT, gridYT = gridX, gridY
	local posX = gridXT * self._halfCellSizeX * 1.5
	local posY = gridXT % 2 * self._halfCellSizeY + gridYT * self._halfCellSizeY * 2

	self._grid2PosCache[gridX] = self._grid2PosCache[gridX] or {}
	self._grid2PosCache[gridX][gridY] = {
		posX,
		posY
	}

	return posX, posY
end

function TreasureRaiderSceneModel:grid2Id(gridX, gridY)
	if self._grid2IdCache[gridX] and self._grid2IdCache[gridX][gridY] then
		return self._grid2IdCache[gridX][gridY]
	end

	local _, cols = self:getSceneGridsDimension()
	local id = gridX * cols + gridY

	self._grid2IdCache[gridX] = self._grid2IdCache[gridX] or {}
	self._grid2IdCache[gridX][gridY] = id

	return id
end

function TreasureRaiderSceneModel:id2Grid(id)
	if self._id2GridCache[id] then
		return self._id2GridCache[id][1], self._id2GridCache[id][2]
	end

	local _, cols = self:getSceneGridsDimension()
	local gridX = math.floor(id / cols)
	local gridY = id % cols

	self._id2GridCache[id] = {
		gridX,
		gridY
	}

	return gridX, gridY
end

function TreasureRaiderSceneModel:id2Pos(id)
	local gridX, gridY = self:id2Grid(id)
	local posX, posY = self:grid2Pos(gridX, gridY)

	return posX, posY
end

function TreasureRaiderSceneModel:pos2Id(posX, posY)
	local gridX, gridY = self:pos2Grid(posX, posY)

	return self:grid2Id(gridX, gridY)
end

function TreasureRaiderSceneModel:getCellRowAndColIndexByPosition(x, y)
	local row, col = self:pos2Grid(x, y)

	return row or 0, col or 0
end

function TreasureRaiderSceneModel:getCellRowAndColIndexByElementId(elementId)
	local idx = self:getGridIdByElementId(elementId)
	local row, col = self:id2Grid(idx)

	return row, col
end

function TreasureRaiderSceneModel:getGridIdByElementId(elementId)
	local preNum = self:getScenePreNum()

	return elementId % preNum
end

function TreasureRaiderSceneModel:getLayerNumByElementId(elementId)
	local preNum = self:getScenePreNum()

	return (math.floor(elementId / preNum))
end

function TreasureRaiderSceneModel:getElementIdByGridId(layer, gridId)
	local preNum = self:getScenePreNum()

	return preNum * layer + gridId
end

function TreasureRaiderSceneModel:isGridWalkableByGridXY(gridX, gridY)
	local node = self._internalFinder:getNode(gridX, gridY)

	return self._internalFinder:isValid(node) and self._internalFinder:isWalkable(node)
end

function TreasureRaiderSceneModel:isGridWalkableByGridId(gridId)
	local gridX, gridY = self:id2Grid(gridId)

	return self:isGridWalkableByGridXY(gridX, gridY)
end

function TreasureRaiderSceneModel:isClickableByGridXY(gridX, gridY)
	local node = self._internalFinder:getNode(gridX, gridY)

	return self._internalFinder:isValid(node) and node.blockType == LuaPathfinder_Const.BlockType_None
end

function TreasureRaiderSceneModel:isClickableByGridId(gridId)
	local gridX, gridY = self:id2Grid(gridId)

	return self:isClickableByGridXY(gridX, gridY)
end

function TreasureRaiderSceneModel:isClosestByGridXY(fromGridX, fromGridY, toGridX, toGridY)
	local fromNode = self._internalFinder:getNode(fromGridX, fromGridY)
	local toNode = self._internalFinder:getNode(toGridX, toGridY)

	return self._internalFinder:isReachableIgnoreWalkable(fromNode, toNode) and self._internalFinder:isNeighbour(fromNode, toNode)
end

function TreasureRaiderSceneModel:isClosestByGridId(fromGridId, toGridId)
	local fromGridX, fromGridY = self:id2Grid(fromGridId)
	local toGridX, toGridY = self:id2Grid(toGridId)

	return self:isClosestByGridXY(fromGridX, fromGridY, toGridX, toGridY)
end

function TreasureRaiderSceneModel:isBuildingSlot(gridId)
	return self._buildingSlotMap[gridId]
end

function TreasureRaiderSceneModel:getPathFinder()
	return self._internalFinder
end

function TreasureRaiderSceneModel:isGridDisableToEditAndShowTips(gridId, bTarget, bIgnoreTips)
	local bDisableEdit = TreasureRaiderConfig.instance:isGridDisableToEdit(gridId)

	if bDisableEdit and not bIgnoreTips then
		if bTarget then
			FloatWordMgr.instance:show(lang("当前建筑不可放置在这里哦"))
		else
			FloatWordMgr.instance:show(lang("该地方为不可编辑区域"))
		end
	end

	return bDisableEdit
end

function TreasureRaiderSceneModel:getCenterPosByIds(ids)
	local len = #ids
	local totalX = 0
	local totalY = 0

	for i, v in ipairs(ids) do
		local posX, posY = self:id2Pos(v)

		totalX = totalX + posX
		totalY = totalY + posY
	end

	return totalX / len, totalY / len
end

function TreasureRaiderSceneModel:getMapCenterPos()
	if not self._mapCenterCache then
		local config = TreasureRaiderConfig.instance:getPathConfig()
		local posX, posY = self:getCenterPosByIds(config.movePathGridIds)

		self._mapCenterCache = {
			posX = posX,
			posY = posY
		}
	end

	return self._mapCenterCache.posX, self._mapCenterCache.posY
end

function TreasureRaiderSceneModel:getCameraMapCenterPos()
	local posX, posY = self:getMapCenterPos()

	return posX, posY + 0.25
end

function TreasureRaiderSceneModel:getNeighbourBuildingCenter(gridId)
	local gridX, gridY = self:id2Grid(gridId)
	local currentNode = self._internalFinder:getNode(gridX, gridY)
	local x, y, direction, node, id
	local directions = LuaPathfinder_Const.Directions
	local array = {}

	for i = 1, #directions do
		id = self:grid2Id(currentNode.x + directions[i][1], currentNode.y + directions[i][2])

		if self._internalFinder:isReachableIgnoreWalkable(currentNode, (self._internalFinder:getNode(currentNode.x + directions[i][1], currentNode.y + directions[i][2]))) and self:isBuildingSlot(id) then
			table.insert(array, id)
		end
	end

	local posX, posY = self:getCenterPosByIds(array)

	return posX, posY
end

function TreasureRaiderSceneModel:getCurGridNeighbourBuildingSlot(gridId)
	local gridX, gridY = self:id2Grid(gridId)
	local currentNode = self._internalFinder:getNode(gridX, gridY)
	local x, y, direction, node, id
	local directions = LuaPathfinder_Const.Directions
	local array = {}
	local controller = TRPopMenuController.instance

	for i = 1, #directions do
		id = self:grid2Id(currentNode.x + directions[i][1], currentNode.y + directions[i][2])

		if self._internalFinder:isReachableIgnoreWalkable(currentNode, (self._internalFinder:getNode(currentNode.x + directions[i][1], currentNode.y + directions[i][2]))) and self:isBuildingSlot(id) then
			local opTypes = controller:getOpGroups(nil, nil, nil, nil, id)

			if #opTypes > 0 then
				table.insert(array, {
					currentNode.x + directions[i][1],
					currentNode.y + directions[i][2],
					id,
					i
				})
			end
		end
	end

	return array
end

function TreasureRaiderSceneModel:isBuildingCanUpgrade(buildingMo)
	local buildingConfig = TreasureRaiderConfig.instance:getBuildingConfig(buildingMo.buildingId)
	local bCanUpgrade = false
	local upgradeConfigs

	if checknumber(buildingConfig.buffPlanId) > 0 then
		local buffConfigs = TreasureRaiderConfig.instance:getBuildingBuffByPlanId(buildingConfig.buffPlanId)

		if buffConfigs[buildingMo.buildingLevel + 1] then
			bCanUpgrade = true
			upgradeConfigs = buffConfigs
		end
	end

	if not bCanUpgrade and checknumber(buildingConfig.srcPlanId) > 0 then
		local resourceConfigs = TreasureRaiderConfig.instance:getResourcePlanConfigs(buildingConfig.srcPlanId)

		if resourceConfigs[buildingMo.buildingLevel + 1] then
			bCanUpgrade = true
			upgradeConfigs = resourceConfigs
		end
	end

	return bCanUpgrade, upgradeConfigs, buildingConfig
end

function TreasureRaiderSceneModel:isGridDisableToEdit(gridId, buildingPlanId, activityId)
	return TreasureRaiderConfig.instance:isGridDisableToEdit(gridId, buildingPlanId, activityId)
end

function TreasureRaiderSceneModel:isMovePathGrid(gridId, mapPlanId, activityId)
	return TreasureRaiderConfig.instance:isMovePathGrid(gridId, mapPlanId, activityId)
end

function TreasureRaiderSceneModel:getBuildingConfigMapByAllTypes(activityId)
	return TreasureRaiderConfig.instance:getBuildingConfigMapByAllTypes(activityId)
end

TreasureRaiderSceneModel.instance = TreasureRaiderSceneModel.New()

return TreasureRaiderSceneModel
