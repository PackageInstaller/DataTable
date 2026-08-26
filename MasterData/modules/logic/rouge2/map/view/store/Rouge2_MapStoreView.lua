-- chunkname: @modules/logic/rouge2/map/view/store/Rouge2_MapStoreView.lua

module("modules.logic.rouge2.map.view.store.Rouge2_MapStoreView", package.seeall)

local Rouge2_MapStoreView = class("Rouge2_MapStoreView", BaseView)

Rouge2_MapStoreView.NormalCostFormat = "<color=#D68A31>%s</color>"
Rouge2_MapStoreView.NotEnoughCostFormat = "<color=#EC6363>%s</color>"
Rouge2_MapStoreView.WaitRefreshAnim = "WaitRefreshAnim"
Rouge2_MapStoreView.DealySwitchTime = 0.17
Rouge2_MapStoreView.GoodsDescIncludeType = {
	Rouge2_Enum.RelicsDescType.Desc
}
Rouge2_MapStoreView.GoodsDescIncludeType2 = {
	Rouge2_Enum.RelicsDescType.NarrativeDesc
}

function Rouge2_MapStoreView:onInitView()
	self._goOther = gohelper.findChild(self.viewGO, "#go_Other")
	self._goStoreBg = gohelper.findChild(self.viewGO, "#go_Other/#go_StoreBg")
	self._goNormalBg = gohelper.findChild(self.viewGO, "#go_Other/#go_StoreBg/#go_NormalBg")
	self._goStealBg = gohelper.findChild(self.viewGO, "#go_Other/#go_StoreBg/#go_StealBg")
	self._goStealSuccBg = gohelper.findChild(self.viewGO, "#go_Other/#go_StoreBg/#go_StealSuccBg")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_Other/#go_topleft")
	self._scrollGoods = gohelper.findChildScrollRect(self.viewGO, "#go_Other/#scroll_Goods")
	self._goGoodsContent = gohelper.findChild(self.viewGO, "#go_Other/#scroll_Goods/Viewport/Content")
	self._goGoodsItem = gohelper.findChild(self.viewGO, "#go_Other/#scroll_Goods/Viewport/Content/#go_GoodsItem")
	self._goContainer = gohelper.findChild(self.viewGO, "#go_Other/#go_Container")
	self._scrollGoodsDesc = gohelper.findChildScrollRect(self.viewGO, "#go_Other/#go_Container/#scroll_GoodsDesc")
	self._txtGoodsDesc = gohelper.findChildText(self.viewGO, "#go_Other/#go_Container/#scroll_GoodsDesc/Viewport/Content/#txt_GoodsDesc")
	self._txtNarrativeDesc = gohelper.findChildText(self.viewGO, "#go_Other/#go_Container/#scroll_GoodsDesc/Viewport/Content/#txt_NarrativeDesc")
	self._goNormalBtns = gohelper.findChild(self.viewGO, "#go_Other/#go_Container/#go_NormalBtns")
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Other/#go_Container/#go_NormalBtns/#btn_Buy")
	self._btnEnterSteal = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Other/#go_Container/#go_NormalBtns/#btn_EnterSteal", AudioEnum.Rouge2.EnterStealType)
	self._btnRefresh = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Other/#go_Container/#go_NormalBtns/#btn_Refresh")
	self._txtRefresh = gohelper.findChildText(self.viewGO, "#go_Other/#go_Container/#go_NormalBtns/#btn_Refresh/#txt_Refresh")
	self._goStealBtns = gohelper.findChild(self.viewGO, "#go_Other/#go_Container/#go_StealBtns")
	self._btnSteal = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Other/#go_Container/#go_StealBtns/#btn_Steal", AudioEnum.Rouge2.StealGoods)
	self._goGoodsBtns = gohelper.findChild(self.viewGO, "#go_Other/#go_Container/#go_GoodsBtns")
	self._goHasBuy = gohelper.findChild(self.viewGO, "#go_Other/#go_Container/#go_GoodsBtns/#go_HasBuy")
	self._goStealSucc = gohelper.findChild(self.viewGO, "#go_Other/#go_Container/#go_GoodsBtns/#go_StealSucc")
	self._goStealFail = gohelper.findChild(self.viewGO, "#go_Other/#go_Container/#go_GoodsBtns/#go_StealFail")
	self._btnExitSteal = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Other/#go_Container/#go_StealBtns/#btn_ExitSteal")
	self._btnExitStore = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Other/#btn_ExitStore")
	self._goSelectGoods = gohelper.findChild(self.viewGO, "#go_Other/#go_Container/#go_SelectGoods")
	self._goSelectGoodsRare = gohelper.findChildImage(self.viewGO, "#go_Other/#go_Container/#go_SelectGoods/#image_SelectGoodsRare")
	self._goSelectGoodsIcon = gohelper.findChildSingleImage(self.viewGO, "#go_Other/#go_Container/#go_SelectGoods/#image_SelectGoodsIcon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapStoreView:addEvents()
	self._btnBuy:AddClickListener(self._btnBuyOnClick, self)
	self._btnEnterSteal:AddClickListener(self._btnEnterStealOnClick, self)
	self._btnRefresh:AddClickListener(self._btnRefreshOnClick, self)
	self._btnSteal:AddClickListener(self._btnStealOnClick, self)
	self._btnExitSteal:AddClickListener(self._btnExitStealOnClick, self)
	self._btnExitStore:AddClickListener(self._btnExitStoreOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onPopViewDone, self._onPopViewDone, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateMapInfo, self._onUpdateMapInfo, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChangeMapInfo, self._onChangeMapInfo, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onSelectStoreGoods, self._onSelectStoreGoods, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChangeStoreState, self._onChangeStoreState, self)
end

function Rouge2_MapStoreView:removeEvents()
	self._btnBuy:RemoveClickListener()
	self._btnEnterSteal:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
	self._btnSteal:RemoveClickListener()
	self._btnExitSteal:RemoveClickListener()
	self._btnExitStore:RemoveClickListener()
end

function Rouge2_MapStoreView:_btnRefreshOnClick()
	local canRefresh = Rouge2_MapStoreGoodsListModel.instance:checkCanRefresh()

	if not canRefresh then
		GameFacade.showToast(ToastEnum.RougeRefreshCoinNotEnough)

		return
	end

	local layerId, nodeId, eventId = Rouge2_MapStoreGoodsListModel.instance:getRpcParams()

	self._refreshCallbackId = Rouge2_Rpc.instance:sendRouge2ShopRefreshRequest(layerId, nodeId, eventId, self._onReceiveRefreshMsg, self)
end

function Rouge2_MapStoreView:_onReceiveRefreshMsg(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	self._animator:Play("refresh", 0, 0)
	Rouge2_MapStoreGoodsListModel.instance:refreshList()
	TaskDispatcher.runDelay(self.refresh, self, RougeMapEnum.WaitStoreRefreshAnimDuration)
	GameUtil.setActiveUIBlock(Rouge2_MapStoreView.WaitRefreshAnim, true, false)
end

function Rouge2_MapStoreView:_btnBuyOnClick()
	local rougeInfo = Rouge2_Model.instance:getRougeInfo()
	local selectGoodsMo = Rouge2_MapStoreGoodsListModel.instance:getSelectGoodsMo()
	local selectGoodsPrice = selectGoodsMo and selectGoodsMo.price

	if selectGoodsPrice > rougeInfo.coin then
		GameFacade.showToast(ToastEnum.RougeCoinNotEnough)

		return
	end

	local layerId, nodeId, eventId = Rouge2_MapStoreGoodsListModel.instance:getRpcParams()

	Rouge2_Rpc.instance:sendRouge2BuyGoodsRequest(layerId, nodeId, eventId, {
		self._selectIndex
	})
end

function Rouge2_MapStoreView:_btnEnterStealOnClick()
	Rouge2_MapStoreGoodsListModel.instance:changeState(Rouge2_MapEnum.StoreState.Steal)
end

function Rouge2_MapStoreView:_btnStealOnClick()
	local canSteal = self._selectGoodsState == Rouge2_MapEnum.GoodsState.CanBuy or self._selectGoodsState == Rouge2_MapEnum.GoodsState.CanSteal

	if not self._selectGoods or not canSteal then
		return
	end

	local layerId, nodeId, eventId = Rouge2_MapStoreGoodsListModel.instance:getRpcParams()

	Rouge2_Rpc.instance:sendRouge2StealGoodsRequest(layerId, nodeId, eventId, {
		self._selectIndex
	})
end

function Rouge2_MapStoreView:_btnExitStealOnClick()
	Rouge2_MapStoreGoodsListModel.instance:changeState(Rouge2_MapEnum.StoreState.Normal)
end

function Rouge2_MapStoreView:_btnExitStoreOnClick()
	self.viewContainer:overrideCloseCallback()
end

function Rouge2_MapStoreView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc)

	self._animator = gohelper.onceAddComponent(self._goOther, gohelper.Type_Animator)
	self._descAnimator = gohelper.onceAddComponent(self._scrollGoodsDesc.gameObject, gohelper.Type_Animator)
end

function Rouge2_MapStoreView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.StoreOpen)

	self._nodeMo = self.viewParam
	self._nodeId = self.viewParam.nodeId

	Rouge2_MapStoreGoodsListModel.instance:initList(self._nodeMo)
	self:refresh()
	self:setStealMode()
end

function Rouge2_MapStoreView:setStealMode()
	if not Rouge2_MapAttrCheckHelper.isAttrCheckInteract() then
		return
	end

	Rouge2_MapStoreGoodsListModel.instance:changeState(Rouge2_MapEnum.StoreState.Steal)
end

function Rouge2_MapStoreView:onUpdateParam()
	Rouge2_MapStoreGoodsListModel.instance:refreshList()
	self:refresh()

	if self._storeState == Rouge2_MapEnum.StoreState.StealSucc then
		AudioMgr.instance:trigger(AudioEnum.Rouge2.StealSucc)
	end
end

function Rouge2_MapStoreView:refresh()
	self:refreshInfo()
	self:refreshUI()
end

function Rouge2_MapStoreView:refreshInfo()
	self._selectIndex = Rouge2_MapStoreGoodsListModel.instance:getSelectGoodsIndex()
	self._selectGoods = Rouge2_MapStoreGoodsListModel.instance:getSelectGoodsMo()
	self._selectGoodsState = Rouge2_MapStoreGoodsListModel.instance:getGoodsState(self._selectIndex)
	self._storeState = Rouge2_MapStoreGoodsListModel.instance:getStoreState()
end

function Rouge2_MapStoreView:refreshUI()
	TaskDispatcher.cancelTask(self._delay2Refresh, self)
	GameUtil.setActiveUIBlock(Rouge2_MapStoreView.WaitRefreshAnim, false, true)

	local isStealFail = self._storeState == Rouge2_MapEnum.StoreState.StealFail

	gohelper.setActive(self._goOther, not isStealFail)

	if isStealFail then
		return
	end

	self:initGoodList()
	self:refreshGoodsDesc()
	self:refreshStateUI()
	self:refreshCount()
end

function Rouge2_MapStoreView:initGoodList()
	local goods = Rouge2_MapStoreGoodsListModel.instance:getList()

	gohelper.CreateObjList(self, self._refreshGoodsItem, goods, self._goGoodsContent, self._goGoodsItem, Rouge2_MapStoreGoodsItem)
end

function Rouge2_MapStoreView:_refreshGoodsItem(goodsItem, goodsMo, index)
	goodsItem:onUpdateMO(goodsMo, index)
end

function Rouge2_MapStoreView:refreshStateUI()
	gohelper.setActive(self._goNormalBg, self._storeState == Rouge2_MapEnum.StoreState.Normal)
	gohelper.setActive(self._goNormalBtns, self._storeState == Rouge2_MapEnum.StoreState.Normal)
	gohelper.setActive(self._goStealBg, self._storeState == Rouge2_MapEnum.StoreState.Steal)
	gohelper.setActive(self._goStealBtns, self._storeState == Rouge2_MapEnum.StoreState.Steal or self._storeState == Rouge2_MapEnum.StoreState.StealSucc or self._storeState == Rouge2_MapEnum.StoreState.FightSucc)
	gohelper.setActive(self._goStealSuccBg, self._storeState == Rouge2_MapEnum.StoreState.StealSucc or self._storeState == Rouge2_MapEnum.StoreState.FightSucc)

	local attrValue = Rouge2_Model.instance:getAttrValue(Rouge2_MapEnum.StealSwitch)
	local isStealFail = attrValue and attrValue > 0

	gohelper.setActive(self._btnEnterSteal.gameObject, not isStealFail)
	gohelper.setActive(self._btnSteal.gameObject, self._selectGoodsState == Rouge2_MapEnum.GoodsState.CanBuy)
	gohelper.setActive(self._goStealSucc, self._selectGoodsState == Rouge2_MapEnum.GoodsState.StealSucc)
	gohelper.setActive(self._goStealFail, self._selectGoodsState == Rouge2_MapEnum.GoodsState.StealFail)
	gohelper.setActive(self._btnBuy.gameObject, self._selectGoodsState == Rouge2_MapEnum.GoodsState.CanBuy)
	gohelper.setActive(self._goHasBuy, self._selectGoodsState == Rouge2_MapEnum.GoodsState.Sell)
end

function Rouge2_MapStoreView:refreshGoodsDesc()
	if not self._selectGoods then
		return
	end

	local itemId = self._selectGoods.collectionId

	Rouge2_ItemDescHelper.setItemDescStr(Rouge2_Enum.ItemDataType.Config, itemId, self._txtGoodsDesc, nil, Rouge2_MapStoreView.GoodsDescIncludeType)
	Rouge2_ItemDescHelper.setItemDescStr(Rouge2_Enum.ItemDataType.Config, itemId, self._txtNarrativeDesc, nil, Rouge2_MapStoreView.GoodsDescIncludeType2)
	Rouge2_IconHelper.setGameItemIcon(itemId, self._goSelectGoodsIcon)
end

function Rouge2_MapStoreView:refreshCount()
	local canRefresh = Rouge2_MapStoreGoodsListModel.instance:checkCanRefresh()
	local refreshNeedCoin = Rouge2_MapStoreGoodsListModel.instance:getRefreshNeedCoin()

	if canRefresh then
		if not RougeMapStoreView.NormalCostFormat then
			local format = RougeMapStoreView.NotEnoughCostFormat

			self._txtRefresh.text = string.format(format, refreshNeedCoin)
		end
	end
end

function Rouge2_MapStoreView:_onSelectStoreGoods()
	self._descAnimator:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(self._delay2Refresh, self)
	TaskDispatcher.runDelay(self._delay2Refresh, self, Rouge2_MapStoreView.DealySwitchTime)
end

function Rouge2_MapStoreView:_delay2Refresh()
	self:refreshInfo()
	self:refreshUI()
end

function Rouge2_MapStoreView:_onChangeStoreState()
	self:refreshInfo()
	self:refreshUI()
end

function Rouge2_MapStoreView:_onChangeMapInfo()
	self:closeThis()
end

function Rouge2_MapStoreView:_onUpdateMapInfo()
	local curNode = Rouge2_MapModel.instance:getCurNode()

	if curNode ~= self._nodeMo or self._nodeMo:isFinishEvent() then
		self:closeThis()

		return
	end

	if not self:_checkCanUpdateView() then
		self._waitUpdate = true

		return
	end

	Rouge2_MapChoiceEventHelper.triggerEventHandle(curNode)
end

function Rouge2_MapStoreView:_onCloseView(viewName)
	if self.viewName == viewName or not self._waitUpdate or not self:_checkCanUpdateView() then
		return
	end

	self._waitUpdate = false

	local curNode = Rouge2_MapModel.instance:getCurNode()

	Rouge2_MapChoiceEventHelper.triggerEventHandle(curNode)
end

function Rouge2_MapStoreView:_onPopViewDone()
	if not self._waitUpdate or not self:_checkCanUpdateView() then
		return
	end

	self._waitUpdate = false

	local curNode = Rouge2_MapModel.instance:getCurNode()

	Rouge2_MapChoiceEventHelper.triggerEventHandle(curNode)
end

function Rouge2_MapStoreView:_checkCanUpdateView()
	return ViewHelper.instance:checkViewOnTheTop(self.viewName, {
		ViewName.Rouge2_MapTipView
	}) and not Rouge2_PopController.instance:isPopping()
end

function Rouge2_MapStoreView:onClose()
	TaskDispatcher.cancelTask(self._delay2Refresh, self)
	GameUtil.setActiveUIBlock(Rouge2_MapStoreView.WaitRefreshAnim, false, true)
end

function Rouge2_MapStoreView:onDestroyView()
	self._goSelectGoodsIcon:UnLoadImage()
end

return Rouge2_MapStoreView
