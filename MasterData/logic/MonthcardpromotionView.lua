-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/MonthcardpromotionView.lua

module("logic.extensions.monthcard.view.MonthcardpromotionView", package.seeall)

local MonthcardpromotionView = class("MonthcardpromotionView", MonthcardView)

function MonthcardpromotionView:ctor()
	MonthcardpromotionView.super.ctor(self)
end

function MonthcardpromotionView:unbindEvents()
	MonthcardpromotionView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnPackBuy)
end

function MonthcardpromotionView:bindEvents()
	MonthcardpromotionView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnPackBuy, self._onClickPackBuy, self)
end

function MonthcardpromotionView:buildUI()
	MonthcardpromotionView.super.buildUI(self)

	self._btnPackBuy = self:getBtn("card/packBuy/btnPackBuy")
	self._soldout = self:getGo("card/packBuy/soldout")
end

function MonthcardpromotionView:onExit()
	MonthcardpromotionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMonthCardPackInfo, self._onMonthCardPackInfo, self)
	GlobalDispatcher:removeListener(PayController.NotifyPayResultRes, self._onNotifyPayResultRes, self)
end

function MonthcardpromotionView:onEnter()
	MonthcardpromotionView.super.onEnter(self)
	MonthCardPackController.instance:checkCurrActivity()

	self._currActivetyId = MonthCardPackModel.instance:getActivityId()

	if self._currActivetyId == 0 then
		FloatWordMgr.instance:show("活动已结束")
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.OnMonthCardPackInfo, self._onMonthCardPackInfo, self)
	GlobalDispatcher:addListener(PayController.NotifyPayResultRes, self._onNotifyPayResultRes, self)
	MonthCardPackController.instance:requestMonthCardPackGetInfo(self._currActivetyId)
end

function MonthcardpromotionView:_getCardId()
	return MonthCardModel.MonthCardId2022
end

function MonthcardpromotionView:_onMonthCardPackInfo()
	local remainTime = MonthCardPackModel.instance:getRemainTimes()

	if remainTime == 0 then
		GameUtil.SetActive(self._soldout, true)
		uGuiUtil.setGoGrayState(self._btnPackBuy, true)
	else
		GameUtil.SetActive(self._soldout, false)
		uGuiUtil.setGoGrayState(self._btnPackBuy, false)
	end
end

function MonthcardpromotionView:_onNotifyPayResultRes()
	MonthCardPackController.instance:requestMonthCardPackGetInfo(self._currActivetyId)
end

function MonthcardpromotionView:_onClickPackBuy()
	local acCo = MonthCardPackConfig.instance:getActivityCo(self._currActivetyId)
	local remainTime = MonthCardPackModel.instance:getRemainTimes()

	if not acCo then
		return
	end

	if remainTime == 0 then
		FloatWordMgr.instance:show("您已购买！")

		return
	end

	local price = PayConfig.instance:getPayMoneyYuan(acCo.payGoodsId)
	local tips = string.format("确定购买该%s元购买该礼包吗？", price)

	local function okFunc()
		PayController.instance:pay(acCo.payGoodsId, GameEnum.PaySubGoodsType.MONTH_CARD_PACK, self._currActivetyId)
	end

	TipsFacade.instance:openPopupWindow(lang("text_buy_tips"), tips, okFunc, cencelFunc, lang("confirm"), lang("cancel"), nil)
end

return MonthcardpromotionView
