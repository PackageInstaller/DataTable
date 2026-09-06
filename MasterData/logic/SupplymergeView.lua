-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/strength/view/SupplymergeView.lua

module("logic.extensions.strength.view.SupplymergeView", package.seeall)

local SupplymergeView = class("SupplymergeView", ViewComponent)

function SupplymergeView:ctor()
	SupplymergeView.super.ctor(self)
end

function SupplymergeView:unbindEvents()
	SupplymergeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnEat)
end

function SupplymergeView:bindEvents()
	SupplymergeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnEat, self._onClickEat, self)
end

function SupplymergeView:buildUI()
	SupplymergeView.super.buildUI(self)

	self._bubble = self:getGo("bubble")
	self._txtBubble = self:getTxt("bubble/text")
	self._txtTomorrow = self:getTxt("bubble/txtTomorrow")
	self._bubbleIcon = self:getGo("bubble/text/icon")
	self._food = self:getGo("food")
	self._mutil = self:getGo("btnEat/mutil")
	self._txtMulti = self:getTxt("btnEat/mutil/txtMulti")
	self._tableView = self:getGo("container/tableView")
	self._cell = self:getGo("container/cell")
	self._itemCellTop = self:getGo("container/topItem")
	self._itemCellDown = self:getGo("container/downItem")
	self._scrollList = ScrollerList.create(self._tableView, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnEat = self:getBtn("btnEat")
end

function SupplymergeView:onExit()
	SupplymergeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BasicBenefitsGetInfoRes, self._onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.BasicBenefitsGainStrengthPrizeRes, self._onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.BasicBenefitsCompensateRes, self._onRefreshList, self)
	self._scrollList:dispose()

	for k, v in pairs(self._tableViewUpMap) do
		v:dispose()
	end

	for k, v in pairs(self._tableViewDownMap) do
		v:dispose()
	end

	removetimer(self._updateSeveralSec, self)
end

function SupplymergeView:onEnter()
	SupplymergeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.BasicBenefitsGetInfoRes, self._onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.BasicBenefitsGainStrengthPrizeRes, self._onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.BasicBenefitsCompensateRes, self._onRefreshList, self)
	SupplymergeController.instance:sendBasicBenefitsGetInfoReq()

	self._tableViewUpMap = {}
	self._tableViewDownMap = {}
	self._dataList = SupplyConfig.instance:getBaseGiftList()
end

function SupplymergeView:_onRefreshUI()
	self._scrollList:reloadData(self._dataList)

	self._txtMulti.text = SupplyConfig.instance:getCommonValue("STRENGTH_TIMES_DESC")

	self:_updateSeveralSec()
	settimer(60, self._updateSeveralSec, self)
end

function SupplymergeView:_updateSeveralSec()
	self:_updateMulti()
	self:_onRefreshList()
end

function SupplymergeView:_onRefreshList()
	self._scrollList:refresh(self._dataList)
end

function SupplymergeView:_updateMulti()
	local isStrengthPrize = SupplymergeController.instance:isStrengthPrize()
	local pId = SupplyConfig.instance:getCommonValue("FREE_STRENGTH_TIME_PLAN_ID")
	local maxLimit = SupplyConfig.instance:getCommonValue("FREE_STRENGTH_MAX_LIMIT")
	local cfg = SupplyConfig.instance:getTimePlanCfg(pId)
	local isMulti = cfg and GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime)
	local tiliNum = 0

	tiliNum = isMulti and SupplyConfig.instance:getCommonValue("FREE_STRENGTH_REPLACE") * 3 or SupplyConfig.instance:getCommonValue("BUY_STRENGTH_GET_NUMBER") * 3

	local newhandDoubleValue = NewhandwelfareController.instance:getNewhandDoubleValue()

	tiliNum = tiliNum * (1 + newhandDoubleValue)
	tiliNum = Mathf.Min(tiliNum, maxLimit)

	local isNeedMutilTag = isMulti or newhandDoubleValue > 0

	self._txtBubble.text = string.format("%s", checkint(tiliNum))

	GameUtil.SetActive(self._food, isStrengthPrize)
	GameUtil.SetActive(self._btnEat, not isStrengthPrize)
	GameUtil.SetActive(self._bubbleIcon, not isStrengthPrize)
	GameUtil.SetActive(self._txtBubble, not isStrengthPrize)
	GameUtil.SetActive(self._txtTomorrow, isStrengthPrize)
	GameUtil.SetActive(self._mutil, isNeedMutilTag)
end

function SupplymergeView:_updateItemCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.setCellByCfg(data, item)
end

function SupplymergeView:_clearItemCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function SupplymergeView:_updateCell(view, cell, data, tag)
	local topTableView = goutil.findChild(cell, "vipTop/tableView")
	local downTableView = goutil.findChild(cell, "vipDown/tableView")
	local titleChange = goutil.findChild(cell, "imgTitle")
	local txtVipTitle = goutil.findChildTextComponent(cell, "vipDown/txtVipTitle")

	GameUtil.setUIImageSpriteIdx(titleChange, data.index)

	local itemStr = data.prize
	local vipLv = VipModel.instance:getCurVipLv()
	local cfg = SupplyConfig.instance:getGiftByVip(data.index, vipLv) or {}

	txtVipTitle.text = string.format("vip%s今日可领", vipLv)

	if self._tableViewUpMap[cell] == nil then
		self._tableViewUpMap[cell] = ScrollerList.create(topTableView, self._itemCellTop, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
	end

	if self._tableViewDownMap[cell] == nil then
		self._tableViewDownMap[cell] = ScrollerList.create(downTableView, self._itemCellDown, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
	end

	self._tableViewUpMap[cell]:reloadData(string.split(itemStr, "#"))
	self._tableViewDownMap[cell]:reloadData(string.split(cfg.prize or "", "#"))

	local btnGet = goutil.findChild(cell, "btnGet")
	local haveGot = goutil.findChild(cell, "haveGot")
	local btnSign = goutil.findChild(cell, "btnSign")
	local btnNotOpen = goutil.findChild(cell, "btnNotOpen")
	local btnTip = goutil.findChild(cell, "btnTip")
	local signIcon = goutil.findChild(btnSign, "icon")
	local txtCost = goutil.findChildTextComponent(btnSign, "txtCost")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local timeStart = data.startTime
	local timeEnd = data.endTime
	local timeStartStr = string.split(timeStart, ":")
	local timeEndStr = string.split(timeEnd, ":")

	txtTime.text = string.format("%s:%s-%s:%s可领", timeStartStr[1], timeStartStr[2], timeEndStr[1], timeEndStr[2])

	local state = SupplymergeController.instance:getTimeState(data.index)

	GameUtil.SetActive(btnNotOpen, state == 0)
	GameUtil.SetActive(btnGet, state == 1)
	GameUtil.SetActive(haveGot, SupplymergeModel.instance:getCellState(data.index))

	local matArr = string.split(data.cost, ":")

	MaterialMgr.setIcon(signIcon, checkint(matArr[1]), checkint(matArr[2]))

	txtCost.text = string.format("%02d", checkint(matArr[3]))

	GameUtil.SetActive(btnSign, state == 2)
	GameUtil.addClickHandler(btnNotOpen, self._onClickNotOpen, self)
	GameUtil.addClickHandler(btnGet, GameUtil.handler(function()
		self:_onClickGetIdx(data.index, state)
	end, self, data))
	GameUtil.addClickHandler(btnSign, GameUtil.handler(function()
		self:_onClickSign(data, state)
	end, self, data))
	GameUtil.addClickHandler(btnTip, GameUtil.handler(function()
		self:_onClickTip(data.index)
	end, self))
end

function SupplymergeView:_clearCell(cell)
	local btnGet = goutil.findChild(cell, "btnGet")
	local haveGot = goutil.findChild(cell, "haveGot")
	local btnSign = goutil.findChild(cell, "btnSign")
	local btnNotOpen = goutil.findChild(cell, "btnNotOpen")
	local btnTip = goutil.findChild(cell, "btnTip")
	local signIcon = goutil.findChild(btnSign, "icon")

	GameUtil.rmClickHandler(btnNotOpen)
	GameUtil.rmClickHandler(btnSign)
	GameUtil.rmClickHandler(btnGet)
	GameUtil.rmClickHandler(btnTip)
end

function SupplymergeView:_onClickEat()
	SupplymergeController.instance:sendQuickEatReq()
end

function SupplymergeView:_onClickTip(index)
	UIStateManager.instance:push(ViewName.SupplymergerewardView, index)
end

function SupplymergeView:_onClickNotOpen()
	FloatWordMgr.instance:show("时间未到")
end

function SupplymergeView:_onClickGetIdx(index, state)
	if state == 1 then
		SupplymergeController.instance:sendBasicBenefitsGainPrizeReq()
	end
end

function SupplymergeView:_onClickSign(data, state)
	if state == 2 then
		local cost = data.cost
		local matType, matId, matNum = MaterialMgr.getMatParams(cost)
		local matName = MaterialMgr.getMaterialsName(matType, matId)
		local content = langPara("是否花费%s%s进行补签", matNum, matName)

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
			SupplymergeController.instance:sendBasicBenefitsCompensateReq(data.index)
		end, nil, nil, nil, nil, false)
	end
end

return SupplymergeView
