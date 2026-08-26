-- chunkname: @modules/logic/room/model/debug/RoomDebugPlaceListModel.lua

module("modules.logic.room.model.debug.RoomDebugPlaceListModel", package.seeall)

local RoomDebugPlaceListModel = class("RoomDebugPlaceListModel", ListScrollModel)

function RoomDebugPlaceListModel:onInit()
	self:_clearData()
end

function RoomDebugPlaceListModel:reInit()
	self:_clearData()
end

function RoomDebugPlaceListModel:clear()
	RoomDebugPlaceListModel.super.clear(self)
	self:_clearData()
end

function RoomDebugPlaceListModel:_clearData()
	self._selectDefineId = nil
	self._filterCategory = nil
	self._filterPackageId = nil
	self._defineIdToBlockId = nil
end

function RoomDebugPlaceListModel:setFilterPackageId(packageId)
	if self._filterPackageId == packageId then
		self._filterPackageId = nil
	else
		self._filterPackageId = packageId
	end
end

function RoomDebugPlaceListModel:isFilterPackageId(packageId)
	return self._filterPackageId == packageId
end

function RoomDebugPlaceListModel:setDebugPlaceList()
	local moList = {}
	local filterDefindIds

	if self._filterPackageId then
		filterDefindIds = {}

		local dict = lua_block_package_data.packageDict[self._filterPackageId]

		if dict then
			for _, v in pairs(dict) do
				filterDefindIds[v.defineId] = true
			end
		end
	end

	if not self._defineIdToBlockId then
		self._defineIdToBlockId = {}

		local blockIds = {}

		for packageId, dict in pairs(lua_block_package_data.packageDict) do
			for _, cfg in pairs(dict) do
				self._defineIdToBlockId[cfg.defineId] = cfg.blockId

				table.insert(blockIds, cfg.blockId)
			end
		end

		RoomInventoryBlockModel.instance:addSpecialBlockIds(blockIds)
	end

	local blockDefineConfigDict = RoomConfig.instance:getBlockDefineConfigDict()

	for defineId, blockDefineConfig in pairs(blockDefineConfigDict) do
		if self:isFilterCategory(blockDefineConfig.category) and (not filterDefindIds or filterDefindIds[defineId]) then
			local roomDebugPlaceMO = RoomDebugPlaceMO.New()

			roomDebugPlaceMO:init({
				id = defineId,
				blockId = self._defineIdToBlockId[defineId]
			})
			table.insert(moList, roomDebugPlaceMO)
		end
	end

	table.sort(moList, self._sortFunction)
	self:setList(moList)
	self:_refreshSelect()
end

function RoomDebugPlaceListModel._sortFunction(x, y)
	return x.config.defineId < y.config.defineId
end

function RoomDebugPlaceListModel:setFilterCategory(category)
	self._filterCategory = category
end

function RoomDebugPlaceListModel:isFilterCategory(category)
	if string.nilorempty(category) and string.nilorempty(self._filterCategory) then
		return true
	end

	return self._filterCategory == category
end

function RoomDebugPlaceListModel:getFilterCategory()
	return self._filterCategory
end

function RoomDebugPlaceListModel:clearSelect()
	for i, view in ipairs(self._scrollViews) do
		view:setSelect(nil)
	end

	self._selectDefineId = nil
end

function RoomDebugPlaceListModel:_refreshSelect()
	local selectMO
	local moList = self:getList()

	for i, mo in ipairs(moList) do
		if mo.id == self._selectDefineId then
			selectMO = mo
		end
	end

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomDebugPlaceListModel:setSelect(defineId)
	self._selectDefineId = defineId

	self:_refreshSelect()
end

function RoomDebugPlaceListModel:getSelect()
	return self._selectDefineId
end

function RoomDebugPlaceListModel:initDebugPlace()
	self:setDebugPlaceList()
	self:setFilterCategory(nil)
end

RoomDebugPlaceListModel.instance = RoomDebugPlaceListModel.New()

return RoomDebugPlaceListModel
