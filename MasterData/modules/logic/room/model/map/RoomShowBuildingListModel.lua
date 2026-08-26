-- chunkname: @modules/logic/room/model/map/RoomShowBuildingListModel.lua

module("modules.logic.room.model.map.RoomShowBuildingListModel", package.seeall)

local RoomShowBuildingListModel = class("RoomShowBuildingListModel", ListScrollModel)

function RoomShowBuildingListModel:onInit()
	self:_clearData()
end

function RoomShowBuildingListModel:reInit()
	self:_clearData()
end

function RoomShowBuildingListModel:clear()
	RoomShowBuildingListModel.super.clear(self)
	self:_clearData()
end

function RoomShowBuildingListModel:_clearData()
	self:clearMapData()
	self:clearFilterData()
end

function RoomShowBuildingListModel:clearMapData()
	RoomShowBuildingListModel.super.clear(self)

	self._selectBuildingUid = nil
end

function RoomShowBuildingListModel:clearFilterData()
	self._filterTypeList = {}
	self._filterOccupyIdList = {}
	self._filerUseList = {}
	self._filterResIdList = {}
	self._isRareDown = true
end

function RoomShowBuildingListModel:getEmptyCount()
	if not self._emptyCount then
		return 0
	end

	return self._emptyCount
end

function RoomShowBuildingListModel:setShowBuildingList()
	local moList = {}
	local unUseDic = {}
	local useDic = {}
	local buildingIdDict = {}
	local infoList = RoomModel.instance:getBuildingInfoList()
	local temp = RoomMapBuildingModel.instance:getTempBuildingMO()

	for i = 1, #infoList do
		local info = infoList[i]
		local isUse = not not RoomMapBuildingModel.instance:getBuildingMOById(info.uid)

		if not info.buildingId then
			local buildingId = info.defineId

			buildingIdDict[buildingId] = true

			if temp and temp.id == info.uid then
				isUse = not RoomInventoryBuildingModel.instance:getBuildingMOById(info.uid)
			end

			if self:_checkInfoShow(buildingId, isUse) then
				local uId = info.uid

				if isUse then
					local showBuildingMO = true

					if not useDic[uId] then
						showBuildingMO = not isUse and unUseDic[buildingId] or false
					end

					if not showBuildingMO then
						showBuildingMO = RoomShowBuildingMO.New()

						showBuildingMO:init(info)
						table.insert(moList, showBuildingMO)

						if not isUse then
							unUseDic[buildingId] = showBuildingMO
						end

						useDic[uId] = showBuildingMO
					end

					showBuildingMO.use = isUse

					showBuildingMO:add(info.uid, info.level)
				end
			end
		end
	end

	local cfgList = lua_manufacture_building.configList
	local buildingCfgList = RoomConfig.instance:getBuildingConfigList()
	local buyInfo = {
		use = false,
		isNeedToBuy = true
	}
	local tradeLevel = ManufactureModel.instance:getTradeLevel()

	for i = 1, #cfgList do
		local manuCfg = cfgList[i]
		local buildingId = manuCfg.id
		local buildingCfg = RoomConfig.instance:getBuildingConfig(buildingId)

		if buildingCfg and tradeLevel and tradeLevel >= manuCfg.placeTradeLevel and manuCfg.placeNoCost ~= 1 and not buildingIdDict[buildingId] then
			buildingIdDict[buildingId] = true

			if self:_checkInfoShow(buildingId, buyInfo.use) then
				buyInfo.uid = -buildingId
				buyInfo.buildingId = buildingId

				local showBuildingMO = RoomShowBuildingMO.New()

				buyInfo.isBuyNoCost = manuCfg.placeNoCost == 1

				showBuildingMO:init(buyInfo)
				showBuildingMO:add(buyInfo.uid, 0)
				table.insert(moList, showBuildingMO)
			end
		end
	end

	table.sort(moList, self._sortFunction)

	self._emptyCount = 0

	for i = #moList + 1, 4 do
		local emptyMO = RoomShowBuildingMO.New()

		emptyMO.id = -i
		self._emptyCount = self._emptyCount + 1

		table.insert(moList, 1, emptyMO)
	end

	self:setList(moList)
	RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingListOnDataChanged)
	self:_refreshSelect()
end

function RoomShowBuildingListModel:setItemAnchorX(x)
	self._itemAnchorX = x or 0
end

function RoomShowBuildingListModel:getItemAnchorX()
	return self._itemAnchorX or 0
end

function RoomShowBuildingListModel:_checkInfoShow(buildingId, isUse)
	if not self:isFilterUseEmpty() and not self:isFilterUse(isUse and 1 or 0) then
		return false
	end

	local config = RoomConfig.instance:getBuildingConfig(buildingId)

	if not config or config.buildingType == RoomBuildingEnum.BuildingType.Transport then
		return false
	end

	if not self:isFilterOccupyIdEmpty() then
		local areaConfig = RoomConfig.instance:getBuildingAreaConfig(config.areaId)

		if not config or not self:isFilterOccupy(areaConfig.occupy) then
			return false
		end
	end

	if not self:isFilterTypeEmpty() and (not config or not self:isFilterType(config.buildingType)) then
		return false
	end

	if not self:_isEmptyList(self._filterResIdList) and not self:_checkResource(buildingId) and not self:_checkPlaceBuilding(buildingId) then
		return false
	end

	if not self:_checkTheme(buildingId) then
		return false
	end

	return true
end

function RoomShowBuildingListModel:_checkTheme(buildingId)
	local tRoomThemeFilterListModel = RoomThemeFilterListModel.instance

	if not tRoomThemeFilterListModel:getIsAll() and tRoomThemeFilterListModel:getSelectCount() > 0 then
		local themeId = RoomConfig.instance:getThemeIdByItem(buildingId, MaterialEnum.MaterialType.Building)

		if not tRoomThemeFilterListModel:isSelectById(themeId) then
			return false
		end
	end

	return true
end

function RoomShowBuildingListModel:_checkResource(buildingId)
	local costRes = RoomBuildingHelper.getCostResource(buildingId)

	if costRes then
		for i = 1, #costRes do
			if self:isFilterType(costRes[i]) then
				return true
			end
		end
	end

	return false
end

function RoomShowBuildingListModel:_checkPlaceBuilding(buildingId)
	local resIdList = self._filterCostResList

	if resIdList and #resIdList > 0 then
		local tRoomConfig = RoomConfig.instance

		for i = 1, #resIdList do
			local paramCfg = tRoomConfig:getResourceParam(resIdList[i])

			if paramCfg and paramCfg.placeBuilding and tabletool.indexOf(paramCfg.placeBuilding, buildingId) then
				return true
			end
		end
	end

	return false
end

function RoomShowBuildingListModel._sortFunction(x, y)
	if x.isNeedToBuy ~= y.isNeedToBuy then
		if x.isNeedToBuy then
			return true
		end

		return false
	end

	if x.use and not y.use then
		return false
	elseif not x.use and y.use then
		return true
	end

	if x:isDecoration() and not y:isDecoration() then
		return false
	elseif not x:isDecoration() and y:isDecoration() then
		return true
	end

	if x.config.rare ~= y.config.rare then
		if RoomShowBuildingListModel.instance:isRareDown() then
			return x.config.rare > y.config.rare
		else
			return x.config.rare < y.config.rare
		end
	end

	if x.config.id ~= y.config.id then
		return x.config.id < y.config.id
	end

	return x.id < y.id
end

function RoomShowBuildingListModel:setRareDown(isRareDown)
	self._isRareDown = isRareDown
end

function RoomShowBuildingListModel:isRareDown()
	return self._isRareDown
end

function RoomShowBuildingListModel:setFilterType(typeList)
	self._filterTypeList = {}

	self:_setList(self._filterTypeList, typeList)
end

function RoomShowBuildingListModel:addFilterType(typeId)
	self:_addListValue(self._filterTypeList, typeId)
end

function RoomShowBuildingListModel:removeFilterType(typeId)
	self:_removeListValue(self._filterTypeList, typeId)
end

function RoomShowBuildingListModel:isFilterType(typeId)
	return self:_isListValue(self._filterTypeList, typeId)
end

function RoomShowBuildingListModel:isFilterTypeEmpty()
	return self:_isEmptyList(self._filterTypeList)
end

function RoomShowBuildingListModel:setFilterOccupy(occupyIdList)
	self._filterOccupyIdList = {}

	self:_setList(self._filterOccupyIdList, occupyIdList)
end

function RoomShowBuildingListModel:addFilterOccupy(occupyId)
	self:_addListValue(self._filterOccupyIdList, occupyId)
end

function RoomShowBuildingListModel:removeFilterOccupy(occupyId)
	self:_removeListValue(self._filterOccupyIdList, occupyId)
end

function RoomShowBuildingListModel:isFilterOccupy(occupyId)
	return self:_isListValue(self._filterOccupyIdList, occupyId)
end

function RoomShowBuildingListModel:isFilterOccupyIdEmpty()
	return self:_isEmptyList(self._filterOccupyIdList)
end

function RoomShowBuildingListModel:setFilterUse(useList)
	self._filerUseList = {}

	self:_setList(self._filerUseList, useList)
end

function RoomShowBuildingListModel:addFilterUse(use)
	self:_addListValue(self._filerUseList, use)
end

function RoomShowBuildingListModel:removeFilterUse(use)
	self:_removeListValue(self._filerUseList, use)
end

function RoomShowBuildingListModel:isFilterUse(use)
	return self:_isListValue(self._filerUseList, use)
end

function RoomShowBuildingListModel:isFilterUseEmpty()
	return self._filerUseList == nil or #self._filerUseList == 0
end

function RoomShowBuildingListModel:_setList(targetArray, addArray)
	tabletool.addValues(targetArray, addArray)
end

function RoomShowBuildingListModel:_isListValue(targetArray, value)
	if value and tabletool.indexOf(targetArray, value) then
		return true
	end

	return false
end

function RoomShowBuildingListModel:_addListValue(targetArray, value)
	if value == nil then
		return
	end

	if targetArray and not tabletool.indexOf(targetArray, value) then
		table.insert(targetArray, value)
	end
end

function RoomShowBuildingListModel:_removeListValue(targetArray, value)
	if value == nil then
		return
	end

	tabletool.removeValue(targetArray, value)
end

function RoomShowBuildingListModel:_isEmptyList(targetArray)
	return targetArray == nil or #targetArray < 1
end

function RoomShowBuildingListModel:clearSelect()
	for i, view in ipairs(self._scrollViews) do
		view:setSelect(nil)
	end

	self._selectBuildingUid = nil
end

function RoomShowBuildingListModel:_refreshSelect()
	local selectMO
	local moList = self:getList()

	for i, mo in ipairs(moList) do
		if mo.id == self._selectBuildingUid then
			selectMO = mo
		end
	end

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomShowBuildingListModel:setSelect(buildingUid)
	self._selectBuildingUid = buildingUid

	self:_refreshSelect()
end

function RoomShowBuildingListModel:initShowBuilding()
	self:setShowBuildingList()
end

function RoomShowBuildingListModel:initFilter()
	self:setFilterType()
	self:setFilterOccupy()
	self:setFilterUse()
end

RoomShowBuildingListModel.instance = RoomShowBuildingListModel.New()

return RoomShowBuildingListModel
