-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pricebreakdiscount/view/femalegod/FemaleGodShopMainView.lua

module("logic.extensions.femalegod.view.FemaleGodShopMainView", package.seeall)

local FemaleGodShopMainView = class("FemaleGodShopMainView", PriceBreakDiscountMainView)

function FemaleGodShopMainView:buildUI()
	FemaleGodShopMainView.super.buildUI(self)

	self._inputComp = self:getInput("searchpart/search")
	self._btnClear = self:getBtn("searchpart/btnClear")
end

function FemaleGodShopMainView:bindEvents()
	FemaleGodShopMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClear, self._onClickbtnClear, self)
	self._inputComp:AddOnValueChanged(self._inputValueChanged, self)
end

function FemaleGodShopMainView:unbindEvents()
	FemaleGodShopMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClear)
	self._inputComp:RemoveOnValueChanged()
end

function FemaleGodShopMainView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.PriceBreakDiscountGetInfo, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PriceBreakDiscountBuy, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PriceBreakDiscountSaveCart, self._refreshView, self)

	self._actType = GameEnum.ActivityType.PriceBreakDiscount

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = PriceBreakDiscountModel.instance:getCurrActId()
	end

	self._tabId = 1
	self._activityCfg = PriceBreakDiscountConfig.instance:getActivityCfg(self._activityId)
	self._discountCfg = PriceBreakDiscountConfig.instance:getDiscountList(self._activityCfg.discPlan)
	self._itemTable = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._costType, self._costId, _ = MaterialMgr.getMatParams(self._activityCfg.costKey)
	self._costName = MaterialMgr.getMaterialsNameByCfg(self._activityCfg.costKey)
	self._price = 0

	local maxDiscount = 0

	for i, v in ipairs(self._discountCfg) do
		if maxDiscount < v.cutPrice then
			maxDiscount = v.cutPrice
		end
	end

	MaterialMgr.setIcon(self._payIconCon, self._costType, self._costId)
	uGuiUtil.setSpriteToImage(self._petCon, nil, GameUrl.getBigbgFolderUrl("pricebreakdiscount", "board_manjian_02"))

	self._targetTime = 0

	local timeCfg = ActivityDefineConfig.instance:getCfgById(self._actType, self._activityId)

	self._targetTime = GameUtil.string2time(timeCfg.endTime)

	self:_onTimeClock()

	if self._goldbarCon then
		self:_setTopGoldBar()
	end

	settimer(1, self._onTimeClock, self, true)
	PriceBreakDiscountAgent.instance:sendPM_PriceBreakDiscountGetInfoReq(self._activityCfg.activityId)
end

function FemaleGodShopMainView:_updateUI()
	local searchItemCfg = self:_filterBySearchText(self._itemShowCfg)

	self._itemTable:reloadData(searchItemCfg)
end

function FemaleGodShopMainView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.PriceBreakDiscountGetInfo, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PriceBreakDiscountBuy, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PriceBreakDiscountSaveCart, self._refreshView, self)
	removetimer(self._onTimeClock, self)
	MaterialMgr.clearIcon(self._payIconCon)
	uGuiUtil.clearImage(self._petCon)
	self._itemTable:dispose()
	PriceBreakDiscountController.instance:sendPM_PriceBreakDiscountSaveCartReq(self._activityCfg.activityId)
end

function FemaleGodShopMainView:onExitFinished()
	if self._itemPools then
		self._itemPools:clear()

		self._itemPools = nil
	end
end

function FemaleGodShopMainView:_refreshView()
	self._tabCfg = PriceBreakDiscountConfig.instance:getTabCfg(self._activityCfg.itemPlan)
	self._itemCfg = PriceBreakDiscountConfig.instance:getItemsCfg(self._activityCfg.itemPlan)
	self._itemShowCfg = PriceBreakDiscountConfig.instance:getItemByTab(self._activityCfg.itemPlan, self._tabId)
	self._trolley = PriceBreakDiscountModel.instance:getTrolley()
	self._buyRecord = PriceBreakDiscountModel.instance:getBuyRecord()

	local dataList = {}
	local lastList = {}

	for i, v in ipairs(self._itemShowCfg) do
		if checknumber(self._buyRecord[v.itemId]) >= v.personLimit then
			table.insert(lastList, v)
		else
			table.insert(dataList, v)
		end
	end

	for i, v in ipairs(lastList) do
		table.insert(dataList, v)
	end

	self:_updateUI()
	self:_refreshPriceInfo()
end

function FemaleGodShopMainView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(goutil.findChild(go, "btnAdd"))
	local payIcon = goutil.findChild(go, "btnAdd/Text/payIcon")
	local itemGo = goutil.findChild(go, "itemGo")
	local txtPrice = goutil.findChildTextComponent(go, "btnAdd/Text")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtLimit = goutil.findChildTextComponent(go, "txtLimit")
	local sellOutGo = goutil.findChild(go, "selloutGo")
	local tagChange = goutil.findChildComponent(go, "imgState", "UIImageSpriteChange")

	MaterialMgr.setIcon(payIcon, self._costType, self._costId)
	MaterialMgr.setCellByCfg(data.prize, itemGo)

	txtName.text = MaterialMgr.getMaterialsNameByCfg(data.prize)
	txtPrice.text = data.cost
	txtLimit.text = langPara("限购次数：%d/%d", self._itemCfg[data.itemId].personLimit - checknumber(self._buyRecord[data.itemId]) - checknumber(self._trolley[data.itemId]), self._itemCfg[data.itemId].personLimit)

	GameUtil.SetActive(sellOutGo, checknumber(self._buyRecord[data.itemId]) >= self._itemCfg[data.itemId].personLimit)

	if not string.nilorempty(data.tag) then
		GameUtil.SetActive(tagChange, true)
	else
		GameUtil.SetActive(tagChange, false)
	end

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self:_onClickAdd(go, data.prize, data.itemId)
	end)
end

function FemaleGodShopMainView:_clearCell(cell)
	local go = cell.gameObject
	local itemGo = goutil.findChild(go, "itemGo")
	local payIcon = goutil.findChild(go, "btnAdd/Text/payIcon")
	local btn = GameUtil.asBtn(goutil.findChild(go, "btnAdd"))

	btn:RemoveClickListener()
	MaterialMgr.clearIcon(payIcon)
	MaterialMgr.resetAll(itemGo)
end

function FemaleGodShopMainView:_onClickbtnClear()
	self._inputComp:SetText("")
end

function FemaleGodShopMainView:_inputValueChanged(text)
	if self._inputComp:GetText() == self._lastInputTxt then
		return
	end

	self._lastInputTxt = text

	self:_updateUI()
end

function FemaleGodShopMainView:_filterBySearchText(dataList)
	local filterDataList = {}
	local text = self._inputComp:GetText()

	if string.nilorempty(text) then
		return dataList
	end

	for i, cfg in ipairs(dataList) do
		if string.find(cfg.name, text) then
			table.insert(filterDataList, cfg)
		end
	end

	return filterDataList
end

function FemaleGodShopMainView:_onClickBuy()
	if self._price == 0 then
		FloatWordMgr.instance:show("请选择商品")

		return
	end

	local isExpendMoneyActivity = FemaleGodController.instance:isExpendMoneyActivity(self._activityId)

	if isExpendMoneyActivity then
		FemaleGodController.instance:showCostTipType(self._activityId, self._activityCfg.costKey, self._price, "购买吗？", function()
			local hasEnoughMoney = FemaleGodController.instance:hasEnoughMoney(self._activityId, self._price, self._activityCfg.costKey)

			if hasEnoughMoney then
				PriceBreakDiscountController.instance:sendPM_PriceBreakDiscountBuyReq(self._activityCfg.activityId)
			else
				FloatWordMgr.instance:show(langPara("%s不足", self._costName))
			end
		end)
	elseif self._price > MaterialMgr.getMatCount(self._activityCfg.costKey) then
		FloatWordMgr.instance:show(langPara("%s不足", self._costName))
	else
		TipsFacade.instance:openPopupCostMatViewNew(self._costType, self._costId, self._price, langPara("确定花费%d%s购买购物车所有商品吗？", self._price, self._costName), GameUtil.handler(function()
			PriceBreakDiscountController.instance:sendPM_PriceBreakDiscountBuyReq(self._activityCfg.activityId)
		end, self))
	end
end

return FemaleGodShopMainView
