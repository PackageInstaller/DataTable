-- chunkname: @IQIGame\\UI\\BuyPanel\\ViewTypeOne.lua

local ViewTypeOne = {
	cellPool = {}
}

function ViewTypeOne.New(view, mainView)
	local obj = Clone(ViewTypeOne)

	obj:Init(view, mainView)

	return obj
end

function ViewTypeOne:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.imgMoney = self.goMoneyIcon:GetComponent("Image")
	self.icon = self.goIcon:GetComponent("Image")
	self.tfMoneyNum = self.goMoneyNum:GetComponent("Text")
	self.tfMoneyNumFree = self.goBtnBuyFree.transform:Find("Text"):GetComponent("Text")
	self.tfDesc = self.goDesc:GetComponent("Text")
	self.tfBuyTimes = self.goBuyTimes:GetComponent("Text")
	self.btnDress = self.goBtnDress:GetComponent("Button")
	self.btnBuy = self.goBtnBuy:GetComponent("Button")
	self.btnBuyFree = self.goBtnBuyFree:GetComponent("Button")
	self.btnReduce = self.goBtnReduce:GetComponent("Button")
	self.btnAdd = self.goBtnAdd:GetComponent("Button")
	self.btnMax = self.goBtnMax:GetComponent("Button")
	self.btnMin = self.goBtnMin:GetComponent("Button")
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnBuyDelegate()
		self:OnClickBtnBuy()
	end

	function self.onClickBtnReduceDelegate()
		self:OnClickBtnReduce()
	end

	function self.onClickBtnAddDelegate()
		self:OnClickBtnAdd()
	end

	function self.onClickBtnMaxDelegate()
		self:OnClickBtnMax()
	end

	function self.onClickBtnMinDelegate()
		self:OnClickBtnMin()
	end

	function self.onClickBtnDressDelegate()
		self:OnClickBtnDress()
	end

	self.goRMBSign:GetComponent("Text").text = MiscApi:GetString("moneySign")
	self.goBtnMax.transform:Find("Text"):GetComponent("Text").text = BuyPanelUIApi:GetString("btnMaxTxt")
	self.goBtnMin.transform:Find("Text"):GetComponent("Text").text = BuyPanelUIApi:GetString("btnMinTxt")
end

function ViewTypeOne:Open(cfgMallData, num, type)
	self.cfgMallData = cfgMallData
	self.type = type
	self.cfgDressData = nil

	if self.cfgMallData.SoulDressID ~= 0 then
		self.cfgDressData = CfgDressTable[self.cfgMallData.SoulDressID]
	end

	local limit_1 = cfgMallData.SingleBuyLimits
	local limit_2 = 1

	if self.cfgMallData.SellType == Constant.Mall_SellType.PayPoint then
		limit_2 = math.floor(PlayerModule.PlayerInfo.baseInfo.payPoint / self.cfgMallData.PayPoint)
	elseif self.cfgMallData.SellType == Constant.Mall_SellType.Item then
		limit_2 = math.floor(WarehouseModule.GetItemNumByCfgID(self.cfgMallData.Price[1]) / self.cfgMallData.Price[2])
	end

	if self.cfgMallData.LimitType ~= 0 then
		local limit_3 = MallModule.GetResidueBuyTimes(self.cfgMallData.Id)

		self.residueTimes = math.min(limit_1, limit_2, limit_3)
	else
		self.residueTimes = math.min(limit_1, limit_2)
	end

	if num ~= nil then
		self.usedTimes = math.min(num, self.residueTimes)
		self.usedTimes = math.max(1, self.usedTimes)

		if self.type == 1 then
			self.usedTimes = num
		end
	else
		self.usedTimes = 1
	end

	if cfgMallData.SellType == Constant.Mall_SellType.RMB then
		self.usedTimes = 1
		self.type = 1
	end

	self.View:SetActive(true)
	self.goBtnMax:SetActive(self.type ~= 1)
	self.goBtnMin:SetActive(self.type ~= 1)
	self.goBtnAdd:SetActive(self.type ~= 1)
	self.goBtnReduce:SetActive(self.type ~= 1)
	self:RefreshMisc()
	self:RefreshCost()
	self:RefreshContent()
	self:RefreshTimes()
end

function ViewTypeOne:Close()
	self:OnHide()
	self.View:SetActive(false)
end

function ViewTypeOne:OnHide()
	return
end

function ViewTypeOne:OnDestroy()
	for i, v in pairs(self.cellPool) do
		v:Dispose()
	end

	self.mainView = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function ViewTypeOne:OnAddListener()
	self.btnBuy.onClick:AddListener(self.onClickBtnBuyDelegate)
	self.btnBuyFree.onClick:AddListener(self.onClickBtnBuyDelegate)
	self.btnReduce.onClick:AddListener(self.onClickBtnReduceDelegate)
	self.btnAdd.onClick:AddListener(self.onClickBtnAddDelegate)
	self.btnMin.onClick:AddListener(self.onClickBtnMinDelegate)
	self.btnMax.onClick:AddListener(self.onClickBtnMaxDelegate)
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnDress.onClick:AddListener(self.onClickBtnDressDelegate)
end

function ViewTypeOne:OnRemoveListener()
	self.btnBuy.onClick:RemoveListener(self.onClickBtnBuyDelegate)
	self.btnBuyFree.onClick:RemoveListener(self.onClickBtnBuyDelegate)
	self.btnReduce.onClick:RemoveListener(self.onClickBtnReduceDelegate)
	self.btnAdd.onClick:RemoveListener(self.onClickBtnAddDelegate)
	self.btnMin.onClick:RemoveListener(self.onClickBtnMinDelegate)
	self.btnMax.onClick:RemoveListener(self.onClickBtnMaxDelegate)
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnDress.onClick:RemoveListener(self.onClickBtnDressDelegate)
end

function ViewTypeOne:OnClickBtnDress()
	UIModule.Open(Constant.UIControllerName.GirlDressShowUI, Constant.UILayer.UI, self.cfgDressData)
end

function ViewTypeOne:OnBuyGoodsSuccess()
	self:RefreshCost()
end

function ViewTypeOne:OnClickBtnBuy()
	self.mainView:OnClickBtnBuy(self.cfgMallData, self.usedTimes)
end

function ViewTypeOne:OnClickBtnReduce()
	self.usedTimes = self.usedTimes - 1
	self.usedTimes = math.max(1, self.usedTimes)

	self:RefreshCost()
end

function ViewTypeOne:OnClickBtnAdd()
	self.usedTimes = self.usedTimes + 1
	self.usedTimes = math.min(self.usedTimes, self.residueTimes)
	self.usedTimes = math.max(1, self.usedTimes)

	self:RefreshCost()
end

function ViewTypeOne:OnClickBtnMax()
	self.usedTimes = self.residueTimes
	self.usedTimes = math.max(1, self.usedTimes)

	self:RefreshCost()
end

function ViewTypeOne:OnClickBtnMin()
	self.usedTimes = 1

	self:RefreshCost()
end

function ViewTypeOne:OnClickBtnClose()
	self.mainView:OnClickBtnClose()
end

function ViewTypeOne:RefreshMisc()
	self.goMoneyIcon:SetActive(self.cfgMallData.SellType ~= Constant.Mall_SellType.Free)
	self.goMoneyNum:SetActive(self.cfgMallData.SellType ~= Constant.Mall_SellType.Free)

	self.goBtnBuy.transform:Find("Text"):GetComponent("Text").text = BuyPanelUIApi:GetString("goBuyBtn", self.cfgMallData.SellType == Constant.Mall_SellType.Free)

	self.goBtnDress:SetActive(self.cfgDressData ~= nil)

	if self.cfgMallData.SellType == Constant.Mall_SellType.Item then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.cfgMallData.Price[1]].Icon), self.imgMoney)
	elseif self.cfgMallData.SellType == Constant.Mall_SellType.PayPoint then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[Constant.ItemID.ID_PAYPOINT_SHOW].Icon), self.imgMoney)
	end
end

function ViewTypeOne:RefreshCost()
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

	self.tfBuyTimes.text = BuyPanelUIApi:GetString("goBuyTimes", self.usedTimes)
	self.tfMoneyNum.text = BuyPanelUIApi:GetString("costMoney", cost, own, self.cfgMallData.SellType)
	self.tfMoneyNumFree.text = self.tfMoneyNum.text

	self.goMoneyIcon:SetActive(self.cfgMallData.SellType ~= Constant.Mall_SellType.RMB)
	self.goRMBSign:SetActive(self.cfgMallData.SellType == Constant.Mall_SellType.RMB)
	self.goBtnBuy:SetActive(self.cfgMallData.SellType ~= Constant.Mall_SellType.Free)
	self.goBtnBuyFree:SetActive(self.cfgMallData.SellType == Constant.Mall_SellType.Free)
end

function ViewTypeOne:RefreshContent()
	local showOne = self.cfgMallData.ShowItem == Constant.Mall_ShowItem.OneItem

	self.goContentOne:SetActive(showOne)
	self.goContentTwo:SetActive(not showOne)

	if showOne then
		self:RefreshContentOne()
	else
		self:RefreshContentTwo()
	end
end

function ViewTypeOne:RefreshContentOne()
	local rootTrans = self.goContentOne.transform
	local cfgItemData = CfgItemTable[self.cfgMallData.Item[1]]

	self.tfDesc.text = BuyPanelUIApi:GetString("goDesc", cfgItemData.Describe)

	local name = rootTrans:Find("Name"):GetComponent("Text")

	name.text = BuyPanelUIApi:GetString("goItemName", cfgItemData.Name)

	local batchNum = rootTrans:Find("Num/Text_01"):GetComponent("Text")

	batchNum.text = BuyPanelUIApi:GetString("goSellNum", self.cfgMallData.ItemNum[1])

	local iconItem = rootTrans:Find("Icon/Image_01"):GetComponent("Image")

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), iconItem)

	local iconBg = rootTrans:Find("QualityBg"):GetComponent("Image")

	AssetUtil.LoadImage(self, BuyPanelUIApi:GetString("goQualityLinePath", cfgItemData.Quality), iconBg)
end

function ViewTypeOne:RefreshContentTwo()
	local rootTrans = self.goContentTwo.transform

	if self.cfgMallData.BG ~= nil and self.cfgMallData.BG ~= "" then
		AssetUtil.LoadImage(self, UIGlobalApi.GetAssetPath(self.cfgMallData.BG), self.icon)
	end

	self.tfDesc.text = MallModule.GetGoodsDesc(self.cfgMallData.Id)

	local name = rootTrans:Find("Name"):GetComponent("Text")

	name.text = BuyPanelUIApi:GetString("goItemName", self.cfgMallData.Name)

	local goCell = rootTrans:Find("Grid/Mould").gameObject

	goCell:SetActive(false)

	for i, v in pairs(self.cellPool) do
		v.ViewGo.transform.parent.gameObject:SetActive(false)
	end

	if self.cfgMallData.ShowItem == Constant.Mall_ShowItem.MultiItem then
		for i, v in ipairs(self.cfgMallData.Item) do
			if i > 3 then
				return
			end

			local cell = self.cellPool[i]

			if cell == nil then
				local goCellClone = UnityEngine.Object.Instantiate(goCell)

				goCellClone.transform:SetParent(goCell.transform.parent, false)

				cell = ItemCell.PackageOrReuseView(self, goCellClone.transform:Find("CommonSlotUI").gameObject, true, true)
				self.cellPool[i] = cell
			end

			cell.ViewGo.transform.parent.gameObject:SetActive(true)
			cell:SetItemByCID(v)
		end
	end
end

function ViewTypeOne:RefreshTimes()
	local showTimes = MallModule.GetResidueBuyTimes(self.cfgMallData.Id)
	local isShow = self.cfgMallData.LimitType == Constant.Mall_LimitType.Day

	if self.goShowTimes then
		self.goShowTimes:SetActive(isShow)
	end

	if self.textNum then
		UGUIUtil.SetText(self.textNum, showTimes)
	end
end

return ViewTypeOne
