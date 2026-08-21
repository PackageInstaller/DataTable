-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\WelfareFundPanel.lua

local welfareBase = require("UI/Welfare/WelfarePanelBase")
local ResFund = require("ClientData/ResFund")
local ResConditionLimit = require("ClientData/ResConditionLimit")
local ResRandClient = require("ClientData/ResRandClient")
local RPC = require("Framework/RPC")
local ResColor = require("ClientData/ResColor")
local Item = require("Common/Object/Item")
local RechargeManager = require("System/Recharge/RechargeManager")
local FundCell = Class("FundCell", UIControls.Child)

function FundCell:ctor(...)
	self.confirmBtn = UIControls.Button(self, "Bg/BtnConfirm")

	self.confirmBtn:addEventClick(self.onBtnClick)

	self.stateLable = UIControls.Label(self, "Bg/TextState")
	self.ruleLable = UIControls.Label(self, "Bg/TextRule")
	self.eff = UIControls.Panel(self, "Bg/EfxGridItem")
	self.switchStateBg = UIControls.Image(self, "Bg")
	self.outAnim = UIControls.UIAni(self, "")
	self.aniName = ""
end

function FundCell:setData(fundDlg, data, stateData)
	self:refershCell()

	self.fundDlg = fundDlg
	self.data = data

	local txt = ResConditionLimit[data.limit].unlock_desc

	self.ruleLable:setText(txt)

	local awardData = ResRandClient[data.award]
	local item = BaseObject.GetObject(awardData.show_ids[1], awardData.show_nums[1])

	if not self.awardItem then
		self.awardItem = UIControls.getGridChild(item, self, "GridItemPanel")

		self.awardItem:setVisible(true)

		self.awardItem.mDisableWays = true
		self.awardItem.isShowPreviewTips = true
	end

	self.awardItem:setObj(item)
	self.awardItem:setIconGray(false)
	self.eff:setVisible(false)

	local state = data.awardState

	if state == 2 then
		self.confirmBtn:setVisible(false)
		self.stateLable:setVisible(true)
		self.stateLable:setText(Lang.get(99))
		self.ruleLable:setFontColor(ResColor.WHITE)
		self.stateLable:setFontColor(ResColor.GREYMIDDLE)

		self.aniName = "BtnFundNml"
	elseif stateData.isBuy == 1 then
		if state == 1 then
			self.ruleLable:setFontColor(ResColor.GREYMIDDLE)
			self.confirmBtn:setVisible(true)
			self.stateLable:setVisible(false)

			self.aniName = "BtnFundSel"

			self.awardItem:setIconGray(false)

			self.fundDlg.toGetAwardCells[data.id] = self

			self.fundDlg.btnGetAward:setEnable(true)
		else
			self.confirmBtn:setVisible(false)
			self.stateLable:setVisible(true)
			self.stateLable:setText(Lang.get(74))

			self.aniName = "BtnFundDis"

			self.ruleLable:setFontColor(ResColor.GREYLIGHT)
			self.stateLable:setFontColor(ResColor.GREYLIGHT)
			self.awardItem:setIconGray(true)
		end
	else
		self.ruleLable:setFontColor(ResColor.GREYMIDDLE)
		self.stateLable:setFontColor(ResColor.GREYMIDDLE)
		self.confirmBtn:setVisible(false)
		self.stateLable:setVisible(true)
		self.stateLable:setText(Lang.get(30785))

		self.aniName = "BtnFundSel"
	end

	self.switchStateBg:setImage("Atlas/StoreAtlas/StoreGiftAtlas", self.aniName)
end

function FundCell:getAwardCB(isShowFly)
	self.eff:setVisible(false)
	self.confirmBtn:setVisible(false)
	self.stateLable:setVisible(true)
	self.stateLable:setText(Lang.get(74))
	self.awardItem:setIconGray(true)
	self.ruleLable:setFontColor(ResColor.GREYLIGHT)
	self.stateLable:setFontColor(ResColor.GREYLIGHT)
	self.switchStateBg:setImage("Atlas/StoreAtlas/StoreGiftAtlas", "BtnFundDis")
	self.eff:setVisible(true)

	if isShowFly == 0 then
		-- block empty
	else
		self.awardItem:flyToCommonFuncEntryPanel()
	end

	if self.fundDlg.toGetAwardCells[self.data.id] then
		self.fundDlg.toGetAwardCells[self.data.id] = nil
	end

	self.outAnim:startAni("FadeStoreGiftFundCell")
end

function FundCell:refershCell()
	self.outAnim:startAni("FadeResetStoreGiftFundCell")
end

function FundCell:onBtnClick()
	self:getAwardCB()

	if self.mEventClick then
		self.mEventClick(self.data.id)
	end
end

local strClassName = "WelfareFundPanel"
local WelfareFundPanel = Class(strClassName, welfareBase)

function WelfareFundPanel:ctor(...)
	self.cells = {}
	self._slotCellClick = Slot(self.onCellClick, self)
	self.toGetAwardCells = {}
end

function WelfareFundPanel:initPanel()
	self:initUI()
end

function WelfareFundPanel:onOpenPanel()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_MALL, self.panelConfigData.id)
	CurAvatar:setFundLooked()
	self:refreshData()
end

function WelfareFundPanel:initUI()
	self.cellPanel = UIControls.Panel(self, "FundList")
	self.contentPanel = UIControls.Panel(self, "FundList/Content")
	self.panelSize = self.contentPanel:getRectSize()
	self.beforePanel = UIControls.Panel(self, "BeforePanel")
	self.btnBuy = UIControls.Button(self, "BeforePanel/BtnFunc", "TextPrice")

	self.btnBuy:addEventClick(self.onBtnBuyClick)

	self.numPanel = UIControls.Panel(self, "BgDec/NumPanel")
	self.txtNum = UIControls.Label(self, "BgDec/NumPanel/TextNum")
	self.getNow = UIControls.Panel(self, "BeforePanel/GetNow")
	self.getNowText = UIControls.Label(self, "BeforePanel/GetNow/TextNum")
	self.getAll = UIControls.Panel(self, "BeforePanel/GetAll")
	self.getAllText = UIControls.Label(self, "BeforePanel/GetAll/TextNum")
	self.afterPanel = UIControls.Panel(self, "AfterPanel")
	self.btnGetAward = UIControls.Button(self, "AfterPanel/BtnFunc")

	self.btnGetAward:addEventClick(self.onBtnGetAward)

	self.getTotal = UIControls.Label(self, "AfterPanel/GetNow/TextNum")
	self.afterBuyAnim = UIControls.UIAni(self, "")

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "BeforePanel/BtnFunc/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "BeforePanel/BtnFunc/TextPt")

		self.priceDmmPanel:setVisible(true)
	end

	self:refreshData()
end

function WelfareFundPanel:refreshData(doCB)
	local srvData, clientData = CurAvatar:getFundData()

	self.svrData = srvData
	self.fundData = clientData
	self.preData = clientData.data

	if self.svrData and self.panelConfigData.value1 ~= self.svrData.season then
		return
	end

	self.rechargeId = self.panelConfigData.includeGiftId[1]

	local product = RechargeManager.getProductByRechargeId(self.rechargeId)

	if product ~= nil then
		self.price = product.priceText
	else
		return
	end

	table.sort(self.preData, function(a, b)
		if a.awardState == b.awardState then
			return a.id < b.id
		else
			return a.awardState < b.awardState
		end
	end)
	self:refreshUI()

	if doCB ~= nil then
		self:_buyCB()
	end
end

function WelfareFundPanel:refreshUI()
	local isBuy = self.svrData.isBuy == 1

	self.beforePanel:setVisible(not isBuy)
	self.afterPanel:setVisible(isBuy)

	local data = self.fundData

	self.getNowText:setText(data.canGetAwardNum .. " ")
	self.getAllText:setText(data.totalAwardNum .. " ")
	self.getTotal:setText(data.canGetAwardNum .. " ")
	self.btnBuy:setText(self.price)
	self.btnGetAward:setEnable(CurAvatar.welfareToGetAward.Fund)
	self.numPanel:setVisible(self.panelConfigData.value1 > 0)
	self.txtNum:setText(self.panelConfigData.value1 + 1)
	self:updateItems()
end

function WelfareFundPanel:panelTop()
	self.contentPanel:setPosition(self.panelSize.width, 0)
end

function WelfareFundPanel:onBtnBuyClick()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_CLICK_RECHARGE, self.rechargeId)
	RechargeManager.startRecharge(self.rechargeId, nil, nil)
end

function WelfareFundPanel:_buyCB()
	self.afterBuyAnim:startAni("ChangeStoreGiftFund")
end

function WelfareFundPanel:onBtnGetAward()
	local idTab = {}
	local count = 1

	for _, tab in pairs(self.toGetAwardCells) do
		idTab[#idTab + 1] = tab.data.id
	end

	RPC.welfareGetAward("kCSWelfareTypeFund", idTab)
	self:getAwardBack(true)
end

function WelfareFundPanel:getAwardBack(suc)
	if suc then
		self.toGetAwardCells = {}

		self.btnGetAward:setEnable(false)
	end

	local item = {}

	item.type = Const.MONEY_TYPE_DIAMOND
	item.value = self.fundData.canGetAwardNum

	UIManager.getUI("commonBonusDlg", true):onShow("", {
		item
	}, {}, {}, {}, {}, {}, Lang.get(1815))
end

function WelfareFundPanel:updateItems()
	for i = #self.cells + 1, #self.preData do
		local cell = FundCell(self, "FundList/Content", "System/Store/StoreGiftFundCell", 0, 0)

		cell.mEventClick = self._slotCellClick
		self.cells[i] = cell
	end

	for idx, cell in ipairs(self.cells) do
		if self.preData[idx] then
			cell:setData(self, self.preData[idx], self.svrData)
			cell:setVisible(true)
		else
			cell:setVisible(false)
		end
	end
end

function WelfareFundPanel:onCellClick(id)
	RPC.welfareGetAward("kCSWelfareTypeFund", {
		id
	})
end

function WelfareFundPanel:onClosePanel()
	CueManager.stopVocal()
	WelfareFundPanel.super.onClosePanel(self)
end

function WelfareFundPanel:onDestroy()
	return
end

return WelfareFundPanel
