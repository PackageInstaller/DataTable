-- chunkname: @modules/logic/store/view/decoratemultigoods/DecorateMultiGoodsTipsViewBanner.lua

module("modules.logic.store.view.decoratemultigoods.DecorateMultiGoodsTipsViewBanner", package.seeall)

local DecorateMultiGoodsTipsViewBanner = class("DecorateMultiGoodsTipsViewBanner", BaseView)

DecorateMultiGoodsTipsViewBanner.SwitchBannerInterval = 5
DecorateMultiGoodsTipsViewBanner.SwitchBannerDuration = 0.5

function DecorateMultiGoodsTipsViewBanner:onInitView()
	self._goTabContent = gohelper.findChild(self.viewGO, "left/top/#scroll_Tab/Viewport/Content")
	self._goTabItem = gohelper.findChild(self.viewGO, "left/top/#scroll_Tab/Viewport/Content/#go_TabItem")
	self._goBannerContent = gohelper.findChild(self.viewGO, "left/banner/#go_BannerContent")
	self._goBannerItem = gohelper.findChild(self.viewGO, "left/banner/#go_BannerContent/#go_BannerItem")
	self._btnLeftArrow = gohelper.findChildButtonWithAudio(self.viewGO, "left/banner/#btn_LeftArrow")
	self._btnRightArrow = gohelper.findChildButtonWithAudio(self.viewGO, "left/banner/#btn_RightArrow")
	self._goBannerScroll = gohelper.findChild(self.viewGO, "left/banner/#go_BannerScroll")
	self._goBannerPoint = gohelper.findChild(self.viewGO, "left/banner/#go_BannerPoint")
	self._goPoint = gohelper.findChild(self.viewGO, "left/banner/#go_BannerPoint/#go_Point")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DecorateMultiGoodsTipsViewBanner:addEvents()
	self._btnLeftArrow:AddClickListener(self._btnLeftArrowOnClick, self)
	self._btnRightArrow:AddClickListener(self._btnRightArrowOnClick, self)
	self._bannerScroll:AddDragBeginListener(self._onScrollDragBegin, self)
	self._bannerScroll:AddDragEndListener(self._onScrollDragEnd, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.OnSelectDecorateMultiGoods, self._onSelectGoodsItem, self)
end

function DecorateMultiGoodsTipsViewBanner:removeEvents()
	self._bannerScroll:RemoveDragBeginListener()
	self._bannerScroll:RemoveDragEndListener()
	self._btnLeftArrow:RemoveClickListener()
	self._btnRightArrow:RemoveClickListener()
end

function DecorateMultiGoodsTipsViewBanner:_onScrollDragBegin(param, eventData)
	self._scrollStartPosX = GamepadController.instance:getMousePosition().x
end

function DecorateMultiGoodsTipsViewBanner:_onScrollDragEnd(param, eventData)
	local scrollEndPos = GamepadController.instance:getMousePosition()
	local deltaX = scrollEndPos.x - self._scrollStartPosX

	if deltaX > self._halfBannerItemWidth then
		self:_manualSwitchBanner(false)
	elseif deltaX < -self._halfBannerItemWidth then
		self:_manualSwitchBanner(true)
	end
end

function DecorateMultiGoodsTipsViewBanner:_btnLeftArrowOnClick()
	self:_manualSwitchBanner(false)
end

function DecorateMultiGoodsTipsViewBanner:_btnRightArrowOnClick()
	self:_manualSwitchBanner(true)
end

function DecorateMultiGoodsTipsViewBanner:_editableInitView()
	self._bannerScroll = SLFramework.UGUI.UIDragListener.Get(self._goBannerScroll)
	self._bannerItemWidth = recthelper.getWidth(self._goBannerItem.transform)
	self._halfBannerItemWidth = self._bannerItemWidth / 2
	self._bannerItemList = self:getUserDataTb_()
	self._selectTabIndex = 1
	self._selectBannerIndex = 1
	self._goRightArrow = self._btnRightArrow.gameObject
	self._goLeftArrow = self._btnLeftArrow.gameObject
end

function DecorateMultiGoodsTipsViewBanner:onOpen()
	self._originGoodsId = self.viewParam and self.viewParam.goodsId

	self:refresh(self._originGoodsId)
end

function DecorateMultiGoodsTipsViewBanner:refresh(goodsId)
	self._goodsId = goodsId
	self._tabGoodsIdList = self:_initShowGoodsTabList() or {}
	self._selectTabIndex = tabletool.indexOf(self._tabGoodsIdList, self._goodsId) or 1
	self._selectBannerIndex = 1

	self:refreshUI()
end

function DecorateMultiGoodsTipsViewBanner:_initShowGoodsTabList()
	local fatherGoodsId = DecorateStoreConfig.instance:getFatherGoodsId(self._originGoodsId)

	if fatherGoodsId and fatherGoodsId ~= 0 and fatherGoodsId ~= self._originGoodsId then
		local isCanBuy = DecorateStoreModel.instance:isCanBuyGoods(fatherGoodsId)

		if isCanBuy then
			return {
				self._originGoodsId,
				fatherGoodsId
			}
		end
	end
end

function DecorateMultiGoodsTipsViewBanner:refreshUI()
	self:refreshGoodsTabList()
	self:refreshBannerList()
	self:tickSwitchBanner()
end

function DecorateMultiGoodsTipsViewBanner:refreshGoodsTabList()
	gohelper.CreateObjList(self, self._refreshGoodsTabItem, self._tabGoodsIdList or {}, self._goTabContent, self._goTabItem, DecorateMultiGoodsTipsTabItem)
end

function DecorateMultiGoodsTipsViewBanner:_refreshGoodsTabItem(tabItem, goodsId, index)
	tabItem:onUpdateMO(goodsId, index, self._selectTabIndex == index)
end

function DecorateMultiGoodsTipsViewBanner:refreshBannerList()
	local allGoodsIdList = self:getShowBannerGoodsIdList()

	self:_initBannerItemGo(allGoodsIdList, self._selectBannerIndex)

	if allGoodsIdList then
		if not #allGoodsIdList then
			local allGoodsNum = 0

			gohelper.setActive(self._goBannerPoint, allGoodsNum > 1)

			if allGoodsNum > 1 then
				gohelper.CreateObjList(self, self._refreshBannerPointItem, allGoodsIdList, self._goBannerPoint, self._goPoint)
			end
		end
	end
end

function DecorateMultiGoodsTipsViewBanner:getShowBannerGoodsIdList()
	if not DecorateStoreConfig.instance:getSonGoodsIdList(self._goodsId) then
		return {
			self._goodsId
		}
	end

	local subGoodsIdList = DecorateStoreConfig.instance:getSonGoodsIdList(self._goodsId)
	local allGoodsIdList = {}

	tabletool.addValues(allGoodsIdList, subGoodsIdList)
	table.insert(allGoodsIdList, 1, self._goodsId)

	return allGoodsIdList
end

function DecorateMultiGoodsTipsViewBanner:_refreshBannerPointItem(goPoint, goodsId, index)
	local goSelect = gohelper.findChild(goPoint, "#go_light")
	local goUnselect = gohelper.findChild(goPoint, "#go_gray")

	gohelper.setActive(goSelect, index == self._selectBannerIndex)
	gohelper.setActive(goUnselect, index ~= self._selectBannerIndex)
end

function DecorateMultiGoodsTipsViewBanner:_initBannerItemGo(allGoodsIdList, selectIndex)
	if allGoodsIdList then
		self._allGoodsNum = #allGoodsIdList or 0
	end

	if self._allGoodsNum <= 0 then
		return
	end

	local showBannerNum = 3

	for i = 1, showBannerNum do
		local bannerItem = self:_getOrCreateGoodsBannerItem(i)
		local showIndex = self:_getRecycleIndex(selectIndex - 2 + i)
		local showGoodsId = allGoodsIdList[showIndex]

		bannerItem:onUpdateMO(showGoodsId, showIndex, i)
	end

	for i = showBannerNum + 1, #self._bannerItemList do
		local bannerItem = self._bannerItemList[i]

		if bannerItem then
			bannerItem:setVisible(false)
		end
	end

	gohelper.setActive(self._goBannerItem, false)
	gohelper.setActive(self._goRightArrow, self._allGoodsNum > 1)
	gohelper.setActive(self._goLeftArrow, self._allGoodsNum > 1)

	self._selectBannerIndex = selectIndex
end

function DecorateMultiGoodsTipsViewBanner:_getRecycleIndex(index)
	if index > self._allGoodsNum then
		index = index - self._allGoodsNum
	elseif index <= 0 then
		index = self._allGoodsNum - index
	end

	return index
end

function DecorateMultiGoodsTipsViewBanner:_getOrCreateGoodsBannerItem(index)
	local bannerItem = self._bannerItemList[index]

	if not bannerItem then
		local goBanner = gohelper.cloneInPlace(self._goBannerItem, "banner_" .. index)

		bannerItem = DecorateMultiGoodsTipsBannerItem.Get(goBanner)
		self._bannerItemList[index] = bannerItem
	end

	return bannerItem
end

function DecorateMultiGoodsTipsViewBanner:_switchBanner(isNext)
	self:stopAutoSwitchBanner()

	self._bannerTweenDoneNum = 0
	self._waitTweenDoneNum = 0
	self._isSwitchNext = isNext

	for _, bannerItem in pairs(self._bannerItemList) do
		if bannerItem:isVisible() then
			self._waitTweenDoneNum = self._waitTweenDoneNum + 1

			bannerItem:tween(isNext, self._onBannerItemTweenDone, self)
		end
	end
end

function DecorateMultiGoodsTipsViewBanner:_onBannerItemTweenDone()
	self._bannerTweenDoneNum = self._bannerTweenDoneNum + 1

	if self._bannerTweenDoneNum >= self._waitTweenDoneNum then
		self:_onTweenBannerDone()
	end
end

function DecorateMultiGoodsTipsViewBanner:_onTweenBannerDone()
	local changeBannerItem
	local selectIndex = self._selectBannerIndex

	if self._isSwitchNext then
		selectIndex = selectIndex + 1
		changeBannerItem = table.remove(self._bannerItemList, 3)

		table.insert(self._bannerItemList, 1, changeBannerItem)
	else
		selectIndex = selectIndex - 1
		changeBannerItem = table.remove(self._bannerItemList, 1)

		table.insert(self._bannerItemList, 3, changeBannerItem)
	end

	self._selectBannerIndex = self:_getRecycleIndex(selectIndex)

	self:tickSwitchBanner()
	self:refreshBannerList()
end

function DecorateMultiGoodsTipsViewBanner:tickSwitchBanner()
	self:stopAutoSwitchBanner()

	if self._allGoodsNum <= 1 then
		return
	end

	TaskDispatcher.runRepeat(self._autoSwitchNextBanner, self, DecorateMultiGoodsTipsViewBanner.SwitchBannerInterval)
end

function DecorateMultiGoodsTipsViewBanner:stopAutoSwitchBanner()
	TaskDispatcher.cancelTask(self._autoSwitchNextBanner, self)
end

function DecorateMultiGoodsTipsViewBanner:_autoSwitchNextBanner()
	self:_switchBanner(true)
end

function DecorateMultiGoodsTipsViewBanner:_manualSwitchBanner(isNext)
	self:_switchBanner(isNext)
end

function DecorateMultiGoodsTipsViewBanner:_onSelectGoodsItem(goodsId)
	self:refresh(goodsId)
end

function DecorateMultiGoodsTipsViewBanner:onDestroyView()
	self:stopAutoSwitchBanner()
end

return DecorateMultiGoodsTipsViewBanner
