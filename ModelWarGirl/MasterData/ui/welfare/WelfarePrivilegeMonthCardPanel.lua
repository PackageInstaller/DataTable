-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\WelfarePrivilegeMonthCardPanel.lua

local welfareBase = require("UI/Welfare/WelfarePanelBase")
local ResRandClient = require("ClientData/ResRandClient")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResCardClient = require("ClientData/ResCardClient")
local EventConst = require("EventConst")
local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName
local SDKCore = require("SDK/SDKCore")
local MonthCardCell = require("UI/Welfare/MonthCardCell")
local PMCAttrCell = Class("PMCAttrCell", UIControls.Child)
local strClassName = "WelfarePrivilegeMonthCardPanel"
local WelfarePrivilegeMonthCardPanel = Class(strClassName, welfareBase)

function WelfarePrivilegeMonthCardPanel:ctor(...)
	self.cardData = {}
	self.cardsCell = {}
	self._slot4ClickCell = Slot(self.onCellClick, self)
	self._slot4ProductLoaded = Slot(self.onProductLoaded, self)

	EventCenter.addEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
end

function WelfarePrivilegeMonthCardPanel:initPanel()
	self.recharge2id = {}

	for _, data in pairs(ResCardClient) do
		for _, rId in ipairs(data.recharge_id) do
			self.recharge2id[rId] = data.id
		end
	end

	self:refreshData()
end

function WelfarePrivilegeMonthCardPanel:onOpenPanel()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_MALL, self.panelConfigData.id)
end

function WelfarePrivilegeMonthCardPanel:_getMonthCardData()
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

function WelfarePrivilegeMonthCardPanel:refreshData()
	local clientData, svrData = CurAvatar:getPrivilegeMonthCardData()

	self.cardData = self:_getMonthCardData()
	self.svrData = svrData and svrData or {}

	for i = #self.cardsCell + 1, #self.cardData do
		self.cardsCell[i] = MonthCardCell(self, "", "System/Store/StoreMonthCardCell1")

		self.cardsCell[i]:setVisible(true)
	end

	for index = 1, #self.cardsCell do
		local clientData = self.cardData[index]

		if clientData then
			self.cardsCell[index]:setData(self.recharge2id[clientData.rechargeId], clientData, self.svrData)

			self.cardsCell[index].mEventClick = self._slot4ClickCell
		else
			self.cardsCell[index]:setVisible(false)
		end
	end
end

function WelfarePrivilegeMonthCardPanel:onProductLoaded()
	if self:getVisible() == true and self.cardData then
		local clientData, svrData = CurAvatar:getPrivilegeMonthCardData()

		self.cardData = self:_getMonthCardData()
		self.svrData = svrData and svrData or {}

		for index, data in ipairs(self.cardData) do
			self.cardsCell[index]:refreshData(data, self.svrData)
		end
	end
end

function WelfarePrivilegeMonthCardPanel:onClosePanel()
	CueManager.stopVocal()
	WelfarePrivilegeMonthCardPanel.super.onClosePanel(self)
end

function WelfarePrivilegeMonthCardPanel:onCellClick(data)
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_CLICK_RECHARGE, data.rechargeId)
	RechargeManager.startRecharge(data.rechargeId, nil, nil)
	SDKAgent.reportBuriedPoint("af_initiated_checkout", "Fire_initiated_checkout")
end

function WelfarePrivilegeMonthCardPanel:onDestroy()
	for _, cell in pairs(self.cardsCell) do
		cell:destroy()
	end

	EventCenter.removeEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
end

return WelfarePrivilegeMonthCardPanel
