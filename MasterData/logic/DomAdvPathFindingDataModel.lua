-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/model/DomAdvPathFindingDataModel.lua

module("logic.extensions.domainadventure.model.DomAdvPathFindingDataModel", package.seeall)

local DomAdvPathFindingDataModel = class("DomAdvPathFindingDataModel", BaseModel)
local json = require("cjson")
local DirectionsEven = {
	{
		-1,
		0
	},
	{
		1,
		0
	},
	{
		0,
		-1
	},
	{
		0,
		1
	},
	{
		-1,
		-1
	},
	{
		1,
		-1
	}
}
local DirectionsOdd = {
	{
		-1,
		0
	},
	{
		1,
		0
	},
	{
		0,
		-1
	},
	{
		0,
		1
	},
	{
		-1,
		1
	},
	{
		1,
		1
	}
}
local AreaPerRow = 5
local AreaPerCol = 4

function DomAdvPathFindingDataModel:onInit()
	self:onReset()
end

function DomAdvPathFindingDataModel:onReset()
	self._halfCellSizeX, self._halfCellSizeY = 0, 0
	self._rows, self._cols = 0, 0
	self._gridCount = 0
	self._scenePreNum = 10
end

function DomAdvPathFindingDataModel:reload(activityId)
	self:onReset()

	local mapJson = DomainAdventureConfig.instance:getMapJson(activityId)
	local data = json.decode(mapJson)

	self._rows, self._cols = data.rows, data.cols
	self._gridCount = self._rows * self._cols
	self._halfCellSizeX, self._halfCellSizeY = data.cellSizeX * 0.5, data.cellSizeY * 0.5

	local str = tostring(self._rows * self._cols)

	self._scenePreNum = math.pow(10, #str + 1)

	local mapCfg = DomainAdventureConfig.instance:getMapCfg(activityId)

	self._relBlockIdFatherDic = {}
	self._occUnlockBlockIdFatherDic = {}

	for blockId, data in pairs(mapCfg or {}) do
		for _, v in ipairs(data.relationBlockIds or {}) do
			self._relBlockIdFatherDic[v] = self._relBlockIdFatherDic[v] or {}

			table.insert(self._relBlockIdFatherDic[v], blockId)
		end

		for _, v in ipairs(data.occupiedUnlockBlocks or {}) do
			self._occUnlockBlockIdFatherDic[v] = self._occUnlockBlockIdFatherDic[v] or {}

			table.insert(self._occUnlockBlockIdFatherDic[v], blockId)
		end
	end

	print("===??? DomAdvPathFindingDataModel:reload")
end

function DomAdvPathFindingDataModel:getSceneGridsDimension()
	return self._rows, self._cols
end

function DomAdvPathFindingDataModel:getGridCount()
	return self._gridCount
end

function DomAdvPathFindingDataModel:getScenePreNum()
	return self._scenePreNum
end

function DomAdvPathFindingDataModel:getCellRowAndColIndexByElementId(elementId)
	local idx = self:getGridIdByElementId(elementId)
	local row = math.floor(idx / self._cols)
	local col = math.floor(idx % self._cols)

	return row, col
end

function DomAdvPathFindingDataModel:getGridIdByElementId(elementId)
	return elementId % self._scenePreNum
end

function DomAdvPathFindingDataModel:getLayerNumByElementId(elementId)
	return math.floor(elementId / self._scenePreNum)
end

function DomAdvPathFindingDataModel:getElementIdByGridId(layer, gridId)
	return self._scenePreNum * layer + gridId
end

function DomAdvPathFindingDataModel:pos2Grid(posX, posY)
	local gridX = math.round(posX / (1.5 * self._halfCellSizeX))
	local gridY = math.round((posY - gridX % 2 * self._halfCellSizeY) / (self._halfCellSizeY * 2))

	return gridX, gridY
end

function DomAdvPathFindingDataModel:pos2Id(posX, posY)
	return self:grid2Id(self:pos2Grid(posX, posY))
end

function DomAdvPathFindingDataModel:grid2Pos(gridX, gridY)
	local posX = gridX * self._halfCellSizeX * 1.5
	local posY = gridX % 2 * self._halfCellSizeY + gridY * self._halfCellSizeY * 2

	return posX, posY
end

function DomAdvPathFindingDataModel:grid2Id(gridX, gridY)
	return gridX * self._cols + gridY
end

function DomAdvPathFindingDataModel:id2Grid(id)
	local gridX = math.floor(id / self._cols)
	local gridY = id % self._cols

	return gridX, gridY
end

function DomAdvPathFindingDataModel:getAdjacentGridIds(gridId, range)
	range = Mathf.Max(checknumber(range), 1)

	local gridX, gridY = self:id2Grid(gridId)
	local queue = {
		{
			dist = 0,
			x = gridX,
			y = gridY
		}
	}
	local visited = {}
	local adjacentGrids = {
		gridId
	}

	while #queue > 0 do
		local node = table.remove(queue, 1)
		local x, y, dist = node.x, node.y, node.dist

		if range < dist then
			break
		end

		local id = self:grid2Id(x, y)

		if not visited[id] then
			visited[id] = true

			if dist > 0 then
				table.insert(adjacentGrids, id)
			end

			if x % 2 == 0 then
				if not DirectionsEven then
					local directions = DirectionsOdd

					for _, dir in ipairs(directions) do
						local adjX, adjY = x + dir[1], y + dir[2]

						if adjX >= 0 and adjX < self._cols and adjY >= 0 and adjY < self._rows then
							table.insert(queue, {
								x = adjX,
								y = adjY,
								dist = dist + 1
							})
						end
					end
				end
			end
		end
	end

	return adjacentGrids
end

function DomAdvPathFindingDataModel:isInRangeById(gridId)
	local gridX, gridY = self:id2Grid(gridId)

	return gridX >= 0 and gridX < self._cols and gridY >= 0 and gridY < self._rows
end

function DomAdvPathFindingDataModel:getAreaCount()
	local x = math.ceil(self._rows / AreaPerRow)
	local y = math.ceil(self._cols / AreaPerCol)

	return x * y
end

function DomAdvPathFindingDataModel:getAreaXY(areaId)
	local areaX = math.floor(areaId / math.ceil(self._cols / AreaPerCol)) + 1
	local areaY = areaId - (areaX - 1) * math.ceil(self._cols / AreaPerCol)

	return areaX, areaY
end

function DomAdvPathFindingDataModel:getAreaIdByXY(areaX, areaY)
	return (areaX - 1) * math.ceil(self._cols / AreaPerCol) + areaY
end

function DomAdvPathFindingDataModel:getAreaId(gridId)
	local x, y = self:id2Grid(gridId)
	local rows, cols = self._rows, self._cols
	local areaX = math.ceil((x + 1) / AreaPerRow)
	local areaY = math.ceil((y + 1) / AreaPerCol)

	return (self:getAreaIdByXY(areaX, areaY))
end

function DomAdvPathFindingDataModel:getAdjacentAreaIds(areaId)
	local rows, cols = self._rows, self._cols
	local areaX, areaY = self:getAreaXY(areaId)
	local maxAreaRow = math.ceil(rows / AreaPerRow)
	local maxAreaCol = math.ceil(cols / AreaPerCol)
	local adjacentAreaIds = {
		areaId
	}

	local function addAdjacentArea(x, y)
		if x >= 1 and x <= maxAreaRow and y >= 1 and y <= maxAreaCol then
			local aId = self:getAreaIdByXY(x, y)

			table.insert(adjacentAreaIds, self:getAreaIdByXY(x, y))
		end
	end

	addAdjacentArea(areaX + 0, areaY + 1)
	addAdjacentArea(areaX + 1, areaY + 1)
	addAdjacentArea(areaX + 1, areaY + 0)
	addAdjacentArea(areaX + 1, areaY - 1)
	addAdjacentArea(areaX - 0, areaY - 1)
	addAdjacentArea(areaX - 1, areaY - 1)
	addAdjacentArea(areaX - 1, areaY - 0)
	addAdjacentArea(areaX - 1, areaY + 1)

	return adjacentAreaIds
end

function DomAdvPathFindingDataModel:getGridIds(areaId)
	local areaX, areaY = self:getAreaXY(areaId)
	local startX = (areaX - 1) * AreaPerRow
	local endX = math.min(areaX * AreaPerRow, self._rows) - 1
	local startY = (areaY - 1) * AreaPerCol
	local endY = math.min(areaY * AreaPerCol, self._cols) - 1
	local gridIds = {}

	for x = startX, endX do
		for y = startY, endY do
			table.insert(gridIds, self:grid2Id(x, y))
		end
	end

	return gridIds
end

function DomAdvPathFindingDataModel:getRelFatherOccIds(gridId)
	return self._relBlockIdFatherDic[gridId]
end

function DomAdvPathFindingDataModel:getSealFatherOccIds(gridId)
	return self._occUnlockBlockIdFatherDic[gridId]
end

DomAdvPathFindingDataModel.instance = DomAdvPathFindingDataModel.New()

return DomAdvPathFindingDataModel
