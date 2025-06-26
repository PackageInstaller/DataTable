-- chunkname: @IQIGame\\UI\\Mall\\MonthCardChild\\MonthCardGoodsView.lua

local MonthCardGoodsView = {
	MonthCardCid = 1
}

function MonthCardGoodsView.New(view, monthCardCid)
	local obj = Clone(MonthCardGoodsView)

	obj:Init(view, monthCardCid)

	return obj
end

function MonthCardGoodsView:Init(view, monthCardCid)
	self.View = view
	self.MonthCardCid = monthCardCid

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfTime = self.goTime:GetComponent("Text")
	self.tfCost = self.goBtnBuy.transform:Find("Sort/Text_02"):GetComponent("Text")
	self.btnRightInfo = self.goBtnRightInfo:GetComponent("Button")
	self.btnBuy = self.goBtnBuy:GetComponent("Button")

	function self.onClickBtnBuyDelegate()
		self:OnClickBtnBuy()
	end

	function self.onClickBtnRightInfoDelegate()
		self:OnClickBtnRightInfo()
	end

	self.goBtnRightInfo.transform:Find("Text"):GetComponent("Text").text = MallUIApi:GetString("monthViewBtnRightInfoTxt")
	self.goDesc1:GetComponent("Text").text = MallUIApi:GetString("monthViewDesc1")
	self.goDesc2:GetComponent("Text").text = MallUIApi:GetString("monthViewDesc2", self.MonthCardCid)
	self.goDesc3:GetComponent("Text").text = MallUIApi:GetString("monthViewDesc3", self.MonthCardCid)
	self.goDesc4:GetComponent("Text").text = MallUIApi:GetString("monthViewDesc4")
	self.goBtnBuy.transform:Find("Sort/Text_01"):GetComponent("Text").text = MiscApi:GetString("moneySign")
	self.goBtnBuy.transform:Find("Text_01"):GetComponent("Text").text = MallUIApi:GetString("monthViewBtnBuyTxt")
	self.goBtnBuy.transform:Find("Text_02"):GetComponent("Text").text = MallUIApi:GetString("monthViewBtnBuyTxtEng")
end

function MonthCardGoodsView:Open(cfgMallData)
	self.View:SetActive(true)

	self.cfgMallData = cfgMallData
	self.duration = 0
	self.tfCost.text = MallUIApi:GetString("monthViewMoneyCostCount", CfgPayTable[self.cfgMallData.PayMoney].Amount)

	self:SyncTime()
	self:OnAddListener()
end

function MonthCardGoodsView:Close()
	self.View:SetActive(false)
end

function MonthCardGoodsView:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.enableTimer then
		self.duration = self.duration + realElapseSeconds

		if self.duration >= 1 then
			self.duration = 0

			self:SyncTime()
		end
	end
end

function MonthCardGoodsView:OnHide()
	self:OnRemoveListener()
end

function MonthCardGoodsView:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function MonthCardGoodsView:OnAddListener()
	self:OnRemoveListener()
	self.btnRightInfo.onClick:AddListener(self.onClickBtnRightInfoDelegate)
	self.btnBuy.onClick:AddListener(self.onClickBtnBuyDelegate)
end

function MonthCardGoodsView:OnRemoveListener()
	self.btnRightInfo.onClick:RemoveListener(self.onClickBtnRightInfoDelegate)
	self.btnBuy.onClick:RemoveListener(self.onClickBtnBuyDelegate)
end

function MonthCardGoodsView:OnClickBtnRightInfo()
	return
end

function MonthCardGoodsView:OnClickBtnBuy()
	if PlayerModule.PlayerInfo.monthCard[self.MonthCardCid] ~= nil then
		local monthTime = PlayerModule.PlayerInfo.monthCard[self.MonthCardCid]

		if monthTime - PlayerModule.GetServerTime() > 2592000 then
			NoticeModule.ShowNoticeNoCallback(21061003)

			return
		end
	end

	UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
		mallCid = self.cfgMallData.Id
	})
end

function MonthCardGoodsView:SyncTime()
	self.enableTimer = PlayerModule.PlayerInfo.monthCard[self.MonthCardCid] ~= nil

	local residueTime = 0

	if self.enableTimer then
		residueTime = PlayerModule.PlayerInfo.monthCard[self.MonthCardCid] - PlayerModule.GetServerTime()
	end

	residueTime = math.max(0, residueTime)
	self.tfTime.text = MallUIApi:GetString("monthViewTime", residueTime)
end

return MonthCardGoodsView
