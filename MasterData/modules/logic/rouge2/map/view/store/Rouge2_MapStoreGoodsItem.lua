-- chunkname: @modules/logic/rouge2/map/view/store/Rouge2_MapStoreGoodsItem.lua

module("modules.logic.rouge2.map.view.store.Rouge2_MapStoreGoodsItem", package.seeall)

local Rouge2_MapStoreGoodsItem = class("Rouge2_MapStoreGoodsItem", ListScrollCell)

Rouge2_MapStoreGoodsItem.RateChangeDuration = 0.3

function Rouge2_MapStoreGoodsItem:init(go)
	self.go = go
	self._imageRare = gohelper.findChildImage(self.go, "image_Rare")
	self._simageIcon = gohelper.findChildSingleImage(self.go, "image_Icon")
	self._txtName = gohelper.findChildText(self.go, "txt_Name")
	self._goDiscount = gohelper.findChild(self.go, "go_Discount")
	self._txtDiscount = gohelper.findChildText(self.go, "go_Discount/txt_Discount")
	self._txtCost = gohelper.findChildText(self.go, "Cost/txt_Cost")
	self._txtOriginalPrice = gohelper.findChildText(self.go, "Cost/txt_OriginalPrice")
	self._goSelect = gohelper.findChild(self.go, "go_Select")
	self._imageAttr = gohelper.findChildImage(self.go, "image_attr")
	self._goSellOut = gohelper.findChild(self.go, "go_SellOut")
	self._goSteal = gohelper.findChild(self.go, "go_Steal")
	self._goStealRate = gohelper.findChild(self.go, "go_StealRate")
	self._txtStealRate = gohelper.findChildText(self.go, "go_StealRate/txt_StealRate")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_Click")
	self._goRecommend = gohelper.findChild(self.go, "go_Recommend")
	self._stealAnimator = gohelper.onceAddComponent(self._goStealRate, gohelper.Type_Animator)
	self._teamTipsParam = {}
	self._teamTipsLoader = Rouge2_TeamRecommendTipsLoader.Load(self._goRecommend, Rouge2_Enum.TeamRecommendTipType.ItemRecommend)
end

function Rouge2_MapStoreGoodsItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onSelectStoreGoods, self._onSelectStoreGoods, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateRougeInfoCoin, self.refreshCost, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChangeStoreState, self._onChangeStoreState, self)
end

function Rouge2_MapStoreGoodsItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_MapStoreGoodsItem:_btnClickOnClick()
	if self._isSelect then
		return
	end

	Rouge2_MapStoreGoodsListModel.instance:select(self._index)
end

function Rouge2_MapStoreGoodsItem:onUpdateMO(goodMo, index)
	self._index = index
	self._goodMo = goodMo
	self._originalPrice = self._goodMo.originalPrice
	self._price = self._goodMo.price
	self._discountRate = self._goodMo.discountRate
	self._hasDiscount = self._discountRate ~= -1 and self._discountRate ~= 1000
	self._stealRate = self._goodMo.stealRate or 0
	self._checkId = self._goodMo.checkId
	self._itemId = self._goodMo.collectionId
	self._oldStealRate = Rouge2_MapStoreGoodsListModel.instance:getAndMarkStealRate(self._itemId, self._stealRate)
	self._curStealRate = self._oldStealRate
	self._itemCo = Rouge2_BackpackHelper.getItemConfig(self._itemId)
	self._itmeType = Rouge2_BackpackHelper.itemId2BagType(self._itemId)
	self._attrTag = self._itemCo and self._itemCo.attributeTag

	self:refreshUI()
end

function Rouge2_MapStoreGoodsItem:refreshUI()
	self:refreshGoods()
	self:refreshCost()
	self:refreshSellOut()
	self:refreshStealRate()
	self:refreshSelect()
end

function Rouge2_MapStoreGoodsItem:refreshGoods()
	self._txtName.text = self._itemCo and self._itemCo.name
	self._teamTipsParam[Rouge2_Enum.TeamRecommendParam.ItemId] = self._itemId

	self._teamTipsLoader:initInfo(nil, self._teamTipsParam)
	self:refreshIcon()
end

function Rouge2_MapStoreGoodsItem:refreshIcon()
	gohelper.setActive(self._imageRare.gameObject, true)
	Rouge2_IconHelper.setAttributeIcon(self._attrTag, self._imageAttr)
	Rouge2_IconHelper.setItemIconAndRare(self._itemId, self._simageIcon, self._imageRare)
end

function Rouge2_MapStoreGoodsItem:refreshCost()
	local curCoin = Rouge2_Model.instance:getRougeInfo().coin

	self._txtCost.text = curCoin < self._price and string.format("<color=#943131>%s</color>", self._price) or self._price

	gohelper.setActive(self._goDiscount, self._hasDiscount)
	gohelper.setActive(self._txtOriginalPrice.gameObject, self._hasDiscount)

	if self._hasDiscount then
		self._txtDiscount.text = string.format("%s%%", (self._discountRate - 1000) / 10)
		self._txtOriginalPrice.text = self._originalPrice
	end
end

function Rouge2_MapStoreGoodsItem:refreshSellOut()
	local state = Rouge2_MapStoreGoodsListModel.instance:getGoodsState(self._index)

	gohelper.setActive(self._goSellOut, state == Rouge2_MapEnum.GoodsState.Sell)
	gohelper.setActive(self._goSteal, state == Rouge2_MapEnum.GoodsState.StealSucc or state == Rouge2_MapEnum.GoodsState.StealFail)
end

function Rouge2_MapStoreGoodsItem:refreshStealRate()
	self._waitUpdate = false

	local storeState = Rouge2_MapStoreGoodsListModel.instance:getStoreState()
	local isSteal = storeState == Rouge2_MapEnum.StoreState.Steal or storeState == Rouge2_MapEnum.StoreState.StealSucc

	gohelper.setActive(self._goStealRate, isSteal)

	if not isSteal then
		return
	end

	if self._oldStealRate ~= self._stealRate then
		self._oldStealRate = self._stealRate
		self._waitUpdate = true

		self:_tryPlayStealRateAnim()

		return
	end

	self._txtStealRate.text = string.format("%s%%", self._curStealRate / 10)
end

function Rouge2_MapStoreGoodsItem:_tryPlayStealRateAnim()
	if not self._waitUpdate then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(ViewName.Rouge2_MapStoreView, {
		ViewName.Rouge2_MapTipView
	}) then
		return
	end

	self._waitUpdate = false

	self._stealAnimator:Play("add", 0, 0)
	self:_killTween()

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._curStealRate, self._stealRate, Rouge2_MapStoreGoodsItem.RateChangeDuration, self._tweenRefreshStealRateCallback, nil, self)
end

function Rouge2_MapStoreGoodsItem:_onCloseViewFinish()
	self:_tryPlayStealRateAnim()
end

function Rouge2_MapStoreGoodsItem:_tweenRefreshStealRateCallback(value)
	self._curStealRate = math.ceil(value)
	self._txtStealRate.text = string.format("%s%%", self._curStealRate / 10)
end

function Rouge2_MapStoreGoodsItem:_killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function Rouge2_MapStoreGoodsItem:_onChangeStoreState()
	self:refreshUI()
end

function Rouge2_MapStoreGoodsItem:_onSelectStoreGoods()
	self:refreshSelect()
end

function Rouge2_MapStoreGoodsItem:refreshSelect()
	self._isSelect = Rouge2_MapStoreGoodsListModel.instance:isGoodSelect(self._index)

	gohelper.setActive(self._goSelect, self._isSelect)
end

function Rouge2_MapStoreGoodsItem:onDestroy()
	self:_killTween()
end

return Rouge2_MapStoreGoodsItem
