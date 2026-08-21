-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/filterview/D6FilterComponent.lua

module("logic.extensions.backpack.view.filterview.D6FilterComponent", package.seeall)

local M = class("D6FilterComponent")
local FilterType = CommEnum.D6FilterType
local CommonAll = CommEnum.CommonAll
local CommonAllMap = {
	[CommEnum.CommonAll] = true
}

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject

	self:init()
end

function M:OnBuildUI()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self._attrList:Dispose()

	self.mainGO = nil
end

function M:buildUI()
	self._partGo = goutil.findChild(self.mainGO, "Content/content1")
	self._resonanceGo = goutil.findChild(self.mainGO, "Content/content2")
	self._btnEnsure = Astral.ButtonAdapter.Get(goutil.findChild(self.mainGO, "btnEnsure"))
	self._btnClear = Astral.ButtonAdapter.Get(goutil.findChild(self.mainGO, "btnDelete"))
	self._btnMask = Astral.ButtonAdapter.Get(goutil.findChild(self.mainGO, "click"))

	local partsGo = goutil.findChild(self.mainGO, "Content/content1/sortList")
	local reasonsGo = goutil.findChild(self.mainGO, "Content/content2/sortList")

	self._partTabItems = {}
	self._resonanceTabItems = {}
	self._filterMulEnum = {}

	for i = 1, 3 do
		local view = Astral.LuaComponentContainer.Add(goutil.findChild(partsGo, "tab" .. i), D6PartFilterItem)

		view:setData({
			filterType = FilterType.Part,
			value = i
		})
		table.insert(self._partTabItems, view)

		view = Astral.LuaComponentContainer.Add(goutil.findChild(reasonsGo, "tab" .. i), D6PartFilterItem)

		view:setData({
			filterType = FilterType.Resonance,
			value = i
		})
		table.insert(self._resonanceTabItems, view)

		self._filterMulEnum[i] = MultipleEnumUtil.getOneMultipleValue(i)
	end

	self._attrList = LoopListHelper.New(goutil.findChild(self.mainGO, "Content/content3/d6Scroll"))

	self._attrList:InitListView(0, self._onCellUpdate, self)
end

function M:clear()
	self._attrList:ClearCells()
end

function M:setVisible(visible)
	goutil.setActive(self.mainGO, visible)

	if visible and self._filterCfg then
		self:_updateView()
	end
end

function M:setData(BackpackD6FilterCfg)
	self._filterCfg = BackpackD6FilterCfg
	self._attrFilter = self._filterCfg:getSimpleAttributeFilter()

	self:_hideIgnoreUI()
end

function M:_hideIgnoreUI()
	self._partIgnore = self._filterCfg:inWhiteList(FilterType.Part)
	self._reasonIgnore = self._filterCfg:inWhiteList(FilterType.Resonance)

	goutil.setActive(self._partGo, not self._partIgnore)
	goutil.setActive(self._resonanceGo, not self._reasonIgnore)
end

function M:_updateView()
	self:_updateTabView(FilterType.Part)
	self:_updateTabView(FilterType.Resonance)
	self:_updateAttrView()
end

function M:bindEvents()
	self._btnEnsure:AddClickListener(self._onClickEnsureBtn, self)
	self._btnClear:AddClickListener(self._onClickClearBtn, self)
	self._btnMask:AddClickListener(self._onClickClearMask, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_D6_TAB_CLICK, self._onClickTab, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_D6_ATTR_ITEM_CLICK, self._onClickAttrItem, self)
end

function M:unbindEvents()
	self._btnEnsure:RemoveClickListener()
	self._btnClear:RemoveClickListener()
	self._btnMask:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_D6_TAB_CLICK, self._onClickTab, self)
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_D6_ATTR_ITEM_CLICK, self._onClickAttrItem, self)
end

function M:setEvent(evt)
	self._event = evt
end

function M:_onClickEnsureBtn()
	if self._event then
		GlobalDispatcher:dispatchEvent(self._event, self._isReseted)
	end

	self:setVisible(false)
end

function M:_onClickClearBtn()
	self._isReseted = true

	if self._filterCfg then
		self._filterCfg:reset()
		self:_updateView()
	end
end

function M:_onClickClearMask()
	self._isReseted = true

	if self._filterCfg then
		self._filterCfg:reset()
		self:_updateView()
	end

	self:setVisible(false)
end

function M:_onClickTab(e, data, isSelect)
	self._isReseted = false

	if not self._filterCfg then
		return
	end

	self:_updateTabValue(data, isSelect)
	self:_updateTabView(data.filterType)
	self:_updateAttrView()
end

function M:_onClickAttrItem(e, attrId, isSelect)
	self._isReseted = false

	if not self._filterCfg then
		return
	end

	local attrFilter = self._attrFilter

	if isSelect then
		if attrId ~= CommonAll then
			table.removebyvalue(attrFilter, attrId)
		end
	elseif attrId == CommonAll then
		table.clear(attrFilter)
	else
		table.insert(attrFilter, attrId)
	end

	if #attrFilter == 0 then
		self._selectAttrMap = CommonAllMap
	else
		self._selectAttrMap = TableUtil.arrayToMap(attrFilter)
	end

	self._attrList:RefreshAllShownItem()
end

function M:_updateTabValue(data, isSelect)
	local cfg = self._filterCfg
	local filter = cfg:getFilterValue(data.filterType)

	if isSelect then
		filter = MultipleEnumUtil.multipleEnumSub(filter, self._filterMulEnum[data.value])
	else
		filter = MultipleEnumUtil.multipleEnumAdd(filter, self._filterMulEnum[data.value])
	end

	cfg:setFilterValue(data.filterType, filter)
end

function M:_updateTabView(filterType)
	local filter = self._filterCfg:getFilterValue(filterType)
	local views = filterType == FilterType.Part and self._partTabItems or self._resonanceTabItems

	for filterValue, tabView in ipairs(views) do
		local isSelect = MultipleEnumUtil.multipleEnumContain(filter, self._filterMulEnum[filterValue])

		tabView:setSelect(isSelect)
	end
end

function M:_updateAttrView()
	local partFilter = self._filterCfg:getSimplePartFilter()
	local resonanceFilter = self._filterCfg:getSimpleResonanceFilter()

	for attrId, attr in ipairs(self._allAttrsMap) do
		if attrId ~= CommonAll then
			local attrCfg = EquipmentConfig.instance:getConfigByKey(ConfigName.DiceAttr, attrId)
			local canUse = MultipleEnumUtil.multipleEnumContainOnZeroAll(partFilter, attrCfg.part) and MultipleEnumUtil.multipleEnumContainOnZeroAll(resonanceFilter, attrCfg.group) or false

			if canUse then
				if not self._canUseAttrsMap[attrId] then
					self._canUseAttrsMap[attrId] = true

					table.insert(self._canUseAttrsList, attr)
				end
			elseif self._canUseAttrsMap[attrId] then
				self._canUseAttrsMap[attrId] = false

				TableUtil.removeByFun(self._canUseAttrsList, attrId, function(atr, attrId)
					return atr.id == attrId
				end)
			end
		end
	end

	TableUtil.removeByFun(self._attrFilter, self._canUseAttrsMap, function(attrId, canUseMap)
		return not canUseMap[attrId]
	end, true)

	if #self._attrFilter == 0 then
		self._selectAttrMap = CommonAllMap
	else
		self._selectAttrMap = TableUtil.arrayToMap(self._attrFilter)
	end

	table.sort(self._canUseAttrsList, function(a, b)
		return a.id < b.id
	end)
	self._attrList:SetListItemCount(#self._canUseAttrsList)
	self._attrList:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex)
	local data = self._canUseAttrsList[curIndex + 1]
	local item = self._attrList:NewListViewItem("d6_fitter_item")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, D6AttrFilterItem)

	shower:setData(data)
	shower:setSelect(self._selectAttrMap[data.id])

	return item
end

function M:init()
	local res = {
		[CommonAll] = {
			iconName = "equip_hole_02",
			id = CommonAll,
			name = lang("tip_common_all")
		}
	}
	local diceAttrDataList = EquipmentConfig.instance:getConfigList(ConfigName.DiceAttr)

	for _, data in ipairs(diceAttrDataList) do
		local desc = ActiveSkillCOUtil.buildBuffAndTagDesc(data.desc, false, false)

		desc = string.gsub(desc, "%-%%", lang("tip_common_dec"))
		desc = string.gsub(desc, "%+%%", lang("tip_common_add"))

		local icon = string.format("equip_hole_0%d", data.group)

		res[data.id] = {
			id = data.id,
			name = desc,
			iconName = icon
		}
	end

	self._allAttrsMap = res
	self._canUseAttrsList = {
		res[CommonAll]
	}
	self._canUseAttrsMap = {}
	self._selectAttrMap = {}
end

return M
