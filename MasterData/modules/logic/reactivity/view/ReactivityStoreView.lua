-- chunkname: @modules/logic/reactivity/view/ReactivityStoreView.lua

module("modules.logic.reactivity.view.ReactivityStoreView", package.seeall)

local ReactivityStoreView = class("ReactivityStoreView", BaseView)

function ReactivityStoreView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "title/image_LimitTimeBG/#txt_time")
	self._scrollstore = gohelper.findChildScrollRect(self.viewGO, "#scroll_store")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content")
	self._gostoreItem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	self._gostoregoodsitem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	self._btnExchange = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Exchange")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ReactivityStoreView:addEvents()
	self._scrollstore:AddOnValueChanged(self._onScrollValueChanged, self)

	if self._btnExchange then
		self.addClickCb(self, self._btnExchange, self._onClickExchange, self)
	end

	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
end

function ReactivityStoreView:removeEvents()
	self._scrollstore:RemoveOnValueChanged()
end

function ReactivityStoreView:_editableInitView()
	gohelper.setActive(self._gostoreItem, false)

	self.rectTrContent = self._goContent:GetComponent(gohelper.Type_RectTransform)
	self.storeItemList = self:getUserDataTb_()
end

function ReactivityStoreView:onUpdateParam()
	return
end

function ReactivityStoreView:_onScrollValueChanged()
	if #self.storeItemList > 0 then
		local storeItem = self.storeItemList[1]

		if storeItem then
			storeItem:refreshTagClip(self._scrollstore)
		end
	end
end

function ReactivityStoreView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)

	self.actId = self.viewParam.actId

	self:refreshTime()
	self:refreshStoreContent()
	self:_onScrollValueChanged()
	self:scrollToFirstNoSellOutStore()
end

function ReactivityStoreView:refreshStoreContent()
	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(self.actId)
	local storeItem

	for i = 1, #storeGroupDict do
		storeItem = self.storeItemList[i]

		if not self.storeItemList[i] then
			storeItem = ReactivityStoreItem.New()

			storeItem:onInitView(gohelper.cloneInPlace(self._gostoreItem))
			table.insert(self.storeItemList, storeItem)
		end

		storeItem:updateInfo(i, storeGroupDict[i])
	end
end

function ReactivityStoreView:scrollToFirstNoSellOutStore()
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

function ReactivityStoreView:getFirstNoSellOutGroup()
	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(self.actId)

	for index, groupGoodsCoList in ipairs(storeGroupDict) do
		for _, goodsCo in ipairs(groupGoodsCoList) do
			local noLimit = goodsCo.maxBuyCount == 0

			if noLimit then
				return index
			end

			local haveBoughtCount = ActivityStoreModel.instance:getActivityGoodsBuyCount(self.actId, goodsCo.id)
			local canBuy = goodsCo.maxBuyCount - haveBoughtCount > 0

			if canBuy then
				return index
			end
		end
	end

	return 1
end

function ReactivityStoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txttime.text = offsetSecond > 0 and TimeUtil.SecondToActivityTimeFormat(offsetSecond) or luaLang("ended")
end

function ReactivityStoreView:_onClickExchange()
	ViewMgr.instance:openView(ViewName.ReactivityRuleView)
end

function ReactivityStoreView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

function ReactivityStoreView:onDestroyView()
	for _, storeItem in ipairs(self.storeItemList) do
		storeItem:onDestroy()
	end
end

function ReactivityStoreView:_onRefreshActivityState(actId)
	if not actId or actId ~= self.actId then
		return
	end

	if not ActivityHelper.isOpen(actId) then
		self:closeThis()

		return
	end
end

return ReactivityStoreView
