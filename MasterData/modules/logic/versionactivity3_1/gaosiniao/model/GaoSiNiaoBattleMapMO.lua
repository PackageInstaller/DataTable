-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/model/GaoSiNiaoBattleMapMO.lua

local ti = table.insert

module("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoBattleMapMO", package.seeall)

local GaoSiNiaoBattleMapMO = class("GaoSiNiaoBattleMapMO")

local function _find(self, x)
	if x ~= self._p[x] then
		self._p[x] = _find(self, self._p[x])
	end

	return self._p[x]
end

local function _merge(self, x, y)
	self._p[_find(self, y)] = _find(self, x)
end

local function _isConned(self, x, y)
	return _find(self, x) == _find(self, y)
end

local function _single(self, x)
	self._p[x] = x
end

local function _configInst()
	return GaoSiNiaoController.instance:config()
end

function GaoSiNiaoBattleMapMO:_dragContext()
	return GaoSiNiaoBattleModel.instance:dragContext()
end

function GaoSiNiaoBattleMapMO:isPlacedBagItem(gridItem)
	return self:_dragContext():isPlacedBagItem(gridItem)
end

function GaoSiNiaoBattleMapMO:getPlacedBagItem(gridItem)
	return self:_dragContext():getPlacedBagItem(gridItem)
end

function GaoSiNiaoBattleMapMO:ctor()
	self._gridList = {}
	self._pt2BagDict = {}
	self._p = {}
	self._startGridList = {}
	self._endGridList = {}
	self._portalGridList = {}
	self._whoActivedPortalGrid = false
	self.__last_whoActivedPortalGrid = false
end

function GaoSiNiaoBattleMapMO.default_ctor(Self, memberName, eVersion)
	local mapMO = GaoSiNiaoBattleMapMO.New()

	mapMO.__info = GaoSiNiaoMapInfo.New(eVersion or GaoSiNiaoEnum.Version.V1_0_0)
	Self[memberName] = mapMO
end

function GaoSiNiaoBattleMapMO:createMapByEpisodeId(episodeId)
	local episodeCO = _configInst():getEpisodeCO(episodeId)

	self:createMapById(episodeCO.gameId)
end

function GaoSiNiaoBattleMapMO:createMapById(mapId)
	mapId = mapId or 0

	local mapCO = self.__info:reset(mapId)

	self:_createMap(mapCO)
end

function GaoSiNiaoBattleMapMO:_createMap(mapCO)
	self:_createGrids(mapCO)
	self:_createBags(mapCO)
end

function GaoSiNiaoBattleMapMO:_createGrids(mapCO)
	self._gridList = {}
	self._startGridList = {}
	self._endGridList = {}
	self._portalGridList = {}
	self._p = {}
	self._whoActivedPortalGrid = false
	self.__last_whoActivedPortalGrid = false

	if not mapCO.gridList then
		return
	end

	GaoSiNiaoBattleMapMO.s_foreachGrid(mapCO.width, mapCO.height, function(i, x, y)
		local gridInfo = mapCO.gridList[i]
		local index = {
			x,
			y
		}
		local item = GaoSiNiaoMapGrid.New(self, index, gridInfo)

		item:setId(i)

		self._gridList[i] = item
		self._p[i] = i

		if item:isStart() then
			ti(self._startGridList, item)
		elseif item:isEnd() then
			ti(self._endGridList, item)
		elseif item:isPortal() then
			ti(self._portalGridList, item)
		end
	end)
	self:foreachGrid(function(gridItem)
		gridItem:setDistanceToStartByStartGrid(self._startGridList[1])
	end)
	self:tryMergeAll()
end

function GaoSiNiaoBattleMapMO:_createBags(mapCO)
	self._pt2BagDict = {}

	if not mapCO.bagList then
		return
	end

	for _, bagInfo in ipairs(mapCO.bagList) do
		local ptype = bagInfo.ptype
		local count = bagInfo.count

		if not self._pt2BagDict[ptype] then
			self._pt2BagDict[ptype] = GaoSiNiaoMapBag.New(self, ptype, count)
		else
			self._pt2BagDict[ptype]:addCnt(count)
		end
	end
end

function GaoSiNiaoBattleMapMO:tryMergeAll(dirtyGridItemList)
	self._tmpPortalConnedInfoList = {}

	for _, gridItem in ipairs(self._startGridList) do
		self:_refreshUnionFind_Impl(gridItem)
	end

	dirtyGridItemList = dirtyGridItemList or self:gridDataList()

	self:_tryMergeAll_AppendPortal(dirtyGridItemList)
	table.sort(dirtyGridItemList, function(a, b)
		local a_isPortal = a:isPortal() and 1 or 0
		local b_isPortal = b:isPortal() and 1 or 0

		if a_isPortal ~= b_isPortal then
			return a_isPortal < b_isPortal
		end

		local a_dist = a:distanceToStart()
		local b_dist = b:distanceToStart()

		if a_dist ~= b_dist then
			return a_dist < b_dist
		end

		return a:id() < b:id()
	end)

	local set = {}

	for _, gridItem in ipairs(dirtyGridItemList) do
		if not set[gridItem] then
			set[gridItem] = true

			self:_refreshUnionFind_Impl(gridItem)
		end
	end

	self:_onPostTryMergeAll()
end

function GaoSiNiaoBattleMapMO:_tryMergeAll_AppendPortal(dirtyGridItemList)
	if self:isActivedPortal() then
		return
	end

	local whoActivedPortalGrid = self.__last_whoActivedPortalGrid

	self.__last_whoActivedPortalGrid = false

	for _, gridPortalItem in ipairs(self._portalGridList) do
		if not gridPortalItem:isRoot() then
			_single(self, gridPortalItem:id())
		end

		if self:isConnedStart(gridPortalItem) then
			if whoActivedPortalGrid and self:isConned(gridPortalItem, whoActivedPortalGrid) then
				local relativeZoneMask = whoActivedPortalGrid:getRelativeZoneMask(gridPortalItem)

				if relativeZoneMask ~= GaoSiNiaoEnum.ZoneMask.None then
					ti(self._tmpPortalConnedInfoList, {
						owner = whoActivedPortalGrid,
						portalGrid = gridPortalItem,
						relativeZoneMask = relativeZoneMask
					})

					whoActivedPortalGrid = false
				end
			end

			local neighborGridList = gridPortalItem:getNeighborGridList()

			for i = 1, 4 do
				local neighborGridItem = neighborGridList[i]
				local relativeZoneMask = GaoSiNiaoEnum.bitPos2Dir(i - 1)

				if neighborGridItem and self:isConned(gridPortalItem, neighborGridItem) then
					ti(self._tmpPortalConnedInfoList, {
						owner = neighborGridItem,
						portalGrid = gridPortalItem,
						relativeZoneMask = GaoSiNiaoEnum.flipDir(relativeZoneMask)
					})
				end
			end
		end

		ti(dirtyGridItemList, gridPortalItem)
	end
end

function GaoSiNiaoBattleMapMO:_onPostTryMergeAll()
	if next(self._tmpPortalConnedInfoList) then
		if not self:isActivedPortal() then
			for _, v in ipairs(self._tmpPortalConnedInfoList) do
				if self:isConnedStart(v.owner) then
					self:onActivePortals(v.owner, v.portalGrid, v.relativeZoneMask)

					break
				end
			end
		end

		self._tmpPortalConnedInfoList = nil
	end

	if self:isActivedPortal() then
		for _, gridPortalItem in ipairs(self._portalGridList) do
			self:_refreshUnionFind_Impl(gridPortalItem, true)
		end
	end
end

function GaoSiNiaoBattleMapMO:_mergeNeighborIfNotConned_Impl(gridItem, neighborGridItem, relativeZoneMask, noSave)
	if not neighborGridItem then
		return
	end

	if self:isConned(gridItem, neighborGridItem) then
		return
	end

	if not gridItem:_internal_tryConnNeighbor(neighborGridItem, relativeZoneMask) then
		return
	end

	if not self:isActivedPortal() and (gridItem:isPortal() or neighborGridItem:isPortal()) then
		self:_mergeNeighborPortalIfNotConned_Impl(gridItem, neighborGridItem, relativeZoneMask, noSave)
	else
		self:merge(gridItem, neighborGridItem)
	end
end

function GaoSiNiaoBattleMapMO:_mergeNeighborPortalIfNotConned_Impl(gridItem, neighborGridItem, relativeZoneMask, noSave)
	if self:isActivedPortal() then
		return
	end

	if neighborGridItem:isPortal() then
		self:_savePortalConnIfNotConned(gridItem, neighborGridItem, relativeZoneMask, noSave)
	elseif gridItem:isPortal() then
		self:_savePortalConnIfNotConned(neighborGridItem, gridItem, GaoSiNiaoEnum.flipDir(relativeZoneMask), noSave)
	end
end

function GaoSiNiaoBattleMapMO:_savePortalConnIfNotConned(ownerGridItem, neighborPortalGridItem, relativeZoneMask, noSave)
	if self:isConnedStart(ownerGridItem) then
		self:onActivePortals(ownerGridItem, neighborPortalGridItem, relativeZoneMask)
	elseif not noSave then
		ti(self._tmpPortalConnedInfoList, {
			owner = ownerGridItem,
			portalGrid = neighborPortalGridItem,
			relativeZoneMask = relativeZoneMask
		})
	end
end

function GaoSiNiaoBattleMapMO:whoActivedPortalGrid()
	return self._whoActivedPortalGrid
end

function GaoSiNiaoBattleMapMO:isActivedPortal()
	return not not self._whoActivedPortalGrid
end

function GaoSiNiaoBattleMapMO:onActivePortals(reqGrid, respPortalGrid, relativeZoneMask)
	assert(respPortalGrid:isPortal())

	self._whoActivedPortalGrid = reqGrid

	self:merge(reqGrid, respPortalGrid)
	respPortalGrid:set_forceInZoneMask(relativeZoneMask)
	respPortalGrid:set_forceOutZoneMask(GaoSiNiaoEnum.ZoneMask.None)

	for _, anotherPortalGridItem in ipairs(self._portalGridList) do
		if anotherPortalGridItem ~= respPortalGrid then
			anotherPortalGridItem:set_forceInZoneMask(GaoSiNiaoEnum.flipDir(relativeZoneMask))
			anotherPortalGridItem:set_forceOutZoneMask(relativeZoneMask)
			self:merge(reqGrid, anotherPortalGridItem)

			break
		end
	end
end

function GaoSiNiaoBattleMapMO:onDisactivePortals()
	for _, gridItem in ipairs(self._portalGridList) do
		gridItem:set_forceInZoneMask(false)
		gridItem:set_forceOutZoneMask(false)
	end

	if self.__last_whoActivedPortalGrid == false then
		self.__last_whoActivedPortalGrid = self._whoActivedPortalGrid
	end

	self._whoActivedPortalGrid = false
end

function GaoSiNiaoBattleMapMO:_refreshUnionFind_Impl(gridItem, noSave)
	local neighborGridList = gridItem:getNeighborGridList()

	for i, neighborGridItem in ipairs(neighborGridList) do
		local relativeZoneMask = GaoSiNiaoEnum.bitPos2Dir(i - 1)

		self:_mergeNeighborIfNotConned_Impl(gridItem, neighborGridItem, relativeZoneMask, noSave)
	end
end

function GaoSiNiaoBattleMapMO:bagList()
	local list = {}

	for _, bagItem in pairs(self._pt2BagDict or {}) do
		ti(list, bagItem)
	end

	table.sort(list, function(a, b)
		return a.type < b.type
	end)

	return list
end

function GaoSiNiaoBattleMapMO:gridDataList()
	local list = {}

	self:foreachGrid(function(gridItem)
		ti(list, gridItem)
	end)

	return list
end

function GaoSiNiaoBattleMapMO:mapId()
	return self.__info.mapId
end

function GaoSiNiaoBattleMapMO:mapSize()
	return self.__info:mapSize()
end

function GaoSiNiaoBattleMapMO:rowCol()
	local col, row = self:mapSize()

	return row, col
end

function GaoSiNiaoBattleMapMO:getGrid(x, y)
	local w, h = self:mapSize()

	if x < 0 or y < 0 or w <= x or h <= y then
		return nil
	end

	return self._gridList[y * w + x]
end

function GaoSiNiaoBattleMapMO:foreachGrid(handler)
	local w, h = self:mapSize()

	GaoSiNiaoBattleMapMO.s_foreachGrid(w, h, function(i, x, y)
		handler(self._gridList[i], i, x, y)
	end)
end

function GaoSiNiaoBattleMapMO:isConnedStart(gridItem)
	if #self._startGridList == 0 then
		return false
	end

	for _, startGridItem in ipairs(self._startGridList) do
		if self:isConned(gridItem, startGridItem) then
			return true
		end
	end

	return false
end

function GaoSiNiaoBattleMapMO:isCompleted()
	local needConnCnt = #self._endGridList

	if needConnCnt == 0 then
		logError("Invalid Map")

		return false
	end

	for _, endGridItem in ipairs(self._endGridList) do
		if self:isConnedStart(endGridItem) then
			needConnCnt = needConnCnt - 1
		end
	end

	return needConnCnt == 0
end

function GaoSiNiaoBattleMapMO:merge(gridItemA, gridItemB)
	local x = gridItemA:id()
	local y = gridItemB:id()

	if self:rootIsStart(gridItemB) then
		_merge(self, y, x)
	elseif self:rootIsEnd(gridItemA) then
		_merge(self, y, x)
	else
		_merge(self, x, y)
	end
end

function GaoSiNiaoBattleMapMO:isConned(gridItemA, gridItemB)
	local x = gridItemA:id()
	local y = gridItemB:id()

	return _isConned(self, x, y)
end

function GaoSiNiaoBattleMapMO:rootId(gridItem)
	return _find(self, gridItem:id())
end

function GaoSiNiaoBattleMapMO:rootIsStart(gridItem)
	for _, startGridItem in ipairs(self._startGridList) do
		if self:rootId(gridItem) == startGridItem:id() then
			return true
		end
	end

	return false
end

function GaoSiNiaoBattleMapMO:rootIsEnd(gridItem)
	for _, endGridItem in ipairs(self._endGridList) do
		if self:rootId(gridItem) == endGridItem:id() then
			return true
		end
	end

	return false
end

function GaoSiNiaoBattleMapMO:single(gridItemListToSingle, isKeepDirty)
	if type(gridItemListToSingle) ~= "table" then
		return {}
	end

	if #gridItemListToSingle == 0 then
		return {}
	end

	local hh = 1
	local tt = 0
	local q = {}

	local function _pop()
		hh = hh + 1

		return q[hh]
	end

	local function _append(obj)
		tt = tt + 1
		q[tt] = obj
	end

	local idToSingleSet = {}
	local isStartIdNeedToSingle = false
	local tmpAppendedSet = {}

	for _, gridItemToSingle in ipairs(gridItemListToSingle) do
		local idToSingle = gridItemToSingle:id()
		local rootIdToSingle = self:rootId(gridItemToSingle)

		idToSingleSet[rootIdToSingle] = true
		idToSingleSet[idToSingle] = true

		if self:isConnedStart(gridItemToSingle) then
			isStartIdNeedToSingle = true
		end

		_append(gridItemToSingle)

		tmpAppendedSet[rootIdToSingle] = true
		tmpAppendedSet[gridItemToSingle:id()] = true
	end

	self:foreachGrid(function(gridItem)
		if not tmpAppendedSet[gridItem:id()] and idToSingleSet[self:rootId(gridItem)] then
			_append(gridItem)

			tmpAppendedSet[gridItem:id()] = true
		end
	end)

	local set = {}

	for _, startGridItem in ipairs(self._startGridList) do
		set[startGridItem] = true

		if isStartIdNeedToSingle then
			local idToSingle = self:rootId(startGridItem)

			idToSingleSet[idToSingle] = true

			_single(self, startGridItem:id())
		end
	end

	if self:isActivedPortal() then
		self:onDisactivePortals()

		for _, gridPortalItem in ipairs(self._portalGridList) do
			if not tmpAppendedSet[gridPortalItem:id()] then
				_append(gridPortalItem)

				tmpAppendedSet[gridPortalItem:id()] = true
			end
		end
	end

	local dirtyGridItemList = {}

	while hh <= tt do
		local gridItem = _pop()

		set[gridItem] = true

		for i = 1, 4 do
			local x = gridItem:x() + GaoSiNiaoEnum.dX[i]
			local y = gridItem:y() + GaoSiNiaoEnum.dY[i]
			local neighborGridItem = self:getGrid(x, y)

			if neighborGridItem and not set[neighborGridItem] and idToSingleSet[self:rootId(neighborGridItem)] then
				_append(neighborGridItem)
			end
		end

		_single(self, gridItem:id())
		ti(dirtyGridItemList, gridItem)
	end

	if not isKeepDirty then
		self:tryMergeAll(dirtyGridItemList)
	end

	return dirtyGridItemList
end

function GaoSiNiaoBattleMapMO.s_foreachGrid(w, h, handler)
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

return GaoSiNiaoBattleMapMO
