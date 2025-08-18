-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\ActivityGiftPanel.lua

local WelfareBase = require("UI/Welfare/WelfarePanelBase")
local ResMallSubPanelConfig = require("ClientData/ResMallSubPanelConfig")
local EventConst = require("EventConst")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResRandClient = require("ClientData/ResRandClient")
local ResColor = require("ClientData/ResColor")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local GiftCell = require("UI/OpActivity/ActivityGiftCell")
local NewBeeChild = require("UI/Welfare/NewBeeChild")
local classNameStr = "ActivityGiftPanel"
local ActivityGiftPanel = Class(classNameStr, WelfareBase)
local CELLPRE_PATH = "System/Common/Grid/"

function ActivityGiftPanel:ctor(...)
	self.cells = {}
	self._slot4CellClick = Slot(self.onCellClick, self)
end

function ActivityGiftPanel:initPanel()
	self:initUI()
end

function ActivityGiftPanel:onOpenPanel()
	self.info = self.panelConfigData
	self.giftType = self.info.pageType
	self.aciId = self.info.arg1

	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_MALL, self.aciId)
	self:refreshData(true)
end

function ActivityGiftPanel:initUI()
	self.textTime = UIControls.Label(self, "TipsPanel/TextTime")

	self.textTime:setText("")
end

function ActivityGiftPanel:refreshMixinData()
	return
end

function ActivityGiftPanel:refreshData(needDestoryItems)
	local data = CurAvatar:getActGiftData(self.aciId)

	self.actObj = CurAvatar:getActivityObj(data.actId)
	self.svrData = self.actObj.actData.serverData or nil
	self.Data = self.actObj.actData:getAllProduct()

	self:refreshLastTime()
	self:refreshUI(needDestoryItems)
end

function ActivityGiftPanel:refreshLastTime()
	local strTimeTip = UIMiscConfig.ACTGIFT_IN_MALL_TIME_TIP[self.aciId] or UIMiscConfig.ACTGIFT_IN_MALL_TIME_TIP[1]

	ClientTimerManager.AddSecondFormatTickUI(self.textTime, self.actObj:getRemainOpenTime(), false, strTimeTip[1])
end

function ActivityGiftPanel:refreshUI(needDestoryItems)
	if needDestoryItems ~= nil then
		for i, cell in ipairs(self.cells) do
			cell:destroy()
		end

		self.cells = {}
	end

	self:updateItems()
end

function ActivityGiftPanel:updateItems()
	for idx, data in ipairs(self.Data) do
		local cell = self.cells[idx]

		if not cell then
			if self.info.arg2 == "GridStoreGiftBeginner" then
				cell = NewBeeChild(self, "AwardList/Content", CELLPRE_PATH .. self.info.arg2)
			else
				cell = GiftCell(self, "AwardList/Content", CELLPRE_PATH .. self.info.arg2)
			end

			cell.mEventClick = self._slot4CellClick
			self.cells[idx] = cell
		end

		self.cells[idx]:initData(data, self.svrData)
		self.cells[idx]:setVisible(true)
	end
end

function ActivityGiftPanel:onCellClick(sender)
	local data = sender.data

	self:_onCellClick(data)
end

function ActivityGiftPanel:_onCellClick(data)
	local ui = UIManager.getUI("giftBuyBox")

	self.uiBox = ui
	self.curCellID = data.rechargeId

	ui:showShopItem(data, self, self.giftType, self.curCellID, self.actObj)
	ui:bindWindow(self)

	if data.price == 0 then
		ui:onItemBuy()
	else
		ui:setVisible(true)
	end
end

function ActivityGiftPanel:onGetAwardBack(data)
	return
end

function ActivityGiftPanel:panelTop()
	return
end

function ActivityGiftPanel:onClosePanel()
	CueManager.stopVocal()

	if self.uiBox and self.uiBox:getVisible() then
		self.uiBox:onBoxClose()
	end

	ActivityGiftPanel.super.onClosePanel(self)
end

function ActivityGiftPanel:recommendShowGift(recommendArgs)
	local rechargeId = recommendArgs[1]

	for _, pInfo in pairs(self.Data) do
		if pInfo[1] and pInfo[1].rechargeId == rechargeId then
			local count = self.actObj.actData:getHasBuyNum(rechargeId)

			if pInfo[1].buyTimesMax - count <= 0 then
				MsgManager.notice(Lang.get(30063))
			else
				self:_onCellClick(pInfo[1])
			end
		end
	end
end

function ActivityGiftPanel:onDestroy()
	if self.timeRemainTimer then
		self.timeRemainTimer:Stop()
	end
end

return ActivityGiftPanel
