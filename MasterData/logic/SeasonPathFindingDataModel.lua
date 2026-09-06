-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonPathFindingDataModel.lua

module("logic.extensions.season.model.SeasonPathFindingDataModel", package.seeall)

local SeasonPathFindingDataModel = class("SeasonPathFindingDataModel", BaseModel)
local json = require("cjson")

function SeasonPathFindingDataModel:onInit()
	self:onReset()
end

function SeasonPathFindingDataModel:onReset()
	self._pathFindingData = nil
	self._grid2IdCache = {}
	self._id2GridCache = {}
end

function SeasonPathFindingDataModel:reload(mapJson)
	self:onReset()
	self:_decodePathFindingData(mapJson)
	self:_initPathFinder()
end

function SeasonPathFindingDataModel:_decodePathFindingData(mapJson)
	self._pathFindingData = json.decode(mapJson)
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
		local occupiedData = {}
		local occArray

		for i = 1, self._rows do
			array = {}
			data[i - 1] = array
			occArray = {}
			occupiedData[i - 1] = occArray

			for j = 1, self._cols do
				blockType = grids[(i - 1) * self._cols + j] > 0 and LuaPathfinder_Const.BlockType_None or LuaPathfinder_Const.BlockType_Wall
				array[j - 1] = {
					weight = 20,
					x = i - 1,
					y = j - 1,
					blockType = blockType
				}
				occArray[j - 1] = {
					x = i - 1,
					y = j - 1,
					blockType = LuaPathfinder_Const.BlockType_Wall
				}
			end
		end

		self._pathFindingGridData = data
		self._pathFindingGridDataOccupied = occupiedData
	end

	return self._pathFindingData
end

function SeasonPathFindingDataModel:_initPathFinder()
	self._internalFinder = LuaAStarPathfinder.New()
	self._internalFinderWithOccupied = LuaAStarPathfinder.New()

	local rows, cols = self:getSceneGridsDimension()
	local data = self:getScenePathFindingGridData()

	if rows > 0 and cols > 0 and data then
		self._internalFinder:reload(data, rows, cols, LuaPathfinder_Const.CostFlag_Dir_8to6, LuaPathfinder_Const.HeuristicFlag_Manhattan)
		self._internalFinderWithOccupied:reload(self._pathFindingGridDataOccupied, rows, cols, LuaPathfinder_Const.CostFlag_Dir_8to6, LuaPathfinder_Const.HeuristicFlag_Manhattan)
		SeasonController.instance:updatePathGridDataOccupied()
	end
end

function SeasonPathFindingDataModel:getPathByOccupied(gridStartX, gridStartY, gridEndX, gridEndY)
	local gridPathTo
	local rows, cols = self:getSceneGridsDimension()

	if rows > 0 and cols > 0 then
		local startNode = self._internalFinderWithOccupied:getNode(gridStartX, gridStartY)
		local endNode = self._internalFinderWithOccupied:getNode(gridEndX, gridEndY)

		if startNode and endNode then
			local blockType = endNode.blockType

			endNode.blockType = LuaPathfinder_Const.BlockType_None
			gridPathTo = self._internalFinderWithOccupied:search(startNode, endNode)
			endNode.blockType = blockType
		end
	end

	return gridPathTo
end

function SeasonPathFindingDataModel:printData()
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

function SeasonPathFindingDataModel:getSceneGridsDimension()
	if not self._pathFindingData then
		return 1, 1
	end

	return self._pathFindingData.rows, self._pathFindingData.cols
end

function SeasonPathFindingDataModel:getScenePreNum()
	return self._scenePreNum
end

function SeasonPathFindingDataModel:getSceneGridsData()
	if self._pathFindingData then
		return self._pathFindingData.grids
	end
end

function SeasonPathFindingDataModel:getSceneGridVersion()
	if self._pathFindingData then
		return self._pathFindingData.exportTime
	end
end

function SeasonPathFindingDataModel:getScenePathFindingGridData()
	return self._pathFindingGridData
end

function SeasonPathFindingDataModel:setPathDataGridCanMoveById(id, isCanMove, weight)
	local row, col = self:id2Grid(id)

	if row and col then
		self:setPathDataGridCanMove(row, col, isCanMove, weight)
	end
end

function SeasonPathFindingDataModel:setPathDataGridCanMove(row, col, isCanMove, weight)
	if self._internalFinder then
		local node = self._internalFinder:getNode(row, col)

		if node and isCanMove then
			node.weight = weight
		end
	end

	if self._internalFinderWithOccupied then
		local node = self._internalFinderWithOccupied:getNode(row, col)

		if node then
			local blockType

			node.blockType = isCanMove and LuaPathfinder_Const.BlockType_None or LuaPathfinder_Const.BlockType_Wall
		end
	end
end

function SeasonPathFindingDataModel:getInternalPathFinder()
	return self._internalFinder
end

function SeasonPathFindingDataModel:getCellRowAndColIndexByPosition(x, y)
	local row, col = self:pos2Grid(x, y)

	return row or 0, col or 0
end

function SeasonPathFindingDataModel:getCellRowAndColIndexByElementId(elementId)
	local idx = self:getGridIdByElementId(elementId)
	local rows, cols = self:getSceneGridsDimension()
	local row = math.floor(idx / cols)
	local col = math.floor(idx % cols)

	return row, col
end

function SeasonPathFindingDataModel:getGridIdByElementId(elementId)
	local preNum = self:getScenePreNum()

	return elementId % preNum
end

function SeasonPathFindingDataModel:getLayerNumByElementId(elementId)
	local preNum = self:getScenePreNum()

	return (math.floor(elementId / preNum))
end

function SeasonPathFindingDataModel:getElementIdByGridId(layer, gridId)
	local preNum = self:getScenePreNum()

	return preNum * layer + gridId
end

function SeasonPathFindingDataModel:pos2Grid(posX, posY)
	if self._pathFindingData then
		local gridX = posX / (1.5 * self._halfCellSizeX)

		gridX = math.round(gridX)

		local gridY = (posY - gridX % 2 * self._halfCellSizeY) / (self._halfCellSizeY * 2)

		return gridX, math.round(gridY)
	end
end

function SeasonPathFindingDataModel:grid2Pos(gridX, gridY)
	if self._pathFindingData then
		local gridXT, gridYT = gridX, gridY
		local posX = gridXT * self._halfCellSizeX * 1.5
		local posY = gridXT % 2 * self._halfCellSizeY + gridYT * self._halfCellSizeY * 2

		return posX, posY
	end
end

function SeasonPathFindingDataModel:grid2Id(gridX, gridY)
	if self._grid2IdCache[gridX] and self._grid2IdCache[gridX][gridY] then
		return self._grid2IdCache[gridX][gridY]
	end

	local _, cols = self:getSceneGridsDimension()
	local id = gridX * cols + gridY

	self._grid2IdCache[gridX] = self._grid2IdCache[gridX] or {}
	self._grid2IdCache[gridX][gridY] = id

	return id
end

function SeasonPathFindingDataModel:id2Grid(id)
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

function SeasonPathFindingDataModel:isWalkable(x, y)
	local gridX, gridY = self:pos2Grid(x, y)

	return self:isGridWalkable(gridX, gridY)
end

function SeasonPathFindingDataModel:isGridWalkable(gridX, gridY)
	local node = self._internalFinder:getNode(gridX, gridY)

	if node == nil then
		printError(">>>>>>>>>>>>>>>>>>>>>>>>> 找不到格子：", gridX, gridY)
	end

	return node and self._internalFinder:isWalkable(node)
end

SeasonPathFindingDataModel.instance = SeasonPathFindingDataModel.New()

return SeasonPathFindingDataModel
