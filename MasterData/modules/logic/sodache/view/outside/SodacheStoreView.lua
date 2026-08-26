-- chunkname: @modules/logic/sodache/view/outside/SodacheStoreView.lua

module("modules.logic.sodache.view.outside.SodacheStoreView", package.seeall)

local SodacheStoreView = class("SodacheStoreView", BaseView)

function SodacheStoreView:onInitView()
	self._txtLeftTime = gohelper.findChildText(self.viewGO, "Right/image_LimitTimeBG/#txt_LeftTime")
	self._simageReward = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Reward")
	self._btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#simage_Reward/#btn_Reward")
	self._txtRewardName = gohelper.findChildText(self.viewGO, "Right/image_RewardNameBG/#txt_RewardName")
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Buy")
	self._txtRewardPrice = gohelper.findChildText(self.viewGO, "Right/#btn_Buy/layout/#txt_RewardPrice")
	self._txtLimitBuy = gohelper.findChildText(self.viewGO, "Right/#txt_LimitBuy")
	self._goSoldOut = gohelper.findChild(self.viewGO, "Right/#go_SoldOut")
	self._scrollstore = gohelper.findChildScrollRect(self.viewGO, "#scroll_store")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content")
	self._gostoreItem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	self._gostoregoodsitem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheStoreView:addEvents()
	self._btnReward:AddClickListener(self._btnRewardOnClick, self)
	self._btnBuy:AddClickListener(self._btnBuyOnClick, self)
end

function SodacheStoreView:removeEvents()
	self._btnReward:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function SodacheStoreView:_btnRewardOnClick()
	self:_btnBuyOnClick()
end

function SodacheStoreView:_btnBuyOnClick()
	if self.remainBuyCount == 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	if self.productItemType == MaterialEnum.MaterialType.HeroSkin then
		ViewMgr.instance:openView(ViewName.StoreSkinGoodsView, {
			isActivityStore = true,
			goodsMO = self.bigRewardCo
		})
	else
		ViewMgr.instance:openView(ViewName.VersionActivityNormalStoreGoodsView, self.bigRewardCo)
	end
end

function SodacheStoreView:_editableInitView()
	self.actId = VersionActivity3_7Enum.ActivityId.SodacheStore
	self.storeItemList = self:getUserDataTb_()
	self.rectTrContent = self._goContent:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(self._gostoreItem, false)
end

function SodacheStoreView:onOpen()
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.refreshBigReward, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
	self:refreshLeftTime()
	TaskDispatcher.runRepeat(self.refreshLeftTime, self, TimeUtil.OneMinuteSecond)
	self:refreshStoreContent()
	self:scrollToFirstNoSellOutStore()
	self:refreshBigReward()
end

function SodacheStoreView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshLeftTime, self)

	for _, storeItem in ipairs(self.storeItemList) do
		storeItem:onDestroy()
	end
end

function SodacheStoreView:refreshLeftTime()
	self._txtLeftTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function SodacheStoreView:refreshStoreContent()
	if self.actId then
		local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(self.actId)

		if not storeGroupDict then
			return
		end

		local storeItem

		for i = 1, #storeGroupDict do
			local goodsCoList = storeGroupDict[i]

			storeItem = self.storeItemList[i]

			if not self.storeItemList[i] then
				local storeItemGo = gohelper.cloneInPlace(self._gostoreItem)

				storeItem = SodacheStoreItem.New()

				storeItem:onInitView(storeItemGo)

				self.storeItemList[i] = storeItem
			end

			storeItem:updateInfo(i, goodsCoList)
			self:checkBigReward(goodsCoList)
		end
	end
end

function SodacheStoreView:scrollToFirstNoSellOutStore()
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

function SodacheStoreView:getFirstNoSellOutGroup()
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

function SodacheStoreView:checkBigReward(goodsCoList)
	for _, config in ipairs(goodsCoList) do
		if config.specProduct == 1 then
			self.bigRewardCo = config

			local params = string.splitToNumber(self.bigRewardCo.product, "#")

			self.itemCo = ItemModel.instance:getItemConfig(params[1], params[2])

			break
		end
	end
end

function SodacheStoreView:refreshBigReward()
	if self.bigRewardCo then
		self.productItemType = string.splitToNumber(self.bigRewardCo.product, "#")[1]
		self._txtRewardName.text = self.itemCo and self.itemCo.name
		self._txtRewardPrice.text = string.splitToNumber(self.bigRewardCo.cost, "#")[3]

		local buyCount = ActivityStoreModel.instance:getActivityGoodsBuyCount(self.actId, self.bigRewardCo.id)

		self.remainBuyCount = self.bigRewardCo.maxBuyCount - buyCount

		gohelper.setActive(self._btnBuy, self.remainBuyCount ~= 0)
		gohelper.setActive(self._goSoldOut, self.remainBuyCount == 0)

		self._txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", self.remainBuyCount)
	end
end

return SodacheStoreView
