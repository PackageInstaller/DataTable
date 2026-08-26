-- chunkname: @modules/logic/versionactivity2_3/act174/view/outside/Act174StoreView.lua

module("modules.logic.versionactivity2_3.act174.view.outside.Act174StoreView", package.seeall)

local Act174StoreView = class("Act174StoreView", BaseView)

function Act174StoreView:onInitView()
	self._scrollstore = gohelper.findChildScrollRect(self.viewGO, "#scroll_store")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content")
	self._gostoreItem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	self._txttime = gohelper.findChildText(self.viewGO, "title/image_LimitTimeBG/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174StoreView:addEvents()
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
end

function Act174StoreView:removeEvents()
	self.removeEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
end

function Act174StoreView:_editableInitView()
	gohelper.setActive(self._gostoreItem, false)

	self.storeItemList = self:getUserDataTb_()
	self.rectTrContent = self._goContent:GetComponent(gohelper.Type_RectTransform)
end

function Act174StoreView:onOpen()
	self.actId = self.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	self:refreshTime()
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)
	self:refreshStoreContent()
	self:scrollToFirstNoSellOutStore()
end

function Act174StoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	self._txttime.text = actInfoMo:getRemainTimeStr3(false, false)
end

function Act174StoreView:refreshStoreContent()
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

				storeItem = Act174StoreItem.New()

				storeItem:onInitView(storeItemGo)
				table.insert(self.storeItemList, storeItem)
			end

			storeItem:updateInfo(i, self.actId[i])
		end
	end
end

function Act174StoreView:scrollToFirstNoSellOutStore()
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

function Act174StoreView:getFirstNoSellOutGroup()
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

function Act174StoreView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

function Act174StoreView:onDestroyView()
	for _, storeItem in ipairs(self.storeItemList) do
		storeItem:onDestroy()
	end
end

return Act174StoreView
