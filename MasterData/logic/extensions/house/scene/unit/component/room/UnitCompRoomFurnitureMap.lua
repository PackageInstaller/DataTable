-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/room/UnitCompRoomFurnitureMap.lua

module("logic.extensions.house.scene.unit.component.room.UnitCompRoomFurnitureMap", package.seeall)

local M = class("UnitCompRoomFurnitureMap", UnitComponentBase)
local FurnitureOperaType = HouseEnum.FurnitureOperaType
local WallType = HouseEnum.WallType
local FurnitureGridState = HouseEnum.FurnitureGridState
local RoomSize = HouseEnum.RoomSize
local kFurnitureRootGoName = "furniture_root"
local kCalculPosGoName = "calcul_pos_go"
local kMapGridRootGoName = "map_grid_root"
local kGridMainColorID = UnityEngine.Shader.PropertyToID("_BaseColor")
local GRID_URL = "scene/common-elems/common-myhome/room-prafeb/room_chamber/room_checker_p.prefab"
local DOOR_ID = -1

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._goFurnitureRoot = nil
	self._gridSide = nil
	self._roomLength = nil
	self._roomDepth = nil
	self._roomHeight = nil
	self._typeToGridMap = nil
	self._dictUnitToGrid = nil
	self._cubeMap = nil
	self._dictUnitToCube = nil
	self._resLoader = nil
	self._dictUsedGridGO = nil
	self._arrayRecycleGridGO = nil
	self._gridOperaType = nil
	self._gridWallType = nil
	self._astarFinder = nil
end

function M:onInit()
	self._resLoader = SingleResLoader.New()
	self._astarFinder = AstarPathFinder.New()
end

function M:onLateInit()
	self:_initMap()
end

function M:onReuse()
	return
end

function M:onReset()
	self._goFurnitureRoot = false
	self._gridSide = false
	self._roomLength = false
	self._roomDepth = false
	self._roomHeight = false

	table.clear(self._typeToGridMap)

	self._typeToGridMap = false

	table.clear(self._dictUnitToGrid)

	self._dictUnitToGrid = false

	table.clear(self._cubeMap)

	self._cubeMap = false

	table.clear(self._dictUnitToCube)

	self._dictUnitToCube = false

	self._astarFinder:clearMapData()
	self:onRoomResUnload()
	self:clearAllGridGO()

	self._gridOperaType = false
	self._gridWallType = false
end

function M:onDestroy()
	self:onReset()

	self._resLoader = nil
	self._astarFinder = nil
end

function M:onRoomEnter(hasRes)
	if not hasRes then
		self:onRoomResLoaded()
	end
end

function M:onRoomExit()
	return
end

function M:onRoomResLoaded()
	self:preloadGridGO()
end

function M:onRoomResUnload()
	self._resLoader:clear()
end

function M:_initMap()
	local unitParentGO = self._unit:getParentGO()
	local sizeType = self._unit.model:getSizeType()

	self._goFurnitureRoot = goutil.findChild(unitParentGO, kFurnitureRootGoName)
	self._gridSide = HouseEnum.FURNITURE_COORD_SIZE
	self._roomLength = sizeType == RoomSize.Big and 48 or 24
	self._roomDepth = sizeType == RoomSize.Big and 18 or 18
	self._roomHeight = sizeType == RoomSize.Big and 12 or 9
	self._typeToGridMap = {
		[FurnitureOperaType.Floor] = {},
		[FurnitureOperaType.Carpet] = {},
		[FurnitureOperaType.Wall] = {},
		[FurnitureOperaType.Ceiling] = {}
	}
	self._dictUnitToGrid = {}
	self._cubeMap = {}
	self._dictUnitToCube = {}
	self._dictUsedGridGO = {}
	self._arrayRecycleGridGO = {}

	self:_initAstarMap()
	self:_addDoorGrid()
end

function M:_initAstarMap()
	for x = 1, self._roomLength do
		for y = 1, self._roomDepth do
			self:_updateAstarMap(x, y)
		end
	end
end

function M:_updateAstarMap(x, y)
	local walkable = true
	local occupyUnitList = self:_getOneGridMapByXY(FurnitureOperaType.Floor, x, y)

	if occupyUnitList and #occupyUnitList > 0 then
		if table.indexof(occupyUnitList, DOOR_ID) then
			if #occupyUnitList > 1 then
				walkable = false
			end
		else
			walkable = false
		end
	end

	self._astarFinder:setCanWalkable(x, y, walkable)
end

function M:_addDoorGrid()
	local wallXLen = 5
	local wallYLen = 6
	local floorXLen = 2
	local floorYLen = 5

	self:addGridDataByUnitId(DOOR_ID, FurnitureOperaType.Wall, 204, 1, wallXLen, wallYLen)
	self:addGridDataByUnitId(DOOR_ID, FurnitureOperaType.Floor, 1, 4, floorXLen, floorYLen)
	self:addGridDataByUnitId(DOOR_ID, FurnitureOperaType.Wall, 304, 1, wallXLen, wallYLen)
	self:addGridDataByUnitId(DOOR_ID, FurnitureOperaType.Floor, self._roomLength + 1 - floorXLen, 4, floorXLen, floorYLen)
end

function M:hasPathToCoord(x, y)
	local startX, startY = 2, 6
	local hasPath, arrayResultPath = self._astarFinder:findPath(startX, startY, x, y, false, true)

	return hasPath
end

function M:getLeftDoorPos()
	return self:getWorldPosByCoord(FurnitureOperaType.Floor, 2, 6, 1, 1)
end

function M:getLeftDoorInsidePos()
	return self:getWorldPosByCoord(FurnitureOperaType.Floor, 6, 6, 1, 1)
end

function M:getLeftDoorOutsidePos()
	return self:getWorldPosByCoord(FurnitureOperaType.Floor, -2, 6, 1, 1)
end

function M:getRightDoorPos()
	return self:getWorldPosByCoord(FurnitureOperaType.Floor, self._roomLength - 1, 6, 1, 1)
end

function M:getRightDoorOutsidePos()
	return self:getWorldPosByCoord(FurnitureOperaType.Floor, self._roomLength - 1 + 4, 6, 1, 1)
end

function M:getFurnitureRootGO()
	return self._goFurnitureRoot
end

function M:preloadGridGO()
	self._resLoader:load(GRID_URL)
end

function M:clearAllGridGO()
	for _, gridGO in pairs(self._dictUsedGridGO) do
		goutil.destroy(gridGO)
	end

	table.clear(self._dictUsedGridGO)

	for _, gridGO in ipairs(self._arrayRecycleGridGO) do
		goutil.destroy(gridGO)
	end

	table.clear(self._arrayRecycleGridGO)

	self._gridOperaType = false
	self._gridWallType = false
end

function M:showMapGrid(operaType, wallType)
	if operaType == self._gridOperaType and operaType ~= FurnitureOperaType.Wall then
		return
	end

	if operaType == FurnitureOperaType.Wall and wallType == self._gridWallType then
		return
	end

	local rotation

	if operaType == FurnitureOperaType.Wall then
		rotation = HouseEnum.FurnitureOperaType2GridRota[operaType][wallType]
	else
		rotation = HouseEnum.FurnitureOperaType2GridRota[operaType]
	end

	self:recycleAllGrid()

	self._gridOperaType = operaType
	self._gridWallType = wallType

	local coordOffset = 0.01
	local minX, maxX, minY, maxY = self:getCoordBorderByType(operaType, wallType)

	for x = minX, maxX do
		for y = minY, maxY do
			local posX, posY, posZ, calculGO = self:getLocalPosByCoord(operaType, x, y, 1, 1, coordOffset)
			local gridGO = self:_getGridGO()

			Astral.TransformUtil.SetLocalPos(gridGO.transform, posX, posY, posZ)
			Astral.TransformUtil.SetLocalRotation(gridGO.transform, rotation.x, rotation.y, rotation.z)

			local key = self:_getGridKey(x, y)

			self._dictUsedGridGO[key] = gridGO
		end
	end

	self:refreshGridState()
end

function M:refreshGridState()
	if self._gridOperaType then
		local minX, maxX, minY, maxY = self:getCoordBorderByType(self._gridOperaType, self._gridWallType)

		for x = minX, maxX do
			for y = minY, maxY do
				local occupyUnitList = self:_getOneGridMapByXY(self._gridOperaType, x, y)
				local state = FurnitureGridState.Normal

				if occupyUnitList and #occupyUnitList == 1 then
					state = FurnitureGridState.Used
				elseif occupyUnitList and #occupyUnitList > 1 then
					state = FurnitureGridState.Conflict
				end

				local key = self:_getGridKey(x, y)

				self:_refreshGrid(self._dictUsedGridGO[key], state)
			end
		end
	end
end

function M:recycleAllGrid()
	for _, gridGO in pairs(self._dictUsedGridGO) do
		table.insert(self._arrayRecycleGridGO, gridGO)
		Astral.TransformUtil.SetLocalPos(gridGO.transform, 1999, 1999, 1999)
	end

	table.clear(self._dictUsedGridGO)

	self._gridOperaType = false
	self._gridWallType = false
end

function M:_getGridKey(x, y)
	return string.format("%s_%s", x, y)
end

function M:_getGridGO()
	local len = #self._arrayRecycleGridGO

	if len > 0 then
		return table.remove(self._arrayRecycleGridGO, len)
	else
		local rootGO = self:_tryGetGoByName(kMapGridRootGoName)
		local gridGO = self._resLoader:getResInstance()

		goutil.addChildToParent(gridGO, rootGO)

		return gridGO
	end
end

function M:_refreshGrid(gridGO, state)
	local colorStr = HouseEnum.FurnitureGridState2Color[state]
	local centerGO = goutil.findChild(gridGO, "room_checker_a")
	local materialSetter = MaterialSetter.Get(gridGO)

	materialSetter:SetGameObject(centerGO)
	materialSetter:SetColor(kGridMainColorID, colorStr)
end

function M:getRoomLength()
	return self._roomLength
end

function M:getRoomDepth()
	return self._roomDepth
end

function M:getRoomHeight()
	return self._roomHeight
end

function M:addAllMapDataByUnit(unit)
	self:addAllMapDataByUnitId(unit.id, unit.model:getOperaType(), unit.model:getCoordX(), unit.model:getCoordY(), unit.model:getCoordXLen(), unit.model:getCoordYLen(), unit.model:getCoordZLen())
end

function M:addAllMapDataByUnitId(unitId, operaType, coordX, coordY, coordXLen, coordYLen, coordZLen)
	self:addGridDataByUnitId(unitId, operaType, coordX, coordY, coordXLen, coordYLen)
	self:addCubeDataByUnitId(unitId, operaType, coordX, coordY, coordXLen, coordYLen, coordZLen)
end

function M:addGridDataByUnitId(unitId, operaType, coordX, coordY, coordXLen, coordYLen)
	local function _addGridData(gridX, gridY)
		if self._dictUnitToGrid[unitId] == nil then
			self._dictUnitToGrid[unitId] = {}
		end

		local gridData = {}

		gridData.x = gridX
		gridData.y = gridY

		table.insert(self._dictUnitToGrid[unitId], gridData)
	end

	local gridMap = self._typeToGridMap[operaType]

	for x = coordX, coordX + coordXLen - 1 do
		for y = coordY, coordY + coordYLen - 1 do
			if gridMap[x] == nil then
				gridMap[x] = {}
			end

			if gridMap[x][y] == nil then
				gridMap[x][y] = {}
			end

			table.insert(gridMap[x][y], unitId)
			_addGridData(x, y)
			self:_updateAstarMap(x, y)
		end
	end
end

function M:addCubeDataByUnitId(unitId, operaType, coordX, coordY, coordXLen, coordYLen, coordZLen)
	local function _addCubeData(x, y, z)
		if self._dictUnitToCube[unitId] == nil then
			self._dictUnitToCube[unitId] = {}
		end

		local cubeData = {}

		cubeData.x = x
		cubeData.y = y
		cubeData.z = z

		table.insert(self._dictUnitToCube[unitId], cubeData)
	end

	local minX, maxX, minY, maxY, minZ, maxZ = self:getCubeRangeByCoord(operaType, coordX, coordY, coordXLen, coordYLen, coordZLen)

	if minX then
		for x = minX, maxX do
			for y = minY, maxY do
				for z = minZ, maxZ do
					if self._cubeMap[x] == nil then
						self._cubeMap[x] = {}
					end

					if self._cubeMap[x][y] == nil then
						self._cubeMap[x][y] = {}
					end

					if self._cubeMap[x][y][z] == nil then
						self._cubeMap[x][y][z] = {}
					end

					local occupyUnitList = self._cubeMap[x][y][z]

					table.insert(occupyUnitList, unitId)
					_addCubeData(x, y, z)
				end
			end
		end
	end
end

function M:removeAllMapDataByUnit(unit)
	self:removeAllMapDataByUnitId(unit.id, unit.model:getOperaType())
end

function M:removeAllMapDataByUnitId(unitId, operaType)
	self:removeGridDataByUnitId(unitId, operaType)
	self:removeCubeDataByUnitId(unitId)
end

function M:removeGridDataByUnitId(unitId, operaType)
	local gridDataList = self._dictUnitToGrid[unitId]

	if gridDataList then
		for _, gridData in ipairs(gridDataList) do
			local occupyUnitList = self:_getOneGridMapByXY(operaType, gridData.x, gridData.y)

			if occupyUnitList then
				local idx = table.indexof(occupyUnitList, unitId)

				if idx then
					table.remove(occupyUnitList, idx)
				end
			end

			self:_updateAstarMap(gridData.x, gridData.y)
		end
	end

	self._dictUnitToGrid[unitId] = nil
end

function M:removeCubeDataByUnitId(unitId)
	local cubeDataList = self._dictUnitToCube[unitId]

	if cubeDataList then
		for _, cubeData in ipairs(cubeDataList) do
			local occupyUnitList = self:_getOneCubeMapByXYZ(cubeData.x, cubeData.y, cubeData.z)

			if occupyUnitList then
				local idx = table.indexof(occupyUnitList, unitId)

				if idx then
					table.remove(occupyUnitList, idx)
				end
			end
		end
	end

	self._dictUnitToCube[unitId] = nil
end

function M:getCubeRangeByCoord(operaType, coordX, coordY, coordXLen, coordYLen, coordZLen)
	if coordZLen > 0 then
		local minX, maxX, minY, maxY, minZ, maxZ

		if operaType == FurnitureOperaType.Floor then
			minX = coordX
			maxX = coordX + coordXLen - 1
			minY = 1
			maxY = coordZLen
			minZ = coordY
			maxZ = coordY + coordYLen - 1
		elseif operaType == FurnitureOperaType.Wall then
			local wallType = HouseSceneUtil.CoordXMapToWallType(coordX)

			coordX = math.fmod(coordX, 100)

			if wallType == WallType.Middle then
				minX = coordX
				maxX = coordX + coordXLen - 1
				minY = coordY
				maxY = coordY + coordYLen - 1
				minZ = self._roomDepth - coordZLen + 1
				maxZ = self._roomDepth
			elseif wallType == WallType.Left then
				minX = 1
				maxX = coordZLen
				minY = coordY
				maxY = coordY + coordYLen - 1
				minZ = coordX
				maxZ = coordX + coordXLen - 1
			elseif wallType == WallType.Right then
				minX = self._roomLength - coordZLen + 1
				maxX = self._roomLength
				minY = coordY
				maxY = coordY + coordYLen - 1
				minZ = coordX
				maxZ = coordX + coordXLen - 1
			end
		elseif operaType == FurnitureOperaType.Ceiling then
			minX = coordX
			maxX = coordX + coordXLen - 1
			minY = self._roomHeight - coordZLen + 1
			maxY = self._roomHeight
			minZ = coordY
			maxZ = coordY + coordYLen - 1
		end

		return minX, maxX, minY, maxY, minZ, maxZ
	end
end

function M:getFloorGridMap(coordX, coordY)
	local gridMap = self._typeToGridMap[FurnitureOperaType.Floor]

	if gridMap[coordX] then
		return gridMap[coordX][coordY]
	end
end

function M:_getOneGridMapByXY(operaType, coordX, coordY)
	local gridMap = self._typeToGridMap[operaType]

	if gridMap[coordX] then
		return gridMap[coordX][coordY]
	end
end

function M:_getOneCubeMapByXYZ(coordX, coordY, coordZ)
	if self._cubeMap[coordX] and self._cubeMap[coordX][coordY] then
		return self._cubeMap[coordX][coordY][coordZ]
	end
end

function M:getAroundGridsByUnit(unit, filterUsed)
	return self:getAroundGridsByCoord(unit.model:getOperaType(), unit.model:getCoordX(), unit.model:getCoordY(), unit.model:getCoordXLen(), unit.model:getCoordYLen(), filterUsed)
end

function M:getAroundGridsByCoord(operaType, coordX, coordY, coordXLen, coordYLen, filterUsed)
	local wallType = HouseSceneUtil.CoordXMapToWallType(coordX)
	local minX, maxX, minY, maxY = self:getCoordBorderByType(operaType, wallType)
	local dataList = {}

	local function _tryAddData(gridX, gridY)
		if gridX >= minX and gridX <= maxX and gridY >= minY and gridY <= maxY then
			local occupyUnitList = self:_getOneGridMapByXY(operaType, gridX, gridY) or {}
			local aroundGridData = {}

			aroundGridData.x = gridX
			aroundGridData.y = gridY
			aroundGridData.occupyUnitList = occupyUnitList

			if filterUsed then
				if #occupyUnitList == 0 or #occupyUnitList == 1 and occupyUnitList[1] == DOOR_ID then
					table.insert(dataList, aroundGridData)
				end
			else
				table.insert(dataList, aroundGridData)
			end
		end
	end

	for x = coordX, coordX + coordXLen - 1 do
		_tryAddData(x, coordY - 1)
		_tryAddData(x, coordY + coordYLen)
	end

	for y = coordY, coordY + coordYLen - 1 do
		_tryAddData(coordX - 1, y)
		_tryAddData(coordX + coordXLen, y)
	end

	_tryAddData(coordX - 1, coordY - 1)
	_tryAddData(coordX - 1, coordY + coordYLen)
	_tryAddData(coordX + coordXLen, coordY - 1)
	_tryAddData(coordX + coordXLen, coordY + coordYLen)

	return dataList
end

function M:getFrontGridsByUnit(unit)
	return self:getFrontGridsByCoord(unit.model:getCoordX(), unit.model:getCoordY(), unit.model:getCoordXLen(), unit.model:getCoordYLen(), unit.model:getAngle())
end

function M:getFrontGridsByCoord(coordX, coordY, coordXLen, coordYLen, angle)
	local operaType = FurnitureOperaType.Floor
	local minX, maxX, minY, maxY = self:getCoordBorderByType(operaType, 0)
	local dataList = {}

	local function _tryAddData(gridX, gridY)
		if gridX >= minX and gridX <= maxX and gridY >= minY and gridY <= maxY then
			local occupyUnitList = self:_getOneGridMapByXY(operaType, gridX, gridY) or {}
			local aroundGridData = {}

			aroundGridData.x = gridX
			aroundGridData.y = gridY
			aroundGridData.occupyUnitList = occupyUnitList

			table.insert(dataList, aroundGridData)
		end
	end

	if angle == 0 then
		for x = coordX, coordX + coordXLen - 1 do
			_tryAddData(x, coordY - 1)
		end
	elseif angle == 90 then
		for y = coordY, coordY + coordYLen - 1 do
			_tryAddData(coordX - 1, y)
		end
	elseif angle == 180 then
		for x = coordX, coordX + coordXLen - 1 do
			_tryAddData(x, coordY + coordYLen)
		end
	elseif angle == 270 then
		for y = coordY, coordY + coordYLen - 1 do
			_tryAddData(coordX + coordXLen, y)
		end
	end

	return dataList
end

function M:getWallFurnGridsInFloorByUnit(unit, filterUsed)
	return self:getWallFurnGridsInFloor(unit.model:getCoordX(), unit.model:getCoordXLen(), filterUsed)
end

function M:getWallFurnGridsInFloor(coordX, coordXLen, filterUsed)
	local dataList = {}

	local function _tryAddData(gridX, gridY)
		local occupyUnitList = self:_getOneGridMapByXY(FurnitureOperaType.Floor, gridX, gridY) or {}
		local aroundGridData = {}

		aroundGridData.x = gridX
		aroundGridData.y = gridY
		aroundGridData.occupyUnitList = occupyUnitList

		if filterUsed then
			if #occupyUnitList == 0 then
				table.insert(dataList, aroundGridData)
			end
		else
			table.insert(dataList, aroundGridData)
		end
	end

	local wallType = HouseSceneUtil.CoordXMapToWallType(coordX)

	if wallType == WallType.Middle then
		local y = self._roomDepth
		local realX = coordX - 100

		for x = realX, realX + coordXLen - 1 do
			_tryAddData(x, y)
		end
	elseif wallType == WallType.Left then
		local x = 1
		local realX = coordX - 200

		for y = realX, realX + coordXLen - 1 do
			_tryAddData(x, y)
		end
	elseif wallType == WallType.Right then
		local x = self._roomLength
		local realX = coordX - 300

		for y = realX, realX + coordXLen - 1 do
			_tryAddData(x, y)
		end
	end

	return dataList
end

function M:getWorldPosByUnit(unit)
	return self:getWorldPosByCoord(unit.model:getOperaType(), unit.model:getCoordX(), unit.model:getCoordY(), unit.model:getCoordXLen(), unit.model:getCoordYLen())
end

function M:getWorldPosByCoord(operaType, coordX, coordY, coordXLen, coordYLen)
	local posX, posY, posZ, calculGO = self:getLocalPosByCoord(operaType, coordX, coordY, coordXLen, coordYLen)

	return Astral.TransformUtil.GetPos(calculGO.transform, 0, 0, 0)
end

function M:getLocalPosByCoord(operaType, coordX, coordY, coordXLen, coordYLen, coordOffset)
	local function _coordWorldLen(coord, coordLen)
		return (coord - 1) * self._gridSide + coordLen * self._gridSide / 2
	end

	coordOffset = coordOffset or 0

	local posX, posY, posZ = 0, 0, 0

	if operaType == FurnitureOperaType.Floor or operaType == FurnitureOperaType.Carpet then
		posX = _coordWorldLen(coordX, coordXLen)
		posY = 0 + coordOffset
		posZ = _coordWorldLen(coordY, coordYLen)
	elseif operaType == FurnitureOperaType.Wall then
		local wallType = HouseSceneUtil.CoordXMapToWallType(coordX)

		coordX = math.fmod(coordX, 100)

		if wallType == WallType.Middle then
			posX = _coordWorldLen(coordX, coordXLen)
			posY = _coordWorldLen(coordY, coordYLen)
			posZ = self._gridSide * self._roomDepth - coordOffset
		elseif wallType == WallType.Left then
			posX = 0 + coordOffset
			posY = _coordWorldLen(coordY, coordYLen)
			posZ = _coordWorldLen(coordX, coordXLen)
		elseif wallType == WallType.Right then
			posX = self._gridSide * self._roomLength - coordOffset
			posY = _coordWorldLen(coordY, coordYLen)
			posZ = _coordWorldLen(coordX, coordXLen)
		end
	elseif operaType == FurnitureOperaType.Ceiling then
		posX = _coordWorldLen(coordX, coordXLen)
		posY = self._gridSide * self._roomHeight - coordOffset
		posZ = _coordWorldLen(coordY, coordYLen)
	end

	local calculGO = self:_tryGetGoByName(kCalculPosGoName)

	Astral.TransformUtil.SetLocalPos(calculGO.transform, posX, posY, posZ)

	return posX, posY, posZ, calculGO
end

function M:getFurnitureCoordPosByWorldPos(worldPos, operaType, wallType, coordXLen, coordYLen)
	local function _getCoordPos(pos, furnLen)
		local gridLen = math.max(pos - furnLen * 0.5 * self._gridSide, 0)

		return math.round(gridLen / self._gridSide) + 1
	end

	local function _adjustOriginPos(pos, len)
		return math.min(math.max(pos, 0.5 * self._gridSide), (len - 0.5) * self._gridSide)
	end

	local calculGO = self:_tryGetGoByName(kCalculPosGoName)

	Astral.TransformUtil.SetPos(calculGO.transform, worldPos.x, worldPos.y, worldPos.z)

	local posX, posY, posZ = Astral.TransformUtil.GetLocalPos(calculGO.transform, 0, 0, 0)
	local coordX, coordY

	if operaType == FurnitureOperaType.Floor or operaType == FurnitureOperaType.Carpet or operaType == FurnitureOperaType.Ceiling then
		posX = _adjustOriginPos(posX, self._roomLength)
		posZ = _adjustOriginPos(posZ, self._roomDepth)
		coordX = _getCoordPos(posX, coordXLen)
		coordY = _getCoordPos(posZ, coordYLen)
	elseif operaType == FurnitureOperaType.Wall then
		if wallType == WallType.Middle then
			posX = _adjustOriginPos(posX, self._roomLength)
			posY = _adjustOriginPos(posY, self._roomHeight)
			coordX = _getCoordPos(posX, coordXLen) + 100
			coordY = _getCoordPos(posY, coordYLen)
		elseif wallType == WallType.Left then
			posZ = _adjustOriginPos(posZ, self._roomDepth)
			posY = _adjustOriginPos(posY, self._roomHeight)
			coordX = _getCoordPos(posZ, coordXLen) + 200
			coordY = _getCoordPos(posY, coordYLen)
		elseif wallType == WallType.Right then
			posZ = _adjustOriginPos(posZ, self._roomDepth)
			posY = _adjustOriginPos(posY, self._roomHeight)
			coordX = _getCoordPos(posZ, coordXLen) + 300
			coordY = _getCoordPos(posY, coordYLen)
		end
	end

	Astral.TransformUtil.SetLocalPos(calculGO.transform, posX, posY, posZ)

	coordX, coordY = self:adjustCoord(coordX, coordY, coordXLen, coordYLen, operaType, wallType)

	return coordX, coordY, Astral.TransformUtil.GetPos(calculGO.transform, 0, 0, 0)
end

function M:getCoordBorderByType(operaType, wallType)
	local minX, maxX, minY, maxY

	if operaType == FurnitureOperaType.Floor or operaType == FurnitureOperaType.Carpet or operaType == FurnitureOperaType.Ceiling then
		minX, maxX = 1, self._roomLength
		minY, maxY = 1, self._roomDepth
	elseif operaType == FurnitureOperaType.Wall then
		if wallType == WallType.Middle then
			minX, maxX = 101, self._roomLength + 100
			minY, maxY = 1, self._roomHeight
		elseif wallType == WallType.Left then
			minX, maxX = 201, self._roomDepth + 200
			minY, maxY = 1, self._roomHeight
		elseif wallType == WallType.Right then
			minX, maxX = 301, self._roomDepth + 300
			minY, maxY = 1, self._roomHeight
		end
	end

	return minX, maxX, minY, maxY
end

function M:checkCoordEnable(coordX, coordY, coordXLen, coordYLen, operaType, wallType)
	local minX, maxX, minY, maxY = self:getCoordBorderByType(operaType, wallType)
	local xEnable = minX <= coordX and coordX <= maxX - coordXLen + 1
	local yEnable = minY <= coordY and coordY <= maxY - coordYLen + 1

	return xEnable and yEnable
end

function M:adjustCoord(coordX, coordY, coordXLen, coordYLen, operaType, wallType)
	local minX, maxX, minY, maxY = self:getCoordBorderByType(operaType, wallType)
	local newCoordX = math.max(minX, math.min(coordX, maxX - coordXLen + 1))
	local newCoordY = math.max(minY, math.min(coordY, maxY - coordYLen + 1))

	return newCoordX, newCoordY
end

function M:canRota90Deg(coordXLen, coordYLen)
	return coordYLen <= self._roomLength and coordXLen <= self._roomDepth
end

function M:checkFurnitureOverlapByUnit(unit)
	local unitId = unit.id
	local operaType = unit.model:getOperaType()
	local cubeOverlap = false
	local sealDoor = false
	local cubeDataList = self._dictUnitToCube[unitId]

	if cubeDataList then
		for _, cubeData in ipairs(cubeDataList) do
			local occupyUnitList = self:_getOneCubeMapByXYZ(cubeData.x, cubeData.y, cubeData.z)

			if occupyUnitList and #occupyUnitList > 1 then
				cubeOverlap = true

				break
			end
		end
	end

	local gridOverlap = false
	local gridDataList = self._dictUnitToGrid[unitId]

	if gridDataList then
		for _, gridData in ipairs(gridDataList) do
			local occupyUnitList = self:_getOneGridMapByXY(operaType, gridData.x, gridData.y)

			if occupyUnitList and #occupyUnitList > 1 then
				if operaType == FurnitureOperaType.Floor then
					if table.indexof(occupyUnitList, DOOR_ID) then
						sealDoor = true

						if #occupyUnitList > 2 then
							gridOverlap = true
						end
					else
						gridOverlap = true
					end
				else
					gridOverlap = true

					break
				end
			end
		end
	end

	return cubeOverlap or gridOverlap, sealDoor
end

function M:_tryGetGoByName(name)
	local go = goutil.findChild(self._goFurnitureRoot, name)

	if not go then
		go = goutil.create(name, false)

		goutil.addChildToParent(go, self._goFurnitureRoot)
	end

	return go
end

return M
