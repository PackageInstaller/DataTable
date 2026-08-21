-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/CommonEquipBaseFilterFragmentView.lua

module("logic.extensions.charactersystem.view.equip.CommonEquipBaseFilterFragmentView", package.seeall)

local M = class("CommonEquipBaseFilterFragmentView", StaticFragmentView)
local CommonAll = CommEnum.CommonAll
local TabItemStatus = CommEnum.BackPackFilterItemStatus
local FilterEnum = CommEnum.EquipFilterKind
local _index2qualityType = {
	CommEnum.QualityFilterType.All,
	CommEnum.QualityFilterType.S,
	CommEnum.QualityFilterType.A,
	CommEnum.QualityFilterType.B,
	CommEnum.QualityFilterType.C,
	CommEnum.QualityFilterType.D
}
local _index2PartType = {
	CommEnum.EquipPartType.All,
	CommEnum.EquipPartType.Assist,
	CommEnum.EquipPartType.Defense,
	CommEnum.EquipPartType.Special
}

function M:ctor(mainGO, viewPresentor)
	M.super.ctor(self, mainGO)

	self._viewPresentor = viewPresentor
end

function M:buildUI()
	local qualitySortList = self:getGo("team_filter_tips_-1705430043")
	local childList = Astral.GameObjectUtil.GetChildren(qualitySortList)

	self._qualityFilterTabViewList = {}

	for index = 0, childList.Length - 1 do
		local view = Astral.LuaComponentContainer.Add(childList[index], BackpackFilterTabView)

		view:setTextStr(CommEnum.FilterViewQuality2Name[_index2qualityType[index + 1]])
		table.insert(self._qualityFilterTabViewList, view)
	end

	local partSortList = self:getGo("backpack_filter_tips_2_-1624020632")
	local childList = Astral.GameObjectUtil.GetChildren(partSortList)

	self._partFilterTabViewList = {}

	for index = 0, childList.Length - 1 do
		local view = Astral.LuaComponentContainer.Add(childList[index], BackpackFilterTabView)

		view:setTextStr(CommEnum.EquipPartName[_index2PartType[index + 1]])
		table.insert(self._partFilterTabViewList, view)
	end

	self._partGo = goutil.findChild(self.mainGO, "basicsFilter/basicsScroll/ViewPort/Content/part")
	self._qualityGo = goutil.findChild(self.mainGO, "basicsFilter/basicsScroll/ViewPort/Content/quality")

	self:_initSuitFilterTabBinderView()
end

function M:_initSuitFilterTabBinderView()
	local suitScrollGo = self:getGo("backpack_filter_tips_2_-1337749975")

	self._loopList = LoopListHelper.New(suitScrollGo)

	self._loopList:InitListView(0, self._updateSuitCell, self)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	for index, view in ipairs(self._qualityFilterTabViewList) do
		local param = {
			normalCallback = function()
				self:_onClickNormalTab(FilterEnum.EquipQuality, index)
			end,
			selectCallback = function()
				self:_onClickSelectTab(FilterEnum.EquipQuality, index)
			end
		}

		view:setParam(param)
	end

	for index, view in ipairs(self._partFilterTabViewList) do
		local param = {
			normalCallback = function()
				self:_onClickNormalTab(FilterEnum.EquipPart, index)
			end,
			selectCallback = function()
				self:_onClickSelectTab(FilterEnum.EquipPart, index)
			end
		}

		view:setParam(param)
	end

	GlobalDispatcher:addEventListener(EventType.Equip_SUIT_FILTER_EVENT, self._dealSuitFilterEvent, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.Equip_SUIT_FILTER_EVENT, self._dealSuitFilterEvent, self)
end

function M:setViewData(equips, filterCfg)
	self._allEquips = equips
	self._filterCfg = filterCfg
end

function M:onEnter()
	self._isPartInWhiteList = self._filterCfg:containFilterWhiteList(FilterEnum.EquipPart)
	self._isQualityInWhiteList = self._filterCfg:containFilterWhiteList(FilterEnum.EquipQuality)

	goutil.setActive(self._partGo, not self._isPartInWhiteList)
	goutil.setActive(self._qualityGo, not self._isQualityInWhiteList)
	self:_recordLast()
	self:_updateTabViewStatus()
end

function M:doReset()
	local cfg = self._filterCfg
	local lastPartFilter = cfg:getPartFilterType()
	local lastQualityFilter = cfg:getQualityFilterType()

	self._filterCfg:resetEquipBase()

	if self._isPartInWhiteList then
		cfg:setPartFilterType(lastPartFilter)
	end

	if self._isQualityInWhiteList then
		cfg:setQualityFilterType(lastQualityFilter)
	end

	self:_recordLast()
	self:_updateTabViewStatus()
end

function M:_recordLast()
	local cfg = self._filterCfg

	self._lastQuality = cfg:getQualityFilterType()
	self._lastPart = cfg:getPartFilterType()
	self._lastSuit = cfg:getSuitId()
	self._hasLastValue = true
end

function M:backToLast()
	if self._hasLastValue then
		local cfg = self._filterCfg

		cfg:setQualityFilterType(self._lastQuality)
		cfg:setPartFilterType(self._lastPart)
		cfg:setSuitId(self._lastSuit)

		self._hasLastValue = false
	end
end

function M:onExit()
	self._loopList:ClearCells()
end

function M:_updateTabViewStatus()
	self:_updateQualityDataAndView()
	self:_updatePartDataAndView()
	self:_updateSuitTabStatus()
end

function M:_updateQualityDataAndView()
	if self._isQualityInWhiteList then
		return
	end

	self:_calQualityFilterInfo()
	self:_updateQualityTabs()
end

function M:_calQualityFilterInfo()
	local qaList = {}
	local qaFlag = {}
	local part = self._filterCfg:getPartFilterType()
	local suitId = self._filterCfg:getSuitId()

	for _, itemData in ipairs(self._allEquips) do
		if MultipleEnumUtil.multipleEnumContainOnZeroAll(part, itemData:getPart()) and (suitId == 0 or itemData:getSuitId() == suitId) then
			local qa = itemData:getQuality()

			if not qaFlag[qa] then
				qaFlag[qa] = true

				table.insert(qaList, qa)
			end
		end
	end

	self._qualityMulEnumMap = MultipleEnumUtil.commEnum2Multiple(qaList)
end

function M:_updateQualityTabs()
	local filterType = self._filterCfg:getQualityFilterType()

	for index, tabView in ipairs(self._qualityFilterTabViewList) do
		local indexKey = _index2qualityType[index]
		local tabType = self._qualityMulEnumMap[indexKey]
		local status = TabItemStatus.Disable

		if tabType then
			if filterType == CommonAll then
				status = indexKey == CommonAll and TabItemStatus.Select or TabItemStatus.Normal
			else
				status = indexKey == CommonAll and TabItemStatus.Normal or MultipleEnumUtil.multipleEnumContain(filterType, tabType) and TabItemStatus.Select or TabItemStatus.Normal
			end
		end

		tabView:setTabStatus(status)
	end
end

function M:_updatePartDataAndView()
	if self._isPartInWhiteList then
		return
	end

	self:_calPartFilterInfo()
	self:_updatePartTabs()
end

function M:_calPartFilterInfo()
	local partList = {}
	local partFlag = {}
	local quality = self._filterCfg:getQualityFilterType()
	local suitId = self._filterCfg:getSuitId()

	for _, itemData in ipairs(self._allEquips) do
		if MultipleEnumUtil.multipleEnumContainOnZeroAll(quality, itemData:getQuality()) and (suitId == 0 or itemData:getSuitId() == suitId) then
			local part = itemData:getPart()

			if not partFlag[part] then
				partFlag[part] = true

				table.insert(partList, part)
			end
		end
	end

	self._partMulEnumMap = MultipleEnumUtil.commEnum2Multiple(partList)
end

function M:_updatePartTabs()
	local filterType = self._filterCfg:getPartFilterType()

	for index, tabView in ipairs(self._partFilterTabViewList) do
		local indexKey = _index2PartType[index]
		local tabType = self._partMulEnumMap[indexKey]
		local status = TabItemStatus.Disable

		if tabType then
			if filterType == CommonAll then
				status = indexKey == CommonAll and TabItemStatus.Select or TabItemStatus.Normal
			else
				status = indexKey == CommonAll and TabItemStatus.Normal or MultipleEnumUtil.multipleEnumContain(filterType, tabType) and TabItemStatus.Select or TabItemStatus.Normal
			end
		end

		tabView:setTabStatus(status)
	end
end

function M:_updateSuitTabStatus()
	self._suitIdsMap = {}

	local part = self._filterCfg:getPartFilterType()
	local quality = self._filterCfg:getQualityFilterType()

	for _, itemData in ipairs(self._allEquips) do
		if MultipleEnumUtil.multipleEnumContainOnZeroAll(part, itemData:getPart()) and MultipleEnumUtil.multipleEnumContainOnZeroAll(quality, itemData:getQuality()) then
			local suitId = itemData:getSuitId()

			if not self._suitIdsMap[suitId] then
				self._suitIdsMap[suitId] = true
			end
		end
	end

	self._suitIdsMap[CommonAll] = true

	local suitDataList = EquipSuitModel.instance:getSuitData()
	local moList = suitDataList:getMoList()

	self._loopList:SetListItemCount(#moList, true)
	self._loopList:RefreshAllShownItem()
end

function M:_updateSuitCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("backpack_suit_filter_tab")
	local suitDataList = EquipSuitModel.instance:getSuitData()
	local moList = suitDataList:getMoList()
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, CommonEquipSuitCellView)
	local data = moList[curIndex]
	local suitId = data:getId()
	local comp = shower:getComponent("cellComp")

	comp:setSpecial(not self._suitIdsMap[suitId])
	shower:updateData(data)
	shower:onSelect(suitId == self._filterCfg:getSuitId())

	return item
end

function M:_onClickNormalTab(filterEnum, index)
	if filterEnum == FilterEnum.EquipQuality then
		local selectKey = _index2qualityType[index]
		local newFilter = CommonAll

		if selectKey ~= CommonAll then
			local lastFilter = self._filterCfg:getQualityFilterType()

			if lastFilter == CommonAll then
				newFilter = self._qualityMulEnumMap[selectKey]
			else
				newFilter = MultipleEnumUtil.multipleEnumAdd(lastFilter, self._qualityMulEnumMap[selectKey])

				if newFilter == self._qualityMulEnumMap[CommonAll] then
					newFilter = CommonAll
				end
			end
		end

		self._filterCfg:setQualityFilterType(newFilter)
	elseif filterEnum == FilterEnum.EquipPart then
		local selectKey = _index2PartType[index]
		local newFilter = CommonAll

		if selectKey ~= CommonAll then
			local lastFilter = self._filterCfg:getPartFilterType()

			if lastFilter == CommonAll then
				newFilter = self._partMulEnumMap[selectKey]
			else
				newFilter = MultipleEnumUtil.multipleEnumAdd(lastFilter, self._partMulEnumMap[selectKey])

				if newFilter == self._partMulEnumMap[CommonAll] then
					newFilter = CommonAll
				end
			end
		end

		self._filterCfg:setPartFilterType(newFilter)
	end

	self:_updateTabViewStatus()
end

function M:_onClickSelectTab(filterEnum, index)
	if filterEnum == FilterEnum.EquipQuality then
		local selectKey = _index2qualityType[index]

		if selectKey == CommonAll then
			return
		end

		local lastFilter = self._filterCfg:getQualityFilterType()
		local value = self._qualityMulEnumMap[selectKey]

		value = MultipleEnumUtil.multipleEnumSub(lastFilter, value)

		self._filterCfg:setQualityFilterType(value)
	else
		local selectKey = _index2PartType[index]

		if selectKey == CommonAll then
			return
		end

		local lastFilter = self._filterCfg:getPartFilterType()
		local value = self._partMulEnumMap[selectKey]

		value = MultipleEnumUtil.multipleEnumSub(lastFilter, value)

		self._filterCfg:setCareerFilterType(value)
	end

	self:_updateTabViewStatus()
end

function M:_dealSuitFilterEvent(e, suitId)
	self._filterCfg:setSuitId(suitId)
	self:_updateTabViewStatus()
end

return M
