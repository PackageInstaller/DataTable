-- chunkname: @modules/logic/sp02/paomian/shop/view/Sp02_PaoMian_ShopPanelView.lua

module("modules.logic.sp02.paomian.shop.view.Sp02_PaoMian_ShopPanelView", package.seeall)

local Sp02_PaoMian_ShopPanelView = class("Sp02_PaoMian_ShopPanelView", BaseView)

function Sp02_PaoMian_ShopPanelView:onInitView()
	self._goCardRoot = gohelper.findChild(self.viewGO, "root/#go_cardview")
	self._goSign = gohelper.findChild(self.viewGO, "root/#go_Sign")
	self._goSignList = gohelper.findChild(self.viewGO, "root/#go_Sign/#scroll_Sign/Viewport/#go_SignList")
	self._goSignItem = gohelper.findChild(self.viewGO, "root/#go_Sign/#scroll_Sign/Viewport/#go_SignList/#go_SignItem")
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_buy")
	self._goOwned = gohelper.findChild(self.viewGO, "root/#go_owned")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._txtTime = gohelper.findChildText(self.viewGO, "root/simage_title/time/#txt_Time")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._godiscount = gohelper.findChild(self.viewGO, "root/#btn_buy/#go_discount")
	self._txtdiscount = gohelper.findChildText(self.viewGO, "root/#btn_buy/#go_discount/#txt_discount")
	self._godiscount2 = gohelper.findChild(self.viewGO, "root/#btn_buy/#go_discount2")
	self._txtdiscount2 = gohelper.findChildText(self.viewGO, "root/#btn_buy/#go_discount2/#txt_discount")
	self._gosingle = gohelper.findChild(self.viewGO, "root/#btn_buy/cost/#go_single")
	self._imagesingleicon = gohelper.findChildImage(self.viewGO, "root/#btn_buy/cost/#go_single/icon/simage_material")
	self._txtcurprice = gohelper.findChildText(self.viewGO, "root/#btn_buy/cost/#go_single/txt_materialNum")
	self._txtoriginalprice = gohelper.findChildText(self.viewGO, "root/#btn_buy/cost/#go_single/#txt_original_price")
	self._godouble = gohelper.findChild(self.viewGO, "root/#btn_buy/cost/#go_doubleprice")
	self._imagedoubleicon1 = gohelper.findChildImage(self.viewGO, "root/#btn_buy/cost/#go_doubleprice/currency1/simage_material")
	self._txtcurprice1 = gohelper.findChildText(self.viewGO, "root/#btn_buy/cost/#go_doubleprice/currency1/txt_materialNum")
	self._txtoriginalprice1 = gohelper.findChildText(self.viewGO, "root/#btn_buy/cost/#go_doubleprice/currency1/#txt_original_price1")
	self._imagedoubleicon2 = gohelper.findChildImage(self.viewGO, "root/#btn_buy/cost/#go_doubleprice/currency2/simage_material")
	self._txtcurprice2 = gohelper.findChildText(self.viewGO, "root/#btn_buy/cost/#go_doubleprice/currency2/txt_materialNum")
	self._txtoriginalprice2 = gohelper.findChildText(self.viewGO, "root/#btn_buy/cost/#go_doubleprice/currency2/#txt_original_price1")
	self._gofree = gohelper.findChild(self.viewGO, "root/#btn_buy/cost/#go_free")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Sp02_PaoMian_ShopPanelView:addEvents()
	self._btnBuy:AddClickListener(self._btnBuyOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.refreshUI, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshUI, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.refreshUI, self)
end

function Sp02_PaoMian_ShopPanelView:removeEvents()
	self._btnBuy:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function Sp02_PaoMian_ShopPanelView:_btnBuyOnClick()
	local goodMo = StoreModel.instance:getGoodsMO(self._goodsId)

	StoreController.instance:openDecorateStoreGoodsView(goodMo)
end

function Sp02_PaoMian_ShopPanelView:_btnCloseOnClick()
	self:closeThis()
end

function Sp02_PaoMian_ShopPanelView:_editableInitView()
	return
end

function Sp02_PaoMian_ShopPanelView:onOpen()
	self._actId = self.viewParam and self.viewParam.actId
	self._goodsId = self.viewParam and self.viewParam.goodsId
	self._activityMo = ActivityModel.instance:getActMO(self._actId)
	self._activityCo = ActivityConfig.instance:getActivityCo(self._actId)
	self._goodsCo = StoreConfig.instance:getGoodsConfig(self._goodsId)
	self._decorateCo = DecorateStoreConfig.instance:getDecorateConfig(self._goodsId)
	self._goodItemCos = GameUtil.splitString2(self._goodsCo.product, true)

	self:refreshUI()
	self:initPlayerCard()
	AudioMgr.instance:trigger(AudioEnum3_10.PaoMian.EnterShopView)
end

function Sp02_PaoMian_ShopPanelView:refreshUI()
	self:refreshBuyBtn()
	self:refreshSignList()
	self:refreshEnterRemainTime()
	TaskDispatcher.cancelTask(self.refreshEnterRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshEnterRemainTime, self, 30)
end

function Sp02_PaoMian_ShopPanelView:refreshSignList()
	local signCoList = ActivityType101Config.instance:getDayCOs(self._actId) or {}

	gohelper.CreateObjList(self, self._refreshSignItem, signCoList, self._goSignList, self._goSignItem, Sp02_PaoMian_ShopSignItem)
end

function Sp02_PaoMian_ShopPanelView:_refreshSignItem(signItem, signCo, index)
	signItem:onUpdateMO(signCo, index)
end

function Sp02_PaoMian_ShopPanelView:refreshBuyBtn()
	gohelper.setActive(self._goOwned, false)
	gohelper.setActive(self._btnBuy.gameObject, false)

	if not self._goodsCo or not self._decorateCo then
		logError(string.format("商品数据或配置不存在 goodId = %s", self._goodsId))

		return
	end

	if not DecorateStoreModel.instance:isCanBuyGoods(self._goodsId) then
		gohelper.setActive(self._goOwned, true)

		return
	else
		gohelper.setActive(self._btnBuy.gameObject, true)
	end

	if self._decorateCo.offTag > 0 then
		if not self._decorateCo.offTag then
			local discount = 100
			local hasDiscount1 = discount > 0 and discount < 100

			if hasDiscount1 then
				self._txtdiscount.text = string.format("-%s%%", discount)
			end

			local offsetSecond = DecorateStoreModel.instance:getGoodItemLimitTime(self._goodsId)
			local discount2 = offsetSecond > 0 and DecorateStoreModel.instance:getGoodDiscount(self._goodsId) or 100

			discount2 = discount2 == 0 and 100 or discount2

			local hasDiscount = discount2 > 0 and discount2 < 100

			if hasDiscount then
				self._txtdiscount2.text = string.format("-%s%%", discount2)
			end

			gohelper.setActive(self._godiscount, hasDiscount1)
			gohelper.setActive(self._godiscount2, hasDiscount)

			if not self._goodsCo.cost or self._goodsCo.cost == "" then
				gohelper.setActive(self._gosingle, false)
				gohelper.setActive(self._godouble, false)
				gohelper.setActive(self._gofree, true)

				return
			end

			gohelper.setActive(self._gofree, false)

			local costs = string.splitToNumber(self._goodsCo.cost, "#")

			if self._goodsCo.cost2 ~= "" then
				gohelper.setActive(self._gosingle, false)
				gohelper.setActive(self._godouble, true)

				local priceCost1 = 0.01 * discount2 * costs[3]

				self._txtcurprice1.text = priceCost1

				if self._decorateCo.originalCost1 > 0 and self._decorateCo.originalCost1 ~= priceCost1 then
					gohelper.setActive(self._txtoriginalprice1.gameObject, true)

					self._txtoriginalprice1.text = self._decorateCo.originalCost1
				else
					gohelper.setActive(self._txtoriginalprice1.gameObject, false)
				end

				local costCo, _ = ItemModel.instance:getItemConfigAndIcon(costs[1], costs[2])

				UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagedoubleicon1, costCo.icon .. "_1", true)

				local cost2s = string.splitToNumber(self._goodsCo.cost2, "#")
				local priceCost2 = 0.01 * discount2 * cost2s[3]

				self._txtcurprice2.text = priceCost2

				if self._decorateCo.originalCost2 > 0 and self._decorateCo.originalCost2 ~= priceCost2 then
					gohelper.setActive(self._txtoriginalprice2.gameObject, true)

					self._txtoriginalprice2.text = self._decorateCo.originalCost2
				else
					gohelper.setActive(self._txtoriginalprice2.gameObject, false)
				end

				local cost2Co, _ = ItemModel.instance:getItemConfigAndIcon(cost2s[1], cost2s[2])

				UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagedoubleicon2, cost2Co.icon .. "_1", true)
			else
				gohelper.setActive(self._gosingle, true)
				gohelper.setActive(self._godouble, false)

				self._txtcurprice.text = 0.01 * discount2 * costs[3]

				if self._decorateCo.originalCost1 > 0 then
					gohelper.setActive(self._txtoriginalprice.gameObject, true)

					self._txtoriginalprice.text = self._decorateCo.originalCost1
				else
					gohelper.setActive(self._txtoriginalprice.gameObject, false)
				end

				local costCo, _ = ItemModel.instance:getItemConfigAndIcon(costs[1], costs[2])

				UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagesingleicon, costCo.icon .. "_1", true)
			end
		end
	end
end

function Sp02_PaoMian_ShopPanelView:refreshEnterRemainTime()
	self._txtTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function Sp02_PaoMian_ShopPanelView:initPlayerCard()
	local pathname = string.format("playercardview_%s", self._goodItemCos[1][2])

	self._cardPath = string.format("ui/viewres/player/playercard/%s.prefab", pathname)
	self._cardLoader = PrefabInstantiate.Create(self._goCardRoot)

	self._cardLoader:startLoad(self._cardPath, self._onCardLoadFinish, self)
end

function Sp02_PaoMian_ShopPanelView:_onCardLoadFinish(loader)
	self._cardViewGO = loader:getInstGO()
	self._cardView = MonoHelper.addNoUpdateLuaComOnceToGo(self._cardViewGO, Sp02_PaoMian_ShopCardView)
	self._cardView.viewParam = {
		userId = PlayerModel.instance:getPlayinfo().userId
	}
	self._cardView.viewContainer = self.viewContainer

	if self._decorateCo then
		self._cardView:onOpen(self._decorateCo, self._goodItemCos[1][2])
		self._cardView:backBottomView()
	end
end

function Sp02_PaoMian_ShopPanelView:onClose()
	TaskDispatcher.cancelTask(self.refreshEnterRemainTime, self)
end

function Sp02_PaoMian_ShopPanelView:onDestroyView()
	return
end

return Sp02_PaoMian_ShopPanelView
