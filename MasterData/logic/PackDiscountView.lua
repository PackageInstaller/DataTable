-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/packdiscount/view/PackDiscountView.lua

module("logic.extensions.packdiscount.view.PackDiscountView", package.seeall)

local PackDiscountView = class("PackDiscountView", ViewComponent)

function PackDiscountView:ctor()
	PackDiscountView.super.ctor(self)
end

function PackDiscountView:unbindEvents()
	PackDiscountView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBuy)
	GameUtil.rmClickHandler(self._btnPack)
end

function PackDiscountView:bindEvents()
	PackDiscountView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
	GameUtil.addClickHandler(self._btnPack, self._onClickPack, self)
end

function PackDiscountView:buildUI()
	PackDiscountView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("btnBuy")
	self._txtBuyPrice = self:getTxt("btnBuy/txtPrice")
	self._btnPack = self:getBtn("btnPack")
	self._txtPackPrice = self:getTxt("btnPack/txtPrice")
	self._btnCell = self:getGo("btnCell")
	self._tableviewGo = self:getGo("tableview")
	self._tableView = ScrollerList.create(self._tableviewGo, self._btnCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._goodsGroup = self:getGo("goods"):GetComponent(ComponentType.UILayoutSingleLine)
	self._goodsItems = {}
	self._goodsCount = 3

	for i = 1, self._goodsCount do
		local goods = {}

		goods.go = self:getGo("goods/cell_" .. i)
		goods.item = self:getGo("goods/cell_" .. i .. "/item")

		table.insert(self._goodsItems, goods)
	end

	self._txtTime = self:getTxt("time/txtTime")
end

function PackDiscountView:onExit()
	PackDiscountView.super.onExit(self)
	self._tableView:dispose()
	removetimer(self._timerCountDown, self)
end

function PackDiscountView:onEnter()
	PackDiscountView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.PackDiscount)

	self.addGEvent(self, GlobalNotify.PackDiscountGetInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.PackDiscountNotifyPaySucRes, self._sendGetInfoReq, self)

	self._discountItemCfg = PackDiscountConfig.instance:getDiscountItemCfg(self._activityId)

	self._tableView:reloadData(self._discountItemCfg)

	self._curSelectItemId = self._discountItemCfg[1].itemId
	self._isBuyPack = PackDiscountController.instance:isBuyPack()
	self._isBuySingleItem = PackDiscountController.instance:isBuySingleItem()

	self:_onClickCell(self._curSelectItemId)
	settimer(1, self._timerCountDown, self)

	self._packCfg = PackDiscountConfig.instance:getDiscountPackCfg(self._activityId)

	local packPrice = PayConfig.instance:getPayMoneyYuan(self._packCfg.packGoodsId)

	self._txtPackPrice.text = string.format("%d元<size=30>打包</size>", packPrice)

	self:_sendGetInfoReq()
end

function PackDiscountView:_timerCountDown()
	local startTimeStamp, endTimeStamp = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.PackDiscount, self._activityId)
	local time = endTimeStamp - ServerTime.nowServerLook()
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(time)

	self._txtTime.text = time > 0 and string.format("剩余时间：%s", GameUtil.FormatTimeWords(time)) or "活动已结束"
end

function PackDiscountView:_sendGetInfoReq()
	PackDiscountController.instance:sendPM_PackDiscountGetInfoReq(self._activityId)
end

function PackDiscountView:_refresh()
	self._isBuyPack = PackDiscountController.instance:isBuyPack()
	self._isBuySingleItem = PackDiscountController.instance:isBuySingleItem()
	self._isBuyItem = PackDiscountController.instance:isBuyItem(self._curSelectItemId)

	self:_onClickCell(self._curSelectItemId)
	uGuiUtil.setGoGrayState(self._btnPack, self._isBuyPack or self._isBuySingleItem)
end

function PackDiscountView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local select = goutil.findChild(cell, "select")
	local txtSelectName = goutil.findChildTextComponent(cell, "select/txtName")
	local price = PayConfig.instance:getPayMoneyYuan(data.packGoodsId)

	txtName.text = string.format("%d元豪礼", price)
	txtSelectName.text = string.format("%d元<size=24>豪礼</size>", price)

	GameUtil.SetActive(select, self._curSelectItemId == data.itemId)
	GameUtil.SetActive(txtName.gameObject, self._curSelectItemId ~= data.itemId)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCell, self, data.itemId))
end

function PackDiscountView:_clearCell(cell)
	return
end

function PackDiscountView:_onClickCell(itemId)
	local cfg = PackDiscountConfig.instance:getDiscountItemCfgById(itemId)
	local price = PayConfig.instance:getPayMoneyYuan(cfg.packGoodsId)

	self._txtBuyPrice.text = string.format("%d元", price)

	local itemStr = string.split(cfg.content, "#")
	local contentCount = #itemStr

	if contentCount < self._goodsCount then
		for i = contentCount + 1, self._goodsCount do
			GameUtil.SetActive(self._goodsItems[i].go, false)
		end
	end

	for i = 1, contentCount do
		MaterialMgr.setCellByCfg(itemStr[i], self._goodsItems[i].item)
	end

	self._goodsGroup:Layout()

	self._curSelectItemId = itemId
	self._isBuyItem = PackDiscountController.instance:isBuyItem(itemId)

	uGuiUtil.setGoGrayState(self._btnBuy, self._isBuyPack or self._isBuyItem)
	self._tableView:refresh()
end

function PackDiscountView:_onClickBuy()
	if self._isBuyPack or self._isBuyItem then
		FloatWordMgr.instance:show("礼包已购买哦~")

		return
	end

	local cfg = PackDiscountConfig.instance:getDiscountItemCfgById(self._curSelectItemId)
	local para = {}

	para.it = cfg.itemId

	local goodsId = cfg.packGoodsId
	local subGoodsType = GameEnum.PaySubGoodsType.PACKDISCOUNT
	local subGoodsId = self._activityId
	local extParams = GameUtil.jsonToString(para)

	PayController.instance:pay(goodsId, subGoodsType, subGoodsId, extParams)
end

function PackDiscountView:_onClickPack()
	if self._isBuyPack or self._isBuySingleItem then
		FloatWordMgr.instance:show("不满足打包购买条件哦~")

		return
	end

	local para = {}

	para.it = -1

	local goodsId = self._packCfg.packGoodsId
	local subGoodsType = GameEnum.PaySubGoodsType.PACKDISCOUNT
	local subGoodsId = self._activityId
	local extParams = GameUtil.jsonToString(para)

	PayController.instance:pay(goodsId, subGoodsType, subGoodsId, extParams)
end

return PackDiscountView
