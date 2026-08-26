-- chunkname: @modules/logic/rouge/map/view/store/RougeStoreGoodsView.lua

module("modules.logic.rouge.map.view.store.RougeStoreGoodsView", package.seeall)

local RougeStoreGoodsView = class("RougeStoreGoodsView", BaseView)

function RougeStoreGoodsView:onInitView()
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "Left/#image_icon")
	self._txtcollectionname = gohelper.findChildText(self.viewGO, "Left/#txt_collectionname")
	self._scrollcollectiondesc = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_collectiondesc")
	self._godescContent = gohelper.findChild(self.viewGO, "Left/#scroll_collectiondesc/Viewport/#go_descContent")
	self._goGrid = gohelper.findChild(self.viewGO, "Left/#go_grid")
	self._goGridItem = gohelper.findChild(self.viewGO, "Left/#go_grid/#go_griditem")
	self._gotagitem = gohelper.findChild(self.viewGO, "Left/tags/#go_tagitem")
	self._goshapecell = gohelper.findChild(self.viewGO, "Left/shape/#go_shapecell")
	self._goholetool = gohelper.findChild(self.viewGO, "Left/#go_holetool")
	self._goholeitem = gohelper.findChild(self.viewGO, "Left/#go_holetool/#go_holeitem")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._txtcost = gohelper.findChildText(self.viewGO, "#btn_confirm/ani/#txt_cost")
	self._gotips = gohelper.findChild(self.viewGO, "Left/#go_tips")
	self._gotagnameitem = gohelper.findChild(self.viewGO, "Left/#go_tips/#go_tagnameitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeStoreGoodsView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function RougeStoreGoodsView:removeEvents()
	self._btnconfirm:RemoveClickListener()
end

function RougeStoreGoodsView:_btnconfirmOnClick()
	if self.sellOut then
		GameFacade.showToast(ToastEnum.RougeStoreSellOut)

		return
	end

	local rougeInfo = RougeModel.instance:getRougeInfo()

	if rougeInfo.coin < self.price then
		GameFacade.showToast(ToastEnum.RougeCoinNotEnough)

		return
	end

	self.callbackId = RougeRpc.instance:sendRougeBuyGoodsRequest(self.eventId, self.pos, self.onReceiveMsg, self)
end

function RougeStoreGoodsView:onReceiveMsg()
	self.callbackId = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onBuyGoods, self.pos)
	self:closeThis()
end

function RougeStoreGoodsView:_editableInitView()
	gohelper.setActive(self._goholeitem, false)

	self.bgClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "mask")

	self.bgClick:AddClickListener(self.closeThis, self)

	self.gridList = self:getUserDataTb_()
	self.tagGoList = self:getUserDataTb_()
	self.goHoleList = self:getUserDataTb_()
	self._itemInstTab = self:getUserDataTb_()
	self.rectDesc = self._scrollcollectiondesc:GetComponent(gohelper.Type_RectTransform)
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)

	self.addEventCb(self, RougeController.instance, RougeEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
end

function RougeStoreGoodsView:initData()
	self.collectionId = self.viewParam.collectionId
	self.price = self.viewParam.price
	self.collectionCo = RougeCollectionConfig.instance:getCollectionCfg(self.collectionId)
	self.pos = self.viewParam.pos
	self.eventMo = self.viewParam.eventMo
	self.eventId = self.eventMo.eventId
	self.sellOut = self.eventMo:checkIsSellOut(self.pos)
end

function RougeStoreGoodsView:onUpdateParam()
	self:initData()
	self:refreshUI()
	self.animator:Play("open", 0, 0)
end

function RougeStoreGoodsView:onOpen()
	self.animator:Play("open", 0, 0)
	self:initData()
	self:refreshUI()
end

function RougeStoreGoodsView:refreshUI()
	self:refreshCollection()
	self:refreshCost()
end

function RougeStoreGoodsView:refreshCollection()
	local collectionId = self.collectionId

	self._simageicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(collectionId))

	self._txtcollectionname.text = RougeCollectionConfig.instance:getCollectionName(collectionId)

	RougeCollectionHelper.loadShapeGrid(collectionId, self._goGrid, self._goGridItem, self.gridList, false)
	self:refreshDesc()
	self:refreshHole()
	self:refreshTag()
end

function RougeStoreGoodsView:refreshDesc()
	RougeCollectionDescHelper.setCollectionDescInfos2(self.collectionId, nil, self._godescContent, self._itemInstTab)
end

function RougeStoreGoodsView:refreshHole()
	local holeNum = self.collectionCo.holeNum

	gohelper.setActive(self._goholetool, holeNum > 0)

	if holeNum > 0 then
		recthelper.setHeight(self.rectDesc, RougeMapEnum.StoreGoodsDescHeight.WithHole)
		RougeMapHelper.loadGoItem(self._goholeitem, holeNum, self.goHoleList)
	else
		recthelper.setHeight(self.rectDesc, RougeMapEnum.StoreGoodsDescHeight.NoHole)
	end
end

function RougeStoreGoodsView:refreshTag()
	RougeCollectionHelper.loadTags(self.collectionId, self._gotagitem, self.tagGoList)
	RougeCollectionHelper.loadCollectionAndEnchantTagNames(self.collectionId, nil, self._gotips, self._gotagnameitem, RougeCollectionHelper._loadCollectionTagNameCallBack)
end

function RougeStoreGoodsView:refreshCost()
	local curCoin = RougeModel.instance:getRougeInfo().coin
	local coin

	self._txtcost.text = curCoin < self.price and string.format("<color=#EC6363>%s</color>", self.price) or self.price
end

function RougeStoreGoodsView:_onSwitchCollectionInfoType()
	self:refreshDesc()
end

function RougeStoreGoodsView:onClose()
	if self.callbackId then
		RougeRpc.instance:removeCallbackById(self.callbackId)
	end
end

function RougeStoreGoodsView:onDestroyView()
	self._simageicon:UnLoadImage()
	self.bgClick:RemoveClickListener()
end

return RougeStoreGoodsView
