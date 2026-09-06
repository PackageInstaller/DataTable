-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportwpextbuyView.lua

module("logic.extensions.passport.view.PassportwpextbuyView", package.seeall)

local PassportwpextbuyView = class("PassportwpextbuyView", ViewComponent)

function PassportwpextbuyView:ctor()
	PassportwpextbuyView.super.ctor(self)
end

function PassportwpextbuyView:unbindEvents()
	PassportwpextbuyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PassportwpextbuyView:bindEvents()
	PassportwpextbuyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i, v in ipairs(self._btnList) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickBtn, self, i))
	end
end

function PassportwpextbuyView:buildUI()
	PassportwpextbuyView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._cell = self:getGo("cell")
	self._prizeList = {}
	self._sclList = {}
	self._sclExtList = {}
	self._btnList = {}
	self._tipsList = {}

	for i = 1, 3 do
		local prizeCell = self:getGo("container/prize_" .. i)
		local tableView = self:getGo("container/prize_" .. i .. "/tableView")
		local tableView2 = self:getGo("container/prize_" .. i .. "/tableView2")
		local btn = self:getGo("container/prize_" .. i .. "/btn")

		table.insert(self._btnList, btn)

		local tip = self:getGo("container/prize_" .. i .. "/tip")

		table.insert(self._tipsList, tip)

		local scrollList = ScrollerList.create(tableView, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
		local scrollList2 = ScrollerList.create(tableView2, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

		table.insert(self._sclList, scrollList)
		table.insert(self._sclExtList, scrollList2)
		table.insert(self._prizeList, prizeCell)
	end
end

function PassportwpextbuyView:onExit()
	PassportwpextbuyView.super.onExit(self)

	for i, v in ipairs(self._sclList) do
		v:dispose()
	end

	for i, v in ipairs(self._sclExtList) do
		v:dispose()
	end
end

function PassportwpextbuyView:onEnter()
	PassportwpextbuyView.super.onEnter(self)
	self:_refreshView()

	self._passPortFuncId = 1

	self.addGEvent(self, GlobalNotify.PassportStateUpdate, self._refreshView, self)
	PassportController.instance:sendGetInfoReq(self._passPortFuncId)
end

function PassportwpextbuyView:_refreshView()
	self._curData = PassportModel.instance:getInfo(self._passPortFuncId)

	if self._curData then
		GameUtil.SetActive(self._prizeList[1], true)
		GameUtil.SetActive(self._prizeList[2], true)
		GameUtil.SetActive(self._prizeList[3], true)

		if self._curData.hasPay then
			GameUtil.SetActive(self._prizeList[1], false)
		end

		if self._curData.hasPayAdd then
			GameUtil.SetActive(self._prizeList[2], false)
		end

		if self._curData.hasPayThird then
			GameUtil.SetActive(self._prizeList[3], false)
		end

		self:_refreshPayBtn(self._prizeList[1], self._curData.actCfg.goodsId)
		self:_refreshPayBtn(self._prizeList[2], self._curData.actCfg.additonalGoodsId)
		self:_refreshPayBtn(self._prizeList[3], self._curData.actCfg.thirdGoodsId)
		self:_checkAndShowTip(self._tipsList[1], self._curData.actCfg.ordinaryBuyStartTime)
		self:_checkAndShowTip(self._tipsList[2], self._curData.actCfg.additionalBuyStartTime)
		self:_checkAndShowTip(self._tipsList[3], self._curData.actCfg.thirdBuyStartTime)
		self:_refreshAllPrize(self._curData.actCfg.actId)
	end
end

function PassportwpextbuyView:_refreshAllPrize(actId)
	local map = PassportConfig.instance:getPassportPeriodProgressByActId(actId) or {}
	local list_11 = {}
	local list_12 = {}
	local list_21 = {}
	local list_22 = {}
	local list_31 = {}
	local list_32 = {}
	local info = PassportModel.instance:getInfo(self._passPortFuncId) or {}

	for k, v in pairs(map) do
		table.insert(list_11, v.payedPrize)
		table.insert(list_21, v.additionalPaymentPrize)
		table.insert(list_31, v.thirdPaymentPrize)

		if checknumber(v.thresholdParam) <= checknumber(info.progress) then
			table.insert(list_12, v.payedPrize)
			table.insert(list_22, v.additionalPaymentPrize)
			table.insert(list_32, v.thirdPaymentPrize)
		end
	end

	local list = MaterialMgr.combineItemsToList(list_11)

	self._sclList[1]:reloadData(list)
	self:setScrollPos(self._sclList[1], list)

	local list = MaterialMgr.combineItemsToList(list_12)

	self._sclExtList[1]:reloadData(list)
	self:setScrollPos(self._sclExtList[1], list)

	local list = MaterialMgr.combineItemsToList(list_21)

	self._sclList[2]:reloadData(list)
	self:setScrollPos(self._sclList[2], list)

	local list = MaterialMgr.combineItemsToList(list_22)

	self._sclExtList[2]:reloadData(list)
	self:setScrollPos(self._sclExtList[2], list)

	local list = MaterialMgr.combineItemsToList(list_31)

	self._sclList[3]:reloadData(list)
	self:setScrollPos(self._sclList[3], list)

	local list = MaterialMgr.combineItemsToList(list_32)

	self._sclExtList[3]:reloadData(list)
	self:setScrollPos(self._sclExtList[3], list)
end

function PassportwpextbuyView:setScrollPos(sList, dataList)
	local rect = sList:GetScrollRect()

	if rect and dataList then
		local num = #dataList
		local x, y, z = Framework.TransformUtil.GetAnchoredPos(rect.gameObject.transform, 0, 0)

		if num == 1 then
			rect.enabled = false

			GameUtil.setAnchoredPos(rect, 16, y)
		elseif num == 2 then
			rect.enabled = false

			GameUtil.setAnchoredPos(rect, -24, y)
		else
			rect.enabled = true

			GameUtil.setAnchoredPos(rect, -38, y)
		end
	end
end

function PassportwpextbuyView:_refreshPayBtn(go, goodId)
	local payNum = PayConfig.instance:getPayMoneyYuan(goodId)
	local txtPay = goutil.findChildTextComponent(go, "btn/Text")

	txtPay.text = langPara("￥%s", payNum)
end

function PassportwpextbuyView:_clearCell(cellGo)
	local cell = {}

	cell.item = goutil.findChild(cellGo, "item")

	MaterialMgr.resetAll(cell.item)

	return cell
end

function PassportwpextbuyView:_updateCell(view, cellGo, data)
	local cell = self:_clearCell(cellGo)

	MaterialMgr.setCellByCfg(data, cell.item)
end

function PassportwpextbuyView:_onClickBtn(idx)
	local timeNow = ServerTime.now()

	if idx == 1 then
		self:checkAndBuy(self._curData.actCfg.ordinaryBuyStartTime, PassportModel.ORDINARY_PAYMENT_PRIZE_TYPE)
	elseif idx == 2 then
		self:checkAndBuy(self._curData.actCfg.additionalBuyStartTime, PassportModel.ADDITIONAL_PAYMENT_PRIZE_TYPE)
	elseif idx == 3 then
		self:checkAndBuy(self._curData.actCfg.thirdBuyStartTime, PassportModel.THIRD_PAYMENT_PRIZE_TYPE)
	end

	self:close()
end

function PassportwpextbuyView:checkAndBuy(time, type)
	if not string.nilorempty(time) then
		local timeNow = ServerTime.now()
		local timeStamp = GameUtil.string2time(time)

		if timeNow < timeStamp then
			local date = GameUtil.time2date(timeStamp)

			TipsFacade.instance:openCommonTips(langPara("%s.%s开启售卖", date.month, date.day))
		else
			PassportController.instance:buyPassportByPayType(self._curData.actCfg.actId, type)
		end
	else
		PassportController.instance:buyPassportByPayType(self._curData.actCfg.actId, type)
	end
end

function PassportwpextbuyView:_checkAndShowTip(tipGo, time)
	goutil.setActive(tipGo, false)

	if not string.nilorempty(time) then
		local timeNow = ServerTime.now()
		local timeStamp = GameUtil.string2time(time)

		if timeNow < timeStamp then
			local date = GameUtil.time2date(timeStamp)
			local txt = goutil.findChildTextComponent(tipGo, "txt")

			txt.text = langPara("%s.%s开启售卖", date.month, date.day)

			goutil.setActive(tipGo, true)
		end
	end
end

return PassportwpextbuyView
