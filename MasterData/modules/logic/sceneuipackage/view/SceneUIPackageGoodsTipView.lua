-- chunkname: @modules/logic/sceneuipackage/view/SceneUIPackageGoodsTipView.lua

module("modules.logic.sceneuipackage.view.SceneUIPackageGoodsTipView", package.seeall)

local SceneUIPackageGoodsTipView = class("SceneUIPackageGoodsTipView", BaseView)

function SceneUIPackageGoodsTipView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg2")
	self._gobannerContent = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent")
	self._goroominfoItem = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem")
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/#simage_pic")
	self._goSceneLogo = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/#btn_Info")
	self._gobannerscroll = gohelper.findChild(self.viewGO, "left/banner/#go_bannerscroll")
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

	gohelper.setActive(self._goicon, false)
end

function SceneUIPackageGoodsTipView:addEvents()
	self._btnInfo:AddClickListener(self._btnInfoOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self._payFinished, self)
end

function SceneUIPackageGoodsTipView:removeEvents()
	self._btnInfo:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, PayController.instance, PayEvent.PayFinished, self._payFinished, self)
end

function SceneUIPackageGoodsTipView:_btnInfoOnClick()
	local sceneCo = SceneUIPackageModel.instance:getSceneCo(self._actId)

	if not sceneCo then
		return
	end

	local sceneSkinId = sceneCo.id
	local UICo = SceneUIPackageModel.instance:getUICo(self._actId)

	if not UICo then
		return
	end

	local uiSkinId = UICo.id

	MainUISwitchController.instance:openSceneUIPackageInfoView(uiSkinId, sceneSkinId, false)
end

function SceneUIPackageGoodsTipView:_btnbuyOnClick()
	PayController.instance:startPay(self._goodsId)
end

function SceneUIPackageGoodsTipView:_btncloseOnClick()
	self:closeThis()
end

function SceneUIPackageGoodsTipView:_editableInitView()
	self._simageSceneLogo = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	self._imageSceneLogo = gohelper.findChildImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	self._godetaildesc = gohelper.findChild(self.viewGO, "right/info/desc/info/txt")
	self._detailDescItems = self:getUserDataTb_()
	self._productItems = self:getUserDataTb_()

	self._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function SceneUIPackageGoodsTipView:onClickModalMask()
	self:closeThis()
end

function SceneUIPackageGoodsTipView:onUpdateParam()
	self:_refreshView()
end

function SceneUIPackageGoodsTipView:onOpen()
	self:_refreshView()

	if self._goodsMo then
		StoreController.instance:statOpenChargeGoods(self._goodsMo.belongStoreId, self._goodsMo.config)
	end
end

function SceneUIPackageGoodsTipView:_refreshView()
	self._actId = SceneUIPackageModel.instance:getActId()
	self._goodsId = self.viewParam.goodsId or SceneUIPackageModel.instance:getGoodsId()
	self._goodsMo = StoreModel.instance:getGoodsMO(self._goodsId)

	if self._goodsMo then
		self._goodsCo = self._goodsMo.config or SceneUIPackageModel.instance:getGoodsCo(self._actId)
	end

	self:_refreshLogo()
	self:_refreshGoods()
	self:_refreshTipTag()
	self:_refreshBuy()
end

function SceneUIPackageGoodsTipView:_refreshTipTag()
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

	local lang = luaLang("sceneuipackage_goods_remain")
	local content = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, luaLang("store_buylimit_forever"), remain)

	self._txtremain.text = content or ""
	self._txtremaintime.text = offlineTime or ""

	gohelper.setActive(self._gorightbg, not string.nilorempty(offlineTime))
	gohelper.setActive(self._goleftbg, maxBuyCount and maxBuyCount > 0)
end

function SceneUIPackageGoodsTipView:_refreshGoods()
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

	if self._goodsCo.product and not string.nilorempty(self._goodsCo.product) then
		local products = GameUtil.splitString2(self._goodsCo.product)

		for i, v in ipairs(products) do
			local item = self:_getProductItem(i)

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

			count1 = count1 + 1
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

function SceneUIPackageGoodsTipView:_getProductItem(index)
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

function SceneUIPackageGoodsTipView:_getDetailDescItem(index)
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

function SceneUIPackageGoodsTipView:_refreshLogo()
	local info = MainSwitchClassifyEnum.ItemInfo[ItemEnum.SubType.SceneUIPackage]

	self._simageSceneLogo:LoadImage(ResUrl.getMainSceneSwitchLangIcon(info.Logo), function()
		self._imageSceneLogo:SetNativeSize()
		recthelper.setAnchor(self._imageSceneLogo.transform, info.LogoAnchor.x, info.LogoAnchor.y)
	end)
end

function SceneUIPackageGoodsTipView:_payFinished()
	self:_refreshBuy()
	self:closeThis()
end

function SceneUIPackageGoodsTipView:_refreshBuy()
	local isSoldOut = not self._goodsMo or self._goodsMo:isSoldOut()

	gohelper.setActive(self._btnbuy.gameObject, not isSoldOut)
	gohelper.setActive(self._gotips.gameObject, isSoldOut)
end

function SceneUIPackageGoodsTipView:onClose()
	return
end

function SceneUIPackageGoodsTipView:onDestroyView()
	self._simageSceneLogo:UnLoadImage()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
end

return SceneUIPackageGoodsTipView
