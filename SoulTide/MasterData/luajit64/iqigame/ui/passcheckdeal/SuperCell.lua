-- chunkname: @IQIGame\\UI\\PassCheckDeal\\SuperCell.lua

local SuperCell = {}

function SuperCell.New(view)
	local obj = Clone(SuperCell)

	obj:Init(view)

	return obj
end

function SuperCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfDiscount = self.goDiscount:GetComponent("Text")
	self.imgBg = self.goBg:GetComponent("Image")
	self.btnBuy = self.goBtnBuy:GetComponent("Button")

	function self.onClickBtnBuyDelegate()
		self:OnClickBtnBuy()
	end

	self.goTitle:GetComponent("Text").text = PassCheckDealUIApi:GetString("superTitle")
	self.goDesc:GetComponent("Text").text = PassCheckDealUIApi:GetString("superDesc")
end

function SuperCell:Refresh(cfgBattlePassData)
	self.bgPath = UIGlobalApi.GetImagePath(cfgBattlePassData.BundleImage)
	self.cfgMallData = CfgMallTable[cfgBattlePassData.LvBundlePayMoney]
	self.cfgPayData = CfgPayTable[self.cfgMallData.PayMoney]

	self:RefreshMisc()
end

function SuperCell:OnHide()
	return
end

function SuperCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SuperCell:OnAddListener()
	self.btnBuy.onClick:AddListener(self.onClickBtnBuyDelegate)
end

function SuperCell:OnRemoveListener()
	self.btnBuy.onClick:RemoveListener(self.onClickBtnBuyDelegate)
end

function SuperCell:OnClickBtnBuy()
	MallModule.ReqPay(self.cfgMallData.PayMoney)
	UIModule.Close(Constant.UIControllerName.PassCheckDealUI)
end

function SuperCell:RefreshMisc()
	self.goDiscount.transform.parent.gameObject:SetActive(self.cfgMallData.Discount ~= 0)

	if self.cfgMallData.Discount ~= 0 then
		self.tfDiscount.text = PassCheckDealUIApi:GetString("superDiscount", self.cfgMallData.Discount, self.cfgPayData.Amount)
	end

	AssetUtil.LoadImage(self, self.bgPath, self.imgBg)

	self.goBtnBuy.transform:Find("Text"):GetComponent("Text").text = MiscApi:GetString("moneySign") .. self.cfgPayData.Amount
end

return SuperCell
