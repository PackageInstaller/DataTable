-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipRecycleView.lua

module("logic.extensions.charactersystem.view.equip.EquipRecycleView", package.seeall)

local M = class("EquipRecycleView", ViewComponent)
local QuickSelectType = CommEnum.MainBackpackQuickRecycleType
local QuickSelectItemStatus = CommEnum.BackPackFilterItemStatus
local BName = lang("tip_recyccle_blue_name")
local CName = lang("tip_recyccle_green_name")
local EquipName = lang("tip_recyccle_xiaoshiqi_name")
local NoName = lang("tip_recyccle_no_name")

function M:buildUI()
	self._detailView = Astral.LuaComponentContainer.Add(self:getGo("backpack_equip_detail_tips_copy_154087081"), EquipRecycleDetailInfoComponent)
	self._sourceEquiplist = LoopGridViewHelper.New(self:getGo("equip_decompose_view_580604661"))

	self._sourceEquiplist:InitGridView(0, self._onAllEquipCellUpdate, self)

	self._recycleEquiplist = LoopGridViewHelper.New(self:getGo("backpack_recycle_view_1455513067"))

	self._recycleEquiplist:InitGridView(0, self._onRecycleEquipCellUpdate, self)

	self._recycleAwardlist = LoopGridViewHelper.New(self:getGo("backpack_recycle_view_copy_1320543274"))

	self._recycleAwardlist:InitGridView(0, self._onRecycleAwardCellUpdate, self)

	self._btnFilter = self:getBtn("backpack_recycle_view_938814839")
	self._btnQuickSelect = self:getBtn("backpack_recycle_view_335196845")
	self._btnRecycle = self:getBtn("backpack_recycle_view_727506294")
	self._btnCancel = self:getBtn("backpack_recycle_view_1854632714")
	self._toggleList = self:getUIComponent("backpack_recycle_view_1161734738", UIComponentType.SpaceXToggle)
	self._recyclelistParentGo = goutil.findChild(self.mainGO, "backpack_recycle_view_copy/content/list")
	self._filterParentGo = self:getGo("backpack_recycle_view_1300850048")
	self._txtFilter = self:getText("backpack_recycle_view_570466300")
	self._txtCapacity = self:getText("backpack_recycle_view_2016217412")

	local topCurrencyGo = self:getGo("3&top_currency_1050779625")

	self._txtlingbujian = goutil.findChildTextComponent(topCurrencyGo, "btnDecompose/txtNum")
	self._quickSelectItemViews = {}

	for _, quickType in pairs(QuickSelectType) do
		local quickItem = goutil.findChild(self._filterParentGo, "Content/Item" .. quickType)
		local itemView = Astral.LuaComponentContainer.Add(quickItem, BackpackQuickSelectItem)

		self._quickSelectItemViews[quickType] = itemView
	end

	self._btnMask = self:getBtn("backpack_recycle_view_-853575840")

	goutil.setActive(self._btnMask.gameObject, false)

	self._btnListToggleMask = self:getBtn("backpack_recycle_view_631727447")

	goutil.setActive(self._btnListToggleMask.gameObject, false)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnFilter:AddClickListener(self._onClickFilterBtn, self)
	self._btnQuickSelect:AddClickListener(self._onClickQuickSelectBtn, self)
	self._btnRecycle:AddClickListener(self._onClickRecycleBtn, self)
	self._btnCancel:AddClickListener(self._onClickCancleBtn, self)
	self._toggleList:AddListener(self._onToggle, self)
	self._btnMask:AddClickListener(self._onClickMaskBtn, self)
	self._btnListToggleMask:AddClickListener(self._onClickMaskBtn, self)
end

function M:unbindEvents()
	self._btnFilter:RemoveClickListener()
	self._btnQuickSelect:RemoveClickListener()
	self._btnRecycle:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._toggleList:RemoveListener()
	self._btnMask:RemoveClickListener()
	self._btnListToggleMask:RemoveClickListener()
end

function M:onEnter()
	self._detailView:onEnter()
	self:initData()
	self:initUI()
	GlobalDispatcher:addEventListener(EventType.EQUIP_INTENCIFY_RECYCLE_ITEM_CLICK, self._onItemClick, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_INTENCIFY_RECYCLE_ITEM_SUB_CLICK, self._onItemSubClick, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_RECYCLE_QUICK_SELECT_ITEM_CLICK, self._onChoseQuickSelectItem, self)
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._handleItemCostEvent, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_INTENCIFY_RECYCLE_REPLY, self._onRecycleReplied, self)
end

function M:onExit()
	self._detailView:onExit()

	self._quickItems = nil
	self._quickItemsHas = nil

	GlobalDispatcher:removeEventListener(EventType.EQUIP_INTENCIFY_RECYCLE_ITEM_CLICK, self._onItemClick, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_INTENCIFY_RECYCLE_ITEM_SUB_CLICK, self._onItemSubClick, self)
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_RECYCLE_QUICK_SELECT_ITEM_CLICK, self._onChoseQuickSelectItem, self)
	GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._handleItemCostEvent, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_INTENCIFY_RECYCLE_REPLY, self._onRecycleReplied, self)
end

function M:initData()
	self._limitCount = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.RecycleLimit)
	self._allEquips = EquipIntensifyRecycleModel.instance:initRecycleEquips()
	self._quickItemsHas = EquipIntensifyRecycleModel.instance:getQuickSelectTypes()
	self._d6AwardCount = 0
	self._quickSelecResult = {}
	self._recycleEquips = {}
	self._recycleEquipsAwards = {}
end

function M:initUI()
	goutil.setActive(self._filterParentGo, false)
	goutil.setActive(self._recyclelistParentGo, false)
	goutil.setActive(self._btnMask.gameObject, false)
	goutil.setActive(self._btnListToggleMask.gameObject, false)

	for _, quickType in pairs(QuickSelectType) do
		local item = self._quickSelectItemViews[quickType]
		local status = self:_calItemStatus(quickType)

		item:setData(quickType, self:getQuickSeletStr(quickType))
		item:setStatus(status)
	end

	self._toggleList.IsOn = false
	self._txtFilter.text = NoName
	self._txtCapacity.text = "0/" .. self._limitCount

	local previewEquip = EquipIntensifyRecycleModel.instance:getPreviewItem()

	self._detailView:setEquipData(previewEquip)
	self:_refreshSourceEquipList()
	self._recycleEquiplist:SetListItemCount(0)
	self._recycleAwardlist:SetListItemCount(0)

	self._txtCapacity.text = "0" .. "/" .. self._limitCount

	local isChooseItems = EquipIntensifyRecycleModel.instance:isChooseAnyRecycleItem()
	local colorStr = isChooseItems and "#8ad7f0" or "#ffffff"

	self._txtlingbujian.color = parsecolor(colorStr)

	local str = MoneyModel.instance:getMoneyUpdateParams(1100014)

	self._txtlingbujian.text = TextFormatter.formatNumber(tonumber(str))
end

function M:_onClickMaskBtn()
	goutil.setActive(self._filterParentGo, false)
	goutil.setActive(self._btnMask.gameObject, false)
	goutil.setActive(self._btnListToggleMask.gameObject, false)
end

function M:_onClickFilterBtn()
	local active = not self._filterParentGo.activeSelf

	goutil.setActive(self._filterParentGo, active)
	goutil.setActive(self._btnMask.gameObject, active)
	goutil.setActive(self._btnListToggleMask.gameObject, active)

	if self._isNeedReset then
		self._isNeedReset = false

		table.clear(self._quickSelecResult)
		self:_refreshList()
		self:_resetItemStatus()
	end
end

function M:_onClickQuickSelectBtn()
	goutil.setActive(self._filterParentGo, false)
	goutil.setActive(self._btnMask.gameObject, false)
	goutil.setActive(self._btnListToggleMask.gameObject, false)

	if not self._hadChanged and not self._isNeedReset then
		return
	end

	EquipIntensifyRecycleModel.instance:addRecycleQuickItems(self._quickSelecResult)
	self:_refreshSourceEquipList()
	self:_refreshRecycleList()
end

function M:_onClickRecycleBtn()
	if #self._recycleEquips < 1 then
		FloatWordMgr.instance:show(lang("tip_backpack_recycle_empty"))

		return
	end

	goutil.setActive(self._filterParentGo, false)

	local isOpen = self:isOpenPrinstallNoticView(self._recycleEquips)

	if isOpen then
		ViewMgr.instance:open(ViewName.CharacterPreinstallNoticeView, 1, self._recycleEquips, self)
	else
		local param = {
			useItems = self._recycleEquips,
			showType = self._showType
		}

		ViewMgr.instance:open(ViewName.ResolveItemTips, param)
	end
end

function M:isOpenPrinstallNoticView(list)
	for k, v in pairs(list) do
		local temp = CharacterPreinstallController.instance:getItemList(v:getUuid())

		if temp then
			return true
		end
	end

	return false
end

function M:_confirmCallbackPreinstall()
	local param = {
		useItems = self._listData,
		showType = self._showType
	}

	ViewMgr.instance:open(ViewName.ResolveItemTips, param)
end

function M:_onRecycleReplied()
	EquipIntensifyRecycleModel.instance:clear()

	self._isNeedReset = true

	self:initData()
	self:initUI()
end

function M:_handleItemCostEvent()
	local str = MoneyModel.instance:getMoneyUpdateParams(1100014)
	local isChooseItems = EquipIntensifyRecycleModel.instance:isChooseAnyRecycleItem()
	local colorStr = isChooseItems and "#8ad7f0" or "#ffffff"

	self._txtlingbujian.color = parsecolor(colorStr)
	self._txtlingbujian.text = TextFormatter.formatNumber(tonumber(str))
end

function M:_onClickCancleBtn()
	EquipIntensifyRecycleModel.instance:clear()
	self:back()
end

function M:_onItemClick(e, itemData, cellGo, cellIndex)
	if not itemData then
		return
	end

	EquipIntensifyRecycleModel.instance:setPreviewItem(itemData)
	self._detailView:setEquipData(itemData)

	if self._recyclelistParentGo.activeSelf then
		GlobalDispatcher:dispatchEvent(itemData:getItemMarkType(), itemData, cellGo, cellIndex, true, true, false, true)
		self:_refreshSourceEquipList()

		return
	end

	local uuid = itemData:getUuid()

	if itemData:getIsEquip() then
		ToolTipsMgr.showCharacterTopToast(lang("tip_equip_recycle_is_use"), CommEnum.CharacterTopToastIcon.Fail, 1)
		self:_refreshSourceEquipList()

		return
	end

	if itemData:getIsLock() then
		ToolTipsMgr.showCharacterTopToast(lang("tip_equip_recycle_is_lock"), CommEnum.CharacterTopToastIcon.Fail, 1)
		self:_refreshSourceEquipList()

		return
	end

	if EquipIntensifyModel.instance:isOperatingEquip(uuid) then
		ToolTipsMgr.showCharacterTopToast(lang("tip_equip_recycle_is_timing"), CommEnum.CharacterTopToastIcon.Fail, 1)
		self:_refreshSourceEquipList()

		return
	end

	EquipIntensifyRecycleModel.instance:addRecycleItem(uuid)
	self:_refreshSourceEquipList()
	self:_refreshRecycleList()
end

function M:_onItemSubClick(e, itemData, cellGo, cellIndex)
	EquipIntensifyRecycleModel.instance:setPreviewItem(itemData)
	EquipIntensifyRecycleModel.instance:subRecycleItem(itemData:getUuid())
	self._detailView:setEquipData(itemData)
	self:_refreshSourceEquipList()
	self:_refreshRecycleList()
end

function M:_refreshSourceEquipList()
	local showItemsCount = #self._allEquips

	self._sourceEquiplist:SetListItemCount(showItemsCount)
	self._sourceEquiplist:RefreshAllShownItem()
end

function M:_refreshRecycleList()
	EquipIntensifyRecycleModel.instance:getRecycleItems(self._recycleEquips)
	EquipIntensifyRecycleModel.instance:calRecycleGetItems(self._recycleEquips, self._recycleEquipsAwards)

	local len = #self._recycleEquips
	local len1 = #self._recycleEquipsAwards

	self._txtCapacity.text = len .. "/" .. self._limitCount

	local str = MoneyModel.instance:getMoneyUpdateParams(1100014)
	local addCount = 0
	local addItem = len1 > 0 and self._recycleEquipsAwards[1] or false

	if addItem and addItem:getItemId() == 1100014 then
		addCount = addItem:getCount()
	end

	local isChooseItems = EquipIntensifyRecycleModel.instance:isChooseAnyRecycleItem()
	local colorStr = isChooseItems and "#8ad7f0" or "#ffffff"

	self._txtlingbujian.color = parsecolor(colorStr)
	self._txtlingbujian.text = TextFormatter.formatNumber(tonumber(str) + addCount)

	if self._recyclelistParentGo.activeSelf then
		self._recycleEquiplist:SetListItemCount(len)
		self._recycleEquiplist:RefreshAllShownItem()
		self._recycleAwardlist:SetListItemCount(len1)
		self._recycleAwardlist:RefreshAllShownItem()
	end
end

function M:_onChoseQuickSelectItem(e, selectType, status)
	if status == QuickSelectItemStatus.Normal then
		self._quickSelecResult[selectType] = true

		self._quickSelectItemViews[selectType]:setStatus(QuickSelectItemStatus.Select)
		self:_refreshQuickFilterText()
	elseif status == QuickSelectItemStatus.Select then
		self._quickSelecResult[selectType] = false

		self._quickSelectItemViews[selectType]:setStatus(QuickSelectItemStatus.Normal)
		self:_refreshQuickFilterText()
	end
end

function M:_onToggle(toggle, isOn)
	goutil.setActive(self._recyclelistParentGo, isOn)

	if isOn then
		local len = #self._recycleEquips

		self._recycleEquiplist:SetListItemCount(len)
		self._recycleEquiplist:RefreshAllShownItem()

		len = #self._recycleEquipsAwards

		self._recycleAwardlist:SetListItemCount(len)
		self._recycleAwardlist:RefreshAllShownItem()
	end
end

function M:_resetItemStatus()
	for _, quickType in pairs(QuickSelectType) do
		local item = self._quickSelectItemViews[quickType]
		local last = item:getStatus()

		if last and last == QuickSelectItemStatus.Select then
			item:setStatus(QuickSelectItemStatus.Normal)
		end
	end

	self._quickItemsHas = MainBackpackModel.instance:getQuickSelectTypes()
	self._txtFilter.text = NoName
	self._hadChanged = true
end

function M:_calItemStatus(quickType)
	return self._quickItemsHas[quickType] and QuickSelectItemStatus.Normal or QuickSelectItemStatus.Disable
end

function M:_refreshQuickFilterText()
	local str1 = ""
	local isEmpty = true

	for quickType, result in pairs(self._quickSelecResult) do
		if result then
			isEmpty = false
			str1 = str1 .. "/" .. (quickType == QuickSelectType.Blue and BName or quickType == QuickSelectType.Green and CName)
		end
	end

	self._hadChanged = true
	self._txtFilter.text = isEmpty and NoName or string.sub(str1, 2, string.len(str1)) .. EquipName
end

function M:getQuickSeletStr(quickType)
	local str1 = quickType == QuickSelectType.Blue and BName or quickType == QuickSelectType.Green and CName

	return str1 .. EquipName
end

function M:_onAllEquipCellUpdate(curIndex)
	curIndex = curIndex + 1

	local item = self._sourceEquiplist:NewListViewItem("backpack_item")
	local view = Astral.LuaComponentContainer.Add(item.gameObject, EquipIntencifyRecycleItem)
	local mo = self._allEquips[curIndex]

	view:updateData(mo)

	local isPreview = EquipIntensifyRecycleModel.instance:isPreviewEquip(mo)
	local isSelected = EquipIntensifyRecycleModel.instance:isSelected(mo)

	view:onSelect(isPreview, isSelected)

	return item
end

function M:_onRecycleEquipCellUpdate(curIndex)
	curIndex = curIndex + 1

	local item = self._recycleEquiplist:NewListViewItem("backpack_item1")
	local itemGo = item.gameObject
	local view = Astral.LuaComponentContainer.Add(itemGo, EquipIntencifyRecycleItem)
	local mo = self._recycleEquips[curIndex]

	view:updateData(mo)

	local isSelected = EquipIntensifyRecycleModel.instance:isSelected(mo)

	view:onSelect(false, isSelected)

	return item
end

function M:_onRecycleAwardCellUpdate(curIndex)
	curIndex = curIndex + 1

	local item = self._recycleAwardlist:NewListViewItem("backpack_item2")
	local itemGo = item.gameObject
	local view = Astral.LuaComponentContainer.Add(itemGo, ItemCell)
	local mo = self._recycleEquipsAwards[curIndex]

	view:updateData(mo)
	view:setShowSelectedEffect(false)
	view:setIsHideGetWay(true)
	view:onSelect(isSelected)

	return item
end

return M
