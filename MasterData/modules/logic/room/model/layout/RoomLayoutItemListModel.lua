-- chunkname: @modules/logic/room/model/layout/RoomLayoutItemListModel.lua

module("modules.logic.room.model.layout.RoomLayoutItemListModel", package.seeall)

local RoomLayoutItemListModel = class("RoomLayoutItemListModel", ListScrollModel)

function RoomLayoutItemListModel:onInit()
	self:clear()
end

function RoomLayoutItemListModel:reInit()
	self:clear()
end

function RoomLayoutItemListModel:init(blockInfos, buildingInfos, isBirthdayBlock)
	local list = {}

	self._isBirthdayBlock = not not isBirthdayBlock

	local packageDict, roleBirthdayList = self:_findBlockInfos(blockInfos)
	local buildingDict = self:_findbuildingInfos(buildingInfos)

	for packageId, blockNum in pairs(packageDict) do
		local mo = RoomLayoutItemMO.New()

		mo:init(#list + 1, packageId, MaterialEnum.MaterialType.BlockPackage, blockNum)
		table.insert(list, mo)
	end

	for i, blockId in ipairs(roleBirthdayList) do
		local mo = RoomLayoutItemMO.New()

		mo:init(#list + 1, blockId, MaterialEnum.MaterialType.SpecialBlock, 1)
		table.insert(list, mo)
	end

	for buildingId, num in pairs(buildingDict) do
		for itemIndex = 1, num do
			local mo = RoomLayoutItemMO.New()

			mo:init(#list + 1, buildingId, MaterialEnum.MaterialType.Building, 1)

			mo.itemIndex = itemIndex

			table.insert(list, mo)
		end
	end

	table.sort(list, RoomLayoutItemListModel.sortFuc)
	self:setList(list)
end

function RoomLayoutItemListModel:resortList()
	local list = self:getList()

	table.sort(list, RoomLayoutItemListModel.sortFuc)
	self:setList(list)
end

function RoomLayoutItemListModel:_findBlockInfos(blockInfos)
	local packageDict, roleBirthdayList = RoomLayoutHelper.findBlockInfos(blockInfos, self._isBirthdayBlock)

	return packageDict, roleBirthdayList
end

function RoomLayoutItemListModel:_findbuildingInfos(buildingInfos)
	return (RoomLayoutHelper.findbuildingInfos(buildingInfos))
end

function RoomLayoutItemListModel.sortFuc(a, b)
	local aLackOrder = RoomLayoutItemListModel._getLackOrder(a)
	local bLackOrder = RoomLayoutItemListModel._getLackOrder(b)

	if aLackOrder ~= bLackOrder then
		return aLackOrder < bLackOrder
	end

	local aTypeOrder = RoomLayoutItemListModel._getItemTypeOrder(a)
	local bTypeOrder = RoomLayoutItemListModel._getItemTypeOrder(b)

	if aTypeOrder ~= bTypeOrder then
		return aTypeOrder < bTypeOrder
	end

	local aCfg = a:getItemConfig()
	local bCfg = b:getItemConfig()

	if not aCfg.rare then
		local aRare = 0

		if not bCfg.rare then
			local bRare = 0

			if aRare ~= bRare then
				return bRare < aRare
			end

			if a:isBlockPackage() and b:isBlockPackage() and a.itemNum ~= b.itemNum then
				return a.itemNum > b.itemNum
			end

			if a:isBuilding() and b:isBuilding() and aCfg.buildDegree ~= bCfg.buildDegree then
				return aCfg.buildDegree > bCfg.buildDegree
			end

			if a.itemId ~= b.itemId then
				return a.itemId < b.itemId
			end
		end
	end
end

function RoomLayoutItemListModel._getLackOrder(a)
	if a:isLack() then
		return 1
	end

	return 2
end

function RoomLayoutItemListModel._getItemTypeOrder(a)
	if a:isBlockPackage() then
		return 1
	elseif a:isSpecialBlock() then
		return 2
	elseif a:isBuilding() then
		return 3
	end

	return 100
end

RoomLayoutItemListModel.instance = RoomLayoutItemListModel.New()

return RoomLayoutItemListModel
