-- chunkname: @modules/logic/room/model/map/RoomShowBlockPackageListModel.lua

module("modules.logic.room.model.map.RoomShowBlockPackageListModel", package.seeall)

local RoomShowBlockPackageListModel = class("RoomShowBlockPackageListModel", ListScrollModel)

function RoomShowBlockPackageListModel:ctor()
	RoomShowBlockPackageListModel.super.ctor(self)

	function self._selectSortFunc(a, b)
		local ast = self._selectBlockPackageId == a.id
		local bst = self._selectBlockPackageId == b.id

		if ast ~= bst then
			if ast then
				return true
			elseif bst then
				return false
			end
		end

		local aFinish = a.num < 1
		local bFinish = b.num < 1

		if aFinish ~= bFinish then
			return bFinish
		end

		local sort

		if self._isSortRate then
			if a.rare ~= b.rare then
				if self._isSortOrder then
					return a.rare < b.rare
				else
					return a.rare > b.rare
				end
			end

			if a.num ~= b.num then
				return a.num > b.num
			end
		else
			if a.num ~= b.num then
				if self._isSortOrder then
					return a.num < b.num
				else
					return a.num > b.num
				end
			end

			if a.rare ~= b.rare then
				return a.rare > b.rare
			end
		end

		if a.id ~= b.id then
			return a.id < b.id
		end
	end
end

function RoomShowBlockPackageListModel:getSortRate()
	return self._isSortRate
end

function RoomShowBlockPackageListModel:getSortOrder()
	return self._isSortOrder
end

function RoomShowBlockPackageListModel:setSortParam(isSortRate, isSortOrder)
	self._isSortOrder = isSortOrder
	self._isSortRate = isSortRate

	self:sort(self._selectSortFunc)
end

function RoomShowBlockPackageListModel:setShowBlockList()
	local moList = {}
	local packageMOList = RoomInventoryBlockModel.instance:getInventoryBlockPackageMOList()

	for i = 1, #packageMOList do
		local packageMO = packageMOList[i]
		local cfg = RoomConfig.instance:getBlockPackageConfig(packageMO.id)

		if cfg and self:_checkTheme(packageMO.id) then
			local showMO = RoomShowBlockPackageMO.New()

			showMO:init(packageMO.id, packageMO:getUnUseCount(), (not cfg.rare or nil) and 0)
			table.insert(moList, showMO)
		end
	end

	table.sort(moList, self._selectSortFunc)
	self:setList(moList)
	self:setSelect(nil)
end

function RoomShowBlockPackageListModel:_checkTheme(packageId)
	local tRoomThemeFilterListModel = RoomThemeFilterListModel.instance

	if not tRoomThemeFilterListModel:getIsAll() and tRoomThemeFilterListModel:getSelectCount() > 0 then
		local themeId = RoomConfig.instance:getThemeIdByItem(packageId, MaterialEnum.MaterialType.BlockPackage)

		if not tRoomThemeFilterListModel:isSelectById(themeId) then
			return false
		end
	end

	return true
end

function RoomShowBlockPackageListModel:clearSelect()
	for i, view in ipairs(self._scrollViews) do
		view:setSelect(nil)
	end

	self._selectBlockPackageId = nil
end

function RoomShowBlockPackageListModel:_refreshSelect()
	local selectMO
	local moList = self:getList()

	for i, mo in ipairs(moList) do
		if mo.id == self._selectBlockPackageId then
			selectMO = mo

			break
		end
	end

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomShowBlockPackageListModel:setSelect(blockPackageId)
	self._selectBlockPackageId = blockPackageId

	self:_refreshSelect()
end

function RoomShowBlockPackageListModel:initShow(blockPackageId)
	self._isSortRate = true
	self._isSortOrder = true
	self._selectBlockPackageId = blockPackageId

	self:setShowBlockList()
end

RoomShowBlockPackageListModel.instance = RoomShowBlockPackageListModel.New()

return RoomShowBlockPackageListModel
