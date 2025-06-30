-- chunkname: @IQIGame\\UI\\Shop\\SoulStoneShopCell.lua

local SoulStoneShopCell = {}

function SoulStoneShopCell.New(go, mainView)
	local o = Clone(SoulStoneShopCell)

	o:Initialize(go, mainView)

	return o
end

function SoulStoneShopCell:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function SoulStoneShopCell:InitComponent()
	self.buyButton = self.BuyButton:GetComponent("Button")
end

function SoulStoneShopCell:InitDelegate()
	function self.OnGotoBuyClicked()
		self:OnClickGotoBuy()
	end
end

function SoulStoneShopCell:AddListener()
	self.buyButton.onClick:AddListener(self.OnGotoBuyClicked)
end

function SoulStoneShopCell:RemoveListener()
	self.buyButton.onClick:RemoveListener(self.OnGotoBuyClicked)
end

function SoulStoneShopCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)
end

function SoulStoneShopCell:Refresh(data)
	self.Data = data

	if data.isShow == false then
		LuaUtility.SetGameObjectShow(self.gameObject, false)

		return
	end

	self:CheckShopInfo()
end

function SoulStoneShopCell:CheckShopInfo()
	LuaUtility.SetText(self.textName, CfgItemTable[self.Data.config.ItemId].Name .. " × " .. self.Data.config.Number)
	LuaUtility.SetText(self.textNum, self.Data.config.Number)
	LuaUtility.SetText(self.textMoney, self.Data:GetPrice())
	AssetUtil.LoadImage(self, ShopUIApi:GetShopBuyIconPath(self.Data:GetPriceIconId()), self.imagePriceIcon:GetComponent("Image"))
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.Data.config.Icon), self.ItemRoot:GetComponent("Image"), function()
		self.ItemRoot:GetComponent("Image"):SetNativeSize()
	end)
	LuaUtility.SetGameObjectShow(self.TitleText, false)
	LuaUtility.SetGameObjectShow(self.textExtra, false)

	local showBG = false

	if self.Data.config.IsDouble and not self.Data.useDouble then
		LuaUtility.SetGameObjectShow(self.TitleText, true)

		showBG = true
	end

	if self.Data.useDouble and table.len(self.Data.config.Additional) > 0 then
		LuaUtility.SetGameObjectShow(self.textExtra, true)

		local additionalCount = self.Data.config.Additional[2]

		LuaUtility.SetText(self.textExtraNum, "×" .. additionalCount)

		showBG = true
	end

	LuaUtility.SetGameObjectShow(self.doubleRoot, showBG)
end

function SoulStoneShopCell:OnClickGotoBuy()
	UIModule.Open(Constant.UIControllerName.BuyResItemUI, Constant.UILayer.UI, {
		data = self.Data
	})
end

return SoulStoneShopCell
