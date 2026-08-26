-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191StoreView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191StoreView", package.seeall)

local Act191StoreView = class("Act191StoreView", BaseView)

function Act191StoreView:onInitView()
	self._scrollstore = gohelper.findChildScrollRect(self.viewGO, "#scroll_store")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content")
	self._gostoreItem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	self._txttime = gohelper.findChildText(self.viewGO, "title/image_LimitTimeBG/#txt_time")
	self._txtCoin = gohelper.findChildText(self.viewGO, "righttop/#txt_Coin")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191StoreView:addEvents()
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.refreshCurrency, self)
end

function Act191StoreView:removeEvents()
	return
end

function Act191StoreView:_editableInitView()
	self.actId = Activity191Controller.instance:getStoreId()

	gohelper.setActive(self._gostoreItem, false)

	self.storeItemList = self:getUserDataTb_()
	self.rectTrContent = self._goContent:GetComponent(gohelper.Type_RectTransform)
end

function Act191StoreView:onOpen()
	Act191StatController.instance:onViewOpen(self.viewName)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	self:refreshTime()
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)
	self:refreshStoreContent()
	self:scrollToFirstNoSellOutStore()
	self:refreshCurrency()
end

function Act191StoreView:refreshCurrency()
	local currencyMo = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V3a8DouQuQu)

	self._txtCoin.text = currencyMo.quantity
end

function Act191StoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	self._txttime.text = actInfoMo:getRemainTimeStr3(false, false)
end

function Act191StoreView:refreshStoreContent()
	if self.actId then
		local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(self.actId)

		if not self.actId then
			return
		end

		local storeItem

		for i = 1, #self.actId do
			storeItem = self.storeItemList[i]

			if not self.storeItemList[i] then
				local storeItemGo = gohelper.cloneInPlace(self._gostoreItem)

				storeItem = Act191StoreItem.New()

				storeItem:onInitView(storeItemGo)
				table.insert(self.storeItemList, storeItem)
			end

			storeItem:updateInfo(i, self.actId[i])
		end
	end
end

function Act191StoreView:scrollToFirstNoSellOutStore()
	local firstNoSellOutIndex = self:getFirstNoSellOutGroup()

	if firstNoSellOutIndex <= 1 then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(self.rectTrContent)

	local height = 0

	for i, storeItem in ipairs(self.storeItemList) do
		if firstNoSellOutIndex <= i then
			break
		end

		height = height + storeItem:getHeight()
	end

	local viewPortTr = gohelper.findChildComponent(self.viewGO, "#scroll_store/Viewport", gohelper.Type_RectTransform)
	local viewPortHeight = recthelper.getHeight(viewPortTr)
	local contentHeight = recthelper.getHeight(self.rectTrContent)
	local maxAnchorY = contentHeight - viewPortHeight

	recthelper.setAnchorY(self.rectTrContent, math.min(height, maxAnchorY))
end

function Act191StoreView:getFirstNoSellOutGroup()
	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(self.actId)

	for index, groupGoodsCoList in ipairs(storeGroupDict) do
		for _, goodsCo in ipairs(groupGoodsCoList) do
			if goodsCo.maxBuyCount == 0 then
				return index
			end

			if goodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(self.actId, goodsCo.id) > 0 then
				return index
			end
		end
	end

	return 1
end

function Act191StoreView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)

	local manual = self.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(self.viewName, manual)
end

function Act191StoreView:onDestroyView()
	for _, storeItem in ipairs(self.storeItemList) do
		storeItem:onDestroy()
	end
end

return Act191StoreView
