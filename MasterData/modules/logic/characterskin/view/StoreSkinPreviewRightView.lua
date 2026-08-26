-- chunkname: @modules/logic/characterskin/view/StoreSkinPreviewRightView.lua

module("modules.logic.characterskin.view.StoreSkinPreviewRightView", package.seeall)

local StoreSkinPreviewRightView = class("StoreSkinPreviewRightView", BaseView)

function StoreSkinPreviewRightView:onInitView()
	self._simageshowbg = gohelper.findChildSingleImage(self.viewGO, "container/#simage_skinSwitchBg")
	self._goskincontainer = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer")
	self._scrollskinSwitch = gohelper.findChildScrollRect(self.viewGO, "container/skinStore/skinSwitch/#scroll_skinSwitch")
	self._goContent = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content")
	self._gopreEmpty = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_preEmpty")
	self._goskinItem = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_skinItem")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy")
	self._gotxtbuy = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy")
	self._goCost = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/price")
	self._imageicon = gohelper.findChildImage(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/price/#image_icon")
	self._txtprice = gohelper.findChildText(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/price/#txt_price")
	self._goCharge = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_charge")
	self._txtCharge = gohelper.findChildText(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_charge/txt_chargeNum")
	self._txtOriginalCharge = gohelper.findChildText(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_charge/txt_originalChargeNum")
	self._goChargeItem = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_pay/#go_chargeItem")
	self._goCostItem = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/dressState/#btn_buy/#go_txtbuy/#go_pay/#go_costItem")
	self._gohas = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/dressState/#go_has")
	self._goskinCard = gohelper.findChild(self.viewGO, "container/skinStore/skinSwitch/#go_skinCard")
	self._goSkinTips = gohelper.findChild(self.viewGO, "container/#go_SkinTips")
	self._imgProp = gohelper.findChildImage(self.viewGO, "container/#go_SkinTips/image/#txt_Tips/#txt_Num/#image_Prop")
	self._txtPropNum = gohelper.findChildTextMesh(self.viewGO, "container/#go_SkinTips/image/#txt_Tips/#txt_Num")
	self._simagelogo = gohelper.findChildSingleImage(self.viewGO, "#simage_logo")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSkinPreviewRightView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
end

function StoreSkinPreviewRightView:removeEvents()
	self._btnbuy:RemoveClickListener()
end

function StoreSkinPreviewRightView:_btnbuyOnClick()
	local goodsMo = self:_goodsMo()

	if not goodsMo then
		GameFacade.showToast(ToastEnum.StoreSkinPreview)

		return
	end

	local goodsConfig = goodsMo.config

	if not StoreModel.instance:getGoodsMO(goodsMo.goodsId) then
		GameFacade.showToast(ToastEnum.StoreSkinPreview)

		return
	end

	local skinId

	if self._skinCo then
		skinId = self._skinCo.id
	end

	if StoreModel.instance:isSkinCanShowMessageBox(skinId) then
		local skinStoreId = self._skinCo.skinStoreId
		local skinGoodsMo = StoreModel.instance:getGoodsMO(skinStoreId)

		GameFacade.showMessageBox(MessageBoxIdDefine.SkinGoodsJumpTips, MsgBoxEnum.BoxType.Yes_No, function()
			StoreController.instance:openStoreView(StoreEnum.StoreId.VersionPackage, skinStoreId)
			self:closeThis()
		end, nil, nil, self, nil, nil, skinGoodsMo.config.name)

		return
	end

	if not self._goodsPriceInfo then
		local info = StoreHelper.getSkinGoodsPriceInfo(goodsConfig, skinId)
		local specialofferItemType = info.specialofferItemType
		local specialofferItemId = info.specialofferItemId
		local hasSpecialOfferItem = info.hasSpecialOfferItem

		if specialofferItemType then
			local specialofferItemCO = ItemModel.instance:getItemConfig(specialofferItemType, specialofferItemId)

			if ItemEnum.Tag.GoldenMilletPresentSkin == specialofferItemCO.clienttag and GoldenMilletPresentModel.instance:isShowRedDot() and not hasSpecialOfferItem then
				GameFacade.showMessageBox(MessageBoxIdDefine.GoldenMilletPresentSkinBeforeBuy, MsgBoxEnum.BoxType.Yes, function()
					GoldenMilletPresentController.instance:openGoldenMilletPresentView()
					self:closeThis()
				end, nil, nil, self, nil, nil)

				return
			end
		end

		if self._bRmbBuy then
			local goodsId = StoreConfig.instance:getSkinChargeGoodsId(skinId)

			if goodsId then
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
				ViewMgr.instance:openView(ViewName.StoreSkinGoodsView2, {
					index = 1,
					goodsMo = goodsMo
				})
			else
				GameFacade.showToast(ToastEnum.CanNotBuy)
			end
		else
			ViewMgr.instance:openView(ViewName.StoreSkinGoodsView2, {
				index = 2,
				goodsMo = goodsMo
			})
		end
	end
end

function StoreSkinPreviewRightView:_setIsChargeBuy(bRmbBuy)
	if bRmbBuy == nil then
		bRmbBuy = self:_bAllowRmb()
	end

	self._bRmbBuy = bRmbBuy

	self:_refreshPrice()
end

function StoreSkinPreviewRightView:_refreshPrice()
	local goodsMo = self:_goodsMo()
	local skinCo = self._skinCo
	local bRmbBuy = self._bRmbBuy
	local info = self._goodsPriceInfo
	local rmbCurPrice = info.rmbCurPrice
	local rmbOriginalPrice = info.rmbOriginalPrice
	local coinsItemType = info.coinsItemType
	local coinsItemId = info.coinsItemId
	local coinsCurPrice = info.coinsCurPrice
	local coinsOriginalPrice = info.coinsOriginalPrice
	local coinsReduction = info.coinsReduction
	local hasDeductionItem = info.hasDeductionItem
	local hasSpecialOfferItem = info.hasSpecialOfferItem
	local canRepeatBuy = StoreModel.instance:isSkinGoodsCanRepeatBuy(goodsMo)
	local alreadyHas = goodsMo:alreadyHas() and not canRepeatBuy

	self:_setPriceText(rmbCurPrice, rmbOriginalPrice)

	if coinsCurPrice then
		local isShowCoinsOriginalPrice = (hasDeductionItem or hasSpecialOfferItem) and coinsCurPrice < coinsOriginalPrice

		self._txtprice.text = isShowCoinsOriginalPrice and string.format("%s <color=#22222280><s>%s", coinsCurPrice, coinsOriginalPrice) or coinsCurPrice
	end

	if coinsItemType then
		local costConfig = ItemModel.instance:getItemConfig(coinsItemType, coinsItemId)
		local costName = costConfig.name
		local iconSpriteName = string.format("%s_1", costConfig.icon)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageicon, iconSpriteName)
		UISpriteSetMgr.instance:setCurrencyItemSprite(self._costItem._imageicon, iconSpriteName)

		self._costItem._txtdesc.text = costName
	end

	gohelper.setActive(self._goChargeItem, rmbCurPrice)
	gohelper.setActive(self._goCostItem, rmbCurPrice)
	gohelper.setActive(self._goCost, not bRmbBuy)
	gohelper.setActive(self._goCharge, rmbCurPrice and bRmbBuy)
	gohelper.setActive(self._costItem._goselectbg, not bRmbBuy)
	gohelper.setActive(self._chargeItem._goselectbg, bRmbBuy)
	UIColorHelper.set(self._costItem._txtdesc, not bRmbBuy and "#FFFFFF" or "#4C4341")
	UIColorHelper.set(self._chargeItem._txtCharge, bRmbBuy and "#FFFFFF" or "#4C4341")
	UIColorHelper.set(self._chargeItem._txtOriginalCharge, bRmbBuy and "#FFFFFF80" or "#4C434180")
	gohelper.setActive(self._btnbuy.gameObject, not alreadyHas)
	gohelper.setActive(self._gohas, alreadyHas)
	gohelper.setActive(self._goSkinTips, canRepeatBuy)

	if canRepeatBuy then
		local compensate = string.splitToNumber(skinCo.compensate, "#")
		local currencyId = compensate[2]
		local currencyNum = compensate[3]
		local currencyCo = CurrencyConfig.instance:getCurrencyCo(currencyId)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imgProp, string.format("%s_1", currencyCo.icon))

		self._txtPropNum.text = tostring(currencyNum)
	end

	self._costItem._txtdeduction.text = -coinsReduction

	gohelper.setActive(self._costItem._godeduction, hasDeductionItem)
end

function StoreSkinPreviewRightView:_editableInitView()
	self._allSkinList = {}
	self._currentSelectSkinIndex = -1
	self._goSkinNormalContainer = gohelper.findChild(self.viewGO, "container/normal")
	self._goSkinTipContainer = gohelper.findChild(self.viewGO, "container/skinTip")
	self._goSkinStoreContainer = gohelper.findChild(self.viewGO, "container/skinStore")
	self._dragGo = gohelper.findChild(self.viewGO, "drag")
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._dragGo)

	self._drag:AddDragBeginListener(self._onViewDragBegin, self)
	self._drag:AddDragListener(self._onViewDrag, self)
	self._drag:AddDragEndListener(self._onViewDragEnd, self)
	self._simageshowbg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))

	self._cardImage = gohelper.findChildSingleImage(self._goskinCard, "skinmask/skinicon")
	self._skincontainerCanvasGroup = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer"):GetComponent(gohelper.Type_CanvasGroup)
	self._animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._chargeItem = self:_createPayItemUserDataTb(self._goChargeItem, true)
	self._costItem = self:_createPayItemUserDataTb(self._goCostItem, false)

	gohelper.setActive(self._goSkinNormalContainer, false)
	gohelper.setActive(self._goSkinTipContainer, false)
	gohelper.setActive(self._goSkinStoreContainer, true)
	gohelper.setActive(self._dragGo, true)
end

function StoreSkinPreviewRightView:_createPayItemUserDataTb(go, bRmbBuy)
	local tb = self:getUserDataTb_()

	tb._go = go
	tb._gonormalbg = gohelper.findChild(go, "go_normalbg")
	tb._goselectbg = gohelper.findChild(go, "go_selectbg")

	if bRmbBuy then
		tb._txtCharge = gohelper.findChildText(go, "go_chargeDesc/txt_chargeNum")
		tb._txtOriginalCharge = gohelper.findChildText(go, "go_chargeDesc/txt_originalChargeNum")
	else
		tb._txtdesc = gohelper.findChildText(go, "txt_desc")
		tb._imageicon = gohelper.findChildImage(go, "txt_desc/simage_icon")
		tb._godeduction = gohelper.findChild(go, "#go_deduction")
		tb._txtdeduction = gohelper.findChildTextMesh(go, "#go_deduction/txt_materialNum")
	end

	tb._btnpay = gohelper.findChildButtonWithAudio(go, "btn_pay")

	tb._btnpay:AddClickListener(function(obj)
		obj:_setIsChargeBuy(bRmbBuy)
	end, self)

	return tb
end

function StoreSkinPreviewRightView:onUpdateParam()
	self:_refreshView()
end

function StoreSkinPreviewRightView:onOpen()
	self._allSkinList = StoreClothesGoodsItemListModel.instance:getList()

	self:onUpdateParam()
end

function StoreSkinPreviewRightView:_refreshView()
	self:_autoSelect()
	self:_refreshUI()
end

function StoreSkinPreviewRightView:_refreshUI(skinCo)
	recthelper.setAnchor(self._goskincontainer.transform, 0, 0)

	if not skinCo then
		local skinId = self:_extractSkinId()

		skinCo = SkinConfig.instance:getSkinCo(skinId)
	end

	local goodsMo = self:_goodsMo()
	local goodsConfig = goodsMo.config
	local skinId = skinCo and skinCo.id

	if skinCo ~= self._skinCo then
		self._skinCo = skinCo
		self._goodsPriceInfo = StoreHelper.getSkinGoodsPriceInfo(goodsConfig, skinId)
	end

	local info = self._goodsPriceInfo
	local hasDeductionItem = info.hasDeductionItem

	if skinId then
		self._cardImage:LoadImage(ResUrl.getHeadSkinSmall(skinId), function()
			ZProj.UGUIHelper.SetImageSize(self._cardImage.gameObject)
		end)
	end

	if hasDeductionItem then
		-- block empty
	end

	local bSelectRmb

	self:_setIsChargeBuy(bSelectRmb)

	local isNotLogo = string.nilorempty(goodsConfig.logoRoots)

	gohelper.setActive(self._simagelogo, not isNotLogo)

	if not isNotLogo then
		self._simagelogo:LoadImage(goodsConfig.logoRoots, self._onLogoLoadFinish, self)
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkin, skinCo, self.viewName)
	StoreController.instance:dispatchEvent(StoreEvent.OnSwitchSpine, skinId)
end

function StoreSkinPreviewRightView:_onLogoLoadFinish()
	ZProj.UGUIHelper.SetImageSize(self._simagelogo.gameObject)
end

function StoreSkinPreviewRightView:_onViewDragBegin(param, pointerEventData)
	self._startPos = pointerEventData.position.x

	self._animator:Play(UIAnimationName.SwitchClose, 0, 0)
	self:setShaderKeyWord(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
end

function StoreSkinPreviewRightView:_onViewDrag(param, pointerEventData)
	local curPos = pointerEventData.position.x
	local moveSmooth = 1
	local curSpineRootPosX = recthelper.getAnchorX(self._goskincontainer.transform)

	curSpineRootPosX = curSpineRootPosX + pointerEventData.delta.x * moveSmooth

	recthelper.setAnchorX(self._goskincontainer.transform, curSpineRootPosX)

	local alphaSmooth = 0.007

	self._skincontainerCanvasGroup.alpha = 1 - Mathf.Abs(self._startPos - curPos) * alphaSmooth
end

function StoreSkinPreviewRightView:_onViewDragEnd(param, pointerEventData)
	local endPos = pointerEventData.position.x
	local newSelectSkinIndex

	if endPos > self._startPos and endPos - self._startPos >= 100 then
		newSelectSkinIndex = self._currentSelectSkinIndex - 1

		if self._currentSelectSkinIndex - 1 == 0 then
			newSelectSkinIndex = #self._allSkinList
		end
	elseif endPos < self._startPos and self._startPos - endPos >= 100 then
		newSelectSkinIndex = self._currentSelectSkinIndex + 1

		if self._currentSelectSkinIndex + 1 > #self._allSkinList then
			newSelectSkinIndex = 1
		end
	end

	self._skincontainerCanvasGroup.alpha = 1

	self._animator:Play(UIAnimationName.SwitchOpen, 0, 0)
	self:setShaderKeyWord(true)
	TaskDispatcher.cancelTask(self.disAbleShader, self)
	TaskDispatcher.runDelay(self.disAbleShader, self, 0.33)

	if newSelectSkinIndex then
		self._currentSelectSkinIndex = newSelectSkinIndex

		local showDynamicVertical = PlayerModel.instance:getMyUserId() % 2 == 0

		if showDynamicVertical then
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, true, self.viewName)
		else
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, false, self.viewName)
		end

		self:_refreshUI()
	else
		recthelper.setAnchor(self._goskincontainer.transform, 0, 0)
	end
end

function StoreSkinPreviewRightView:setShaderKeyWord(enable)
	if enable then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function StoreSkinPreviewRightView:disAbleShader()
	self:setShaderKeyWord(false)
end

function StoreSkinPreviewRightView:onClose()
	TaskDispatcher.cancelTask(self.disAbleShader, self)
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._drag:RemoveDragListener()
	self._costItem._btnpay:RemoveClickListener()
	self._chargeItem._btnpay:RemoveClickListener()
end

function StoreSkinPreviewRightView:onDestroyView()
	self._simageshowbg:UnLoadImage()
	self._cardImage:UnLoadImage()
end

function StoreSkinPreviewRightView:_goodsMo()
	if self._currentSelectSkinIndex > 0 then
		return self._allSkinList[self._currentSelectSkinIndex]
	end

	return self.viewParam.goodsMO
end

function StoreSkinPreviewRightView:_extractSkinId()
	local goodsMo = self:_goodsMo()
	local product = goodsMo.config.product
	local productInfo = string.splitToNumber(product, "#")

	return productInfo[2]
end

function StoreSkinPreviewRightView:_bAllowRmb()
	local info = self._goodsPriceInfo
	local rmbCurPrice = info.rmbCurPrice

	return not not rmbCurPrice
end

function StoreSkinPreviewRightView:_autoSelect()
	local curGoodsMo = self:_goodsMo()

	self._currentSelectSkinIndex = -1

	for i, goodsMo in ipairs(self._allSkinList) do
		if curGoodsMo.goodsId == goodsMo.goodsId then
			self._currentSelectSkinIndex = i
		end
	end
end

function StoreSkinPreviewRightView:_setPriceText(rmbCurPrice, rmbOriginalPrice)
	local function _setRmbText(str)
		self._chargeItem._txtCharge.text = str or ""
		self._txtCharge.text = str or ""
	end

	local function _setCoinsText(str)
		self._chargeItem._txtOriginalCharge.text = str or ""
		self._txtOriginalCharge.text = str or ""

		local bActive = not not str

		gohelper.setActive(self._chargeItem._txtOriginalCharge, bActive)
		gohelper.setActive(self._txtOriginalCharge, bActive)
	end

	_setRmbText(rmbCurPrice and string.format("%s%s", StoreModel.instance:getCostStr(rmbCurPrice)) or nil)
	_setCoinsText(rmbOriginalPrice)
end

return StoreSkinPreviewRightView
