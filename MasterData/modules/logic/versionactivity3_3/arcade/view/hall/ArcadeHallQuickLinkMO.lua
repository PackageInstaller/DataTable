-- chunkname: @modules/logic/versionactivity3_3/arcade/view/hall/ArcadeHallQuickLinkMO.lua

module("modules.logic.versionactivity3_3.arcade.view.hall.ArcadeHallQuickLinkMO", package.seeall)

local ArcadeHallQuickLinkMO = pureTable("ArcadeHallQuickLinkMO")

function ArcadeHallQuickLinkMO:initMo()
	local mos = ArcadeHallModel.instance:getInteractiveMOs()

	self._gridMosDict = {}
	self._gridMosList = {}

	local maxGrid = ArcadeHallModel.instance:getHallGridSize()

	for i = 1, maxGrid[1] do
		self._gridMosDict[i] = {}

		for j = 1, maxGrid[2] do
			local grid = {
				hexPoint = {
					x = i,
					y = j
				}
			}

			self._gridMosDict[i][j] = grid

			table.insert(self._gridMosList, grid)
		end
	end

	self._buildingGridDict = {}

	for buidlingId, mo in pairs(mos) do
		local minPosX, minPosY, maxPosX, maxPosY = mo:gridRange()

		self._buildingGridDict[buidlingId] = {}

		for i = minPosX, maxPosX do
			for j = minPosY, maxPosY do
				local _mo = self:_getGridMo(i, j)

				if _mo then
					table.insert(self._buildingGridDict[buidlingId], _mo)
				end
			end
		end
	end
end

function ArcadeHallQuickLinkMO:findPath(buidlingId, initX, initY)
	self._buildingId = buidlingId
	self._orginGrid = self:_getGridMo(initX, initY)

	if self:_isBuildingGrid(self._orginGrid) then
		return
	end

	self._buildingGridMo = self._buildingGridDict[self._buildingId]
	self._pathGridList = {}

	for i, _ in ipairs(self._buildingGridMo) do
		self:_findBuildingPath(i)
	end

	local neareastIndex, neareastCount

	for i, list in pairs(self._pathGridList) do
		if not neareastCount or list.linkList and #list.linkList > 0 and neareastCount > #list.linkList then
			neareastIndex = i
			neareastCount = #list.linkList
		end
	end

	local list = self._pathGridList[neareastIndex]

	if list and list.linkList then
		table.remove(list.linkList, 1)

		return list.linkList
	end
end

function ArcadeHallQuickLinkMO:_findBuildingPath(index)
	self._findCount = 0
	self._pathGridList[index] = {}
	self._pathGridList[index].closeList = {}
	self._pathGridList[index].openList = {}
	self._pathGridList[index].linkList = {}
	self._orginGrid.orginGrid = nil
	self._orginGrid.f = 0
	self._orginGrid.g = 0
	self._orginGrid.h = 0

	table.insert(self._pathGridList[index].closeList, self._orginGrid)
	self:_checkGrid(self._orginGrid, index)
end

function ArcadeHallQuickLinkMO:_checkGrid(orginGrid, index)
	local list = self._pathGridList[index]
	local targetMo = self._buildingGridMo[index]

	self:_findNearLyNodeToOpenList(orginGrid, index)

	if list.openList and #list.openList == 0 then
		table.remove(self._pathGridList, index)

		return
	end

	self._findCount = self._findCount + 1

	if self._findCount > #self._gridMosList then
		table.remove(self._pathGridList, index)

		return
	end

	table.sort(list.openList, self.sortOpen)

	local gridMo = list.openList[1]

	table.insert(list.closeList, gridMo)
	table.remove(list.openList, 1)

	if self:_isSameGrid(gridMo, targetMo) then
		table.insert(list.linkList, gridMo.hexPoint)
		self:_calculatePath(gridMo, index)

		return
	end

	self:_checkGrid(gridMo, index)
end

function ArcadeHallQuickLinkMO:_findNearLyNodeToOpenList(orginGrid, index)
	local targetMo = self._buildingGridMo[index]

	if self:_isSameGrid(orginGrid, targetMo) then
		table.insert(self._pathGridList[index].openList, orginGrid)

		return
	end

	local x, y = orginGrid.hexPoint.x, orginGrid.hexPoint.y

	for i = 1, 4 do
		local dirHexPoint = ArcadeHallEnum.Directions[i]
		local gridX = x + dirHexPoint.x
		local gridY = y + dirHexPoint.y
		local gridMo = self:_isLegal(gridX, gridY, index)

		if gridMo then
			gridMo.orginGrid = orginGrid
			gridMo.g = (orginGrid.g or 0) + 1

			if targetMo ~= gridMo then
				local dis = math.abs(targetMo.hexPoint.x - gridX) + math.abs(targetMo.hexPoint.y - gridY)

				if not gridMo.dis or dis < gridMo.dis then
					gridMo.h = dis
				end
			end

			gridMo.f = gridMo.g + (gridMo.h or 0)

			table.insert(self._pathGridList[index].openList, gridMo)
		end
	end
end

function ArcadeHallQuickLinkMO.sortOpen(a, b)
	return a.f < b.f
end

function ArcadeHallQuickLinkMO:_calculatePath(gridMo, index)
	if not gridMo or not gridMo.orginGrid or self:_isSameGrid(gridMo.orginGrid, self._orginGrid) then
		return
	end

	local list = self._pathGridList[index]

	table.insert(list.linkList, gridMo.orginGrid.hexPoint)
	self:_calculatePath(gridMo.orginGrid, index)
end

function ArcadeHallQuickLinkMO:_isLegal(x, y, index)
	local gridMo = self:_getGridMo(x, y)

	if not gridMo then
		return
	end

	if self:_isObstacle(gridMo, index) then
		return
	end

	if self:_isOpen(gridMo, index) then
		return
	end

	if self:_isClose(gridMo, index) then
		return
	end

	return gridMo
end

function ArcadeHallQuickLinkMO:_isSameGrid(a, b)
	return a == b or a.hexPoint.x == b.hexPoint.x and a.hexPoint.y == b.hexPoint.y
end

function ArcadeHallQuickLinkMO:_isObstacle(gridMo, index)
	local targetMo = self._buildingGridMo[index]

	if not self:_isSameGrid(gridMo, targetMo) and self:_isBuildingGrid(gridMo) then
		return true
	end
end

function ArcadeHallQuickLinkMO:_isBuildingGrid(gridMo)
	for _, gridList in pairs(self._buildingGridDict) do
		for _, grid in ipairs(gridList) do
			if self:_isSameGrid(gridMo, grid) then
				return true
			end
		end
	end
end

function ArcadeHallQuickLinkMO:_isOpen(gridMo, index)
	local list = self._pathGridList[index]

	if list and list.openList then
		for _, grid in ipairs(list.openList) do
			if self:_isSameGrid(gridMo, grid) then
				return true
			end
		end
	end
end

function ArcadeHallQuickLinkMO:_isClose(gridMo, index)
	local list = self._pathGridList[index]

	if list and list.closeList then
		for _, grid in ipairs(list.closeList) do
			if self:_isSameGrid(gridMo, grid) then
				return true
			end
		end
	end
end

function ArcadeHallQuickLinkMO:_getGridMo(x, y)
	return self._gridMosDict[x] and self._gridMosDict[x][y]
end

return ArcadeHallQuickLinkMO
