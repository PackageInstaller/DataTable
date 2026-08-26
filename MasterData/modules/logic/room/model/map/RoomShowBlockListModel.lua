-- chunkname: @modules/logic/room/model/map/RoomShowBlockListModel.lua

module("modules.logic.room.model.map.RoomShowBlockListModel", package.seeall)

local RoomShowBlockListModel = class("RoomShowBlockListModel", ListScrollModel)

function RoomShowBlockListModel:onInit()
	self:_clearData()
end

function RoomShowBlockListModel:reInit()
	self:_clearData()
end

function RoomShowBlockListModel:clear()
	RoomShowBlockListModel.super.clear(self)
	self:_clearData()
end

function RoomShowBlockListModel:_clearData()
	self:clearMapData()

	self._curPreviewIndex = 0
end

function RoomShowBlockListModel:clearMapData()
	RoomShowBlockListModel.super.clear(self)

	self._selectBlockId = nil
	self._packageId = nil
	self._selectIndex = 1
end

function RoomShowBlockListModel:addScrollView(scrollView)
	RoomShowBlockListModel.super.addScrollView(self, scrollView)
end

function RoomShowBlockListModel:setShowBlockList()
	local moList = {}
	local selectBlockId
	local sblockId = RoomInventoryBlockModel.instance:getSelectInventoryBlockId()
	local packageMOList = self:_getPackageMOList()

	for i = 1, #packageMOList do
		local packageMO = packageMOList[i]

		if self._isSelectPackage or self:_checkTheme(packageMO.id) then
			local unUseMOList = packageMO:getUnUseBlockMOList()

			for _, blockMO in ipairs(unUseMOList) do
				if self:_checkBlockMO(blockMO) then
					if sblockId == blockMO.id then
						selectBlockId = sblockId
					end

					table.insert(moList, blockMO)
				end
			end
		end
	end

	table.sort(moList, self._sortFunction)

	if selectBlockId == nil then
		selectBlockId = self:_findSelectId(moList)
	end

	self:setList(moList)
	self:setSelect(selectBlockId)

	self._curPreviewIndex = 0
end

function RoomShowBlockListModel:_getPackageMOList()
	if self._isSelectPackage then
		return {
			RoomInventoryBlockModel.instance:getCurPackageMO()
		}
	end

	return RoomInventoryBlockModel.instance:getInventoryBlockPackageMOList()
end

function RoomShowBlockListModel:_findSelectId(blockMOList)
	if not blockMOList or #blockMOList < 1 then
		return nil
	end

	if self._selectIndex then
		if not blockMOList[self._selectIndex] then
			local blockMO = blockMOList[#blockMOList]

			return (blockMO or nil) and (blockMO.id or nil)
		end
	end
end

function RoomShowBlockListModel._sortFunction(a, b)
	local aBirIndex = RoomShowBlockListModel._getBirthdayBlockIndex(a)
	local bBirIndex = RoomShowBlockListModel._getBirthdayBlockIndex(b)

	if aBirIndex ~= bBirIndex then
		return aBirIndex < bBirIndex
	end

	local aIndex = RoomInventoryBlockModel.instance:getBlockSortIndex(a.packageId, a.id)
	local bIndex = RoomInventoryBlockModel.instance:getBlockSortIndex(b.packageId, b.id)

	if aIndex ~= bIndex then
		return aIndex < bIndex
	end

	if a.packageId ~= b.packageId then
		return a.packageId > b.packageId
	end

	if a.packageOrder ~= b.packageOrder then
		return a.packageOrder < b.packageOrder
	end
end

function RoomShowBlockListModel._getBirthdayBlockIndex(a)
	local aBlockCfg = RoomConfig.instance:getSpecialBlockConfig(a.id)

	if aBlockCfg and RoomCharacterModel.instance:isOnBirthday(aBlockCfg.heroId) then
		return 1
	end

	return 9999
end

function RoomShowBlockListModel:clearSelect()
	for i, view in ipairs(self._scrollViews) do
		view:setSelect(nil)
	end

	self._selectBlockId = nil
end

function RoomShowBlockListModel:_refreshSelect()
	local selectMO
	local moList = self:getList()

	for i, mo in ipairs(moList) do
		if mo.id == self._selectBlockId then
			self._selectIndex = i
			selectMO = mo

			break
		end
	end

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomShowBlockListModel:setSelect(blockId)
	self._selectBlockId = blockId

	RoomInventoryBlockModel.instance:setSelectInventoryBlockId(blockId)
	self:_refreshSelect()
end

function RoomShowBlockListModel:initShowBlock()
	self._packageId = nil
	self._selectIndex = 1

	self:setShowBlockList()
end

function RoomShowBlockListModel:_checkBlockMO(blockMO)
	local blockDefineConfig = blockMO:getBlockDefineCfg()

	if not blockDefineConfig then
		return false
	end

	if not self:_isEmptyList(self._filterExcludeList) then
		for _, resId in ipairs(self._filterExcludeList) do
			if blockDefineConfig.resIdCountDict[resId] then
				return false
			end
		end
	end

	if not self:_isEmptyList(self._filterIncludeList) then
		for _, resId in ipairs(self._filterIncludeList) do
			if blockDefineConfig.resIdCountDict[resId] then
				return true
			end
		end
	else
		return true
	end

	return false
end

function RoomShowBlockListModel:_checkTheme(packageId)
	local tRoomThemeFilterListModel = RoomThemeFilterListModel.instance

	if not tRoomThemeFilterListModel:getIsAll() and tRoomThemeFilterListModel:getSelectCount() > 0 then
		local themeId = RoomConfig.instance:getThemeIdByItem(packageId, MaterialEnum.MaterialType.BlockPackage)

		if not tRoomThemeFilterListModel:isSelectById(themeId) then
			return false
		end
	end

	return true
end

function RoomShowBlockListModel:setIsPackage(isPackage)
	self._isSelectPackage = isPackage == true
end

function RoomShowBlockListModel:getIsPackage()
	return self._isSelectPackage
end

local DEFAULT_START_INDEX = 1
local MIN_PREVIEW_COUNT = 20
local MAX_PREVIEW_COUNT = 100

function RoomShowBlockListModel:getPreviewBlockIdList(startIndex)
	startIndex = startIndex or DEFAULT_START_INDEX

	local resultList = {}
	local list = self:getList()
	local listCount = #list
	local isPreviewAll = listCount <= self._curPreviewIndex
	local isStartIndexValid = startIndex <= listCount
	local remainPreviewCount = self._curPreviewIndex - startIndex
	local isMinPreviewCount = remainPreviewCount <= MIN_PREVIEW_COUNT

	if not isPreviewAll and isStartIndexValid and isMinPreviewCount then
		local endIndex = startIndex + MAX_PREVIEW_COUNT - 1
		local previewIndex

		for i = startIndex, endIndex do
			local blockMO = list[i]

			if not blockMO then
				break
			end

			resultList[#resultList + 1] = blockMO.id
			previewIndex = i
		end

		if previewIndex then
			self._curPreviewIndex = previewIndex
		end
	end

	return resultList
end

function RoomShowBlockListModel:setFilterResType(includeList, excludeList)
	self._filterIncludeList = {}
	self._filterExcludeList = {}

	self:_setList(self._filterIncludeList, includeList)
	self:_setList(self._filterExcludeList, excludeList)
end

function RoomShowBlockListModel:isFilterType(includeList, excludeList)
	if self:_isSameValue(self._filterIncludeList, includeList) and self:_isSameValue(self._filterExcludeList, excludeList) then
		return true
	end

	return false
end

function RoomShowBlockListModel:isFilterTypeEmpty()
	return self:_isEmptyList(self._filterTypeList)
end

function RoomShowBlockListModel:_setList(targetArray, addArray)
	tabletool.addValues(targetArray, addArray)
end

function RoomShowBlockListModel:_isListValue(targetArray, value)
	if value and tabletool.indexOf(targetArray, value) then
		return true
	end

	return false
end

function RoomShowBlockListModel:_isSameValue(targetArray, array)
	if self:_isEmptyList(targetArray) and self:_isEmptyList(array) then
		return true
	end

	if #targetArray ~= #array then
		return false
	end

	for _, value in ipairs(array) do
		if not tabletool.indexOf(targetArray, value) then
			return false
		end
	end

	for _, value in ipairs(targetArray) do
		if not tabletool.indexOf(array, value) then
			return false
		end
	end

	return true
end

function RoomShowBlockListModel:_isEmptyList(targetArray)
	return targetArray == nil or #targetArray < 1
end

RoomShowBlockListModel.instance = RoomShowBlockListModel.New()

return RoomShowBlockListModel
