-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pricebreakdiscount/view/PriceBreakDiscountTrolleyView.lua

module("logic.extensions.pricebreakdiscount.view.PriceBreakDiscountTrolleyView", package.seeall)

local PriceBreakDiscountTrolleyView = class("PriceBreakDiscountTrolleyView", ViewComponent)

function PriceBreakDiscountTrolleyView:buildUI()
	PriceBreakDiscountTrolleyView.super.buildUI(self)

	self._customInput = UICustomInput.Get(self:getGo("content"))
	self._btnClose = self:getBtn("content/btnClose")
	self._btnClear = self:getBtn("content/btnClear")
	self._btnPay = self:getBtn("content/btnPay")
	self._txtEmptyTips = self:getGo("content/txtEmpty")
	self._tableview = self:getGo("content/tableview")
	self._tableCell = self:getGo("content/tableCell")
end

function PriceBreakDiscountTrolleyView:bindEvents()
	PriceBreakDiscountTrolleyView.super.buildUI(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnClear, self._onClickClear, self)
	GameUtil.addClickHandler(self._btnPay, self._onClickClose, self)
end

function PriceBreakDiscountTrolleyView:unbindEvents()
	PriceBreakDiscountTrolleyView.super.unbindEvents(self)
	self._customInput:RemoveListener()
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnClear)
	GameUtil.rmClickHandler(self._btnPay)
end

function PriceBreakDiscountTrolleyView:onEnter()
	PriceBreakDiscountTrolleyView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._activityCfg = PriceBreakDiscountConfig.instance:getActivityCfg(self._activityId)
	self._itemCfg = PriceBreakDiscountConfig.instance:getItemsCfg(self._activityCfg.itemPlan)
	self._costType, self._costId, _ = MaterialMgr.getMatParams(self._activityCfg.costKey)
	self._itemTable = ScrollerList.create(self._tableview, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self:_refreshView()
end

function PriceBreakDiscountTrolleyView:onExit()
	PriceBreakDiscountTrolleyView.super.onExit(self)
	self._itemTable:dispose()
	PriceBreakDiscountController.instance:sendPM_PriceBreakDiscountSaveCartReq(self._activityId)
end

function PriceBreakDiscountTrolleyView:_refreshView()
	self._trolley = PriceBreakDiscountModel.instance:getTrolley()
	self._buyRecord = PriceBreakDiscountModel.instance:getBuyRecord()

	local list = {}

	for i, v in pairs(self._trolley) do
		if v > 0 then
			table.insert(list, i)
		end
	end

	table.sort(list, function(a, b)
		return a < b
	end)
	self._itemTable:reloadData(list)
	GameUtil.SetActive(self._txtEmptyTips, #list <= 0)
end

function PriceBreakDiscountTrolleyView:_updateCell(view, cell, id, tag)
	local go = cell.gameObject
	local itemGo = goutil.findChild(go, "itemCon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local priceIcon = goutil.findChild(go, "priceIcon")
	local priceIcon2 = goutil.findChild(go, "priceIcon2")
	local txtPrice = goutil.findChildTextComponent(go, "txtPrice")
	local txtTotalPrice = goutil.findChildTextComponent(go, "txtTotalPrice")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local btnReduce = GameUtil.asBtn(goutil.findChild(go, "btnReduce"))
	local btnAddGo = goutil.findChild(go, "btnAdd")
	local btnAdd = GameUtil.asBtn(btnAddGo)
	local addFalseGo = goutil.findChild(go, "btnAdd/imgAddFalse")
	local itemCfg = PriceBreakDiscountConfig.instance:getItemCfg(self._activityCfg.itemPlan, id)

	MaterialMgr.setCellByCfg(itemCfg.prize, itemGo)
	MaterialMgr.setIcon(priceIcon, self._costType, self._costId)
	MaterialMgr.setIcon(priceIcon2, self._costType, self._costId)

	txtName.text = MaterialMgr.getMaterialsNameByCfg(itemCfg.prize)
	txtPrice.text = itemCfg.cost
	txtNum.text = self._trolley[id]
	txtTotalPrice.text = itemCfg.cost * self._trolley[id]

	btnAdd:RemoveClickListener()
	btnAdd:AddClickListener(function()
		self:_onClickAdd(id)
	end, self)
	btnReduce:RemoveClickListener()
	btnReduce:AddClickListener(function()
		self:_onClickReduce(id)
	end, self)

	if checknumber(self._trolley[id]) + checknumber(self._buyRecord[id]) < self._itemCfg[id].personLimit then
		uGuiUtil.setImageGrayState(btnAddGo, false)
	else
		uGuiUtil.setImageGrayState(btnAddGo, true)
	end
end

function PriceBreakDiscountTrolleyView:_clearCell(cell)
	local go = cell.gameObject
	local itemGo = goutil.findChild(go, "itemCon")
	local priceIcon = goutil.findChild(go, "priceIcon")
	local priceIcon2 = goutil.findChild(go, "priceIcon2")
	local btnAdd = GameUtil.asBtn(goutil.findChild(go, "btnAdd"))
	local btnReduce = GameUtil.asBtn(goutil.findChild(go, "btnReduce"))

	MaterialMgr.resetAll(itemGo)
	MaterialMgr.clearIcon(priceIcon)
	MaterialMgr.clearIcon(priceIcon2)
	btnAdd:RemoveClickListener()
	btnReduce:RemoveClickListener()
end

function PriceBreakDiscountTrolleyView:_onCustomInputCallback(hover)
	if not hover then
		self:_onClickClose()
	end
end

function PriceBreakDiscountTrolleyView:_onClickClose(id)
	self:close()
end

function PriceBreakDiscountTrolleyView:_onClickClear()
	PriceBreakDiscountModel.instance:clearTrolley()
	self:_refreshView()
end

function PriceBreakDiscountTrolleyView:_onClickAdd(id)
	if checknumber(self._trolley[id]) + checknumber(self._buyRecord[id]) < self._itemCfg[id].personLimit then
		self._trolley[id] = checknumber(self._trolley[id]) + 1

		self._itemTable:refresh()
	else
		FloatWordMgr.instance:show(lang("已达到最大限购数量"))
	end
end

function PriceBreakDiscountTrolleyView:_onClickReduce(id)
	if checknumber(self._trolley[id]) > 1 then
		self._trolley[id] = checknumber(self._trolley[id]) - 1

		self._itemTable:refresh()
	else
		self._trolley[id] = nil

		self:_refreshView()
	end
end

return PriceBreakDiscountTrolleyView
