-- chunkname: @IQIGame\\UI\\Skin\\BuySkinTipsView.lua

local m = {}

function m.New(view, fatherView)
	local obj = Clone(m, fatherView)

	obj:Init(view, fatherView)

	return obj
end

function m:Init(view, fatherView)
	self.View = view
	self.FatherView = fatherView

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickBuyBtn()
		self:OnClickBuyBtn()
	end

	function self.DelegateOnClickCancelBtn()
		self:OnClickCancelBtn()
	end

	function self.DelegateOnBuyShopResultEvent()
		self:OnBuyShopResultEvent()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.buyBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBuyBtn)
	self.cancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCancelBtn)
	EventDispatcher.AddEventListener(EventID.BuyItemResult, self.DelegateOnBuyShopResultEvent)
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.buyBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBuyBtn)
	self.cancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCancelBtn)
	EventDispatcher.RemoveEventListener(EventID.BuyItemResult, self.DelegateOnBuyShopResultEvent)
end

function m:SetData(commodityData)
	self.buyCommodityData = commodityData

	LuaUtility.SetGameObjectShow(self.icon, false)
	LuaUtility.SetGameObjectShow(self.icon, true)
	AssetUtil.LoadImage(self, ShopUIApi:GetShopBuyIconPath(self.buyCommodityData:GetPriceIconId()), self.icon:GetComponent("Image"))

	if self.buyCommodityData.isDiscount then
		LuaUtility.SetText(self.needNumText, "×" .. self.buyCommodityData:GetDiscount())
	else
		LuaUtility.SetText(self.needNumText, "×" .. self.buyCommodityData:GetPrice())
	end
end

function m:OnClickCloseBtn()
	self:Hide()
end

function m:OnClickBuyBtn()
	ShopModule.BuyItem(self.buyCommodityData, 1)
end

function m:OnClickCancelBtn()
	self:Hide()
end

function m:OnBuyShopResultEvent()
	self:Hide()
	self.FatherView:OnBuyShopResultEvent()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
