-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174GameShopView.lua

module("modules.logic.versionactivity2_3.act174.view.Act174GameShopView", package.seeall)

local Act174GameShopView = class("Act174GameShopView", BaseView)

function Act174GameShopView:onInitView()
	self._txtShopLevel = gohelper.findChildText(self.viewGO, "#go_Shop/ShopLevel/txt_ShopLevel")
	self._btnFreshShop = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Shop/btn_FreshShop")
	self._txtFreshCost = gohelper.findChildText(self.viewGO, "#go_Shop/btn_FreshShop/txt_FreshCost")
	self._btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Shop/ShopLevel/btn_detail")
	self._goDetail = gohelper.findChild(self.viewGO, "#go_Shop/ShopLevel/go_detail")
	self._btnCloseTip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Shop/ShopLevel/go_detail/btn_closetip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174GameShopView:addEvents()
	self.addClickCb(self, self._btnFreshShop, self._btnFreshShopOnClick, self)
	self.addClickCb(self, self._btnDetail, self._btnDetailOnClick, self)
	self.addClickCb(self, self._btnCloseTip, self._btnCloseTipOnClick, self)
end

function Act174GameShopView:_btnFreshShopOnClick()
	if self.gameInfo.coin < self.shopInfo.freshCost then
		GameFacade.showToast(ToastEnum.Act174CoinNotEnough)

		return
	end

	for _, shopItem in ipairs(self.shopItemList) do
		shopItem.anim:Play("flushed", 0, 0)
	end

	TaskDispatcher.runDelay(self.delayFresh, self, 0.16)
end

function Act174GameShopView:_btnDetailOnClick()
	gohelper.setActive(self._goDetail, true)
end

function Act174GameShopView:_btnCloseTipOnClick()
	gohelper.setActive(self._goDetail, false)
end

function Act174GameShopView:delayFresh()
	Activity174Rpc.instance:sendFresh174ShopRequest(self.actId)
end

function Act174GameShopView:_editableInitView()
	self.animBtnFresh = self._btnFreshShop.gameObject:GetComponent(gohelper.Type_Animator)

	self:initShopItem()
end

function Act174GameShopView:onUpdateParam()
	return
end

function Act174GameShopView:onOpen()
	self.actId = Activity174Model.instance:getCurActId()

	self:refreshShop()
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.FreshShopReply, self.refreshShop, self)
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.BuyInShopReply, self.refreshShop, self)
end

function Act174GameShopView:onClose()
	return
end

function Act174GameShopView:onDestroyView()
	TaskDispatcher.cancelTask(self.delayFresh, self)
end

function Act174GameShopView:initShopItem()
	self.shopItemList = {}

	for i = 1, 8 do
		local go = gohelper.findChild(self.viewGO, "#go_Shop/bagRoot/bag" .. i)

		self.shopItemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act174GameShopItem)
	end
end

function Act174GameShopView:refreshShop()
	self.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	self.shopInfo = self.gameInfo:getShopInfo()
	self.goodInfos = self.shopInfo.goodInfo

	local shopConfig = Activity174Config.instance:getShopCo(self.actId, self.shopInfo.level)

	if shopConfig then
		self._txtShopLevel.text = shopConfig.name or ""
	end

	local cost = self.shopInfo.freshCost

	self._txtFreshCost.text = cost

	local animName = cost == 0 and "first" or "idle"

	self.animBtnFresh:Play(animName)

	for i = 1, 8 do
		local goodInfo = self.goodInfos[i]

		self.shopItemList[i]:setData(goodInfo)
	end
end

return Act174GameShopView
