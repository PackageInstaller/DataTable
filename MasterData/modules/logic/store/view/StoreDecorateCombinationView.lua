-- chunkname: @modules/logic/store/view/StoreDecorateCombinationView.lua

module("modules.logic.store.view.StoreDecorateCombinationView", package.seeall)

local StoreDecorateCombinationView = class("StoreDecorateCombinationView", BaseView)

function StoreDecorateCombinationView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg2")
	self._gobannerContent = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent")
	self._goroominfoItem = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem")
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/#simage_pic")
	self._goSceneLogo = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	self._gotag = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/#go_tag")
	self._gotag2 = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/#go_tag2")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/txt_desc/txt_name/#btn_Info")
	self._gobannerscroll = gohelper.findChild(self.viewGO, "left/banner/#go_bannerscroll")
	self._gogray = gohelper.findChild(self.viewGO, "left/banner/#go_paperpoint/#go_point/#go_gray")
	self._golight = gohelper.findChild(self.viewGO, "left/banner/#go_paperpoint/#go_point/#go_light")
	self._txtgoodsNameCn = gohelper.findChildText(self.viewGO, "right/title/#txt_goodsNameCn")
	self._goleftbg = gohelper.findChild(self.viewGO, "right/info/remain/#go_leftbg")
	self._txtremain = gohelper.findChildText(self.viewGO, "right/info/remain/#go_leftbg/#txt_remain")
	self._gorightbg = gohelper.findChild(self.viewGO, "right/info/remain/#go_rightbg")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "right/info/remain/#go_rightbg/#txt_remaintime")
	self._scrollproduct = gohelper.findChildScrollRect(self.viewGO, "right/info/scroll/#scroll_product")
	self._goicon = gohelper.findChild(self.viewGO, "right/info/scroll/#scroll_product/Viewport/Content/#go_icon")
	self._gotips = gohelper.findChild(self.viewGO, "right/#go_tips")
	self._txtlocktips = gohelper.findChildText(self.viewGO, "right/#go_tips/#txt_locktips")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_buy")
	self._txtmaterialNum = gohelper.findChildText(self.viewGO, "right/#btn_buy/cost/#txt_materialNum")
	self._txtprice = gohelper.findChildText(self.viewGO, "right/#btn_buy/cost/#txt_price")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreDecorateCombinationView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self._payFinished, self)
end

function StoreDecorateCombinationView:removeEvents()
	self._btnbuy:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, PayController.instance, PayEvent.PayFinished, self._payFinished, self)
end

function StoreDecorateCombinationView:_btnbuyOnClick()
	PayController.instance:startPay(self._goodsId)
end

function StoreDecorateCombinationView:_btncloseOnClick()
	self:closeThis()
end

function StoreDecorateCombinationView:_editableInitView()
	self._godetaildesc = gohelper.findChild(self.viewGO, "right/info/desc/info/txt")
	self._detailDescItems = self:getUserDataTb_()
	self._productItems = self:getUserDataTb_()

	self._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
	gohelper.setActive(self._goicon, false)
end

function StoreDecorateCombinationView:onUpdateParam()
	self:_refreshView()
end

function StoreDecorateCombinationView:onOpen()
	self:_refreshView()
end

function StoreDecorateCombinationView:onClose()
	return
end

function StoreDecorateCombinationView:onClickModalMask()
	self:closeThis()
end

function StoreDecorateCombinationView:_refreshView()
	self:checkParam()
	self:_refreshGoodsInfo()
	self:_refreshTipTag()
end

function StoreDecorateCombinationView:checkParam()
	self._goodsId = self.viewParam and self.viewParam.goodsId

	if not self._goodsId then
		return
	end

	self._goodsMo = StoreModel.instance:getGoodsMO(self._goodsId)

	if self._goodsMo then
		self._goodsCo = self._goodsMo.config or StoreConfig.instance:getGoodsConfig(self._goodsId)
	end

	self._curProductIndex = 1
	self._productList = GameUtil.splitString2(self._goodsCo.product)
end

function StoreDecorateCombinationView:_refreshGoodsInfo()
	if not self._goodsCo then
		return
	end

	self._txtgoodsNameCn.text = self._goodsCo.name

	local count = 0

	if not string.nilorempty(self._goodsCo.detailDesc) then
		local detailDescStrList = string.split(self._goodsCo.detailDesc, "\n")

		for i, desc in ipairs(detailDescStrList) do
			local item = self:_getDetailDescItem(i)

			item.txt.text = desc
			count = count + 1
		end
	end

	for i = 1, #self._detailDescItems do
		gohelper.setActive(self._detailDescItems[i].go, i <= count)
	end

	local count1 = 0

	if self._productList and next(self._productList) then
		for i, v in ipairs(self._productList) do
			local itemConfig = ItemConfig.instance:getItemConfig(v[1], v[2])

			if itemConfig then
				count1 = count1 + 1

				local item = self:_getProductItem(count1)

				item.item:setMOValue(v[1], v[2], v[3], nil, true)
				item.item:hideExpEquipState()
				item.item:isShowName(false)

				if item.item:isEquipIcon() then
					item.item:isShowEquipAndItemCount(true)
				end

				item.item:setCountFontSize(36)
				item.item:hideEquipLvAndBreak(true)
				item.item:showEquipRefineContainer(false)
				item.item:setScale(0.6)
				item.item:SetCountLocalY(43.6)
				item.item:SetCountBgHeight(25)
			else
				logError("不存在的商品: type: " .. tostring(v[1]) .. " id: " .. tostring(v[2]))
			end
		end
	end

	for i = 1, #self._productItems do
		gohelper.setActive(self._productItems[i].go, i <= count1)
	end

	local originalCost = self._goodsCo.originalCost

	self._txtmaterialNum.text = StoreModel.instance:getCostPriceFull(self._goodsId)
	self._txtprice.text = StoreModel.instance:getOriginCostPriceFull(self._goodsId)

	gohelper.setActive(self._txtprice.gameObject, originalCost > 0)
end

function StoreDecorateCombinationView:_getProductItem(index)
	local item = self._productItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._goicon)

		gohelper.setActive(go, true)

		item = self:getUserDataTb_()
		item.go = go
		item.item = IconMgr.instance:getCommonPropItemIcon(go)
		self._productItems[index] = item
	end

	return item
end

function StoreDecorateCombinationView:_getDetailDescItem(index)
	local item = self._detailDescItems[index]

	if not item then
		if index == 1 then
			if not self._godetaildesc then
				local go = gohelper.cloneInPlace(self._godetaildesc)

				item = self:getUserDataTb_()
				item.go = go
				item.txt = go:GetComponent(typeof(TMPro.TMP_Text))
				self._detailDescItems[index] = item
			end
		end
	end

	return item
end

function StoreDecorateCombinationView:_payFinished()
	self:_refreshBuy()
	self:closeThis()
end

function StoreDecorateCombinationView:_refreshBuy()
	local isSoldOut = not self._goodsMo or self._goodsMo:isSoldOut()

	gohelper.setActive(self._btnbuy.gameObject, not isSoldOut)
	gohelper.setActive(self._gotips.gameObject, isSoldOut)
end

function StoreDecorateCombinationView:_refreshTipTag()
	local maxBuyCount, buyCount, offlineTime

	if self._goodsMo then
		offlineTime = self._goodsMo.offlineTime
		maxBuyCount = self._goodsMo.maxBuyCount or 0
		buyCount = self._goodsMo.buyCount or 0
	elseif self._goodsCo then
		offlineTime = TimeUtil.stringToTimestamp(self._goodsCo.offlineTime)

		local limitArr = GameUtil.splitString2(self._goodsCo.limit, true)

		maxBuyCount = limitArr[1][1] == StoreEnum.ChargeRefreshTime.None and 0 or limitArr[1][2]
		buyCount = 0
	end

	local remain = maxBuyCount - buyCount

	if not string.nilorempty(offlineTime) then
		local limitSec = math.floor(offlineTime - ServerTime.now())

		offlineTime = string.format("%s%s", TimeUtil.secondToRoughTime(limitSec))
	end

	local content = string.format("%s:%d", luaLang("store_buylimit_forever"), remain)

	self._txtremain.text = content or ""
	self._txtremaintime.text = offlineTime or ""

	gohelper.setActive(self._gorightbg, not string.nilorempty(offlineTime))
	gohelper.setActive(self._goleftbg, maxBuyCount and maxBuyCount > 0)
end

function StoreDecorateCombinationView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
end

return StoreDecorateCombinationView
