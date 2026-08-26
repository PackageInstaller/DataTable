-- chunkname: @modules/logic/store/view/StoreSkinGoodsItem.lua

module("modules.logic.store.view.StoreSkinGoodsItem", package.seeall)

local StoreSkinGoodsItem = class("StoreSkinGoodsItem", ListScrollCellExtend)

function StoreSkinGoodsItem:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_NormalSkin/image_bg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_NormalSkin/#simage_icon")
	self._goNormalSkin = gohelper.findChild(self.viewGO, "#go_NormalSkin")
	self._advanceImagebg = gohelper.findChildSingleImage(self.viewGO, "#go_AdvancedSkin/#simage_bg")
	self._advanceImageicon = gohelper.findChildSingleImage(self.viewGO, "#go_AdvancedSkin/#simage_icon")
	self._advanceImage1 = gohelper.findChildSingleImage(self.viewGO, "#go_AdvancedSkin/#image_D")
	self._advanceImage2 = gohelper.findChildSingleImage(self.viewGO, "#go_AdvancedSkin/#image_A")
	self._goAdvanceSkin = gohelper.findChild(self.viewGO, "#go_AdvancedSkin")
	self._goUniqueSkinsImage = gohelper.findChild(self.viewGO, "#go_UniqueSkin/#simage_icon")
	self._goUniqueSkin = gohelper.findChild(self.viewGO, "#go_UniqueSkin")
	self._uniqueSingleImageicon = gohelper.findChildSingleImage(self.viewGO, "#go_UniqueSkin/#simage_icon")
	self._uniqueImagebg = gohelper.findChildSingleImage(self.viewGO, "#go_UniqueSkin/#simage_iconbg")
	self._goUniqueSkinBubble = gohelper.findChild(self.viewGO, "#go_UniqueSkin/#simage_bubble")
	self._xtIconbg = gohelper.findChild(self.viewGO, "#go_UniqueSkin/#xingti_iconbg")
	self._goLinkTag = gohelper.findChild(self.viewGO, "go_tagTR/#go_linkTag")
	self._gocost = gohelper.findChild(self.viewGO, "cost")
	self._gocostline = gohelper.findChild(self.viewGO, "cost/line")
	self._goprice = gohelper.findChild(self.viewGO, "cost/#go_price")
	self._goowned = gohelper.findChild(self.viewGO, "cost/#go_owned")
	self._txtoriginalprice = gohelper.findChildText(self.viewGO, "cost/#txt_original_price")
	self._goCharge = gohelper.findChild(self.viewGO, "cost/#go_charge")
	self._txtCharge = gohelper.findChildText(self.viewGO, "cost/#go_charge/txt_chargeNum")
	self._txtOriginalCharge = gohelper.findChildText(self.viewGO, "cost/#go_charge/txt_originalChargeNum")
	self._goremaintime = gohelper.findChild(self.viewGO, "#go_tag/#go_remaintime")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "#go_tag/#go_remaintime/bg/icon/#txt_remaintime")
	self._gotag = gohelper.findChild(self.viewGO, "#go_tag")
	self._gonewtag = gohelper.findChild(self.viewGO, "#go_newtag")
	self._godiscount = gohelper.findChild(self.viewGO, "#go_tag/#go_discount")
	self._txtdiscount = gohelper.findChildText(self.viewGO, "#go_tag/#go_discount/#txt_discount")
	self._godeduction = gohelper.findChild(self.viewGO, "#go_tag/#go_deduction")
	self._txtdeduction = gohelper.findChildTextMesh(self.viewGO, "#go_tag/#go_deduction/txt_materialNum")
	self._goSkinTips = gohelper.findChild(self.viewGO, "#go_SkinTips")
	self._imgProp = gohelper.findChildImage(self.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num/#image_Prop")
	self._txtPropNum = gohelper.findChildTextMesh(self.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num")
	self._goSpecial = gohelper.findChild(self.viewGO, "go_tagTR/#go_Special")
	self.goSelect = gohelper.findChild(self.viewGO, "#go_select")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSkinGoodsItem:addEvents()
	self.addEventCb(self, StoreController.instance, StoreEvent.SkinChargePackageUpdate, self.refreshChargeInfo, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.SkinPreviewChanged, self._onSkinPreviewChanged, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.SkinPlayPriceAnim, self._onSkinPlayPriceAnim, self)
end

function StoreSkinGoodsItem:removeEvents()
	self.removeEventCb(self, StoreController.instance, StoreEvent.SkinChargePackageUpdate, self.refreshChargeInfo, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.SkinPreviewChanged, self._onSkinPreviewChanged, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.SkinPlayPriceAnim, self._onSkinPlayPriceAnim, self)
end

function StoreSkinGoodsItem:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("img_card_bg"))

	self._txtmaterialNum = gohelper.findChildText(self._goprice, "txt_materialNum")
	self._simagematerial = gohelper.findChildImage(self._goprice, "simage_material")
	self._btnGO = gohelper.findChild(self.viewGO, "clickArea")
	self._btn = gohelper.getClickWithAudio(self._btnGO, AudioEnum.UI.play_ui_rolesopen)

	self._btn:AddClickListener(self._onClick, self)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.viewGOTrs = self.viewGO.transform
	self.parentViewGO = self.viewGO.transform.parent.gameObject
	self._costAnimator = self._gocost:GetComponent(gohelper.Type_Animator)
end

function StoreSkinGoodsItem:_onSkinPreviewChanged()
	self:updateSelect()
	self:updateNew()
end

function StoreSkinGoodsItem:updateNew()
	local alreadyHas = self._mo:alreadyHas() and not StoreModel.instance:isSkinGoodsCanRepeatBuy(self._mo)

	if alreadyHas then
		gohelper.setActive(self._gonewtag, false)

		return
	end

	local needNew = self._mo:checkShowNewRedDot()

	gohelper.setActive(self._gonewtag, needNew)
end

function StoreSkinGoodsItem:updateSelect()
	local selectGoods = StoreClothesGoodsItemListModel.instance:getSelectGoods()
	local isSelect = selectGoods == self._mo

	gohelper.setActive(self.goSelect, isSelect)

	if self._mo:checkShowNewRedDot() then
		self._mo:setNewRedDotKey()
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
			[RedDotEnum.DotNode.StoreBtn] = true
		})
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function StoreSkinGoodsItem:_onClick()
	StoreClothesGoodsItemListModel.instance:setSelectIndex(self._index)
end

function StoreSkinGoodsItem:_openStoreSkinView()
	ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
		goodsMO = self._mo
	})
end

function StoreSkinGoodsItem:_onDraggingBegin()
	return
end

function StoreSkinGoodsItem:_onDragging()
	return
end

function StoreSkinGoodsItem:_onDraggingEnd()
	return
end

function StoreSkinGoodsItem:checkItemInGoodsList(rectTrans, itemRectTrans)
	local screenPosX, screenPosY = recthelper.uiPosToScreenPos2(itemRectTrans)

	return recthelper.screenPosInRect(rectTrans, CameraMgr.instance:getUICamera(), screenPosX, screenPosY)
end

function StoreSkinGoodsItem:onUpdateMO(mo)
	self._mo = mo

	local goodsConfig = mo.config
	local product = goodsConfig.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]
	local isShowLinkageSkin = self:_isLinkageSkin()
	local isShowNormalSkin = self:_isNormalSkin()
	local isShowAdvancedSkin = self:_isAdvanceSkin()
	local isShowUniqueSkin = self:_isUniqueSkin()

	self._skinId = skinId
	self.skinCo = SkinConfig.instance:getSkinCo(skinId)

	self:clearSpine()
	gohelper.setActive(self._goNormalSkin, isShowNormalSkin)
	gohelper.setActive(self._goAdvanceSkin, isShowAdvancedSkin)
	gohelper.setActive(self._goUniqueSkin, isShowUniqueSkin)
	gohelper.setActive(self._goLinkTag, isShowLinkageSkin)

	if isShowUniqueSkin then
		self:_onUpdateMO_uniqueSkin()
	else
		local imageIcon = isShowAdvancedSkin and self._advanceImageicon or self._simageicon

		if string.nilorempty(self._mo.config.bigImg) == false then
			imageIcon:LoadImage(self._mo.config.bigImg)
		else
			imageIcon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
		end
	end

	self:refreshChargeInfo()
	self:refreshSkinTips()
	self:_refreshSpecial()
	self:updateNew()
	self:updateSelect()

	if self._view and self._view.viewContainer then
		self._view.viewContainer:dispatchEvent(StoreEvent.SkinGoodsItemChanged)
	end
end

function StoreSkinGoodsItem:refreshChargeInfo()
	local mo = self._mo
	local skinId = self._skinId
	local goodsConfig = self._mo.config

	self._goodsPriceInfo = StoreHelper.getSkinGoodsPriceInfo(goodsConfig, skinId)

	local info = self._goodsPriceInfo
	local rmbCurPrice = info.rmbCurPrice
	local rmbOriginalPrice = info.rmbOriginalPrice
	local coinsItemType = info.coinsItemType
	local coinsItemId = info.coinsItemId
	local coinsCurPrice = info.coinsCurPrice
	local coinsOriginalPrice = info.coinsOriginalPrice
	local coinsReduction = info.coinsReduction
	local hasDeductionItem = info.hasDeductionItem
	local alreadyHas = mo:alreadyHas() and not StoreModel.instance:isSkinGoodsCanRepeatBuy(mo)

	gohelper.setActive(self._goowned, alreadyHas)
	gohelper.setActive(self._goprice, not alreadyHas)
	gohelper.setActive(self._gocostline, not alreadyHas)

	if not alreadyHas then
		recthelper.setAnchorX(self._goprice.transform, rmbCurPrice and 60 or 5)
	end

	self._txtdeduction.text = -coinsReduction

	gohelper.setActive(self._godeduction, not alreadyHas and hasDeductionItem)

	if rmbCurPrice then
		self._txtCharge.text = string.format("%s%s", StoreModel.instance:getCostStr(rmbCurPrice))
	end

	gohelper.setActive(self._goCharge, rmbCurPrice and not alreadyHas)
	ZProj.UGUIHelper.RebuildLayout(self._goCharge.transform)

	if rmbOriginalPrice then
		self._txtOriginalCharge.text = rmbOriginalPrice
	end

	gohelper.setActive(self._txtOriginalCharge, rmbOriginalPrice)

	if coinsCurPrice then
		self._txtmaterialNum.text = coinsCurPrice
	end

	gohelper.setActive(self._txtmaterialNum, coinsCurPrice)

	local isShowCoinsOriginalPrice = false

	if isShowCoinsOriginalPrice then
		self._txtoriginalprice.text = coinsOriginalPrice
	end

	gohelper.setActive(self._txtoriginalprice, isShowCoinsOriginalPrice)

	local isShowOffTag = false

	if isShowOffTag then
		local offDiscount = math.ceil(coinsCurPrice / coinsOriginalPrice * 100)

		isShowOffTag = offDiscount < 100 and offDiscount > 0
		self._txtdiscount.text = string.format("-%d%%", 100 - offDiscount)
	end

	gohelper.setActive(self._godiscount, isShowOffTag)

	if coinsItemType then
		local costConfig = ItemModel.instance:getItemConfig(coinsItemType, coinsItemId)
		local iconSpriteName = string.format("%s_1", costConfig.icon)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._simagematerial, iconSpriteName, true)
	end

	local offlineTime = mo:getOfflineTime()
	local offEndTime = offlineTime - ServerTime.now()

	gohelper.setActive(self._goremaintime, offlineTime > 0 and alreadyHas == false)

	self._txtremaintime.text = offEndTime > 3600 and TimeUtil.getFormatTime1(offEndTime) or luaLang("not_enough_one_hour")
end

function StoreSkinGoodsItem:getAnimator()
	return self._animator
end

function StoreSkinGoodsItem:refreshSkinTips()
	gohelper.setActive(self._goSkinTips, false)
end

function StoreSkinGoodsItem:clearSpine()
	GameUtil.doClearMember(self, "_skinSpine")
	GameUtil.doClearMember(self, "_skinSpine2")
end

function StoreSkinGoodsItem:onDestroyView()
	self._btn:RemoveClickListener()
	self._simagebg:UnLoadImage()
	self._uniqueSingleImageicon:UnLoadImage()
	self._uniqueImagebg:UnLoadImage()
	GameUtil.doClearMember(self, "_skinSpine")
	GameUtil.doClearMember(self, "_skinSpine2")
	self.removeEventCb(self, StoreController.instance, StoreEvent.DragSkinListBegin, self._onDraggingBegin, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.DragSkinListEnd, self._onDraggingEnd, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.DraggingSkinList, self._onDragging, self)
	TaskDispatcher.cancelTask(self._delayRefreshPrice, self)
end

function StoreSkinGoodsItem:_onUpdateMO_uniqueSkin()
	self.addEventCb(self, StoreController.instance, StoreEvent.DragSkinListBegin, self._onDraggingBegin, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.DragSkinListEnd, self._onDraggingEnd, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.DraggingSkinList, self._onDragging, self)
	gohelper.setActive(self._xtIconbg, false)
	gohelper.setActive(self._goUniqueSkinBubble, false)
	self._uniqueImagebg:LoadImage(ResUrl.getCharacterSkinIcon(self._skinId))
	self._uniqueSingleImageicon:LoadImage(ResUrl.getHeadSkinIconUnique(self._skinId))
end

function StoreSkinGoodsItem:_isNormalSkin()
	return self._mo.config.skinLevel == 0
end

function StoreSkinGoodsItem:_isAdvanceSkin()
	return self._mo.config.isAdvancedSkin or self._mo.config.skinLevel == 1
end

function StoreSkinGoodsItem:_isUniqueSkin()
	return self._mo.config.skinLevel == 2
end

function StoreSkinGoodsItem:_isLinkageSkin()
	return self._mo.config.islinkageSkin or false
end

function StoreSkinGoodsItem:_isShowLinkageLogo()
	return self._mo.config.showLinkageLogo or false
end

function StoreSkinGoodsItem:_refreshSpecial()
	local info = self._goodsPriceInfo
	local hasSpecialOfferItem = info.hasSpecialOfferItem

	gohelper.setActive(self._goSpecial, hasSpecialOfferItem)
end

function StoreSkinGoodsItem:_playAnimCostIdle()
	self:_playAnimCost(UIAnimationName.Idle, 0, 1)
end

function StoreSkinGoodsItem:_playAnimCostSwitch()
	self:_playAnimCost(UIAnimationName.Switch, 0, 0)
end

function StoreSkinGoodsItem:_playAnimCost(name, ...)
	self._costAnimator:Play(name, ...)
end

function StoreSkinGoodsItem:_onSkinPlayPriceAnim()
	TaskDispatcher.cancelTask(self._delayRefreshPrice, self)

	local skinId = self._skinId

	if not skinId then
		return
	end

	local goodsMO = self._mo

	if not goodsMO then
		return
	end

	local alreadyHas = goodsMO:alreadyHas()

	if alreadyHas then
		return
	end

	local goodsConfig = goodsMO.config

	if not goodsConfig then
		return
	end

	local info = StoreHelper.getSkinGoodsPriceInfo(goodsConfig, skinId)
	local hasSpecialOfferItem = info.hasSpecialOfferItem
	local hasDeductionItem = info.hasDeductionItem
	local coinsReduction = info.coinsReduction
	local bShowAnim = hasSpecialOfferItem or hasDeductionItem or coinsReduction > 0

	if not bShowAnim then
		return
	end

	TaskDispatcher.runDelay(self._delayRefreshPrice, self, 0.16)
	self:_playAnimCostSwitch()
end

function StoreSkinGoodsItem:_delayRefreshPrice()
	self:refreshChargeInfo()
	self:_refreshSpecial()
end

return StoreSkinGoodsItem
