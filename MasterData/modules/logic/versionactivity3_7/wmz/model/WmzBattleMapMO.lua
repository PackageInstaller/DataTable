-- chunkname: @modules/logic/versionactivity3_7/wmz/model/WmzBattleMapMO.lua

local ti = table.insert
local sf = string.format

module("modules.logic.versionactivity3_7.wmz.model.WmzBattleMapMO", package.seeall)

local WmzBattleMapMO = class("WmzBattleMapMO")

local function _configInst()
	return WmzController.instance:configInst()
end

local function _foreachGrid(w, h, handler)
	assert(type(handler) == "function")

	if w <= 0 or h <= 0 then
		return
	end

	local y = 0
	local i = 0

	while y < h do
		local x = 0

		while x < w do
			handler(i, x, y)

			i = i + 1
			x = x + 1
		end

		y = y + 1
	end
end

local function _foreachLTRB(ltx, lty, rbx, rby, handler)
	for y = lty, rby do
		for x = ltx, rbx do
			handler(x, y)
		end
	end
end

WmzBattleMapMO.foreachLTRB = _foreachLTRB

function WmzBattleMapMO:gameId(episodeId)
	if not self._mapId or episodeId ~= nil then
		episodeId = episodeId or WmzBattleModel.instance:episodeId()
		self._mapId = _configInst():getEpisodeCO_gameId(episodeId)
	end

	return self._mapId
end

function WmzBattleMapMO:getGameCO()
	local mapId = self:gameId()

	return _configInst():getGameCO(mapId)
end

function WmzBattleMapMO:getZoneCOList()
	local mapId = self:gameId()

	self._cache_zoneCOList[mapId] = self._cache_zoneCOList[mapId] or _configInst():getZoneCOList(mapId)

	return self._cache_zoneCOList[mapId]
end

function WmzBattleMapMO:getZoneId2IndexDict()
	local mapId = self:gameId()

	if not self._cache_zoneId2IndexList[mapId] then
		local dict = {}
		local zoneCOList = self:getZoneCOList()

		for index, zoneCO in ipairs(zoneCOList) do
			local zoneId = zoneCO.id

			dict[zoneId] = index
		end

		self._cache_zoneId2IndexList[mapId] = dict
	end

	return self._cache_zoneId2IndexList[mapId]
end

function WmzBattleMapMO:ctor()
	self._cache_zoneCOList = {}
	self._cache_zoneId2IndexList = {}
	self._cellList = {}
	self._tileList = {}
	self._startCellList = {}
	self._groupId2TileIdxList = {}
	self._zoneId2TileIdxList = {}
	self._mapSize = Vector2.New(0, 0)
	self._wireList = {}
	self._curEnergy = 0
	self._clearZoneCnt = 0
end

function WmzBattleMapMO.default_ctor(Self, memberName)
	local mapMO = WmzBattleMapMO.New()

	mapMO.__info = WmzMapInfo.New()
	Self[memberName] = mapMO
end

function WmzBattleMapMO:restartByEpisodeId(episodeId)
	self:restart(self:gameId(episodeId))
end

function WmzBattleMapMO:restart(mapId)
	mapId = mapId or self:gameId()
	self._mapId = mapId

	local mapCO = self.__info:reset(mapId)

	self:_createMap(mapCO)
end

function WmzBattleMapMO:_createMap(mapCO)
	self._curEnergy = self:maxEnergy()
	self._clearZoneCnt = 0

	self._mapSize:Set(mapCO.width, mapCO.height)
	self:_createGrids(mapCO)
end

function WmzBattleMapMO:_createGrids(mapCO)
	self._tileList = {}
	self._cellList = {}
	self._startCellList = {}
	self._groupId2TileIdxList = {}
	self._zoneId2TileIdxList = {}
	self._wireList = {}

	local tmpGridDict = {}

	for _, cellInfo in ipairs(mapCO.girds) do
		local zoneId = cellInfo.zoneId
		local gridObj = WmzMapGridBase.s_ctor(self, cellInfo)
		local x, y = gridObj:xy()

		tmpGridDict[x] = tmpGridDict[x] or {}

		if gridObj:isTile() then
			local emptyCellInfo = WmzMapInfo.s_makeEmpty(x, y, cellInfo)

			tmpGridDict[x][y] = WmzMapGridBase.s_ctor(self, emptyCellInfo)

			local tileId = #self._tileList + 1

			self._tileList[tileId] = gridObj

			gridObj:setId(tileId)

			if gridObj:bHasGroup() then
				local groupId = gridObj:groupId()

				if isDebugBuild then
					assert(groupId ~= 0)
				end

				self._groupId2TileIdxList[groupId] = self._groupId2TileIdxList[groupId] or {}

				ti(self._groupId2TileIdxList[groupId], tileId)
			end

			if zoneId ~= 0 then
				self._zoneId2TileIdxList[zoneId] = self._zoneId2TileIdxList[zoneId] or {}

				ti(self._zoneId2TileIdxList[zoneId], tileId)
			end
		else
			tmpGridDict[x][y] = gridObj

			if gridObj:isStart() then
				local startIndex = #self._startCellList + 1

				self._startCellList[startIndex] = gridObj

				gridObj:setId(startIndex)
			end
		end

		if not gridObj:isPathNone() then
			ti(self._wireList, gridObj)
		end
	end

	local w, h = self:mapSize()

	_foreachGrid(w, h, function(i, x, y)
		if tmpGridDict[x] then
			if not tmpGridDict[x][y] then
				local gridObj

				if not gridObj then
					gridObj = WmzMapCell.New(self, WmzMapInfo.s_makeVoid(x, y))
				elseif isDebugBuild then
					assert((gridObj:isPassable() and not gridObj:isStart() and gridObj:pathType() ~= WmzEnum.PathType.None or nil) and false, sf("(%s,%s) invalid config", x, y))
				end

				gridObj:setId(i)

				self._cellList[i] = gridObj
			end
		end
	end)
	self:_bindTiles()

	if WmzEnum.rDir then
		local strBuf = {}

		_foreachGrid(w, h, function(i, x, y)
			local gridObj = self._cellList[i]
			local ptStr = WmzEnum.nameOfPT(gridObj:pathType())
			local ftStr = WmzEnum.nameOfFT(gridObj:floorType())

			ti(strBuf, sf("(%s,%s): pt:%s, ft:%s, gp:%s, sprite:%s", gridObj:x(), gridObj:y(), ptStr, ftStr, gridObj:groupId() or 0, gridObj:sprite() or "None"))
		end)
		logError(table.concat(strBuf, "\n"))
	end
end

function WmzBattleMapMO:_bindTiles()
	for tileId, tileObj in ipairs(self._tileList) do
		local x, y = tileObj:xy()
		local cellObj = self:getCell(x, y)

		if isDebugBuild then
			local w, h = self:mapSize()

			assert(cellObj, sf("out of bound (%s,%s) in %sx%s", x, y, w, h))
			assert(not cellObj:isStart(), sf("invalid type: (%s, %s)", x, y))
		end

		cellObj:setTileId(tileId)
	end

	self:floodfill()
end

function WmzBattleMapMO:floodfill()
	local hh = 1
	local tt = 0
	local q = {}

	local function _pop()
		hh = hh + 1

		return q[hh]
	end

	local set = {
		[-1] = true
	}

	local function _append(obj)
		tt = tt + 1
		q[tt] = obj
	end

	for _, gridObj in ipairs(self._startCellList) do
		_append(gridObj)

		local flattenIndex = gridObj:calcCellFlattenIndex()

		set[flattenIndex] = true
	end

	for _, gridObj in ipairs(self._wireList) do
		gridObj:setWelded(false)
	end

	local weldedCnt = 0

	while hh <= tt do
		local gridObj = _pop()

		for i = 1, 4 do
			local targetX = gridObj:x() + WmzEnum.dX[i]
			local targetY = gridObj:y() + WmzEnum.dY[i]
			local targetFlatternIndex = self:calcCellFlattenIndex(targetX, targetY)

			if targetFlatternIndex ~= -1 and not set[targetFlatternIndex] then
				local relativeZoneMask = WmzEnum.bitPos2Dir(i - 1)
				local targetNeighborObj = self:getCellByFlattenIdx(targetFlatternIndex)

				if isDebugBuild then
					assert(targetNeighborObj, tostring(targetFlatternIndex))
				end

				local ok = gridObj:_isConnedNeighbor(targetNeighborObj, relativeZoneMask)

				if ok then
					weldedCnt = weldedCnt + 1

					targetNeighborObj:setWelded(true)
					_append(targetNeighborObj)

					set[targetFlatternIndex] = true
				end
			end
		end
	end

	for _, startObj in ipairs(self._startCellList) do
		local bConned = false

		for i = 1, 4 do
			local targetCell = self:getCell(startObj:x() + WmzEnum.dX[i], startObj:y() + WmzEnum.dY[i])

			if targetCell and targetCell:bWelded() and startObj:_isConnedNeighbor(targetCell, WmzEnum.bitPos2Dir(i - 1)) then
				bConned = true

				break
			end
		end

		startObj:setWelded(bConned)

		if bConned then
			weldedCnt = weldedCnt + 1
		end
	end

	return weldedCnt == #self._wireList
end

function WmzBattleMapMO:mapSize()
	local w, h = self._mapSize:Get()

	return w, h
end

function WmzBattleMapMO:rowCol()
	local col, row = self:mapSize()

	return row, col
end

function WmzBattleMapMO:getTile(tileId)
	return self._tileList[tileId]
end

function WmzBattleMapMO:calcCellFlattenIndex(x, y)
	if isDebugBuild then
		assert(x)
		assert(y)
	end

	local w, h = self:mapSize()

	if x < 0 or y < 0 or w <= x or h <= y then
		return -1
	end

	return y * w + x
end

function WmzBattleMapMO:getCell(x, y)
	local w, h = self:mapSize()
	local flattenIndex = self:calcCellFlattenIndex(x, y)

	return self:getCellByFlattenIdx(flattenIndex)
end

function WmzBattleMapMO:getCellByFlattenIdx(flattenIndex)
	return self._cellList[flattenIndex]
end

function WmzBattleMapMO:bValidCoord(x, y)
	local w, h = self:mapSize()

	if x < 0 or y < 0 or w <= x or h <= y then
		return false
	end

	return true
end

function WmzBattleMapMO:foreachCell(handler)
	local w, h = self:mapSize()

	_foreachGrid(w, h, function(i, x, y)
		handler(self._cellList[i], i, x, y)
	end)
end

function WmzBattleMapMO:foreachTile(handler)
	for tileId, tileObj in ipairs(self._tileList) do
		local x = tileObj:x()
		local y = tileObj:y()

		handler(tileObj, tileId, x, y)
	end
end

function WmzBattleMapMO:foreachWire(handler)
	for _, gridObj in ipairs(self._wireList) do
		local x = gridObj:x()
		local y = gridObj:y()

		handler(gridObj, x, y)
	end
end

function WmzBattleMapMO:foreachCellByLTRB(ltx, lty, rbx, rby, handler)
	_foreachLTRB(ltx, lty, rbx, rby, function(x, y)
		local i = self:calcCellFlattenIndex(x, y)
		local cellObj = self:getCell(x, y)

		handler(cellObj, i, x, y)
	end)
end

function WmzBattleMapMO:zoneCount()
	local zoneCOList = self:getZoneCOList()

	return #zoneCOList
end

function WmzBattleMapMO:clearZoneCnt()
	return self._clearZoneCnt or 0
end

function WmzBattleMapMO:setClearZoneCnt(value)
	self._clearZoneCnt = GameUtil.clamp(value, 0, self:zoneCount())
end

function WmzBattleMapMO:setEnergy(value)
	self._curEnergy = GameUtil.clamp(value, 0, self:maxEnergy())
end

function WmzBattleMapMO:curEnergy()
	return self._curEnergy
end

function WmzBattleMapMO:maxEnergy()
	local CO = self:getGameCO()

	return CO.maxEnergy or -1
end

function WmzBattleMapMO:getTileIdListByGroup(groupId)
	local tileIdList = self._groupId2TileIdxList[groupId]

	return tileIdList or {}
end

function WmzBattleMapMO:getZoneIdListByGroup(zoneId)
	local tileIdList = self._zoneId2TileIdxList[zoneId]

	return tileIdList or {}
end

function WmzBattleMapMO:restartZone(zoneId)
	if not zoneId or zoneId == 0 then
		return
	end

	self:foreachCell(function(cellObj, i, x, y)
		if cellObj:zoneId() ~= zoneId then
			return
		end

		local tileObj = cellObj:getTile()

		if tileObj then
			tileObj:resetToInit()
		end

		cellObj:resetToInit()
	end)
	self:_bindTiles()
end

function WmzBattleMapMO:curPlayingZoneIndex()
	local clearZoneCnt = self:clearZoneCnt()

	return clearZoneCnt + 1
end

function WmzBattleMapMO:curPlayingZoneId()
	return (self:zoneIndex2ZoneId(self:curPlayingZoneIndex()))
end

function WmzBattleMapMO:restartCurZone()
	local zoneId = self:curPlayingZoneId()

	if zoneId == 0 then
		return
	end

	local zoneCO = WmzConfig.instance:getZoneCO(zoneId)

	if not zoneCO then
		return
	end

	self:restartZone(zoneId)
end

function WmzBattleMapMO:zoneIndex2ZoneId(zoneIndex)
	local gameCO = self:getGameCO()
	local mem = "zoneId" .. tostring(zoneIndex)

	return gameCO[mem] or 0
end

function WmzBattleMapMO:getZoneId2Index(zoneId)
	local dict = self:getZoneId2IndexDict()

	if not dict then
		return -1
	end

	return dict[zoneId] or -1
end

function WmzBattleMapMO:isZoneCompleted(zoneId)
	if not zoneId or zoneId <= 0 then
		return false
	end

	local bHasZoneMember = false

	for _, gridObj in ipairs(self._wireList) do
		if gridObj:zoneId() == zoneId then
			bHasZoneMember = true

			if not gridObj:bWelded() then
				return false
			end
		end
	end

	return bHasZoneMember
end

return WmzBattleMapMO
