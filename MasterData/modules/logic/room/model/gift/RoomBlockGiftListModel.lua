-- chunkname: @modules/logic/room/model/gift/RoomBlockGiftListModel.lua

module("modules.logic.room.model.gift.RoomBlockGiftListModel", package.seeall)

local RoomBlockGiftListModel = class("RoomBlockGiftListModel", ListScrollModel)

function RoomBlockGiftListModel:initMoList()
	self._subType = MaterialEnum.MaterialType.BlockPackage
	self._moList = {}

	for _, co in ipairs(lua_block_package.configList) do
		if co.canExchange then
			local rare = co.rare
			local rareMoList = self._moList[rare]

			if not rareMoList then
				rareMoList = {}
				self._moList[rare] = rareMoList
			end

			local showMO = RoomGiftShowBlockMo.New()

			showMO:init(co)
			table.insert(rareMoList, showMO)
		end
	end

	for i = 1, 5 do
		local list = self._moList[i]
		local preList = self._moList[i - 1]

		if preList then
			if list then
				tabletool.addValues(self._moList[i], preList)
			else
				self._moList[i] = preList
			end
		end
	end

	self._subTypeInfo = RoomBlockGiftEnum.SubTypeInfo[self._subType]
end

function RoomBlockGiftListModel:getRareMoList(rare)
	if not self._moList then
		self:initMoList()
	end

	return self._moList[rare]
end

function RoomBlockGiftListModel:setMoList(rare)
	local _moList = self:getRareMoList(rare)
	local moList = {}

	self._themeBlocks = {}
	self._themeIds = {}

	if _moList then
		local _isAllColloct = self:isAllColloct(rare)

		for _, showMO in ipairs(_moList) do
			if _isAllColloct or not showMO:isCollect() then
				table.insert(moList, showMO)
			end

			local themeId = RoomConfig.instance:getThemeIdByItem(showMO.id, showMO.subType)

			if themeId then
				self._themeBlocks[themeId] = self._themeBlocks[themeId] or {}

				if not self:isHasTheme(themeId) then
					table.insert(self._themeIds, themeId)
				end

				table.insert(self._themeBlocks[themeId], showMO)
			else
				logError("该地块包没找到主题:" .. showMO.id)
			end
		end
	end

	self:setList(moList)
end

function RoomBlockGiftListModel:openSubType(rare)
	self:onModelUpdate()

	if self:isAllColloct(rare) then
		GameFacade.showToast(self._subTypeInfo.AllColloctToast)
	end
end

function RoomBlockGiftListModel:isAllColloct(rare)
	local moList = self:getRareMoList(rare)

	if not moList then
		return true
	end

	for _, mo in ipairs(moList) do
		if not mo:isCollect() then
			return false
		end
	end

	return true
end

function RoomBlockGiftListModel:onSort()
	local isFilter = RoomThemeFilterListModel.instance:getSelectCount() > 0

	if isFilter then
		self:_sortThemeBlocks()
	else
		local moList = self:getList()

		table.sort(moList, self._sort)
		self:setList(moList)
	end
end

function RoomBlockGiftListModel._sort(x, y)
	if x:isCollect() ~= y:isCollect() then
		return y:isCollect()
	end

	local sortRareType = RoomBlockBuildingGiftModel.instance:getSortBlockRare()
	local sortNumType = RoomBlockBuildingGiftModel.instance:getSortBlockNum()
	local xNum = x:getBlockNum()
	local yNum = y:getBlockNum()

	if sortRareType ~= RoomBlockGiftEnum.SortType.None then
		if x.rare == y.rare and xNum == yNum then
			return x.id < y.id
		end

		if sortRareType == RoomBlockGiftEnum.SortType.Order then
			return x.rare > y.rare
		end

		return x.rare < y.rare
	end

	if xNum == yNum then
		if x.rare == y.rare then
			return x.id < y.id
		end

		return x.rare > y.rare
	end

	if sortNumType ~= RoomBlockGiftEnum.SortType.Reverse then
		return yNum < xNum
	end

	return xNum < yNum
end

function RoomBlockGiftListModel:setThemeList()
	RoomThemeFilterListModel.instance:initThemeData(self._themeIds)
end

function RoomBlockGiftListModel:isHasTheme(themeId)
	return LuaUtil.tableContains(self._themeIds, themeId)
end

function RoomBlockGiftListModel:setThemeMoList()
	self._themeMoList = {}

	local themeIds = RoomThemeFilterListModel.instance:getSelectIdList()

	for _, themeId in ipairs(themeIds) do
		if self:isHasTheme(themeId) then
			local mo = {
				themeId = themeId,
				moList = self._themeBlocks[themeId]
			}

			table.insert(self._themeMoList, mo)
		else
			RoomThemeFilterListModel.instance:setSelectById(themeId, false)
		end
	end

	self:_sortThemeBlocks()
end

function RoomBlockGiftListModel:getThemeMoList()
	return self._themeMoList
end

function RoomBlockGiftListModel:_sortThemeBlocks()
	if self._themeMoList then
		table.sort(self._themeMoList, self._sortTheme)

		for _, mo in ipairs(self._themeMoList) do
			table.sort(mo.moList, self._sort)
		end

		RoomBlockGiftController.instance:dispatchEvent(RoomBlockGiftEvent.OnSortTheme)
	end
end

function RoomBlockGiftListModel._sortTheme(x, y)
	if x.themeId ~= y.themeId then
		return x.themeId > y.themeId
	end
end

function RoomBlockGiftListModel:onSelect(mo, isSelect)
	self._selectMo = mo
	mo.isSelect = isSelect

	local index = self:getIndex(mo)

	self:selectCell(index, isSelect)
end

RoomBlockGiftListModel.instance = RoomBlockGiftListModel.New()

return RoomBlockGiftListModel
