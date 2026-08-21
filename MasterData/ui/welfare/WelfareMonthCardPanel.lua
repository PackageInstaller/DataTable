-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\WelfareMonthCardPanel.lua

local welfareBase = require("UI/Welfare/WelfarePanelBase")
local ResRandClient = require("ClientData/ResRandClient")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResCardClient = require("ClientData/ResCardClient")
local EventConst = require("EventConst")
local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName
local SDKCore = require("SDK/SDKCore")
local MonthCardCell = require("UI/Welfare/MonthCardCell")
local strClassName = "WelfareMonthCardPanel"
local WelfareMonthCardPanel = Class(strClassName, welfareBase)

function WelfareMonthCardPanel:ctor(...)
	self.cardData = {}
	self.cardsCell = {}
	self._slot4ClickCell = Slot(self.onCellClick, self)
	self._slot4ProductLoaded = Slot(self.onProductLoaded, self)

	EventCenter.addEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
end

function WelfareMonthCardPanel:initPanel()
	self.recharge2id = {}

	for _, data in pairs(ResCardClient) do
		for _, rId in ipairs(data.recharge_id) do
			self.recharge2id[rId] = data.id
		end
	end

	self:refreshData()
end

function WelfareMonthCardPanel:onOpenPanel()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_MALL, self.panelConfigData.id)
end

function WelfareMonthCardPanel:_getMonthCardData()
	local allRechargeIds = self.panelConfigData.includeGiftId or {}
	local allProducts = {}

	for _, rechargeId in ipairs(allRechargeIds) do
		local realRechargeId = RechargeManager.getNestedId(rechargeId)
		local realProduct = RechargeManager.getProductByRechargeId(realRechargeId)

		if realProduct and (realProduct:isProductValid() or CurAvatar:monthCardInEffect(realRechargeId)) then
			table.insert(allProducts, realProduct)
		end
	end

	return allProducts
end

function WelfareMonthCardPanel:refreshData()
	local clientData, svrData = CurAvatar:getMonthCardData()

	self.cardData = self:_getMonthCardData()
	self.svrData = svrData and svrData or {}

	for i = #self.cardsCell + 1, #self.cardData do
		self.cardsCell[i] = MonthCardCell(self, "", "System/Store/StoreMonthCardCell")

		self.cardsCell[i]:setVisible(true)
	end

	for index = 1, #self.cardsCell do
		local clientData = self.cardData[index]

		if clientData then
			self.cardsCell[index]:setData(self.recharge2id[clientData.rechargeId], clientData, self.svrData[clientData.rechargeId])

			self.cardsCell[index].mEventClick = self._slot4ClickCell
		else
			self.cardsCell[index]:setVisible(false)
		end
	end
end

function WelfareMonthCardPanel:onProductLoaded()
	if self:getVisible() == true and self.cardData then
		local clientData, svrData = CurAvatar:getMonthCardData()

		self.cardData = self:_getMonthCardData()
		self.svrData = svrData and svrData or {}

		for index, data in ipairs(self.cardData) do
			self.cardsCell[index]:refreshData(data, self.svrData[data.rechargeId])
		end
	end
end

function WelfareMonthCardPanel:onCellClick(data)
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_CLICK_RECHARGE, data.rechargeId)
	RechargeManager.startRecharge(data.rechargeId, nil, nil)
	SDKAgent.reportBuriedPoint("af_initiated_checkout", "Fire_initiated_checkout")
end

function WelfareMonthCardPanel:onClosePanel()
	CueManager.stopVocal()
	WelfareMonthCardPanel.super.onClosePanel(self)
end

function WelfareMonthCardPanel:onDestroy()
	for _, cell in pairs(self.cardsCell) do
		cell:destroy()
	end

	EventCenter.removeEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
end

return WelfareMonthCardPanel
