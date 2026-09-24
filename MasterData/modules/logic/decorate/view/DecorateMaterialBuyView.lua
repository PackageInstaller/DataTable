-- chunkname: @modules/logic/decorate/view/DecorateMaterialBuyView.lua

module("modules.logic.decorate.view.DecorateMaterialBuyView", package.seeall)

local DecorateMaterialBuyView = class("DecorateMaterialBuyView", BaseView)

function DecorateMaterialBuyView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg2")
	self._txttheme = gohelper.findChildText(self.viewGO, "left/#btn_theme/txt")
	self._gocobrand = gohelper.findChild(self.viewGO, "left/#go_cobrand")
	self._gobuyContent = gohelper.findChild(self.viewGO, "right/#go_buyContent")
	self._goblockInfoItem = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_blockInfoItem")
	self._gochange = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_change")
	self._txtchange = gohelper.findChildText(self.viewGO, "right/#go_buyContent/#go_change/#txt_desc")
	self._imagechangeicon = gohelper.findChildImage(self.viewGO, "right/#go_buyContent/#go_change/#txt_desc/simage_icon")
	self._gopaynoraml = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_change/go_normalbg")
	self._gopayselect = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_change/go_selectbg")
	self._btnticket = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_buyContent/#go_change/btn_pay")
	self._gopay = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_pay")
	self._gopayitem = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_pay/#go_payitem")
	self._btninsight = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_buyContent/buy/#btn_insight")
	self._txtcostnum = gohelper.findChildText(self.viewGO, "right/#go_buyContent/buy/#txt_costnum")
	self._txtoriginalprice = gohelper.findChildText(self.viewGO, "right/#go_buyContent/buy/#txt_costnum/#txt_original_price")
	self._imagecosticon = gohelper.findChildImage(self.viewGO, "right/#go_buyContent/buy/#txt_costnum/#simage_costicon")
	self._gosource = gohelper.findChild(self.viewGO, "right/#go_source")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gotips = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_tips")
	self._txtdiscounttips = gohelper.findChildText(self.viewGO, "right/#go_buyContent/#go_tips/#txt_discount")
	self._godiscount = gohelper.findChild(self.viewGO, "right/#go_buyContent/buy/#btn_insight/#go_discount")
	self._txtdiscount = gohelper.findChildText(self.viewGO, "right/#go_buyContent/buy/#btn_insight/#go_discount/#txt_discount")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DecorateMaterialBuyView:addEvents()
	self._btninsight:AddClickListener(self._btninsightOnClick, self)
	self._btnticket:AddClickListener(self._btnClickUseTicket, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshUI, self)
end

function DecorateMaterialBuyView:removeEvents()
	self._btninsight:RemoveClickListener()
	self._btnticket:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshUI, self)
end

function DecorateMaterialBuyView:_btninsightOnClick()
	local has, items = DecorateStoreModel.instance:hasDiscountItem(self._goodsId)

	self._discountItems = items

	local isCanBuySceneUIPackage = DecorateStoreModel.instance:isCanBuySceneUIPackage()

	if has and items and isCanBuySceneUIPackage then
		local co = ItemModel.instance:getItemConfig(items[1], items[2])

		GameFacade.showMessageBox(MessageBoxIdDefine.DecorateDiscountTip2, MsgBoxEnum.BoxType.Yes_No, self._checkDiscounnt, self._closeFunc, nil, self, self, nil, (co or nil) and (co.name or ""), self._goodConfig.name)
	else
		self:_checkDiscounnt()
	end
end

function DecorateMaterialBuyView:_checkDiscounnt()
	if self._discountItems then
		if self._discountItems then
			local isCanClaim = DecorateStoreModel.instance:isCanClaimDiscountItem(self._discountItems)

			if not isCanClaim then
				self:_readyBuy()
			else
				local co = ItemModel.instance:getItemConfig(self._discountItems[1], self._discountItems[2])

				GameFacade.showMessageBox(MessageBoxIdDefine.DecorateDiscountTip1, MsgBoxEnum.BoxType.Yes_No, self._onJumpGetDiscountItemView, self._readyBuy, nil, self, self, nil, (co or nil) and (co.name or ""))
			end
		else
			self:_readyBuy()
		end
	end
end

function DecorateMaterialBuyView:_onJumpGetDiscountItemView()
	if self._discountItems[2] then
		if self._discountItems[2] then
			ActivityModel.instance:setTargetActivityCategoryId(self._discountItems[2])
			ActivityController.instance:openActivityBeginnerView()
		end
	end
end

function DecorateMaterialBuyView:_readyBuy()
	local curIndex = DecorateStoreModel.instance:getCurCostIndex()
	local costParam = self._currencyParam[curIndex]

	if costParam[1] == MaterialEnum.MaterialType.Currency and costParam[2] == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		if CurrencyController.instance:checkFreeDiamondEnough(costParam[3], CurrencyEnum.PayDiamondExchangeSource.Store, nil, self._exchangeFinished, self, self._closeFunc, self) then
			self:_buyGood(curIndex)
		end
	elseif costParam[1] == MaterialEnum.MaterialType.Currency and costParam[2] == CurrencyEnum.CurrencyType.Diamond then
		if CurrencyController.instance:checkDiamondEnough(costParam[3], self._closeFunc, self) then
			self:_buyGood(curIndex)
		end
	elseif costParam[1] == MaterialEnum.MaterialType.Currency and costParam[2] == CurrencyEnum.CurrencyType.OldTravelTicket then
		local currencyMo = CurrencyModel.instance:getCurrency(costParam[2])

		if currencyMo then
			if currencyMo.quantity >= costParam[3] then
				self:_buyGood(curIndex)
			else
				GameFacade.showToast(ToastEnum.CurrencyNotEnough)

				return false
			end
		end
	elseif ItemModel.instance:goodsIsEnough(costParam[1], costParam[2], costParam[3]) then
		self:_buyGood(curIndex)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.DecorateStoreCurrencyNotEnough, MsgBoxEnum.BoxType.Yes_No, self._storeCurrencyNotEnoughCallback, nil, nil, self, nil)
	end
end

function DecorateMaterialBuyView:_storeCurrencyNotEnoughCallback()
	GameFacade.jump(JumpEnum.JumpId.GlowCharge)
end

function DecorateMaterialBuyView:_exchangeFinished()
	local curIndex = DecorateStoreModel.instance:getCurCostIndex()

	self:_buyGood(curIndex)
end

function DecorateMaterialBuyView:_buyGood(index)
	StoreController.instance:buyGoods(self._mo, 1, self._buyCallback, self, index)
end

function DecorateMaterialBuyView:_buyCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		self:_closeFunc()
	end
end

function DecorateMaterialBuyView:_btnClickUseTicket()
	return
end

function DecorateMaterialBuyView:_btncloseOnClick()
	self:_closeFunc()
end

function DecorateMaterialBuyView:_closeFunc()
	self._animatorPlayer:Play("close", self.closeThis, self)
end

function DecorateMaterialBuyView:_editableInitView()
	self._gobannerItem = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem")
	self._txtSceneLogo = gohelper.findChildText(self._gobannerItem, "image_frame/#go_SceneLogo/titlebg/#txt_SceneLogo")
	self._goSceneLogo = gohelper.findChild(self._gobannerItem, "image_frame/#go_SceneLogo")
	self._gotag = gohelper.findChild(self._gobannerItem, "#go_tag")
	self._txttag = gohelper.findChildText(self._gobannerItem, "#go_tag/txt_name")
	self._simageinfobg = gohelper.findChildSingleImage(self._gobannerItem, "#simage_pic")
	self._imageinfobg = gohelper.findChildImage(self._gobannerItem, "#simage_pic")
	self._btnInfo = gohelper.findChild(self._gobannerItem, "txt_desc/txt_name/#btn_Info")
	self._goheadiconbg = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/#go_headiconbg")
	self._txtdesc = gohelper.findChildText(self._gobannerItem, "txt_desc")
	self._txtname = gohelper.findChildText(self._gobannerItem, "txt_desc/txt_name")
	self._payItemTbList = {}
	self._infoItemTbList = {}

	gohelper.setActive(self._goblockInfoItem, false)
	gohelper.setActive(self._btnInfo, false)
	gohelper.setActive(self._gobuyContent, true)
	gohelper.setActive(self._gosource, false)
	self:_createPayItemUserDataTb_(self._gopayitem, 1)
	self:_createInfoItemUserDataTb_(self._goblockInfoItem, 1)
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
	gohelper.removeUIClickAudio(self._btnclose.gameObject)
	gohelper.addUIClickAudio(self._btninsight.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)

	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function DecorateMaterialBuyView:onOpen()
	self._goodsId = self.viewParam.goodsId
	self._mo = StoreModel.instance:getGoodsMO(self._goodsId)
	self._goodConfig = StoreConfig.instance:getGoodsConfig(self._goodsId)

	DecorateStoreModel.instance:setCurCostIndex(1)
	self:_setCurrency()
	self:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)

	if self._mo then
		StoreController.instance:statOpenChargeGoods(self._mo.belongStoreId, self._goodConfig)
	end
end

function DecorateMaterialBuyView:_setCurrency()
	local currencyParam = {}

	self._currencyParam = {}

	if self._goodConfig.cost ~= "" then
		local costs = string.splitToNumber(self._goodConfig.cost, "#")

		costs[3] = self:_getCostNum(tonumber(costs[3]))

		table.insert(currencyParam, costs[2])
		table.insert(self._currencyParam, costs)
	end

	if self._goodConfig.cost2 ~= "" then
		local cost2s = string.splitToNumber(self._goodConfig.cost2, "#")

		table.insert(currencyParam, cost2s[2])

		cost2s[3] = self:_getCostNum(tonumber(cost2s[3]))

		table.insert(self._currencyParam, cost2s)
	end

	for _, v in pairs(currencyParam) do
		if v == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			table.insert(currencyParam, CurrencyEnum.CurrencyType.Diamond)
		end
	end

	local result = LuaUtil.getReverseArrTab(currencyParam)

	self.viewContainer:setCurrencyType(result)
end

function DecorateMaterialBuyView:_refreshUI()
	self._products = string.splitToNumber(self._goodConfig.product, "#")
	self._itemCo = ItemModel.instance:getItemConfig(self._products[1], self._products[2])

	self:_refreshIcon()
	self:_refreshCost()
	self:_refreshLogo()

	self._txtdesc.text = self._itemCo.desc
	self._txtname.text = self._itemCo.name

	local has, _, discount = DecorateStoreModel.instance:hasDiscountItem(self._goodsId)

	if has then
		self._txtdiscounttips.text = string.format("-%s%%", discount * 0.1)
	end

	gohelper.setActive(self._gotips, has)

	if self._simageinfobg then
		local icon = DecorateModel.instance:getGoodsBuyIcon(self._itemCo, self._goodsId)

		self._simageinfobg:LoadImage(icon, function()
			self._imageinfobg:SetNativeSize()
		end, self)
	end

	if self._decorateConfig.offTag > 0 then
		self._txtdiscount.text = string.format("-%s%%", self._decorateConfig.offTag)
	end

	gohelper.setActive(self._godiscount, self._decorateConfig.offTag > 0)
end

function DecorateMaterialBuyView:_createPayItemUserDataTb_(goItem, index)
	local item = self:getUserDataTb_()

	item._go = goItem
	item._index = index
	item._gonormalbg = gohelper.findChild(goItem, "go_normalbg")
	item._goselectbg = gohelper.findChild(goItem, "go_selectbg")
	item._imageicon = gohelper.findChildImage(goItem, "txt_desc/simage_icon")
	item._txtdesc = gohelper.findChildText(goItem, "txt_desc")
	item._btnpay = gohelper.findChildButtonWithAudio(goItem, "btn_pay")

	item._btnpay:AddClickListener(self._onClickPlay, self, index)
	table.insert(self._payItemTbList, item)

	return item
end

function DecorateMaterialBuyView:_onClickPlay(index)
	for _, item in ipairs(self._payItemTbList) do
		self:_onSelectPayItemUI(item, item._index == index)
	end

	DecorateStoreModel.instance:setCurCostIndex(index)
	self:_refreshCost()
end

function DecorateMaterialBuyView:_createInfoItemUserDataTb_(goItem, index)
	local item = self:getUserDataTb_()

	item._go = goItem
	item._index = index
	item._goeprice = gohelper.findChild(goItem, "go_price")
	item._gofinish = gohelper.findChild(goItem, "go_finish")
	item._txtgold = gohelper.findChildText(goItem, "go_price/txt_gold")
	item._imagegold = gohelper.findChildImage(goItem, "go_price/image_gold")
	item._txtname = gohelper.findChildText(goItem, "txt_name")
	item._txtnum = gohelper.findChildText(goItem, "txt_num")
	item._gobg = gohelper.findChild(goItem, "go_bg")
	item._txtowner = gohelper.findChildText(goItem, "go_finish/txt_owner")

	table.insert(self._infoItemTbList, item)

	return item
end

function DecorateMaterialBuyView:_refreshPayItemUI(item, costId, itemType, itemId)
	item.costId = costId

	local str = self:_getCurrencyIconStr(itemType, itemId)

	UISpriteSetMgr.instance:setCurrencyItemSprite(item._imageicon, str)

	local itemCfg, iconPath = ItemModel.instance:getItemConfigAndIcon(itemType, itemId, true)

	if itemCfg then
		item._txtdesc.text = itemCfg.name or nil
	end
end

function DecorateMaterialBuyView:_getCurrencyIconStr(itemType, itemId)
	return string.format("%s_1", string.len(itemId) == 1 and itemType .. "0" .. itemId or itemType .. itemId)
end

function DecorateMaterialBuyView:_onSelectPayItemUI(item, isSelect)
	gohelper.setActive(item._goselectbg, isSelect)
	gohelper.setActive(item._gonormalbg, not isSelect)
	SLFramework.UGUI.GuiHelper.SetColor(item._txtdesc, isSelect and "#FFFFFF" or "#4C4341")
end

function DecorateMaterialBuyView:_refreshIcon()
	if self._currencyParam and #self._currencyParam > 1 then
		local curIndex = DecorateStoreModel.instance:getCurCostIndex()

		for index, currency in ipairs(self._currencyParam) do
			local item = self._payItemTbList[index]

			if not item then
				local goItem = gohelper.cloneInPlace(self._gopayitem, "go_payitem" .. index)

				item = self:_createPayItemUserDataTb_(goItem, index)
			end

			self:_onSelectPayItemUI(item, item._index == curIndex)
			gohelper.setActive(item._go, true)
			self:_refreshPayItemUI(item, index, currency[1], currency[2])
		end
	else
		for _, item in ipairs(self._payItemTbList) do
			gohelper.setActive(item._go, false)
		end
	end
end

function DecorateMaterialBuyView:_refreshCost()
	local curIndex = DecorateStoreModel.instance:getCurCostIndex()
	local costParam = self._currencyParam[curIndex]

	if costParam then
		self._decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(self._goodsId)

		local str = self:_getCurrencyIconStr(costParam[1], costParam[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecosticon, str)

		local quantity = ItemModel.instance:getItemQuantity(costParam[1], costParam[2])

		SLFramework.UGUI.GuiHelper.SetColor(self._txtcostnum, quantity and quantity >= costParam[3] and "#595959" or "#BF2E11")

		self._txtcostnum.text = tostring(costParam[3])

		local item = self._infoItemTbList[1]

		if not item then
			local goItem = gohelper.cloneInPlace(self._goblockInfoItem, "go_payitem" .. curIndex)

			item = self:_createInfoItemUserDataTb_(goItem, curIndex)
		end

		item._txtname.text = self._goodConfig.name

		local var_27_0 = ItemModel.instance:getItemQuantity(self._products[1], self._products[2])

		item._txtnum.text = string.format("%s/%s", count, self._products[3] or 0)
		item._txtgold.text = tostring(costParam[3])

		UISpriteSetMgr.instance:setCurrencyItemSprite(item._imagegold, str)
		gohelper.setActive(item._go, true)

		if self._txtoriginalprice then
			local originalCost = self._decorateConfig["originalCost" .. curIndex]

			gohelper.setActive(self._txtoriginalprice, originalCost ~= nil and originalCost > 0)

			if originalCost then
				self._txtoriginalprice.text = tostring(originalCost)
			end
		end
	else
		logError("消耗货币数据出错")
	end
end

function DecorateMaterialBuyView:_getCostNum(costNum)
	local has, _, discount = DecorateStoreModel.instance:hasDiscountItem(self._goodsId)

	if discount then
		self._txtdiscounttips.text = string.format("-%s%%", discount * 0.1)

		return (has or nil) and (costNum * discount * 0.001 or costNum)
	end

	return costNum
end

function DecorateMaterialBuyView:_refreshLogo()
	local title, tag, isShowHeadBg

	if self._products[1] == MaterialEnum.MaterialType.Item then
		local info = DecorateEnum.DecorateUIParams[self._itemCo.subType]

		if info then
			title = info.Title
			tag = info.Tag
			isShowHeadBg = info.IsShowHeadBg
		end
	elseif self._products[1] == MaterialEnum.MaterialType.Building then
		title = "main_switch_classify_title_6"
	end

	if not string.nilorempty(title) then
		self._txtSceneLogo.text = luaLang(title)
	end

	gohelper.setActive(self._goSceneLogo, not string.nilorempty(title))

	if not string.nilorempty(tag) then
		self._txttag.text = luaLang(tag)
	end

	gohelper.setActive(self._gotag, not string.nilorempty(tag))
	gohelper.setActive(self._goheadiconbg, isShowHeadBg)
end

function DecorateMaterialBuyView:onClickModalMask()
	self:_closeFunc()
end

function DecorateMaterialBuyView:onClose()
	for _, item in ipairs(self._payItemTbList) do
		item._btnpay:RemoveClickListener()
	end
end

function DecorateMaterialBuyView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
	self._simageinfobg:UnLoadImage()
end

return DecorateMaterialBuyView
