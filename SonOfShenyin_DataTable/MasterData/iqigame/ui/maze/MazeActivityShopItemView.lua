-- chunkname: @IQIGame\\UI\\Maze\\MazeActivityShopItemView.lua

local MazeActivityShopItemView = {}

function MazeActivityShopItemView.New(go, mainView)
	local o = Clone(MazeActivityShopItemView)

	o:Initialize(go, mainView)

	return o
end

function MazeActivityShopItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MazeActivityShopItemView:InitComponent()
	return
end

function MazeActivityShopItemView:InitDelegate()
	function self.delegateOnClickButtonBuy()
		self:OnClickButtonBuy()
	end
end

function MazeActivityShopItemView:AddListener()
	self.buttonBuy:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonBuy)
end

function MazeActivityShopItemView:RemoveListener()
	self.buttonBuy:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonBuy)
end

function MazeActivityShopItemView:OnClickButtonBuy()
	ShopModule.BuyItemRequest(self.data.cid, 1)
end

function MazeActivityShopItemView:OnDestroy()
	return
end

function MazeActivityShopItemView:Refresh(data)
	self.data = data

	local cfgItem = CfgUtil.GetItemCfgDataWithID(self.data.config.ItemId)

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(cfgItem.Icon), self.imageItem:GetComponent("Image"))
	LuaUtility.SetText(self.textName, cfgItem.Name)
	LuaUtility.SetText(self.textPrice, self.data:GetPrice())
	LuaUtility.SetText(self.textLimit, self.data.buyNum)
	LuaUtility.SetText(self.textMaxLimit, self.data.buyLimit)
end

return MazeActivityShopItemView
