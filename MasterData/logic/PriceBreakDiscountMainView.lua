-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pricebreakdiscount/view/PriceBreakDiscountMainView.lua

module("logic.extensions.pricebreakdiscount.view.PriceBreakDiscountMainView", package.seeall)

local PriceBreakDiscountMainView = class("PriceBreakDiscountMainView", ViewComponent)

function PriceBreakDiscountMainView:buildUI()
	PriceBreakDiscountMainView.super.buildUI(self)

	self._btnTrolley = self:getBtn("btnTrolley")
	self._trolleyOffset = GameUtil.getAnchoredPos(self._btnTrolley)
	self._btnClose = self:getBtn("btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._btnBuy = self:getBtn("btnBuy")
	self._txtTime = self:getTxt("time/txt")
	self._petCon = self:getGo("petIcon")
	self._goldbarCon = self:getGo("goldBar")
	self._tableview = self:getGo("tableview")
	self._tableContent = self:getGo("tableview/Nego_Viewport/Nego_Content")
	self._tablecell = self:getGo("tableCell")
	self._tabTableView = self:getGo("ScrollView")
	self._tabTableCell = self:getGo("BtnCell")

	local tableOffset = GameUtil.getAnchoredPos(self._tableview)
	local tableItemCon = self:getGo("tableCell/itemGo")
	local itemOffset = GameUtil.getAnchoredPos(tableItemCon)

	self._itemOffset = tableOffset + itemOffset
	self._txtPrePrize = self:getTxt("txtPrePrize")
	self._txtNowPrize = self:getTxt("txtNowPrize")
	self._txtDisCountTip = self:getTxt("txtDisCountTip")
	self._payIconCon = self:getGo("txtNowPrize/payIcon")
	self._itemMoveContent = self:getGo("itemMoveContent")
	self._itemMoveCell = self:getGo("itemMoveCell")
end

function PriceBreakDiscountMainView:bindEvents()
	PriceBreakDiscountMainView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnTrolley, self._onClickTrolley, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
end

function PriceBreakDiscountMainView:unbindEvents()
	PriceBreakDiscountMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTrolley)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnBuy)
end

function PriceBreakDiscountMainView:onEnter()
	PriceBreakDiscountMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PriceBreakDiscountGetInfo, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PriceBreakDiscountBuy, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PriceBreakDiscountSaveCart, self._refreshView, self)

	self._actType = GameEnum.ActivityType.PriceBreakDiscount
	self._activityCfg = PriceBreakDiscountConfig.instance:getActivityCfg(PriceBreakDiscountModel.instance:getCurrActId())

	local params = self:getOpenParam()

	self._tabId = params and (params[1] or 1) or checknumber(self._tabId) > 0 and self._tabId or 1
	self._discountCfg = PriceBreakDiscountConfig.instance:getDiscountList(self._activityCfg.discPlan)
	self._itemTable = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tabTable = ScrollerList.create(self._tabTableView, self._tabTableCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
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

	local timeCfg = ActivityDefineConfig.instance:getCfgById(self._actType, self._activityCfg.activityId)

	self._targetTime = GameUtil.string2time(timeCfg.endTime)

	self:_onTimeClock()

	if self._goldbarCon then
		self:_setTopGoldBar()
	end

	settimer(1, self._onTimeClock, self, true)
	PriceBreakDiscountAgent.instance:sendPM_PriceBreakDiscountGetInfoReq(self._activityCfg.activityId)
end

function PriceBreakDiscountMainView:onExit()
	PriceBreakDiscountMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PriceBreakDiscountGetInfo, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PriceBreakDiscountBuy, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PriceBreakDiscountSaveCart, self._refreshView, self)
	removetimer(self._onTimeClock, self)
	MaterialMgr.clearIcon(self._payIconCon)
	uGuiUtil.clearImage(self._petCon)
	self._itemTable:dispose()
	self._tabTable:dispose()
	PriceBreakDiscountController.instance:sendPM_PriceBreakDiscountSaveCartReq(self._activityCfg.activityId)
end

function PriceBreakDiscountMainView:onExitFinished()
	if self._itemPools then
		self._itemPools:clear()

		self._itemPools = nil
	end
end

function PriceBreakDiscountMainView:_refreshView()
	self._tabCfg = PriceBreakDiscountConfig.instance:getTabCfg(self._activityCfg.itemPlan)

	self._tabTable:reloadData(self._tabCfg)

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

	self._itemTable:reloadData(dataList)
	self:_refreshPriceInfo()
end

function PriceBreakDiscountMainView:_refreshPriceInfo()
	self._price = 0

	local totalPrice = 0

	for i, v in pairs(self._trolley) do
		local cfg = PriceBreakDiscountConfig.instance:getItemCfg(self._activityCfg.itemPlan, i)

		totalPrice = totalPrice + cfg.cost * v
	end

	local discountPrice = 0
	local nextDiscountPrice = 0
	local nextFullPrice = 0

	for i, v in ipairs(self._discountCfg) do
		if totalPrice >= v.fullPrice then
			discountPrice = v.cutPrice
		else
			nextFullPrice = v.fullPrice
			nextDiscountPrice = v.cutPrice

			break
		end
	end

	self._price = totalPrice - discountPrice
	self._txtNowPrize.text = self._price
	self._txtPrePrize.text = totalPrice
	self._txtDisCountTip.text = langPara("再买%d%s可减%d%s", nextFullPrice - totalPrice, self._costName, nextDiscountPrice, self._costName)

	GameUtil.SetActive(self._txtPrePrize, discountPrice > 0)
	GameUtil.SetActive(self._txtDisCountTip, nextDiscountPrice > 0)
end

function PriceBreakDiscountMainView:_updateCell(view, cell, data, tag)
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

function PriceBreakDiscountMainView:_clearCell(cell)
	local go = cell.gameObject
	local itemGo = goutil.findChild(go, "itemGo")
	local payIcon = goutil.findChild(go, "btnAdd/Text/payIcon")
	local btn = GameUtil.asBtn(goutil.findChild(go, "btnAdd"))

	btn:RemoveClickListener()
	MaterialMgr.clearIcon(payIcon)
	MaterialMgr.resetAll(itemGo)
end

function PriceBreakDiscountMainView:_updateTabCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgBg = goutil.findChildComponent(go, "imgBg", "UIImageSpriteChange")
	local tagBg = goutil.findChildComponent(go, "tag", "UIImageSpriteChange")
	local txtTag = goutil.findChildTextComponent(go, "tag/Text")
	local txtName = goutil.findChildTextComponent(go, "text")
	local txtColor = goutil.findChildComponent(go, "text", "UITextColorChange")
	local btn = GameUtil.asBtn(go)

	txtName.text = data.name

	if not string.nilorempty(data.tag) then
		GameUtil.SetActive(tagBg, true)
		tagBg:SetState(1)

		txtTag.text = data.tag
	else
		GameUtil.SetActive(tagBg, false)
	end

	if data.tabId == self._tabId then
		imgBg:SetState(1)
		txtColor:SetState(1)
	else
		imgBg:SetState(0)
		txtColor:SetState(0)
	end

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self._tabId = data.tabId

		self:_refreshView()
	end)
end

function PriceBreakDiscountMainView:_clearTabCell(cell)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(goutil.findChild(go, "click"))

	btn:RemoveClickListener()
end

function PriceBreakDiscountMainView:_onClickAdd(go, prizeStr, id)
	if checknumber(self._trolley[id]) + checknumber(self._buyRecord[id]) < self._itemCfg[id].personLimit then
		local moveItem = self:_getMoveItem(self._itemCfg[id].prize)
		local cellOffset = GameUtil.getAnchoredPos(go) + GameUtil.getAnchoredPos(self._tableContent)
		local totalOffset = cellOffset + self._itemOffset

		UnityTweens.TweenScale.StartTween(moveItem, Vector3.New(1, 1, 1), Vector3.New(0, 0, 0), 1)

		local tween = UnityTweens.TweenPosition.StartTween(moveItem, Vector3.New(totalOffset.x, totalOffset.y, 0), Vector3.New(self._trolleyOffset.x, self._trolleyOffset.y, 0), 1, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.Anchor)

		tween:RemoveListener()
		tween:AddListener(function()
			GameUtil.SetActive(moveItem.gameObject, false)

			if self._itemPools then
				self._itemPools:returnObject(moveItem)
			end
		end)

		self._trolley[id] = checknumber(self._trolley[id]) + 1

		self._itemTable:refresh()
		self:_refreshPriceInfo()
	else
		FloatWordMgr.instance:show(lang("已达到最大限购数量"))
	end
end

function PriceBreakDiscountMainView:_onClickTrolley()
	UIStateManager.instance:push(ViewName.PriceBreakDiscountTrolleyView, self._activityCfg.activityId)
end

function PriceBreakDiscountMainView:_onClickClose()
	self:close()
end

function PriceBreakDiscountMainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, self._activityCfg.ruleKey)
end

function PriceBreakDiscountMainView:_onClickBuy()
	if self._price > MaterialMgr.getMatCount(self._activityCfg.costKey) then
		FloatWordMgr.instance:show(langPara("%s不足", self._costName))
	else
		TipsFacade.instance:openPopupCostMatViewNew(self._costType, self._costId, self._price, langPara("确定花费%d%s购买购物车所有商品吗？", self._price, self._costName), GameUtil.handler(function()
			PriceBreakDiscountController.instance:sendPM_PriceBreakDiscountBuyReq(self._activityCfg.activityId)
		end, self))
	end
end

function PriceBreakDiscountMainView:_onTimeClock()
	self._txtTime.text = langPara("活动时间：剩余%s", GameUtil.FormatTimeWords(self._targetTime - ServerTime.now()))
end

function PriceBreakDiscountMainView:_getMoveItem(str)
	function resetFunc(obj)
		self:_resetItemFunc(obj)
	end

	function disposeFunc(obj)
		self:_disposeItemFunc(obj)
	end

	self._itemPools = self._itemPools or ObjectPool.New(8, nil, disposeFunc, resetFunc)

	local cellObj

	if self._itemPools then
		cellObj = self._itemPools:fetchObject()
	end

	if not cellObj then
		cellObj = goutil.cloneAndSetParent(self._itemMoveCell, self._itemMoveContent.gameObject.transform)

		GameUtil.SetActive(cellObj, false)
	end

	MaterialMgr.resetAll(cellObj)
	MaterialMgr.setCellByCfg(str, cellObj)
	GameUtil.SetActive(cellObj, true)

	return cellObj
end

function PriceBreakDiscountMainView:_disposeItemFunc(obj)
	GameUtil.SetActive(obj.gameObject, false)
	MaterialMgr.resetAll(obj.gameObject)
	goutil.destroy(obj.gameObject)
end

function PriceBreakDiscountMainView:_resetItemFunc(obj)
	GameUtil.SetActive(obj.gameObject, false)
	MaterialMgr.resetAll(obj.gameObject)
end

function PriceBreakDiscountMainView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = true,
		id = self._activityCfg.costKey
	})
	MainUIController.instance:showGlodBar(self._goldbarCon, self._viewPresentor, btn_list, true)
end

return PriceBreakDiscountMainView
