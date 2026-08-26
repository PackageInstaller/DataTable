-- chunkname: @modules/logic/rouge/map/view/store/RougeMapStoreView.lua

module("modules.logic.rouge.map.view.store.RougeMapStoreView", package.seeall)

local RougeMapStoreView = class("RougeMapStoreView", BaseView)

function RougeMapStoreView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._scrollstore = gohelper.findChildScrollRect(self.viewGO, "#scroll_store")
	self._gostoregoodsitem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/Content/#go_storegoodsitem")
	self._btnexit = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_exit")
	self._btnrefresh = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_refresh")
	self._txtrefresh = gohelper.findChildText(self.viewGO, "#btn_refresh/#txt_refresh")
	self._txtcost = gohelper.findChildText(self.viewGO, "#btn_refresh/#txt_refresh/image_coin/#txt_cost")
	self._gorougefunctionitem2 = gohelper.findChild(self.viewGO, "#go_rougefunctionitem2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapStoreView:addEvents()
	self._btnexit:AddClickListener(self._btnexitOnClick, self)
	self._btnrefresh:AddClickListener(self._btnrefreshOnClick, self)
end

function RougeMapStoreView:removeEvents()
	self._btnexit:RemoveClickListener()
	self._btnrefresh:RemoveClickListener()
end

function RougeMapStoreView:_btnexitOnClick()
	self.leaveCallbackId = RougeRpc.instance:sendRougeEndShopEventRequest(self.eventMo.eventId, self.closeThis, self)
end

function RougeMapStoreView:_btnrefreshOnClick()
	if not self:checkCanRefresh() then
		GameFacade.showToast(ToastEnum.RougeRefreshCoinNotEnough)

		return
	end

	self.refreshCallbackId = RougeRpc.instance:sendRougeShopRefreshRequest(self.eventMo.eventId, self.onReceiveMsg, self)
end

RougeMapStoreView.WaitRefreshAnim = "WaitRefreshAnim"

function RougeMapStoreView:onReceiveMsg(msg, code)
	self.animator:Play("refresh", 0, 0)
	TaskDispatcher.runDelay(self.refreshUI, self, RougeMapEnum.WaitStoreRefreshAnimDuration)
	UIBlockMgr.instance:startBlock(RougeMapStoreView.WaitRefreshAnim)
end

function RougeMapStoreView:_editableInitView()
	self._simagebg:LoadImage("singlebg/rouge/rouge_reward_fullbg.png")
	gohelper.setActive(self._gostoregoodsitem, false)

	self.goodsItemList = {}

	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeInfoCoin, self.onCoinChange, self)

	self.goCollection = self.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, self._gorougefunctionitem2)
	self.collectionComp = RougeCollectionComp.Get(self.goCollection)
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)

	NavigateMgr.instance:addEscape(self.viewName, RougeMapHelper.blockEsc)

	self._txtrefresh.text = luaLang("refresh")
end

function RougeMapStoreView:onCoinChange()
	self:refreshRefreshCount()
end

function RougeMapStoreView:onUpdateParam()
	return
end

function RougeMapStoreView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.StoreOpen)

	self.eventMo = self.viewParam

	self:refreshUI()
	self.collectionComp:onOpen()
end

function RougeMapStoreView:refreshUI()
	UIBlockMgr.instance:endBlock(RougeMapStoreView.WaitRefreshAnim)
	self:refreshGoods()
	self:refreshRefreshCount()
end

function RougeMapStoreView:refreshGoods()
	local goodsList = self.eventMo.posGoodsList

	for index, goodsMo in pairs(goodsList) do
		local goodsItem = self.goodsItemList[index]

		if not goodsItem then
			local go = gohelper.cloneInPlace(self._gostoregoodsitem)

			goodsItem = RougeMapStoreGoodsItem.New()

			goodsItem:init(go)
			table.insert(self.goodsItemList, goodsItem)
		end

		goodsItem:update(self.eventMo, tonumber(index), goodsMo)
	end

	for i = #goodsList + 1, #self.goodsItemList do
		self.goodsItemList[i]:hide()
	end
end

RougeMapStoreView.NormalCostFormat = "<color=#D68A31>%s</color>"
RougeMapStoreView.NotEnoughCostFormat = "<color=#EC6363>%s</color>"

function RougeMapStoreView:refreshRefreshCount()
	self.cost = self.eventMo.refreshNeedCoin or 0

	if self:checkCanRefresh() then
		if not RougeMapStoreView.NormalCostFormat then
			local format = RougeMapStoreView.NotEnoughCostFormat

			self._txtcost.text = string.format(format, self.cost)
		end
	end
end

function RougeMapStoreView:checkCanRefresh()
	local rougeInfo = RougeModel.instance:getRougeInfo()

	return rougeInfo and rougeInfo.coin >= self.cost
end

function RougeMapStoreView:onClose()
	if self.leaveCallbackId then
		RougeRpc.instance:removeCallbackById(self.leaveCallbackId)
	end

	if self.refreshCallbackId then
		RougeRpc.instance:removeCallbackById(self.refreshCallbackId)
	end

	self.collectionComp:onClose()
end

function RougeMapStoreView:onDestroyView()
	for _, goodsItem in ipairs(self.goodsItemList) do
		goodsItem:destroy()
	end

	self.goodsItemList = nil

	self._simagebg:UnLoadImage()
	self.collectionComp:destroy()
end

return RougeMapStoreView
