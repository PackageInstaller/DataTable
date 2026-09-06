-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityshop/view/XinxiyapurchaseView.lua

module("logic.extensions.activityshop.view.XinxiyapurchaseView", package.seeall)

local XinxiyapurchaseView = class("XinxiyapurchaseView", ViewComponent)

function XinxiyapurchaseView:ctor()
	XinxiyapurchaseView.super.ctor(self)
end

function XinxiyapurchaseView:unbindEvents()
	XinxiyapurchaseView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBuy)
	GameUtil.rmClickHandler(self._btnBuyAll)

	for id, btn in ipairs(self._btnGifts) do
		GameUtil.rmClickHandler(btn.go)
	end
end

function XinxiyapurchaseView:bindEvents()
	XinxiyapurchaseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
	GameUtil.addClickHandler(self._btnBuyAll, self._onClickBuyAll, self)

	for id, btn in ipairs(self._btnGifts) do
		GameUtil.addClickHandler(btn.go, GameUtil.handler(self._onClickGift, self, id), self)
	end
end

function XinxiyapurchaseView:buildUI()
	XinxiyapurchaseView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("btnBuy")
	self._btnBuyAll = self:getBtn("btnBuyAll")
	self._txtTime = self:getTxt("txtTime")
	self._txtPrice = self:getTxt("btnBuy/txtPrice")
	self._txtAllPrice = self:getTxt("btnBuyAll/txtPrice")
	self._btnGifts = {}

	for i = 1, 3 do
		local btn = {}

		btn.go = self:getBtn("btnGift_" .. i)
		btn.txt = goutil.findChildTextComponent(btn.go, "txt")

		table.insert(self._btnGifts, btn)
	end

	self._items = {}

	for i = 1, 3 do
		local item = self:getGo("items/item" .. i)

		table.insert(self._items, item)
	end
end

function XinxiyapurchaseView:onExit()
	XinxiyapurchaseView.super.onExit(self)

	for _, v in ipairs(self._items) do
		MaterialMgr.resetAll(v)
	end

	removetimer(self._countDown, self)
	GlobalDispatcher:removeListener(PayTrussAgent.PM_PayTrussNotifyPaySucRes, self._onGetPayTrussInfo, self)
	GlobalDispatcher:removeListener(PayTrussAgent.PM_PayTrussGetInfoRes, self._onRefreshUI, self)
end

function XinxiyapurchaseView:onEnter()
	XinxiyapurchaseView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DressActivityShop)
	self._dressCfgs = DressActivityShopConfig.instance:getSingleCfgByActId(self._activityId)

	if not self:_isInTime() then
		FloatWordMgr.instance.show("不在活动时间内哦~")
		self:close()

		return
	end

	self:_setTimeUI()

	self._curData = {}
	self._curSelectId = 1

	self:_onClickGift(self._curSelectId)

	for id, cfg in ipairs(self._dressCfgs) do
		local price = PayConfig.instance:getPayMoneyYuan(cfg.payGoodsId)

		self._btnGifts[id].txt.text = string.format("%d元秒杀", price)
	end

	GlobalDispatcher:addListener(PayTrussAgent.PM_PayTrussNotifyPaySucRes, self._onGetPayTrussInfo, self)
	GlobalDispatcher:addListener(PayTrussAgent.PM_PayTrussGetInfoRes, self._onRefreshUI, self)
	self:_onGetPayTrussInfo()
end

function XinxiyapurchaseView:_onGetPayTrussInfo()
	PayTrussController.instance:_sendReqGetPayTrussInfo(self._activityId)
end

function XinxiyapurchaseView:_onRefreshUI()
	local hasPurchasedIds = PayTrussModel.instance:_getPayTrussInfoFormModel()
	local suitCfg = DressActivityShopConfig.instance:getSuitCfgByActIdAndHasOwnTab(self._activityId, hasPurchasedIds)
	local isHasBuy = table.indexof(hasPurchasedIds, self._curData.cfg.id) ~= false

	if suitCfg == nil then
		uGuiUtil.setGoGrayState(self._btnBuyAll, true)
	else
		uGuiUtil.setGoGrayState(self._btnBuyAll, false)

		local price = PayConfig.instance:getPayMoneyYuan(suitCfg.payGoodsId)

		self._txtAllPrice.text = string.format("%d元全买", price)
	end

	if isHasBuy then
		uGuiUtil.setGoGrayState(self._btnBuy, true)
	else
		uGuiUtil.setGoGrayState(self._btnBuy, false)
	end
end

function XinxiyapurchaseView:_isInTime()
	return (ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.DressActivityShop, self._activityId))
end

function XinxiyapurchaseView:_setTimeUI()
	self._timeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.DressActivityShop, self._activityId)
	self._endTime = GameUtil.string2time(self._timeCfg.endTime)

	if self:_isInTime() then
		settimer(1, self._countDown, self, true)
		self:_countDown()
	end
end

function XinxiyapurchaseView:_countDown()
	local time = self._endTime - ServerTime.nowServerLook()
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(time)

	if time > 0 then
		self._txtTime.text = string.format("秒杀倒计时：%d天%d时%d分%d秒", day, hour, min, sec)
	else
		self._txtTime.text = "活动已结束！"

		removetimer(self._countDown, self)
	end
end

function XinxiyapurchaseView:_onClickGift(id)
	self._curSelectId = id

	local cfg = self._dressCfgs[id]
	local price = PayConfig.instance:getPayMoneyYuan(cfg.payGoodsId)

	self._txtPrice.text = string.format("%d元秒杀", price)

	local gifContents = string.split(cfg.giftContent, "#")

	for id, gift in ipairs(gifContents) do
		MaterialMgr.setCellByCfg(gift, self._items[id])
	end

	self._curData.price = price
	self._curData.cfg = cfg

	self:_onRefreshUI()
end

function XinxiyapurchaseView:_onClickBuy()
	local hasPurchasedIds = PayTrussModel.instance:_getPayTrussInfoFormModel()
	local isHasBuy = table.indexof(hasPurchasedIds, self._curData.cfg.id) ~= false

	if isHasBuy == true then
		FloatWordMgr.instance:show(lang("text_buy_you_have_purchased"))

		return
	end

	local tips = string.format("确定购买该%s元购买该礼包吗？", self._curData.price)

	local function okFunc()
		local para = {}

		para.id = self._curData.cfg.id

		local goodsId = self._curData.cfg.payGoodsId
		local subGoodsType = GameEnum.PaySubGoodsType.DRESSACTIVITY
		local subGoodsId = self._activityId
		local extParams = GameUtil.jsonToString(para)

		PayController.instance:pay(goodsId, subGoodsType, subGoodsId, extParams)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow(lang("text_buy_tips"), tips, okFunc, cencelFunc, lang("confirm"), lang("cancel"), nil)
end

function XinxiyapurchaseView:_onClickBuyAll()
	local hasPurchasedIds = PayTrussModel.instance:_getPayTrussInfoFormModel()
	local suitCfg = DressActivityShopConfig.instance:getSuitCfgByActIdAndHasOwnTab(self._activityId, hasPurchasedIds)

	if suitCfg == nil then
		FloatWordMgr.instance:show(lang("text_buy_you_have_purchased"))

		return
	end

	local para = {}

	para.id = -1

	local price = PayConfig.instance:getPayMoneyYuan(suitCfg.payGoodsId)
	local tips = string.format("确定购买该%s元购买该礼包吗？", price)

	local function okFunc()
		local goodsId = suitCfg.payGoodsId
		local subGoodsType = GameEnum.PaySubGoodsType.DRESSACTIVITY
		local subGoodsId = self._activityId
		local extParams = GameUtil.jsonToString(para)

		PayController.instance:pay(goodsId, subGoodsType, subGoodsId, extParams)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow(lang("text_buy_tips"), tips, okFunc, cencelFunc, lang("confirm"), lang("cancel"), nil)
end

return XinxiyapurchaseView
