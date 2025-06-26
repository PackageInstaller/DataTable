-- chunkname: @IQIGame\\UI\\PassCheckDeal\\BaseCell.lua

local BaseCell = {}

function BaseCell.New(view)
	local obj = Clone(BaseCell)

	obj:Init(view)

	return obj
end

function BaseCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.imgBg = self.goBg:GetComponent("Image")
	self.btnBuy = self.goBtnBuy:GetComponent("Button")

	function self.onClickBtnBuyDelegate()
		self:OnClickBtnBuy()
	end

	self.goTitle:GetComponent("Text").text = PassCheckDealUIApi:GetString("baseTitle")
end

function BaseCell:Refresh(cfgBattlePassData)
	self.bgPath = UIGlobalApi.GetImagePath(cfgBattlePassData.Image)
	self.cfgMallData = CfgMallTable[cfgBattlePassData.PayMoney]
	self.cfgPayData = CfgPayTable[self.cfgMallData.PayMoney]

	self:RefreshMisc()
end

function BaseCell:OnHide()
	return
end

function BaseCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function BaseCell:OnAddListener()
	self.btnBuy.onClick:AddListener(self.onClickBtnBuyDelegate)
end

function BaseCell:OnRemoveListener()
	self.btnBuy.onClick:RemoveListener(self.onClickBtnBuyDelegate)
end

function BaseCell:OnClickBtnBuy()
	MallModule.ReqPay(self.cfgMallData.PayMoney)
	UIModule.Close(Constant.UIControllerName.PassCheckDealUI)
end

function BaseCell:RefreshMisc()
	AssetUtil.LoadImage(self, self.bgPath, self.imgBg)

	self.goBtnBuy.transform:Find("Text"):GetComponent("Text").text = MiscApi:GetString("moneySign") .. self.cfgPayData.Amount
end

return BaseCell
