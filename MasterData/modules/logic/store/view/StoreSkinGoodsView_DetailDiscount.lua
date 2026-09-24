-- chunkname: @modules/logic/store/view/StoreSkinGoodsView_DetailDiscount.lua

module("modules.logic.store.view.StoreSkinGoodsView_DetailDiscount", package.seeall)

local StoreSkinGoodsView_DetailDiscount = class("StoreSkinGoodsView_DetailDiscount", DecoratorSimpleItemBase)

function StoreSkinGoodsView_DetailDiscount:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "fold/#btn_click")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "expand/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSkinGoodsView_DetailDiscount:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function StoreSkinGoodsView_DetailDiscount:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function StoreSkinGoodsView_DetailDiscount.s_create(Self, srcGo, baseViewContainer)
	return DecoratorSimpleItemBase.s_create(StoreSkinGoodsView_DetailDiscount, Self, srcGo, baseViewContainer)
end

function StoreSkinGoodsView_DetailDiscount.s_createByView(Self, srcGo)
	return DecoratorSimpleItemBase.s_createByView(StoreSkinGoodsView_DetailDiscount, Self, srcGo)
end

function StoreSkinGoodsView_DetailDiscount.s_createByListScrollCellExtend(Self, srcGo)
	return DecoratorSimpleItemBase.s_createByListScrollCellExtend(StoreSkinGoodsView_DetailDiscount, Self, srcGo)
end

function StoreSkinGoodsView_DetailDiscount:_btnclickOnClick()
	self:_setActive_expand(true)
end

function StoreSkinGoodsView_DetailDiscount:_btncloseOnClick()
	self:_setActive_expand(false)
end

function StoreSkinGoodsView_DetailDiscount:bCostRMB()
	local p = self:parent()

	return p:bCostRMB()
end

function StoreSkinGoodsView_DetailDiscount:bCostCoin()
	local p = self:parent()

	return p:bCostCoin()
end

function StoreSkinGoodsView_DetailDiscount:curCostIndex()
	local p = self:parent()

	return p:curCostIndex()
end

function StoreSkinGoodsView_DetailDiscount:onClickRMB()
	self:_onSwitchPayMode()
end

function StoreSkinGoodsView_DetailDiscount:onClickCoin()
	self:_onSwitchPayMode()
end

function StoreSkinGoodsView_DetailDiscount:_onSwitchPayMode()
	local invalidCnt = 0
	local totCnt = 0

	for _, costIndex in pairs(StoreSkinGoodsView2.CostIndex) do
		totCnt = totCnt + 1

		if self:bEmpty(costIndex) then
			invalidCnt = invalidCnt + 1
		end
	end

	if invalidCnt == totCnt then
		return
	end

	self:_resetToSetData()
end

function StoreSkinGoodsView_DetailDiscount:ctor(...)
	StoreSkinGoodsView_DetailDiscount.super.ctor(self, ...)

	self._itemList = {}
	self._infos = {}

	for _, costIndex in pairs(StoreSkinGoodsView2.CostIndex) do
		self._infos[costIndex] = {
			maxCount = 0,
			priceMO = StoreSkinPriceMO.New(),
			validInfoIndexList = {}
		}
	end
end

function StoreSkinGoodsView_DetailDiscount:getInfo(optCostIndex)
	return self._infos[optCostIndex or self:curCostIndex()]
end

function StoreSkinGoodsView_DetailDiscount:getPriceMO(optCostIndex)
	return self:getInfo(optCostIndex).priceMO
end

function StoreSkinGoodsView_DetailDiscount:getMaxCount(optCostIndex)
	return self:getInfo(optCostIndex).maxCount or 0
end

function StoreSkinGoodsView_DetailDiscount:getValidInfoIndexList(optCostIndex)
	return self:getInfo(optCostIndex).validInfoIndexList or {}
end

function StoreSkinGoodsView_DetailDiscount:getValidInfoIndexCount(optCostIndex)
	optCostIndex = optCostIndex or self:curCostIndex()

	local validInfoIndexList = self:getValidInfoIndexList(optCostIndex)
	local specialofferItemIndex = self:_specialofferItemIndex(optCostIndex)
	local cnt = #validInfoIndexList

	if specialofferItemIndex then
		local mo = self:_getItemMo(specialofferItemIndex)

		if mo then
			if optCostIndex == StoreSkinGoodsView2.CostIndex.Coin then
				if mo.coinReduction then
					cnt = cnt + 1
				end
			elseif optCostIndex == StoreSkinGoodsView2.CostIndex.RMB and mo.rmbReduction then
				cnt = cnt + 1
			end
		end
	end

	return cnt
end

function StoreSkinGoodsView_DetailDiscount:bEmpty(optCostIndex)
	local validInfoIndexList = self:getValidInfoIndexList(optCostIndex)

	return #validInfoIndexList == 0 and validInfoIndexList[-1] == nil
end

function StoreSkinGoodsView_DetailDiscount:_specialofferItemIndex(optCostIndex)
	local validInfoIndexList = self:getValidInfoIndexList(optCostIndex)

	return validInfoIndexList[-1]
end

function StoreSkinGoodsView_DetailDiscount:onDestroyView()
	StoreSkinGoodsView_DetailDiscount.super.onDestroyView(self)
	GameUtil.onDestroyViewMemberList(self, "_itemList")
end

function StoreSkinGoodsView_DetailDiscount:_editableInitView()
	StoreSkinGoodsView_DetailDiscount.super._editableInitView(self)

	self._animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._fold = gohelper.findChild(self.viewGO, "fold")
	self._expand = gohelper.findChild(self.viewGO, "expand")
	self._go_item = gohelper.findChild(self._expand, "panel/go_item")

	gohelper.setActive(self._go_item, false)
	self:_playAnim("open_fold", 0, 1)
	gohelper.setActive(self._expand, false)
end

function StoreSkinGoodsView_DetailDiscount:_playAnim(animName, ...)
	self._animator:Play(animName, ...)
end

function StoreSkinGoodsView_DetailDiscount:_setActive_expand(bActive)
	self:_playAnim(bActive and "open_expand" or "open_fold", 0, 0)
	gohelper.setActive(self._expand, bActive)
end

function StoreSkinGoodsView_DetailDiscount:_create_StoreSkinGoodsView_DetailDiscountItem(index)
	local go = gohelper.cloneInPlace(self._go_item)
	local item = StoreSkinGoodsView_DetailDiscountItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function StoreSkinGoodsView_DetailDiscount:onClickDetailDiscountItem(item)
	local index = item:index()
	local bNewSelected = not item:isSelected()

	item:setSelected(bNewSelected)
	self:_onDiscountValueChanged()
end

function StoreSkinGoodsView_DetailDiscount:_onDiscountValueChanged()
	local p = self:parent()

	p:onDiscountValueChanged()
end

function StoreSkinGoodsView_DetailDiscount:setData(mo)
	StoreSkinGoodsView_DetailDiscount.super.setData(self, mo)
	self:_internal_setData(mo)
	self:_resetToSetData()

	return self
end

function StoreSkinGoodsView_DetailDiscount:_internal_setData(mo)
	local goodsConfig = StoreConfig.instance:getGoodsConfig(mo.lua_store_goods_id)

	for _, costIndex in pairs(StoreSkinGoodsView2.CostIndex) do
		local info = self._infos[costIndex]

		info.priceMO:reset(goodsConfig, mo.skinId)

		local deductionItemInfoList = info.priceMO.deductionItemInfoList
		local hasSpecialOfferItem = info.priceMO.hasSpecialOfferItem
		local specialofferReduction = info.priceMO.specialofferReduction
		local rmbDiffAbsPrice = info.priceMO.rmbDiffAbsPrice
		local maxCount = 0
		local validInfoIndexList = {}

		for index, info in ipairs(deductionItemInfoList) do
			if info.has then
				local rmbReduction = false
				local coinReduction = info.reduction
				local bGreyscale = false

				bGreyscale = StoreSkinGoodsView2.CostIndex.Coin == costIndex and not coinReduction or StoreSkinGoodsView2.CostIndex.RMB == costIndex and not rmbReduction or false

				if not bGreyscale then
					maxCount = maxCount + 1

					table.insert(validInfoIndexList, index)
				end
			end
		end

		info.validInfoIndexList = validInfoIndexList

		if hasSpecialOfferItem then
			local rmbReduction = rmbDiffAbsPrice
			local coinReduction = specialofferReduction
			local bGreyscale = false

			bGreyscale = StoreSkinGoodsView2.CostIndex.Coin == costIndex and not coinReduction or StoreSkinGoodsView2.CostIndex.RMB == costIndex and not rmbReduction or false

			if not bGreyscale then
				maxCount = maxCount + 1
			end
		end

		if maxCount % 2 ~= 0 then
			maxCount = maxCount + 1
		end

		if not hasSpecialOfferItem then
			info.validInfoIndexList[-1] = nil
		end

		info.maxCount = maxCount
	end
end

function StoreSkinGoodsView_DetailDiscount:_resetToSetData()
	self:_refreshItemList()
	self:_setSelectAll(true, true)
	self:_onDiscountValueChanged()

	local bActive = not self:bEmpty()

	gohelper.setActive(self._fold, bActive)

	if not bActive then
		self:_setActive_expand(false)
	end
end

function StoreSkinGoodsView_DetailDiscount:_refreshItemList()
	local validInfoIndexList = self:getValidInfoIndexList()
	local maxCount = self:getMaxCount()
	local specialofferItemIndex = self:_specialofferItemIndex()
	local deductionItemInfoList = self:getPriceMO().deductionItemInfoList
	local specialofferItemType = self:getPriceMO().specialofferItemType
	local specialofferItemId = self:getPriceMO().specialofferItemId
	local specialofferReduction = self:getPriceMO().specialofferReduction
	local hasSpecialOfferItem = self:getPriceMO().hasSpecialOfferItem
	local rmbDiffAbsPrice = self:getPriceMO().rmbDiffAbsPrice
	local deductionItemInfoIndex = 0

	for i = 1, maxCount do
		local item = self._itemList[i]

		if not item then
			item = self:_create_StoreSkinGoodsView_DetailDiscountItem(i)

			table.insert(self._itemList, item)
		end

		local mo

		if specialofferItemIndex == i then
			mo = {
				bGreyscale = false,
				bLockSelectState = true,
				bForceSelected = true,
				itemType = specialofferItemType,
				itemId = specialofferItemId,
				coinReduction = specialofferReduction,
				rmbReduction = rmbDiffAbsPrice
			}
		else
			deductionItemInfoIndex = deductionItemInfoIndex + 1

			local index = validInfoIndexList[deductionItemInfoIndex]
			local info = deductionItemInfoList[index]

			if not info and maxCount == i then
				-- block empty
			else
				mo = {
					rmbReduction = false,
					bGreyscale = false,
					bLockSelectState = false,
					bForceSelected = false,
					itemType = info.itemType,
					itemId = info.itemId,
					coinReduction = info.reduction,
					deductionItemInfoIndex = deductionItemInfoIndex
				}
			end
		end

		item:onUpdateMO(mo)
		item:setActive(true)
	end

	for i = maxCount + 1, #self._itemList do
		local item = self._itemList[i]

		item:setActive(false)
		item:setSelectedSlient(false)
	end
end

function StoreSkinGoodsView_DetailDiscount:_setSelectAll(bSelected, bForce)
	self:_foreachValidItemList(function(i, item)
		if not item:bEmpty() then
			if bForce then
				item:setSelectedSlient(true)
				item:_setAsSelected(true)
			else
				item:setSelected(bSelected)
			end
		end
	end)
end

function StoreSkinGoodsView_DetailDiscount:getDeductionItemIndices()
	local list = {}
	local validInfoIndexList = self:getValidInfoIndexList()
	local specialofferItemIndex = validInfoIndexList[-1]

	self:_foreachValidItemList(function(i, item)
		if not item:bEmpty() and item:isSelected() and specialofferItemIndex ~= i then
			local mo = item:mo()
			local deductionItemInfoIndex = mo.deductionItemInfoIndex
			local index = validInfoIndexList[deductionItemInfoIndex]

			if index then
				table.insert(list, index)
			end
		end
	end)

	return list
end

function StoreSkinGoodsView_DetailDiscount:getSelectedDeductionItemInfoList()
	local list = {}
	local deductionItemInfoList = self:getPriceMO().deductionItemInfoList
	local deductionItemIndices = self:getDeductionItemIndices()

	for i, info in ipairs(deductionItemInfoList) do
		local bSelected = deductionItemIndices[i]

		if bSelected then
			table.insert(list, info)
		end
	end

	return list
end

function StoreSkinGoodsView_DetailDiscount:getCoinsTotalReductionNum()
	local tot = 0

	self:_foreachValidItemList(function(i, item)
		if not item:bEmpty() and item:isSelected() then
			local mo = item:mo()

			if mo then
				tot = tot + mo.coinReduction
			end
		end
	end)

	return -tot
end

function StoreSkinGoodsView_DetailDiscount:getCoinsTotalReductionStr()
	return tostring(self:getCoinsTotalReductionNum())
end

function StoreSkinGoodsView_DetailDiscount:getRmbTotalReductionStr(optCostIndex)
	local hasSpecialOfferItem = self:getPriceMO(optCostIndex).hasSpecialOfferItem
	local rmbDiffAbsPrice = self:getPriceMO(optCostIndex).rmbDiffAbsPrice

	if hasSpecialOfferItem and rmbDiffAbsPrice then
		return "-" .. rmbDiffAbsPrice
	end

	return nil
end

function StoreSkinGoodsView_DetailDiscount:selectedCount()
	local count = 0

	self:_foreachValidItemList(function(i, item)
		if not item:bEmpty() and item:isSelected() then
			count = count + 1
		end
	end)

	return count
end

function StoreSkinGoodsView_DetailDiscount:_foreachValidItemList(handler)
	local n = self:getMaxCount() or 0
	local validInfoIndexList = self:getValidInfoIndexList()
	local priceMO = self:getPriceMO()

	for i = 1, n do
		local item = self._itemList[i]

		if item and handler(i, item) then
			break
		end
	end
end

function StoreSkinGoodsView_DetailDiscount:coinsCurPriceNumeric()
	local priceMO = self:getPriceMO(StoreSkinGoodsView2.CostIndex.Coin)
	local minusNum = 0

	minusNum = self:bCostCoin() and self:getCoinsTotalReductionNum() or -priceMO.coinsReduction

	return ((priceMO.specialofferItemId or nil) and priceMO.coinsCostPrice + priceMO.specialofferReduction) + minusNum
end

function StoreSkinGoodsView_DetailDiscount:coinsCurPrice()
	return math.max(0, self:coinsCurPriceNumeric())
end

function StoreSkinGoodsView_DetailDiscount:_getItemMo(i)
	local item = self._itemList[i]

	if item then
		return item:mo()
	end

	return nil
end

return StoreSkinGoodsView_DetailDiscount
