-- chunkname: @IQIGame\\UI\\BuyPanel\\ViewTypeTwo.lua

local ViewTypeTwo = {}

function ViewTypeTwo.New(view, mainView)
	local obj = Clone(ViewTypeTwo)

	obj:Init(view, mainView)

	return obj
end

function ViewTypeTwo:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.imgMoney = self.goMoneyIcon:GetComponent("Image")
	self.icon = self.goIcon:GetComponent("Image")
	self.tfMoneyNum = self.goMoneyNum:GetComponent("Text")
	self.tfMoneyNumFree = self.goBtnBuyFree.transform:Find("Text"):GetComponent("Text")
	self.tfDesc = self.goDesc:GetComponent("Text")
	self.tfName = self.goName:GetComponent("Text")
	self.btnBuy = self.goBtnBuy:GetComponent("Button")
	self.btnBuyFree = self.goBtnBuyFree:GetComponent("Button")
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnBuyDelegate()
		self:OnClickBtnBuy()
	end

	self.goRMBSign:GetComponent("Text").text = MiscApi:GetString("moneySign")
end

function ViewTypeTwo:Open(cfgMallData, num)
	self.cfgMallData = cfgMallData

	if self.cfgMallData.LimitType ~= 0 then
		self.residueTimes = MallModule.GetResidueBuyTimes(self.cfgMallData.Id)
	else
		self.residueTimes = BuyPanelUIApi:GetString("timesLimit")
	end

	if num ~= nil then
		self.usedTimes = math.min(num, self.residueTimes)
		self.usedTimes = math.max(1, self.usedTimes)
	else
		self.usedTimes = 1
	end

	if cfgMallData.SellType == Constant.Mall_SellType.RMB then
		self.usedTimes = 1
	end

	self.View:SetActive(true)
	self:RefreshMisc()
	self:RefreshCost()
end

function ViewTypeTwo:Close()
	self:OnHide()
	self.View:SetActive(false)
end

function ViewTypeTwo:OnHide()
	return
end

function ViewTypeTwo:OnDestroy()
	self.mainView = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function ViewTypeTwo:OnAddListener()
	self.btnBuy.onClick:AddListener(self.onClickBtnBuyDelegate)
	self.btnBuyFree.onClick:AddListener(self.onClickBtnBuyDelegate)
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function ViewTypeTwo:OnRemoveListener()
	self.btnBuy.onClick:RemoveListener(self.onClickBtnBuyDelegate)
	self.btnBuyFree.onClick:RemoveListener(self.onClickBtnBuyDelegate)
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function ViewTypeTwo:OnClickBtnBuy()
	self.mainView:OnClickBtnBuy(self.cfgMallData, self.usedTimes)
end

function ViewTypeTwo:OnClickBtnClose()
	self.mainView:OnClickBtnClose()
end

function ViewTypeTwo:OnBuyGoodsSuccess()
	self:RefreshCost()
end

function ViewTypeTwo:RefreshMisc()
	self.tfName.text = BuyPanelUIApi:GetString("goItemName", self.cfgMallData.Name)
	self.tfDesc.text = MallModule.GetGoodsDesc(self.cfgMallData.Id)

	self.goMoneyIcon:SetActive(self.cfgMallData.SellType ~= Constant.Mall_SellType.Free)
	self.goMoneyNum:SetActive(self.cfgMallData.SellType ~= Constant.Mall_SellType.Free)

	self.goBtnBuy.transform:Find("Text"):GetComponent("Text").text = BuyPanelUIApi:GetString("goBuyBtn", self.cfgMallData.SellType == Constant.Mall_SellType.Free)

	if self.cfgMallData.SellType == Constant.Mall_SellType.Item then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.cfgMallData.Price[1]].Icon), self.imgMoney)
	elseif self.cfgMallData.SellType == Constant.Mall_SellType.PayPoint then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[Constant.ItemID.ID_PAYPOINT_SHOW].Icon), self.imgMoney)
	end

	if self.cfgMallData.BG ~= nil and self.cfgMallData.BG ~= "" then
		AssetUtil.LoadImage(self, UIGlobalApi.GetAssetPath(self.cfgMallData.BG), self.icon)
	end
end

function ViewTypeTwo:RefreshCost()
	local cost, own

	if self.cfgMallData.SellType == Constant.Mall_SellType.Item then
		cost = math.max(self.cfgMallData.Price[2] * self.usedTimes, self.cfgMallData.Price[2])
		own = WarehouseModule.GetItemNumByCfgID(self.cfgMallData.Price[1])
	elseif self.cfgMallData.SellType == Constant.Mall_SellType.PayPoint then
		cost = math.max(self.cfgMallData.PayPoint * self.usedTimes, self.cfgMallData.PayPoint)
		own = PlayerModule.PlayerInfo.baseInfo.payPoint
	elseif self.cfgMallData.SellType == Constant.Mall_SellType.RMB then
		cost = CfgPayTable[self.cfgMallData.PayMoney].Amount
	elseif self.cfgMallData.SellType == Constant.Mall_SellType.Free then
		cost = 0
		own = 0
	end

	self.tfMoneyNum.text = BuyPanelUIApi:GetString("costMoney", cost, own, self.cfgMallData.SellType)
	self.tfMoneyNumFree.text = self.tfMoneyNum.text

	self.goMoneyIcon:SetActive(self.cfgMallData.SellType ~= Constant.Mall_SellType.RMB)
	self.goRMBSign:SetActive(self.cfgMallData.SellType == Constant.Mall_SellType.RMB)
	self.goBtnBuy:SetActive(self.cfgMallData.SellType ~= Constant.Mall_SellType.Free)
	self.goBtnBuyFree:SetActive(self.cfgMallData.SellType == Constant.Mall_SellType.Free)
end

return ViewTypeTwo
