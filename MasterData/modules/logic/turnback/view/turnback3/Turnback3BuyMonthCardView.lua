-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3BuyMonthCardView.lua

module("modules.logic.turnback.view.turnback3.Turnback3BuyMonthCardView", package.seeall)

local Turnback3BuyMonthCardView = class("Turnback3BuyMonthCardView", BaseView)

function Turnback3BuyMonthCardView:onInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/#txt_desc")
	self._btnyes = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_yes")
	self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_no")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "root/yueka/#simage_icon")
	self._goyueka = gohelper.findChild(self.viewGO, "root/yueka")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/yueka/#txt_num")
	self._txtprice = gohelper.findChildText(self.viewGO, "root/yueka/pricebg/#txt_price")
	self._btnmonthcard = gohelper.findChildButtonWithAudio(self.viewGO, "root/yueka/#btn_monthcard")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback3BuyMonthCardView:addEvents()
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
	self._btnmonthcard:AddClickListener(self._btnmonthcardOnClick, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.MonthCardInfoChanged, self.succbuymonthcard, self)
end

function Turnback3BuyMonthCardView:removeEvents()
	self._btnyes:RemoveClickListener()
	self._btnno:RemoveClickListener()
	self._btnmonthcard:RemoveClickListener()
end

function Turnback3BuyMonthCardView:_btnyesOnClick()
	GameFacade.jump(JumpEnum.JumpId.ChargeView)
end

function Turnback3BuyMonthCardView:_btnnoOnClick()
	self:closeThis()
end

function Turnback3BuyMonthCardView:_editableInitView()
	return
end

function Turnback3BuyMonthCardView:_btnmonthcardOnClick()
	local storePackageMo = StoreModel.instance:getGoodsMO(StoreEnum.MonthCardGoodsId)

	StoreController.instance:openPackageStoreGoodsView(storePackageMo)
end

function Turnback3BuyMonthCardView:succbuymonthcard()
	if TurnbackModel.instance:checkHasGetAllTaskReward() then
		ViewMgr.instance:openView(ViewName.Turnback3BuyBpTipView)
	else
		ViewMgr.instance:openView(ViewName.Turnback3BuyBpView)
	end

	self:closeThis()
end

function Turnback3BuyMonthCardView:onOpen()
	self._turnbackId = TurnbackModel.instance:getCurTurnbackId()
	self._config = TurnbackConfig.instance:getTurnbackCo(self._turnbackId)

	local havenum = CurrencyModel.instance:getDiamond()
	local temp = not string.nilorempty(self._config.buyDoubleBonusPrice) and string.splitToNumber(self._config.buyDoubleBonusPrice, "#")
	local price = temp and temp[3]
	local needNum = price - havenum

	self._txtdesc.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("Turnback3BuyMonthCardView_Tip"), price, needNum)

	local haveMonthCard = StoreModel.instance:hasPurchaseMonthCard()

	self._txtprice.text = PayModel.instance:getProductPrice(StoreEnum.MonthCardGoodsId)

	gohelper.setActive(self._goyueka, not haveMonthCard)
end

function Turnback3BuyMonthCardView:onClose()
	return
end

function Turnback3BuyMonthCardView:onDestroyView()
	return
end

return Turnback3BuyMonthCardView
