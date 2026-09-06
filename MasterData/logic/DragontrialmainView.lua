-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontrialmainView.lua

module("logic.extensions.dragontrial.view.DragontrialmainView", package.seeall)

local DragontrialmainView = class("DragontrialmainView", TableViewComponent)

DragontrialmainView.TabEnum = {
	DailyTask = 2,
	DevelopTask = 3,
	Battle = 1
}

local TabConfigs = {
	[DragontrialmainView.TabEnum.Battle] = {
		id = DragontrialmainView.TabEnum.Battle,
		viewName = ViewName.DragontrialView
	},
	[DragontrialmainView.TabEnum.DailyTask] = {
		id = DragontrialmainView.TabEnum.DailyTask,
		viewName = ViewName.DragontraildaytaskView
	},
	[DragontrialmainView.TabEnum.DevelopTask] = {
		id = DragontrialmainView.TabEnum.DevelopTask,
		viewName = ViewName.DragontraildeveloptaskView
	}
}

function DragontrialmainView:ctor()
	DragontrialmainView.super.ctor(self)
end

function DragontrialmainView:unbindEvents()
	DragontrialmainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnShop:RemoveClickListener()
end

function DragontrialmainView:bindEvents()
	DragontrialmainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnShop:AddClickListener(self._onClickbtnShop, self)
end

function DragontrialmainView:buildUI()
	DragontrialmainView.super.buildUI(self)

	self._containerGo = self:getGo("container")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnShop = self:getBtn("btnShop")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txt")
	self._goldBarConGo = self:getGo("goldBarCon")
	self._rateGo = self:getGo("btnShop/rate")
	self._txtRate = goutil.findChildTextComponent(self.mainGO, "btnShop/rate/txtRate")
	self._redPointGo = self:getGo("btnShop/redPoint")

	goutil.setActive(self._rateGo, false)
end

function DragontrialmainView:onExit()
	DragontrialmainView.super.onExit(self)
	removetimer(self._updateTimer, self)
	GlobalDispatcher:removeListener(DragontrialController.PM_DragonTrialGetInfoRes, self._PM_DragonTrialGetInfoRes, self)
	GlobalDispatcher:removeListener(DragontrialController.PM_DragonTrialGainCultivateTaskPrizeRes, self._checkRedDot, self)
	GlobalDispatcher:removeListener(DragontrialController.PM_DragonTrialGainDailyTaskPrizeRes, self._checkRedDot, self)
	GlobalDispatcher:removeListener(DragontrialController.PM_DragonTrialValidatePetStrengthenRes, self._checkRedDot, self)
	GlobalDispatcher:removeListener(DragontrialController.ForceSelectMainViewTab, self._forceSelectMainViewTab, self)
end

function DragontrialmainView:onEnter()
	DragontrialmainView.super.onEnter(self)
	DragontrialModel.instance:clearDailyDot()

	self._activityId = DragontrialModel.instance:getCurrActivityId()

	GlobalDispatcher:addListener(DragontrialController.PM_DragonTrialGetInfoRes, self._PM_DragonTrialGetInfoRes, self)
	GlobalDispatcher:addListener(DragontrialController.PM_DragonTrialGainCultivateTaskPrizeRes, self._checkRedDot, self)
	GlobalDispatcher:addListener(DragontrialController.PM_DragonTrialGainDailyTaskPrizeRes, self._checkRedDot, self)
	GlobalDispatcher:addListener(DragontrialController.PM_DragonTrialValidatePetStrengthenRes, self._checkRedDot, self)
	GlobalDispatcher:addListener(DragontrialController.ForceSelectMainViewTab, self._forceSelectMainViewTab, self)

	if self._activityId > 0 then
		DragonTrialAgent.instance:sendPM_DragonTrialGetInfoReq(self._activityId)
	else
		printError("检查下配置 是不是没有对应的活动")
	end

	self._redDotList = {}

	self:_setTabs()
	self:_setActLeftTime()
	self:_setDiscTag()
	self:_setTopGoldBar()
	self:_checkShopDot()
end

function DragontrialmainView:_onClickbtnClose()
	self:close()
end

function DragontrialmainView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("dragontrialmain")
end

function DragontrialmainView:_onClickbtnShop()
	DragontrialModel.instance:clearExchangeShopRedPoint()
	ActivityshopController.instance:openExchangeView(GameEnum.ActivityType.DragonTrial, self._activityId)
end

function DragontrialmainView:_getPath()
	return {
		cellPath = "btnCell",
		viewPath = "tableview"
	}
end

function DragontrialmainView:_updateCell(view, cell, data)
	local goImgPoint = goutil.findChild(cell.gameObject, "imgPoint")
	local goSelected = goutil.findChild(cell.gameObject, "selected")
	local btnSelect = Framework.ButtonAdapter.Get(cell.gameObject)
	local uiChange = cell.gameObject:GetComponent(ComponentType.UIImageSpriteChange)
	local redPoint = self:_getRedPoint(data.id)

	self._redDotList[data.id] = goImgPoint

	goutil.setActive(goSelected, self._currTabId == data.id)
	goutil.setActive(goImgPoint, redPoint)
	uiChange:SetState(data.id - 1)
	btnSelect:AddClickListener(function()
		self:_onClickTab(data.id)
	end)
end

function DragontrialmainView:_clearTableview(cell)
	return
end

function DragontrialmainView:_setTabs()
	self._curViewDatas = TabConfigs
	self._currTabId = self._currTabId or DragontrialmainView.TabEnum.Battle

	self:_onClickTab(self._currTabId, true)
end

function DragontrialmainView:_onClickTab(tabId, force)
	if self._currTabId == tabId and not force then
		return
	end

	self._currTabId = tabId

	self:reloadData()
	self:_updateView()
end

function DragontrialmainView:_updateView()
	local tabCfg = self._curViewDatas[self._currTabId]

	self:showTabAt(self._containerGo, tabCfg.viewName)
end

function DragontrialmainView:_setActLeftTime()
	self._destTime = DragontrialModel.instance:getActEndTime()

	if self._destTime > 0 then
		settimer(1, self._updateTimer, self, true)
		self:_updateTimer()
	else
		self:_actEndOp()
	end
end

function DragontrialmainView:_updateTimer()
	self._leftTime = self._destTime - ServerTime.nowServerLook()

	if self._leftTime > 0 then
		self._txtTime.text = self._leftTime > 86400 and string.format("时间剩余：%s", GameUtil.FormatTimeWordsNoSec(self._leftTime)) or string.format("时间剩余：%s", GameUtil.FormatTimeWords(self._leftTime))
	else
		self:_actEndOp()
	end
end

function DragontrialmainView:_actEndOp()
	self._txtTime.text = "活动已结束"

	removetimer(self._updateTimer, self)
end

function DragontrialmainView:_PM_DragonTrialGetInfoRes(status)
	if status == 0 and self._currTabId then
		self:_onClickTab(self._currTabId, true)
	end
end

function DragontrialmainView:_setDiscTag()
	local isInTime = false
	local timeStr = ActivityshopConfig.instance:getActDiscountTimeStr(self._activityId)

	if not string.nilorempty(timeStr) then
		isInTime = PayShopController.instance:checkTimeStr(timeStr)
	end

	if isInTime then
		self._txtRate.text = DragontrialConfig.instance:getCommonValue("DISCOUNT_SHOW")
	end

	goutil.setActive(self._rateGo, isInTime)
end

function DragontrialmainView:_getRedPoint(tabId)
	if tabId == DragontrialmainView.TabEnum.DailyTask then
		return DragontrialModel.instance:checkDailyTaskRedPoint()
	elseif tabId == DragontrialmainView.TabEnum.DevelopTask then
		return DragontrialModel.instance:checkDevelopTaskRedPoint()
	end

	return false
end

function DragontrialmainView:_checkRedDot()
	for id, go in pairs(self._redDotList) do
		goutil.setActive(go, self:_getRedPoint(id))
	end
end

function DragontrialmainView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = false,
		id = "10:" .. self._activityId
	})
	MainUIController.instance:showGlodBar(self._goldBarConGo, self._viewPresentor, btn_list, false)
end

function DragontrialmainView:_forceSelectMainViewTab(tabId)
	local var_25_0

	if not tabId then
		::label_25_0::

		var_25_0 = self._currTabId or DragontrialmainView.TabEnum.Battle
	end

	self._currTabId = var_25_0

	self:_onClickTab(self._currTabId, true)
end

function DragontrialmainView:_checkShopDot()
	local isRed = DragontrialModel.instance:checkExchangeShopRedPoint()

	goutil.setActive(self._redPointGo, isRed)
end

return DragontrialmainView
