-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyShop\\MonsterAcademyBuyView.lua

local m = {
	buyMax = 1,
	buyCont = 1
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

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

	function self.delegateUpdateShopEvent()
		self:OnUpdateShopEvent()
	end

	UGUIUtil.SetText(self.goBtnBuyLabel, MonsterAcademyBuyPanelUIApi:GetString("BtnBuyLabel"))
	UGUIUtil.SetTextInChildren(self.goBtnMax, MonsterAcademyBuyPanelUIApi:GetString("btnMaxTxt"))
	UGUIUtil.SetTextInChildren(self.goBtnMin, MonsterAcademyBuyPanelUIApi:GetString("btnMinTxt"))
	self:AddListener()
end

function m:AddListener()
	self.goBtnBuy:GetComponent("Button").onClick:AddListener(self.onClickBtnBuyDelegate)
	self.goBtnReduce:GetComponent("Button").onClick:AddListener(self.onClickBtnReduceDelegate)
	self.goBtnAdd:GetComponent("Button").onClick:AddListener(self.onClickBtnAddDelegate)
	self.goBtnMin:GetComponent("Button").onClick:AddListener(self.onClickBtnMinDelegate)
	self.goBtnMax:GetComponent("Button").onClick:AddListener(self.onClickBtnMaxDelegate)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateShopEvent, self.delegateUpdateShopEvent)
end

function m:RemoveListener()
	self.goBtnBuy:GetComponent("Button").onClick:RemoveListener(self.onClickBtnBuyDelegate)
	self.goBtnReduce:GetComponent("Button").onClick:RemoveListener(self.onClickBtnReduceDelegate)
	self.goBtnAdd:GetComponent("Button").onClick:RemoveListener(self.onClickBtnAddDelegate)
	self.goBtnMin:GetComponent("Button").onClick:RemoveListener(self.onClickBtnMinDelegate)
	self.goBtnMax:GetComponent("Button").onClick:RemoveListener(self.onClickBtnMaxDelegate)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateShopEvent, self.delegateUpdateShopEvent)
end

function m:OnUpdateShopEvent()
	if self.cfgShopData then
		self:UpdateView()
	end
end

function m:SetData(data)
	self.cfgShopData = data

	self:UpdateView()
end

function m:UpdateView()
	local limitedBuyCount = MonsterAcademyModule.GetResidueBuyTimes(self.cfgShopData.Id)
	local useItemBuyCount = MonsterAcademyModule.GetUseItemBuyCount(self.cfgShopData.Id)

	self.buyMax = math.min(limitedBuyCount, useItemBuyCount)

	UGUIUtil.SetText(self.goDesc, self.cfgShopData.Desc)
	UGUIUtil.SetText(self.goMallName, self.cfgShopData.Name)
	UGUIUtil.SetText(self.goMallValue, self.cfgShopData.ItemNum)

	local path = UIGlobalApi.GetImagePath(CfgGalgameMonsterItemTable[self.cfgShopData.Item].Icon)

	AssetUtil.LoadImage(self, path, self.goMallIcon:GetComponent("Image"))

	local spendPath = UIGlobalApi.GetImagePath(CfgGalgameMonsterItemTable[self.cfgShopData.SellPrice].Icon)

	AssetUtil.LoadImage(self, spendPath, self.goMoneyIcon:GetComponent("Image"))
	self:RefreshCount()
end

function m:RefreshCount()
	if self.buyCont > self.buyMax then
		self.buyCont = self.buyMax
	end

	if self.buyCont <= 0 then
		self.buyCont = 1
	end

	UGUIUtil.SetText(self.goBuyTimes, self.buyCont)
	UGUIUtil.SetText(self.goMoneyNum, self.buyCont * self.cfgShopData.Price)
	UGUIUtil.SetText(self.goMallValue, self.buyCont * self.cfgShopData.ItemNum)
end

function m:OnClickBtnBuy()
	if self.buyMax == 0 then
		NoticeModule.ShowNotice(21045056)

		return
	end

	if self.buyCont == 0 then
		NoticeModule.ShowNotice(21040078)

		return
	end

	MonsterAcademyModule.ShopBuy(self.cfgShopData.Id, self.buyCont)
end

function m:OnClickBtnReduce()
	if self.buyCont > 1 then
		self.buyCont = self.buyCont - 1
	end

	self:RefreshCount()
end

function m:OnClickBtnAdd()
	if self.buyCont < self.buyMax then
		self.buyCont = self.buyCont + 1
	end

	self:RefreshCount()
end

function m:OnClickBtnMax()
	self.buyCont = self.buyMax
	self.buyCont = self.buyCont == 0 and 1 or self.buyCont

	self:RefreshCount()
end

function m:OnClickBtnMin()
	self.buyCont = 1

	self:RefreshCount()
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
