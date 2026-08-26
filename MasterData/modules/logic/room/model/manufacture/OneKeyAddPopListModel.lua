-- chunkname: @modules/logic/room/model/manufacture/OneKeyAddPopListModel.lua

module("modules.logic.room.model.manufacture.OneKeyAddPopListModel", package.seeall)

local OneKeyAddPopListModel = class("OneKeyAddPopListModel", ListScrollModel)

OneKeyAddPopListModel.MINI_COUNT = 1

local NO_MAT_ITEM_TYPE = 1
local NO_MAT_ITEM_HEIGHT = 200
local NEED_MAT_ITEM_TYPE = 2
local NEED_MAT_ITEM_HEIGHT = 262

function OneKeyAddPopListModel:onInit()
	self:clear()
end

function OneKeyAddPopListModel:clear()
	OneKeyAddPopListModel.super.clear(self)

	self._strCache = nil

	self:setSelectedManufactureItem()
end

function OneKeyAddPopListModel:resetSelectManufactureItemFromCache()
	self._strCache = self._strCache or GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.RoomManufactureOneKeyCustomize, "")

	local cacheData = string.splitToNumber(self._strCache or "", "|")

	self:setSelectedManufactureItem(cacheData[1], cacheData[2])
end

function OneKeyAddPopListModel:recordSelectManufactureItem()
	local curManufactureItem, curCount = self:getSelectedManufactureItem()

	if curManufactureItem then
		self._strCache = string.format("%s|%s", curManufactureItem, curCount)

		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.RoomManufactureOneKeyCustomize, self._strCache)
	end
end

function OneKeyAddPopListModel:setOneKeyFormulaItemList(buildingUidList)
	local dict = {}
	local list = {}

	self._isNoMat = true

	local repeatCheckDict = {}

	for _, buildingUid in ipairs(buildingUidList) do
		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

		if buildingMO then
			local buildingId = buildingMO.buildingId
			local buildingType = RoomConfig.instance:getBuildingType(buildingId)

			self._isNoMat = buildingType == RoomBuildingEnum.BuildingType.Collect

			local buildingLevel = buildingMO:getLevel()
			local allManufactureItemList = ManufactureConfig.instance:getAllManufactureItems(buildingId)

			for _, manufactureItemId in ipairs(allManufactureItemList) do
				local unitCount = ManufactureConfig.instance:getUnitCount(manufactureItemId)
				local itemId = ManufactureConfig.instance:getItemId(manufactureItemId)

				if not repeatCheckDict[itemId] or unitCount < repeatCheckDict[itemId] then
					local needLevel = ManufactureConfig.instance:getManufactureItemNeedLevel(buildingId, manufactureItemId)

					if needLevel <= buildingLevel then
						dict[itemId] = {
							id = manufactureItemId,
							buildingUid = buildingUid
						}
						repeatCheckDict[itemId] = unitCount
					end
				end
			end
		end
	end

	for _, mo in pairs(dict) do
		list[#list + 1] = mo
	end

	table.sort(list, ManufactureFormulaListModel.sortFormula)
	self:setList(list)
end

function OneKeyAddPopListModel:setSelectedManufactureItem(manufactureItemId, count)
	self._selectedManufacture = manufactureItemId
	self._selectedManufactureCount = count or OneKeyAddPopListModel.MINI_COUNT
end

function OneKeyAddPopListModel:getInfoList(scrollGO)
	local mixCellInfos = {}
	local list = self:getList()

	if not list or #list <= 0 then
		return mixCellInfos
	end

	for i, mo in ipairs(list) do
		if self._isNoMat then
			if not NO_MAT_ITEM_TYPE then
				local mixType = NEED_MAT_ITEM_TYPE

				if self._isNoMat then
					if not NO_MAT_ITEM_HEIGHT then
						local cellHeight = NEED_MAT_ITEM_HEIGHT

						table.insert(mixCellInfos, SLFramework.UGUI.MixCellInfo.New(mixType, cellHeight, nil))
					end
				end
			end
		end
	end

	return mixCellInfos
end

function OneKeyAddPopListModel:getSelectedManufactureItem()
	if not self._strCache then
		self:resetSelectManufactureItemFromCache()
	end

	return self._selectedManufacture, self._selectedManufactureCount or OneKeyAddPopListModel.MINI_COUNT
end

function OneKeyAddPopListModel:getTabDataList()
	local result = {}
	local typeDict = {}
	local allPlacedManufactureBuildingList = ManufactureModel.instance:getAllPlacedManufactureBuilding()

	for _, buildingMO in ipairs(allPlacedManufactureBuildingList) do
		local buildingId = buildingMO.buildingId
		local buildingType = RoomConfig.instance:getBuildingType(buildingId)
		local typeList = typeDict[buildingType]

		if not typeList then
			typeList = {}
			typeDict[buildingType] = typeList
		end

		typeList[#typeList + 1] = buildingMO.id
	end

	for buildingType, buildingUidList in pairs(typeDict) do
		if buildingType == RoomBuildingEnum.BuildingType.Collect then
			result[#result + 1] = buildingUidList
		else
			for _, buildingUid in ipairs(buildingUidList) do
				result[#result + 1] = {
					buildingUid
				}
			end
		end
	end

	return result
end

OneKeyAddPopListModel.instance = OneKeyAddPopListModel.New()

return OneKeyAddPopListModel
