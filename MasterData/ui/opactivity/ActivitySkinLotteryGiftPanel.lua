-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivitySkinLotteryGiftPanel.lua

local WelfarePanelBase = require("UI/Welfare/WelfarePanelBase")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResMallSubPanelConfig = require("ClientData/ResMallSubPanelConfig")
local UIControls = UIControls
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResRandClient = require("ClientData/ResRandClient")
local ResColor = require("ClientData/ResColor")
local GiftCell = require("UI/OpActivity/ActivityGiftCell")
local strClassName = "ActivitySkinLotteryGiftPanel"
local ActivitySkinLotteryGiftPanel = Class(strClassName, WelfarePanelBase)

MixinClass(ActivitySkinLotteryGiftPanel, ActivityPanelMixin)

function ActivitySkinLotteryGiftPanel:ctor()
	self:initUI()
end

function ActivitySkinLotteryGiftPanel:initUI()
	self._slot4CellClick = Slot(self._onShopItemClick, self)
	self.goodsPanel = UIControls.Panel(self, "GoodsPanel")
	self.textTime = UIControls.Label(self, "TextTime")
	self.closeBtn = UIControls.Button(self, "BtnClose")

	self.closeBtn:addEventClick(self._onClickClose)

	self.cells = {}
end

function ActivitySkinLotteryGiftPanel:_setData()
	self.actId = self.actObj.actId

	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.subCellPrefab = "System/Common/Grid/" .. self.replaceableCellPath[1]
	else
		self.subCellPrefab = "System/Common/Grid/GridStoreGiftCommonBingo"
	end

	self.cellClass = GiftCell

	if self.actObj.templateData.changed_new_notice then
		self.actObj.actData:onSetChangedNew()
	end
end

function ActivitySkinLotteryGiftPanel:_onShow(needDestoryItems)
	self.svrData = self.actObj.actData.serverData or nil

	local showLock

	if self.actObj.templateData.changed_new_notice then
		showLock = true
	end

	local datas = self.actObj.actData:getAllProduct(showLock)

	self.Data = {}

	for i, v in pairs(datas or {}) do
		table.insert(self.Data, v)
	end

	self:refreshLastTime()
	self:refreshUI(needDestoryItems)
end

function ActivitySkinLotteryGiftPanel:updateItems()
	for idx, data in ipairs(self.Data) do
		local cell = self.cells[idx]

		if not cell then
			cell = self.cellClass(self, "GoodsPanel", self.subCellPrefab)
			cell.mEventClick = self._slot4CellClick
			self.cells[idx] = cell
		end

		self.cells[idx]:initData(data, self.svrData)
		self.cells[idx]:setVisible(true)
	end
end

function ActivitySkinLotteryGiftPanel:refreshLastTime()
	local strTimeTip = UIMiscConfig.ACTGIFT_IN_MALL_TIME_TIP[self.actId] or UIMiscConfig.ACTGIFT_IN_MALL_TIME_TIP[1]
	local leftTime = self.actObj:getRemainOpenTime()

	ClientTimerManager.AddSecondFormatTickUI(self.textTime, leftTime, false, strTimeTip[1])
end

function ActivitySkinLotteryGiftPanel:refreshUI(needDestoryItems)
	if needDestoryItems ~= nil then
		for i, cell in ipairs(self.cells) do
			cell:destroy()
		end

		self.cells = {}
	end

	self:updateItems()
end

function ActivitySkinLotteryGiftPanel:_onShopItemClick(sender)
	local data = sender.data
	local ui = UIManager.getUI("giftBuyBox")

	self.uiBox = ui
	self.curCellID = data.rechargeId

	ui:showShopItem(data, self, nil, self.curCellID, self.actObj)
	ui:bindWindow(self)

	if data.price == 0 then
		ui:onItemBuy()
	else
		ui:setVisible(true)
	end
end

function ActivitySkinLotteryGiftPanel:_onClickClose(...)
	self.mParent:setVisible(false)
end

function ActivitySkinLotteryGiftPanel:refreshActivityData()
	self:refreshUI()
end

return ActivitySkinLotteryGiftPanel
