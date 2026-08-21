-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/CommonEquipD6FilterFragmentView.lua

module("logic.extensions.charactersystem.view.equip.CommonEquipD6FilterFragmentView", package.seeall)

local _index2PartType = {
	CommEnum.D6PartType.All,
	CommEnum.D6PartType.Weapon,
	CommEnum.D6PartType.Armor,
	CommEnum.D6PartType.Decorations
}
local _index2ResonanceType = {
	CommEnum.D6ResonanceType.All,
	CommEnum.D6ResonanceType.Resonance1,
	CommEnum.D6ResonanceType.Resonance2,
	CommEnum.D6ResonanceType.Resonance3
}
local CommonAll = CommEnum.CommonAll
local TabItemStatus = CommEnum.BackPackFilterItemStatus
local FilterEnum = CommEnum.EquipFilterKind
local M = class("CommonEquipD6FilterFragmentView", StaticFragmentView)

function M:ctor(mainGO, viewPresentor)
	M.super.ctor(self, mainGO)

	self._viewPresentor = viewPresentor
end

function M:buildUI()
	self._btnFilterGo = self:getGo("backpack_filter_tips_2_-373096839")
	self._btnFilter = self:getBtn("backpack_filter_tips_2_-373096839")
	self._toggleFilter = self:getUIComponent("backpack_filter_tips_2_-373096839", UIComponentType.SpaceXToggle)

	goutil.setActive(self._btnFilterGo, false)

	local partSortList = self:getGo("backpack_filter_tips_2_-1833570458")
	local childList = Astral.GameObjectUtil.GetChildren(partSortList)

	self._partFilterTabViewList = {}

	for index = 0, childList.Length - 1 do
		local view = Astral.LuaComponentContainer.Add(childList[index], BackpackFilterTabView)

		view:setTextStr(CommEnum.D6PartName[_index2PartType[index + 1]])
		table.insert(self._partFilterTabViewList, view)
	end

	local resonanceSortList = self:getGo("backpack_filter_tips_2_-1576125887")
	local childList = Astral.GameObjectUtil.GetChildren(resonanceSortList)

	self._resonanceFilterTabViewList = {}

	for index = 0, childList.Length - 1 do
		local view = Astral.LuaComponentContainer.Add(childList[index], BackpackFilterTabView)

		table.insert(self._resonanceFilterTabViewList, view)
	end

	self._index2AttrType = self:_genIndex2AttrType()

	local attributeSortList = self:getGo("backpack_filter_tips_2_-1174782820")

	self._tempItemGo = self:getGo("38&backpack_d6_filter_tab_1596948367")

	self._tempItemGo:SetActive(false)

	self._attributeFilterTabViewList = {}

	for index = 1, #self._index2AttrType do
		local itemGo = goutil.clone(self._tempItemGo)

		itemGo:SetActive(true)
		goutil.addChildToParent(itemGo, attributeSortList)

		local view = Astral.LuaComponentContainer.Add(itemGo, BackpackD6FilterTabView3)

		view:setTextStr("")
		table.insert(self._attributeFilterTabViewList, view)
	end

	self._partGo = goutil.findChild(self.mainGO, "basicsScroll/ViewPort/Content/part")
	self._resonanceGo = goutil.findChild(self.mainGO, "basicsScroll/ViewPort/Content/resonance")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	for index, view in ipairs(self._partFilterTabViewList) do
		local param = {
			normalCallback = function()
				self:_onClickNormalTab(FilterEnum.D6Part, index)
			end,
			selectCallback = function()
				self:_onClickSelectTab(FilterEnum.D6Part, index)
			end
		}

		view:setParam(param)
	end

	for index, view in ipairs(self._resonanceFilterTabViewList) do
		local param = {
			normalCallback = function()
				self:_onClickNormalTab(FilterEnum.D6Resonance, index)
			end,
			selectCallback = function()
				self:_onClickSelectTab(FilterEnum.D6Resonance, index)
			end
		}

		view:setParam(param)
	end

	for index, view in ipairs(self._attributeFilterTabViewList) do
		local param = {
			normalCallback = function()
				self:_onClickNormalTab(FilterEnum.D6Attr, index)
			end,
			selectCallback = function()
				self:_onClickSelectTab(FilterEnum.D6Attr, index)
			end
		}

		view:setParam(param)
	end
end

function M:unbindEvents()
	self._btnFilter:RemoveClickListener()
end

function M:onEnter()
	goutil.setActive(self._mainGo, true)

	self._isPartInWhiteList = self._filterCfg:containFilterWhiteList(FilterEnum.D6Part)
	self._isResonanceInWhiteList = self._filterCfg:containFilterWhiteList(FilterEnum.D6Resonance)

	goutil.setActive(self._partGo, not self._isPartInWhiteList)
	goutil.setActive(self._resonanceGo, not self._isResonanceInWhiteList)

	self._partMulEnumMap = MultipleEnumUtil.commEnum2Multiple(CommEnum.D6PartType)
	self._resonanceMulEnumMap = MultipleEnumUtil.commEnum2Multiple(CommEnum.D6ResonanceType)

	self:_recordLast()
	self:_updateTabViewStatus()
end

function M:_recordLast()
	local cfg = self._filterCfg

	self._lastAttrFilter = clone(cfg:getD6AttributeFilter())
	self._lastResonanceFilter = cfg:getD6ResonanceFilter()
	self._lastPartFilter = cfg:getD6PartFilter()
	self._hasLastValue = true
end

function M:doReset()
	local cfg = self._filterCfg
	local lastPartFilter = cfg:getD6PartFilter()
	local lastResonanceFilter = cfg:getD6ResonanceFilter()

	self._filterCfg:resetEquipD6()

	if self._isPartInWhiteList then
		cfg:setD6PartFilter(lastPartFilter)
	end

	if self._isResonanceInWhiteList then
		cfg:setD6ResonanceFilter(lastResonanceFilter)
	end

	self:_recordLast()
	self:_updateTabViewStatus()
end

function M:backToLast()
	if self._hasLastValue then
		local cfg = self._filterCfg

		cfg:setD6PartFilter(self._lastPartFilter)
		cfg:setD6ResonanceFilter(self._lastResonanceFilter)
		cfg:setD6AttributeFilter(self._lastAttrFilter)

		self._hasLastValue = false
	end
end

function M:onExit()
	return
end

function M:setViewData(filterCfg)
	self._filterCfg = filterCfg
end

function M:_updateTabViewStatus()
	self:_updatePartTabView()
	self:_updateResonanceTabView()
	self:_updateAttrTabView()
end

function M:_updatePartTabView()
	if self._isPartInWhiteList then
		return
	end

	local partFilter = self._filterCfg:getD6PartFilter()

	for index, tabView in ipairs(self._partFilterTabViewList) do
		local indexKey = _index2PartType[index]
		local tabType = self._partMulEnumMap[indexKey]
		local status = TabItemStatus.Disable

		if tabType then
			if partFilter == CommonAll then
				status = indexKey == CommonAll and TabItemStatus.Select or TabItemStatus.Normal
			else
				status = indexKey == CommonAll and TabItemStatus.Normal or MultipleEnumUtil.multipleEnumContain(partFilter, tabType) and TabItemStatus.Select or TabItemStatus.Normal
			end
		end

		tabView:setTabStatus(status)
	end
end

function M:_updateResonanceTabView()
	if self._isResonanceInWhiteList then
		return
	end

	local resonanceFilter = self._filterCfg:getD6ResonanceFilter()

	for index, tabView in ipairs(self._resonanceFilterTabViewList) do
		local indexKey = _index2ResonanceType[index]
		local tabType = self._resonanceMulEnumMap[indexKey]
		local status = TabItemStatus.Disable

		if tabType then
			if resonanceFilter == CommonAll then
				status = indexKey == CommonAll and TabItemStatus.Select or TabItemStatus.Normal
			else
				status = indexKey == CommonAll and TabItemStatus.Normal or MultipleEnumUtil.multipleEnumContain(resonanceFilter, tabType) and TabItemStatus.Select or TabItemStatus.Normal
			end
		end

		tabView:setTabStatus(status)
	end
end

function M:_updateAttrTabView()
	local filterCfg = self._filterCfg
	local partFilter = filterCfg:getD6PartFilter()
	local resonanceFilter = filterCfg:getD6ResonanceFilter()
	local attrFilter = filterCfg:getD6AttributeFilter()
	local attrsMap = TableUtil.arrayToMap(attrFilter)

	for _, v in ipairs(self._index2AttrType) do
		local attrId = v[1]

		if attrId ~= CommonAll then
			local attrCfg = EquipmentConfig.instance:getConfigByKey(ConfigName.DiceAttr, attrId)

			v[2] = MultipleEnumUtil.multipleEnumContainOnZeroAll(partFilter, attrCfg.part) and MultipleEnumUtil.multipleEnumContainOnZeroAll(resonanceFilter, attrCfg.enhanceType) or false

			if attrsMap[attrId] and not v[2] then
				attrsMap[attrId] = false

				table.removebyvalue(attrFilter, attrId)
			end
		end
	end

	if TableUtil.getLen(attrFilter) == 0 then
		table.insert(attrFilter, CommonAll)

		attrsMap[CommonAll] = true
	end

	table.sort(self._index2AttrType, FilterCfgUtil.d6AttrFilterSort)

	for index, tabView in ipairs(self._attributeFilterTabViewList) do
		local attrId = self._index2AttrType[index][1]

		if attrId == CommEnum.CommonAll then
			tabView:setTextStr(lang("tip_common_all"))
		else
			local attrCfg = EquipmentConfig.instance:getConfigByKey(ConfigName.DiceAttr, attrId)
			local desc = attrCfg.desc

			desc = string.gsub(desc, "%-%%", lang("tip_common_dec"))
			desc = string.gsub(desc, "%+%%", lang("tip_common_add"))

			tabView:setTextStr(desc)
		end

		local status = attrsMap[attrId] and TabItemStatus.Select or self._index2AttrType[index][2] and TabItemStatus.Normal or TabItemStatus.Disable

		tabView:setTabStatus(status)
	end
end

function M:_onClickNormalTab(filterEnum, index)
	local cfg = self._filterCfg

	if filterEnum == FilterEnum.D6Part then
		local selectKey = _index2PartType[index]
		local newFilter = CommonAll

		if selectKey ~= CommonAll then
			local lastFilter = cfg:getD6PartFilter()

			if lastFilter == CommonAll then
				newFilter = self._partMulEnumMap[selectKey]
			else
				newFilter = MultipleEnumUtil.multipleEnumAdd(lastFilter, self._partMulEnumMap[selectKey])

				if newFilter == self._partMulEnumMap[CommonAll] then
					newFilter = CommonAll
				end
			end
		end

		cfg:setD6PartFilter(newFilter)
	end

	if filterEnum == FilterEnum.D6Resonance then
		local selectKey = _index2ResonanceType[index]
		local newFilter = CommonAll

		if selectKey ~= CommonAll then
			local lastFilter = cfg:getD6ResonanceFilter()

			if lastFilter == CommonAll then
				newFilter = self._resonanceMulEnumMap[selectKey]
			else
				newFilter = MultipleEnumUtil.multipleEnumAdd(lastFilter, self._resonanceMulEnumMap[selectKey])

				if newFilter == self._resonanceMulEnumMap[CommonAll] then
					newFilter = CommonAll
				end
			end
		end

		cfg:setD6ResonanceFilter(newFilter)
	end

	if filterEnum == FilterEnum.D6Attr then
		local selectKey = self._index2AttrType[index][1]

		if selectKey == CommonAll then
			cfg:setD6AttributeFilter({
				CommonAll
			})
		else
			local lastFilter = cfg:getD6AttributeFilter()

			if table.indexof(lastFilter, CommonAll) then
				cfg:setD6AttributeFilter({
					selectKey
				})
			else
				table.insert(lastFilter, selectKey)
			end
		end
	end

	self:_updateTabViewStatus()
end

function M:_onClickSelectTab(filterEnum, index)
	if filterEnum == FilterEnum.D6Attr then
		local selectKey = _index2PartType[index]

		if selectKey == CommonAll then
			return
		end

		local lastFilter = self._filterCfg:getD6PartFilter()
		local value = self._partMulEnumMap[selectKey]

		value = MultipleEnumUtil.multipleEnumSub(lastFilter, value)

		self._filterCfg:setD6PartFilter(value)
	end

	if filterEnum == FilterEnum.D6Resonance then
		local selectKey = _index2ResonanceType[index]

		if selectKey == CommonAll then
			return
		end

		local lastFilter = self._filterCfg:getD6ResonanceFilter()
		local value = self._resonanceMulEnumMap[selectKey]

		value = MultipleEnumUtil.multipleEnumSub(lastFilter, value)

		self._filterCfg:setD6ResonanceFilter(value)
	end

	if filterEnum == FilterEnum.D6Attr then
		local selectKey = self._index2AttrType[index][1]

		if selectKey ~= CommonAll then
			local lastFilter = self._filterCfg:getD6AttributeFilter()

			if #lastFilter == 1 then
				self._filterCfg:setD6AttributeFilter({
					CommonAll
				})
			else
				table.removebyvalue(lastFilter, selectKey)
			end
		end
	end

	self:_updateTabViewStatus()
end

function M:_genIndex2AttrType()
	local res = {
		{
			CommEnum.CommonAll,
			true
		}
	}
	local diceAttrDataList = EquipmentConfig.instance:getConfigList(ConfigName.DiceAttr)

	for _, data in ipairs(diceAttrDataList) do
		table.insert(res, {
			data.id,
			false
		})
	end

	return res
end

return M
