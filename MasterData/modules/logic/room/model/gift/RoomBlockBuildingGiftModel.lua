-- chunkname: @modules/logic/room/model/gift/RoomBlockBuildingGiftModel.lua

module("modules.logic.room.model.gift.RoomBlockBuildingGiftModel", package.seeall)

local RoomBlockBuildingGiftModel = class("RoomBlockBuildingGiftModel", BaseModel)

function RoomBlockBuildingGiftModel:init()
	self:clear()
end

function RoomBlockBuildingGiftModel:reInit()
	self:clear()
end

function RoomBlockBuildingGiftModel:clear()
	self._selectSubType = nil
	self._selectMo = nil
	self._themeFilterList = nil

	RoomThemeFilterListModel.instance:clear()
end

function RoomBlockBuildingGiftModel:getGiftBlockMos(itemId)
	self._blocksMos = self._blocksMos or {}

	local blockMos = self._blocksMos[itemId]

	if blockMos then
		return blockMos
	end

	local itemCo = ItemConfig.instance:getItemCo(itemId)
	local rare = itemCo.rare

	blockMos = {}

	local buildingMoList = RoomBuildingGiftListModel.instance:getRareMoList(rare)

	table.sort(buildingMoList, self._sortBuilding)

	for _, mo in pairs(buildingMoList) do
		local _mo = {
			mo.subType,
			mo.id,
			1
		}

		table.insert(blockMos, _mo)
	end

	local blockMoList = RoomBlockGiftListModel.instance:getRareMoList(rare)

	table.sort(blockMoList, self._sortBlock)

	for _, mo in pairs(blockMoList) do
		local _mo = {
			mo.subType,
			mo.id,
			1
		}

		table.insert(blockMos, _mo)
	end

	return blockMos
end

function RoomBlockBuildingGiftModel:getSubTypeListModelInstance(subType)
	subType = subType or self:getSelectSubType()

	local info = RoomBlockGiftEnum.SubTypeInfo[subType]

	return info.ListModel.instance
end

function RoomBlockBuildingGiftModel._sortBlock(x, y)
	if x.rare ~= y.rare then
		return x.rare > y.rare
	end

	local xblockList = RoomConfig.instance:getBlockListByPackageId(x.id)

	if xblockList then
		if not #xblockList then
			local xblockNum = 0
			local ylockList = RoomConfig.instance:getBlockListByPackageId(y.id)

			if ylockList then
				if not #ylockList then
					local yblockNum = 0

					if xblockNum ~= yblockNum then
						return yblockNum < xblockNum
					end

					return x.id > y.id
				end
			end
		end
	end
end

function RoomBlockBuildingGiftModel._sortBuilding(x, y)
	if x.rare ~= y.rare then
		return x.rare > y.rare
	end

	local xBuildingCo = RoomConfig.instance:getBuildingConfig(x.id)
	local yBuildingCo = RoomConfig.instance:getBuildingConfig(y.id)
	local xAreaCo = RoomConfig.instance:getBuildingAreaConfig(xBuildingCo.areaId)
	local yAreaCo = RoomConfig.instance:getBuildingAreaConfig(yBuildingCo.areaId)

	if xAreaCo.occupy ~= yAreaCo.occupy then
		return xAreaCo.occupy > yAreaCo.occupy
	end

	return x.id > y.id
end

function RoomBlockBuildingGiftModel:isAllColloct(rare)
	for _, info in pairs(RoomBlockGiftEnum.SubTypeInfo) do
		if not info.ListModel.instance:isAllColloct(rare) then
			return false
		end
	end

	return true
end

function RoomBlockBuildingGiftModel:getSelectSubType()
	return self._selectSubType or MaterialEnum.MaterialType.BlockPackage
end

function RoomBlockBuildingGiftModel:clickSortBlockRare()
	self._sortNumType = RoomBlockGiftEnum.SortType.None

	if not self._sortRareType then
		self._sortRareType = RoomBlockGiftEnum.SortType.Order

		return self._sortRareType
	end

	self._sortRareType = self._sortRareType == RoomBlockGiftEnum.SortType.Order and RoomBlockGiftEnum.SortType.Reverse or RoomBlockGiftEnum.SortType.Order

	return self._sortRareType
end

function RoomBlockBuildingGiftModel:getSortBlockRare()
	return self._sortRareType
end

function RoomBlockBuildingGiftModel:clickSortBlockNum()
	self._sortRareType = RoomBlockGiftEnum.SortType.None

	if not self._sortNumType then
		self._sortNumType = RoomBlockGiftEnum.SortType.Order

		return self._sortNumType
	end

	self._sortNumType = self._sortNumType == RoomBlockGiftEnum.SortType.Order and RoomBlockGiftEnum.SortType.Reverse or RoomBlockGiftEnum.SortType.Order

	return self._sortNumType
end

function RoomBlockBuildingGiftModel:getSortBlockNum()
	return self._sortNumType
end

function RoomBlockBuildingGiftModel:onOpenView(rare)
	self._sortNumType = RoomBlockGiftEnum.SortType.None
	self._sortRareType = RoomBlockGiftEnum.SortType.Order

	self:clearSelect()
	self:initSelect()
	self:setThemeList()

	self._rare = rare

	self:openSubType(MaterialEnum.MaterialType.BlockPackage)
end

function RoomBlockBuildingGiftModel:openSubType(subType)
	RoomBlockBuildingGiftModel.instance:setThemeList()

	local listModelInstance = self:getSubTypeListModelInstance(subType)

	listModelInstance:openSubType(self._rare)

	self._selectSubType = subType
end

function RoomBlockBuildingGiftModel:onCloseView()
	self:saveThemeFilter()
end

function RoomBlockBuildingGiftModel:initBlockBuilding(rare)
	for _, info in pairs(RoomBlockGiftEnum.SubTypeInfo) do
		info.ListModel.instance:setMoList(rare)
	end
end

function RoomBlockBuildingGiftModel:initSelect()
	return
end

function RoomBlockBuildingGiftModel:saveThemeFilter()
	self._themeFilterList = RoomThemeFilterListModel.instance:getSelectIdList()
end

function RoomBlockBuildingGiftModel:setThemeList()
	self:saveThemeFilter()

	local listModelInstance = self:getSubTypeListModelInstance(self:getSelectSubType())

	listModelInstance:setThemeList()

	if self._themeFilterList then
		for _, id in ipairs(self._themeFilterList) do
			local isHasTheme = listModelInstance:isHasTheme(id)

			if isHasTheme then
				RoomThemeFilterListModel.instance:setSelectById(id, true)
			end
		end
	end
end

function RoomBlockBuildingGiftModel:onSort()
	local listModelInstance = self:getSubTypeListModelInstance(self:getSelectSubType())

	listModelInstance:onSort()
end

function RoomBlockBuildingGiftModel:getThemeColloctCount(moList)
	local collectCount = 0

	if moList then
		for _, mo in ipairs(moList) do
			if mo:isCollect() then
				collectCount = collectCount + 1
			end
		end
	end

	return collectCount
end

function RoomBlockBuildingGiftModel:onSelect(mo)
	local subType = mo.subType
	local listModelInstance = self:getSubTypeListModelInstance(subType)

	if mo.isSelect then
		listModelInstance:onSelect(mo, false)

		self._selectMo = nil
	else
		if self._selectMo then
			local selectListModel = self:getSubTypeListModelInstance(self._selectMo.subType)

			selectListModel:onSelect(self._selectMo, false)
		end

		listModelInstance:onSelect(mo, true)

		self._selectMo = mo
	end
end

function RoomBlockBuildingGiftModel:clearSelect()
	if self._selectMo then
		local subType = self._selectMo.subType
		local listModelInstance = self:getSubTypeListModelInstance(subType)

		listModelInstance:onSelect(self._selectMo, false)

		self._selectMo = nil
	end
end

function RoomBlockBuildingGiftModel:getSelectCount()
	return self._selectMo and 1 or 0
end

function RoomBlockBuildingGiftModel:getMaxSelectCount()
	return 1
end

function RoomBlockBuildingGiftModel:getSelectGoodsData(itemId)
	if self._selectMo then
		local type = self._selectMo.subType
		local id = self._selectMo.id

		if type and id then
			local goodsId = id * 10 + (self._selectMo.subTypeIndex - 1)

			if goodsId then
				local mo = {
					quantity = 1,
					materialId = itemId
				}

				return {
					data = {
						mo
					},
					goodsId = goodsId
				}
			end
		end
	end
end

RoomBlockBuildingGiftModel.instance = RoomBlockBuildingGiftModel.New()

return RoomBlockBuildingGiftModel
