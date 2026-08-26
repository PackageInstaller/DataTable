-- chunkname: @modules/logic/room/model/gift/RoomBuildingGiftListModel.lua

module("modules.logic.room.model.gift.RoomBuildingGiftListModel", package.seeall)

local RoomBuildingGiftListModel = class("RoomBuildingGiftListModel", ListScrollModel)

function RoomBuildingGiftListModel:initMoList()
	self._subType = MaterialEnum.MaterialType.Building

	for _, co in ipairs(room_building.configList) do
		if co.canExchange then
			local rare = co.rare
			local rareMoList = self._moList[rare]

			if not rareMoList then
				rareMoList = {}
				self._moList[rare] = rareMoList
			end

			local showMO = RoomGiftShowBuildingMo.New()

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

function RoomBuildingGiftListModel:getRareMoList(rare)
	if not self._moList then
		self._moList = {}

		self:initMoList()
	end

	return self._moList[rare]
end

function RoomBuildingGiftListModel:setMoList(rare)
	local _moList = self:getRareMoList(rare)
	local moList = {}

	self._themeBuilding = {}
	self._themeIds = {}

	if _moList then
		local _isAllColloct = self:isAllColloct(rare)

		for _, showMO in ipairs(_moList) do
			if _isAllColloct or not showMO:isCollect() then
				table.insert(moList, showMO)
			end

			local themeId = RoomConfig.instance:getThemeIdByItem(showMO.id, showMO.subType)

			if themeId then
				self._themeBuilding[themeId] = self._themeBuilding[themeId] or {}

				if not self:isHasTheme(themeId) then
					table.insert(self._themeIds, themeId)
				end

				table.insert(self._themeBuilding[themeId], showMO)
			else
				logError("该建筑没找到主题:" .. showMO.id)
			end
		end
	end

	table.sort(moList, self._sort)
	self:setList(moList)
end

function RoomBuildingGiftListModel:openSubType(rare)
	self:onModelUpdate()

	if self:isAllColloct(rare) then
		GameFacade.showToast(self._subTypeInfo.AllColloctToast)
	end
end

function RoomBuildingGiftListModel:isAllColloct(rare)
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

function RoomBuildingGiftListModel:onSort()
	local isFilter = RoomThemeFilterListModel.instance:getSelectCount() > 0

	if isFilter then
		self:_sortThemeBuilding()
	else
		local moList = self:getList()

		table.sort(moList, self._sort)
		self:setList(moList)
	end
end

function RoomBuildingGiftListModel._sort(x, y)
	if x:isCollect() ~= y:isCollect() then
		return y:isCollect()
	end

	local sortRareType = RoomBlockBuildingGiftModel.instance:getSortBlockRare()
	local sortNumType = RoomBlockBuildingGiftModel.instance:getSortBlockNum()
	local xNum = x:getBuildingAreaConfig().occupy
	local yNum = y:getBuildingAreaConfig().occupy

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

function RoomBuildingGiftListModel:isHasTheme(themeId)
	return LuaUtil.tableContains(self._themeIds, themeId)
end

function RoomBuildingGiftListModel:setThemeList()
	RoomThemeFilterListModel.instance:initThemeData(self._themeIds)
end

function RoomBuildingGiftListModel:setThemeMoList()
	self._themeMoList = {}

	local themeIds = RoomThemeFilterListModel.instance:getSelectIdList()
	local removeIds = {}

	for _, themeId in ipairs(themeIds) do
		if self:isHasTheme(themeId) then
			local mo = {
				themeId = themeId,
				moList = self._themeBuilding[themeId]
			}

			table.insert(self._themeMoList, mo)
		else
			table.insert(removeIds, themeId)
		end
	end

	for _, themeId in ipairs(removeIds) do
		RoomThemeFilterListModel.instance:setSelectById(themeId, false)
	end

	self:_sortThemeBuilding()
end

function RoomBuildingGiftListModel:getThemeMoList()
	return self._themeMoList
end

function RoomBuildingGiftListModel:_sortThemeBuilding()
	if self._themeMoList then
		table.sort(self._themeMoList, self._sortTheme)

		for _, mo in ipairs(self._themeMoList) do
			table.sort(mo.moList, self._sort)
		end

		RoomBlockGiftController.instance:dispatchEvent(RoomBlockGiftEvent.OnSortTheme)
	end
end

function RoomBuildingGiftListModel._sortTheme(x, y)
	if x.themeId ~= y.themeId then
		return x.themeId > y.themeId
	end
end

function RoomBuildingGiftListModel:onSelect(mo, isSelect)
	mo.isSelect = isSelect

	local index = self:getIndex(mo)

	self:selectCell(index, isSelect)
end

RoomBuildingGiftListModel.instance = RoomBuildingGiftListModel.New()

return RoomBuildingGiftListModel
