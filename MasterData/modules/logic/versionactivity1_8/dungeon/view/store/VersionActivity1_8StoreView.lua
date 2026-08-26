-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/store/VersionActivity1_8StoreView.lua

module("modules.logic.versionactivity1_8.dungeon.view.store.VersionActivity1_8StoreView", package.seeall)

local VersionActivity1_8StoreView = class("VersionActivity1_8StoreView", BaseView)

function VersionActivity1_8StoreView:onInitView()
	self._scrollstore = gohelper.findChildScrollRect(self.viewGO, "#scroll_store")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content")
	self._gostoreItem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	self._txttime = gohelper.findChildText(self.viewGO, "title/timebg/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8StoreView:addEvents()
	self._scrollstore:AddOnValueChanged(self._onScrollValueChanged, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
end

function VersionActivity1_8StoreView:removeEvents()
	self._scrollstore:RemoveOnValueChanged()
	self.removeEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
end

function VersionActivity1_8StoreView:_onScrollValueChanged()
	if #self.storeItemList > 0 then
		local storeItem = self.storeItemList[1]

		if storeItem then
			storeItem:refreshTagClip(self._scrollstore)
		end
	end
end

function VersionActivity1_8StoreView:_editableInitView()
	gohelper.setActive(self._gostoreItem, false)

	self.actId = VersionActivity1_8Enum.ActivityId.DungeonStore
	self.storeItemList = self:getUserDataTb_()
	self.rectTrContent = self._goContent:GetComponent(gohelper.Type_RectTransform)
end

function VersionActivity1_8StoreView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	self:refreshTime()
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)
	self:refreshStoreContent()
	self:_onScrollValueChanged()
	self:scrollToFirstNoSellOutStore()
end

function VersionActivity1_8StoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_8Enum.ActivityId.DungeonStore]

	self._txttime.text = actInfoMo:getRemainTimeStr3(false, true)
end

function VersionActivity1_8StoreView:refreshStoreContent()
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

				storeItem = VersionActivity1_8StoreItem.New()

				storeItem:onInitView(storeItemGo)
				table.insert(self.storeItemList, storeItem)
			end

			storeItem:updateInfo(i, self.actId[i])
		end
	end
end

function VersionActivity1_8StoreView:scrollToFirstNoSellOutStore()
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

function VersionActivity1_8StoreView:getFirstNoSellOutGroup()
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

function VersionActivity1_8StoreView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

function VersionActivity1_8StoreView:onDestroyView()
	for _, storeItem in ipairs(self.storeItemList) do
		storeItem:onDestroy()
	end
end

return VersionActivity1_8StoreView
