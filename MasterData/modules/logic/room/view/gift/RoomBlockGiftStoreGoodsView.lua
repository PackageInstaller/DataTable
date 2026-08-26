-- chunkname: @modules/logic/room/view/gift/RoomBlockGiftStoreGoodsView.lua

module("modules.logic.room.view.gift.RoomBlockGiftStoreGoodsView", package.seeall)

local RoomBlockGiftStoreGoodsView = class("RoomBlockGiftStoreGoodsView", BaseView)

function RoomBlockGiftStoreGoodsView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "view/#simage_blur")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "view/bg/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "view/bg/#simage_leftbg")
	self._txtgoodsNameCn = gohelper.findChildText(self.viewGO, "view/common/title/#txt_goodsNameCn")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "view/common/#btn_buy")
	self._godiscount = gohelper.findChild(self.viewGO, "view/common/#btn_buy/#go_discount")
	self._txtdiscount = gohelper.findChildText(self.viewGO, "view/common/#btn_buy/#go_discount/#txt_discount")
	self._godiscount2 = gohelper.findChild(self.viewGO, "view/common/#btn_buy/#go_discount2")
	self._txtdiscount2 = gohelper.findChildText(self.viewGO, "view/common/#btn_buy/#go_discount2/#txt_discount")
	self._gocost = gohelper.findChild(self.viewGO, "view/common/cost")
	self._btncost1 = gohelper.findChildButtonWithAudio(self.viewGO, "view/common/cost/#btn_cost1")
	self._gounselect1 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost1/unselect")
	self._imageiconunselect1 = gohelper.findChildImage(self.viewGO, "view/common/cost/#btn_cost1/unselect/icon/simage_icon")
	self._txtcurpriceunselect1 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost1/unselect/txt_Num")
	self._txtoriginalpriceunselect1 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost1/unselect/#txt_original_price")
	self._goselect1 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost1/select")
	self._imageiconselect1 = gohelper.findChildImage(self.viewGO, "view/common/cost/#btn_cost1/select/icon/simage_icon")
	self._txtcurpriceselect1 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost1/select/txt_Num")
	self._txtoriginalpriceselect1 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost1/select/#txt_original_price")
	self._btncost2 = gohelper.findChildButtonWithAudio(self.viewGO, "view/common/cost/#btn_cost2")
	self._gounselect2 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost2/unselect")
	self._imageiconunselect2 = gohelper.findChildImage(self.viewGO, "view/common/cost/#btn_cost2/unselect/icon/simage_icon")
	self._txtcurpriceunselect2 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost2/unselect/txt_Num")
	self._txtoriginalpriceunselect2 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost2/unselect/#txt_original_price")
	self._goselect2 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost2/select")
	self._imageiconselect2 = gohelper.findChildImage(self.viewGO, "view/common/cost/#btn_cost2/select/icon/simage_icon")
	self._txtcurpriceselect2 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost2/select/txt_Num")
	self._txtoriginalpriceselect2 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost2/select/#txt_original_price")
	self._gocostsingle = gohelper.findChild(self.viewGO, "view/common/cost_single")
	self._imageiconsingle = gohelper.findChildImage(self.viewGO, "view/common/cost_single/simage_material")
	self._txtcurpricesingle = gohelper.findChildText(self.viewGO, "view/common/cost_single/#txt_materialNum")
	self._txtoriginalpricesingle = gohelper.findChildText(self.viewGO, "view/common/cost_single/#txt_price")
	self._gonormaldetail = gohelper.findChild(self.viewGO, "view/normal_detail")
	self._godetailremain = gohelper.findChild(self.viewGO, "view/normal_detail/remain")
	self._godetailleftbg = gohelper.findChild(self.viewGO, "view/normal_detail/remain/#go_leftbg")
	self._txtdetailleftremain = gohelper.findChildText(self.viewGO, "view/normal_detail/remain/#go_leftbg/#txt_remain")
	self._godetailrightbg = gohelper.findChild(self.viewGO, "view/normal_detail/remain/#go_rightbg")
	self._txtdetailrightremain = gohelper.findChildText(self.viewGO, "view/normal_detail/remain/#go_rightbg/#txt_remaintime")
	self._gonormaldetailinfo = gohelper.findChild(self.viewGO, "view/normal_detail/info")
	self._txtnormaldetailUseDesc = gohelper.findChildText(self.viewGO, "view/normal_detail/info/goodsDesc/Viewport/Content/#txt_goodsUseDesc")
	self._txtnormaldetaildesc = gohelper.findChildText(self.viewGO, "view/normal_detail/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "view/#btn_close")
	self._simagetype1 = gohelper.findChildSingleImage(self.viewGO, "view/right/type1/#simage_icon")
	self._gohadnumber = gohelper.findChild(self.viewGO, "view/right/type1/#go_hadnumber")
	self._txttype1num = gohelper.findChildText(self.viewGO, "view/right/type1/#go_hadnumber/#txt_hadnumber")
	self._btnicon = gohelper.findChildButtonWithAudio(self.viewGO, "view/right/#btn_click")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomBlockGiftStoreGoodsView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btncost1:AddClickListener(self._btncost1OnClick, self)
	self._btncost2:AddClickListener(self._btncost2OnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnicon:AddClickListener(self._btniconOnClick, self)
end

function RoomBlockGiftStoreGoodsView:removeEvents()
	self._btnbuy:RemoveClickListener()
	self._btncost1:RemoveClickListener()
	self._btncost2:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnicon:RemoveClickListener()
end

function RoomBlockGiftStoreGoodsView:_btncloseOnClick()
	self:closeThis()
end

function RoomBlockGiftStoreGoodsView:_btniconOnClick()
	local products = string.splitToNumber(self._goodConfig.product, "#")

	MaterialTipController.instance:showMaterialInfo(products[1], products[2])
end

function RoomBlockGiftStoreGoodsView:_btncost1OnClick()
	if self._curSelectCostIndex == 1 then
		return
	end

	self._curSelectCostIndex = 1

	self:_refreshCost()
end

function RoomBlockGiftStoreGoodsView:_btncost2OnClick()
	if self._curSelectCostIndex == 2 then
		return
	end

	self._curSelectCostIndex = 2

	self:_refreshCost()
end

function RoomBlockGiftStoreGoodsView:_btnbuyOnClick()
	local isFree = string.nilorempty(self._mo.config.cost) and string.nilorempty(self._mo.config.cost2)

	if isFree then
		self:_buyGood()

		return
	end

	if self._curSelectCostIndex == 1 then
		local costs = string.splitToNumber(self._mo.config.cost, "#")

		self._costType = costs[1]
		self._costId = costs[2]
		self._costQuantity = costs[3]
	else
		local cost2s = string.splitToNumber(self._mo.config.cost2, "#")

		self._costType = cost2s[1]
		self._costId = cost2s[2]
		self._costQuantity = cost2s[3]
	end

	if self._costType == MaterialEnum.MaterialType.Currency and self._costId == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		if CurrencyController.instance:checkFreeDiamondEnough(self._costQuantity, CurrencyEnum.PayDiamondExchangeSource.Store, nil, self._onDiamondEnoughBuyGood, self, self.closeThis, self) then
			self:_buyGood(self._curSelectCostIndex)
		end
	elseif self._costType == MaterialEnum.MaterialType.Currency and self._costId == CurrencyEnum.CurrencyType.Diamond then
		if CurrencyController.instance:checkDiamondEnough(self._costQuantity, self.closeThis, self) then
			self:_buyGood(self._curSelectCostIndex)
		end
	elseif self._costType == MaterialEnum.MaterialType.Currency and self._costId == CurrencyEnum.CurrencyType.OldTravelTicket then
		local currencyMo = CurrencyModel.instance:getCurrency(self._costId)

		if currencyMo then
			if currencyMo.quantity >= self._costQuantity then
				self:_buyGood(self._curSelectCostIndex)
			else
				GameFacade.showToast(ToastEnum.CurrencyNotEnough)

				return false
			end
		end
	elseif ItemModel.instance:goodsIsEnough(self._costType, self._costId, self._costQuantity) then
		self:_buyGood(self._curSelectCostIndex)
	else
		local config, icon = ItemModel.instance:getItemConfigAndIcon(self._costType, self._costId)

		if config then
			GameFacade.showToast(ToastEnum.ClickRoomStoreInsight, config.name)
		end
	end
end

function RoomBlockGiftStoreGoodsView:_onDiamondEnoughBuyGood()
	self:_buyGood(self._curSelectCostIndex)
end

function RoomBlockGiftStoreGoodsView:_storeCurrencyNotEnoughCallback()
	GameFacade.jump(JumpEnum.JumpId.GlowCharge)
end

function RoomBlockGiftStoreGoodsView:_buyGood(index)
	StoreController.instance:buyGoods(self._mo, 1, self._buyCallback, self, index)
end

function RoomBlockGiftStoreGoodsView:_buyCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		self:closeThis()
	end
end

function RoomBlockGiftStoreGoodsView:_editableInitView()
	gohelper.addUIClickAudio(self._btnbuy.gameObject, AudioEnum.UI.Store_Good_Click)

	self._curSelectCostIndex = 1

	gohelper.setActive(self._txtoriginalpriceunselect1.gameObject, false)
	gohelper.setActive(self._txtoriginalpriceselect1.gameObject, false)
	gohelper.setActive(self._txtoriginalpriceunselect2.gameObject, false)
	gohelper.setActive(self._txtoriginalpriceselect2.gameObject, false)
end

function RoomBlockGiftStoreGoodsView:_refreshUI()
	self._goodConfig = StoreConfig.instance:getGoodsConfig(self._mo.goodsId)

	self:_refreshIcon()
	self:_refreshGoodDetail()
	self:_refreshCost()
end

function RoomBlockGiftStoreGoodsView:_refreshIcon()
	local products = string.splitToNumber(self._goodConfig.product, "#")
	local _, icon = ItemModel.instance:getItemConfigAndIcon(products[1], products[2], true)
	local itemCount = ItemModel.instance:getItemCount(products[2])

	self._simagetype1:LoadImage(icon)

	self._txttype1num.text = itemCount
end

function RoomBlockGiftStoreGoodsView:_refreshGoodDetail()
	local items = string.splitToNumber(self._goodConfig.product, "#")
	local itemConfig = ItemModel.instance:getItemConfig(items[1], items[2])

	self._txtgoodsNameCn.text = self._mo.config.name
	self._txtnormaldetailUseDesc.text = itemConfig.useDesc
	self._txtnormaldetaildesc.text = itemConfig.desc

	local offlineTime = self._mo:getOfflineTime()

	if offlineTime > 0 then
		local limitSec = math.floor(offlineTime - ServerTime.now())

		gohelper.setActive(self._godetailrightbg, true)

		self._txtdetailrightremain.text = string.format("%s%s", TimeUtil.secondToRoughTime(limitSec))
	else
		gohelper.setActive(self._godetailrightbg, false)
	end

	if self._goodConfig.maxBuyCount and self._goodConfig.maxBuyCount > 0 then
		gohelper.setActive(self._godetailleftbg, true)

		local remain = self._goodConfig.maxBuyCount - self._mo.buyCount

		self._txtdetailleftremain.text = GameUtil.getSubPlaceholderLuaLang(luaLang("store_buylimit_count"), {
			remain
		})
	else
		gohelper.setActive(self._godetailleftbg, false)
	end

	gohelper.setActive(self._gonormaldetail, true)
end

function RoomBlockGiftStoreGoodsView:_refreshCost()
	gohelper.setActive(self._btncost1, not string.nilorempty(self._goodConfig.cost))
	gohelper.setActive(self._btncost2, not string.nilorempty(self._goodConfig.cost2))

	if string.nilorempty(self._goodConfig.cost) then
		gohelper.setActive(self._gocost, false)

		return
	end

	local costs = string.splitToNumber(self._mo.config.cost, "#")

	gohelper.setActive(self._gocost, true)

	if string.nilorempty(self._mo.config.cost2) then
		gohelper.setActive(self._gocost, false)
		gohelper.setActive(self._gocostsingle, true)

		local costCo, _ = ItemModel.instance:getItemConfigAndIcon(costs[1], costs[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconsingle, costCo.icon .. "_1", true)

		local hadQuantity = ItemModel.instance:getItemQuantity(costs[1], costs[2])

		if hadQuantity >= costs[3] then
			SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpricesingle, "#393939")
		else
			SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpricesingle, "#bf2e11")
		end

		self._txtcurpricesingle.text = costs[3]
	else
		gohelper.setActive(self._gocost, true)
		gohelper.setActive(self._gocostsingle, false)

		local costCo, _ = ItemModel.instance:getItemConfigAndIcon(costs[1], costs[2])

		self._txtcurpriceunselect1.text = costs[3]
		self._txtcurpriceselect1.text = costs[3]

		local hadQuantity = ItemModel.instance:getItemQuantity(costs[1], costs[2])

		if hadQuantity >= costs[3] then
			SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect1, "#393939")
			SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect1, "#ffffff")
		else
			SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect1, "#bf2e11")
			SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect1, "#bf2e11")
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconselect1, costCo.icon .. "_1", true)
		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconunselect1, costCo.icon .. "_1", true)
		gohelper.setActive(self._goselect1, self._curSelectCostIndex == 1)
		gohelper.setActive(self._gounselect1, self._curSelectCostIndex ~= 1)

		if string.nilorempty(self._goodConfig.cost2) then
			gohelper.setActive(self._txtoriginalpriceselect2.gameObject, false)
			gohelper.setActive(self._txtoriginalpriceunselect2.gameObject, false)

			return
		end

		local costs2 = string.splitToNumber(self._goodConfig.cost2, "#")
		local cost2Co, _ = ItemModel.instance:getItemConfigAndIcon(costs2[1], costs2[2])

		self._txtcurpriceunselect2.text = costs2[3]
		self._txtcurpriceselect2.text = costs2[3]

		local hadQuantity2 = ItemModel.instance:getItemQuantity(costs2[1], costs2[2])

		if hadQuantity2 >= costs2[3] then
			SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect2, "#393939")
			SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect2, "#ffffff")
		else
			SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect2, "#bf2e11")
			SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect2, "#bf2e11")
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconselect2, cost2Co.icon .. "_1", true)
		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconunselect2, cost2Co.icon .. "_1", true)
		gohelper.setActive(self._goselect2, self._curSelectCostIndex == 2)
		gohelper.setActive(self._gounselect2, self._curSelectCostIndex ~= 2)
	end
end

function RoomBlockGiftStoreGoodsView:onOpen()
	self._mo = self.viewParam

	self:_setCurrency()
	self:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)
end

function RoomBlockGiftStoreGoodsView:_setCurrency()
	local currencyParam = {}

	if self._mo.config.cost ~= "" then
		local costs = string.splitToNumber(self._mo.config.cost, "#")

		table.insert(currencyParam, costs[2])
	end

	if self._mo.config.cost2 ~= "" then
		local cost2s = string.splitToNumber(self._mo.config.cost2, "#")

		table.insert(currencyParam, cost2s[2])
	end

	for _, v in pairs(currencyParam) do
		if v == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			table.insert(currencyParam, CurrencyEnum.CurrencyType.Diamond)
		end
	end

	local result = LuaUtil.getReverseArrTab(currencyParam)

	self.viewContainer:setCurrencyType(result)
end

function RoomBlockGiftStoreGoodsView:onClose()
	return
end

function RoomBlockGiftStoreGoodsView:onUpdateParam()
	self._mo = self.viewParam

	self:_refreshUI()
end

function RoomBlockGiftStoreGoodsView:onDestroyView()
	self._simagetype1:UnLoadImage()
end

return RoomBlockGiftStoreGoodsView
