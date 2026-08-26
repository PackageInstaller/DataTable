-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/store/VersionActivityFixedStoreView.lua

module("modules.versionactivitybase.fixed.dungeon.view.store.VersionActivityFixedStoreView", package.seeall)

local VersionActivityFixedStoreView = class("VersionActivityFixedStoreView", BaseView)

function VersionActivityFixedStoreView:onInitView()
	self._scrollstore = gohelper.findChildScrollRect(self.viewGO, "#scroll_store")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content")
	self._gostoreItem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	self._txttime = gohelper.findChildText(self.viewGO, "title/image_LimitTimeBG/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityFixedStoreView:addEvents()
	self._scrollstore:AddOnValueChanged(self._onScrollValueChanged, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self, LuaEventSystem.Low)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onCurrencyChange, self, LuaEventSystem.Low)
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self._refreshView, self, LuaEventSystem.Low)
end

function VersionActivityFixedStoreView:removeEvents()
	self._scrollstore:RemoveOnValueChanged()
	self.removeEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onCurrencyChange, self)
	self:removeEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self._refreshView)
end

function VersionActivityFixedStoreView:_onScrollValueChanged()
	if #self.storeItemList > 0 then
		local storeItem = self.storeItemList[1]

		if storeItem then
			storeItem:refreshTagClip(self._scrollstore)
		end
	end
end

function VersionActivityFixedStoreView:_editableInitView()
	gohelper.setActive(self._gostoreItem, false)

	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	self.actId = VersionActivityFixedHelper.getVersionActivityDungeonStore(self._bigVersion, self._smallVersion)

	VersionActivityFixedHelper.setCustomDungeonStore()

	self.storeItemList = self:getUserDataTb_()
	self.rectTrContent = self._goContent:GetComponent(gohelper.Type_RectTransform)
end

function VersionActivityFixedStoreView:onOpen()
	VersionActivityFixedStoreListModel.instance:initStoreGoodsConfig()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	self:refreshTime()
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)
	self:refreshStoreContent()
	self:_onScrollValueChanged()
	self:scrollToFirstNoSellOutStore()
end

function VersionActivityFixedStoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	self._txttime.text = actInfoMo:getRemainTimeStr3(false, false)
end

function VersionActivityFixedStoreView:refreshStoreContent()
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

				storeItem = VersionActivityFixedHelper.getVersionActivityStoreItem(self._bigVersion, self._smallVersion).New()

				storeItem:setActId(self.actId)
				storeItem:onInitView(storeItemGo)
				table.insert(self.storeItemList, storeItem)
			end

			storeItem:updateInfo(i, self.actId[i])
		end

		if self._gospitem and self.storeItemList[1] then
			gohelper.addChild(self.storeItemList[1].go, self._gospitem)
			gohelper.setAsFirstSibling(self._gospitem)
		end
	end
end

function VersionActivityFixedStoreView:scrollToFirstNoSellOutStore()
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

function VersionActivityFixedStoreView:getFirstNoSellOutGroup()
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

function VersionActivityFixedStoreView:_onCurrencyChange()
	self.viewContainer:refreshCurrencyItem()
end

function VersionActivityFixedStoreView:_refreshView()
	self.viewContainer:refreshCurrencyItem()
end

function VersionActivityFixedStoreView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

function VersionActivityFixedStoreView:onDestroyView()
	for _, storeItem in ipairs(self.storeItemList) do
		storeItem:onDestroy()
	end
end

return VersionActivityFixedStoreView
