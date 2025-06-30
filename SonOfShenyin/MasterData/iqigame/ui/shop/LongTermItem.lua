-- chunkname: @IQIGame\\UI\\Shop\\LongTermItem.lua

local LongTermItem = {
	lastCount = 0,
	shopScrollItemList = {},
	changePageTabList = {}
}
local shopScrollItemView = require("IQIGame.UI.Shop.ShopScrollItemView.ShopScrollItemView")

function LongTermItem.New(go, mainView)
	local o = Clone(LongTermItem)

	o:Initialize(go, mainView)

	return o
end

function LongTermItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitDelegate()
	self:InitComponent()
	self:AddListener()
end

function LongTermItem:InitComponent()
	self.ItemScrollPageExt = self.ItemScrollParent:GetComponent(typeof(ScrollRectPageExt))
	self.ItemScrollPageExt.OnDrageEnd = self.DelegateOnScrollDragEnd
	self.LeftBtnCom = self.LeftBtn:GetComponent("Button")
	self.RightBtnCom = self.RightBtn:GetComponent("Button")
end

function LongTermItem:InitDelegate()
	function self.DelegateOnScrollDragEnd(index)
		self:OnScrollDragEnd(index)
	end

	function self.DelegateOnClickTab(isOn)
		self:OnTabClick(isOn)
	end

	function self.DelegateOnClickLeftBtn()
		self:OnNextOrUpEvent(-1)
	end

	function self.DelegateOnClickRightBtn()
		self:OnNextOrUpEvent(1)
	end
end

function LongTermItem:AddListener()
	self.LeftBtnCom.onClick:AddListener(self.DelegateOnClickLeftBtn)
	self.RightBtnCom.onClick:AddListener(self.DelegateOnClickRightBtn)
end

function LongTermItem:RemoveListener()
	self.LeftBtnCom.onClick:RemoveListener(self.DelegateOnClickLeftBtn)
	self.RightBtnCom.onClick:RemoveListener(self.DelegateOnClickRightBtn)
end

function LongTermItem:Dispose()
	for k, v in pairs(self.shopScrollItemList) do
		v:Dispose()
	end

	self.shopScrollItemList = nil

	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)
end

function LongTermItem:Show(show)
	LuaUtility.SetGameObjectShow(self.gameObject, show)
end

function LongTermItem:Refresh(Data)
	self.Data = Data
end

function LongTermItem:RefreshAll(recommendData, isMonthCard)
	self.isMonthCard = isMonthCard

	self:RefreshItemScroll(recommendData)
end

function LongTermItem:RefreshItemScroll(recommendData)
	self.ItemScrollPageExt.allPageCount = 0

	local tempBannerCfgs = recommendData

	if #tempBannerCfgs == self.lastCount then
		for i = 1, #tempBannerCfgs do
			local bannerItemView = self:CreateBannerItem(i, self.ItemScrollPageExt.Content.transform, self.shopScrollItemList)

			bannerItemView:SetData(tempBannerCfgs[i], self.isMonthCard)
		end

		self.ItemScrollPageExt.allPageCount = #tempBannerCfgs
	else
		for i = 1, #self.shopScrollItemList do
			self.shopScrollItemList[i]:Hide()
		end

		for i = 1, #tempBannerCfgs do
			local bannerItemView = self:CreateBannerItem(i, self.ItemScrollPageExt.Content.transform, self.shopScrollItemList)

			bannerItemView:SetData(tempBannerCfgs[i], self.isMonthCard)
		end

		self.ItemScrollPageExt.allPageCount = #tempBannerCfgs

		for i = 1, #self.changePageTabList do
			LuaUtility.SetGameObjectShow(self.changePageTabList[i], i <= self.ItemScrollPageExt.allPageCount)
		end

		if self.ItemScrollPageExt.allPageCount <= 0 then
			return
		end

		for i = 1, self.ItemScrollPageExt.allPageCount do
			local tab = self:CreateChangeTab(i)

			tab:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnClickTab)
		end

		self.changePageTabList[1]:GetComponent("Toggle").isOn = true

		if self.ItemScrollPageExt.allPageCount >= 1 then
			self.ItemScrollPageExt:SetHorizontalPos(0)
		end

		self.ItemScrollPageExt:ListPageValueInit()
	end

	self.lastCount = #tempBannerCfgs

	self:InitNextOrUpBtnState()
end

function LongTermItem:CreateBannerItem(index, transPrent, itemList)
	local luaTable = itemList[index]

	if luaTable == nil then
		local longTermItem = UnityEngine.Object.Instantiate(self.longTermPrefab)

		longTermItem.transform:SetParent(transPrent, false)

		luaTable = shopScrollItemView.New(longTermItem, self.mainView)
		itemList[index] = luaTable
	end

	luaTable:Show()

	return luaTable
end

function LongTermItem:CreateChangeTab(index)
	local tab = self.changePageTabList[index]

	if tab == nil then
		tab = UnityEngine.Object.Instantiate(self.ItemTogglePrefab)

		tab.transform:SetParent(self.ItemToggleParent.transform, false)

		self.changePageTabList[index] = tab
	end

	tab:GetComponent("Toggle").isOn = false

	LuaUtility.SetGameObjectShow(tab, true)

	return tab
end

function LongTermItem:OnScrollDragEnd(index)
	self.bannerSelectIndex = index + 1
	self.changePageTabList[self.bannerSelectIndex]:GetComponent("Toggle").isOn = true

	self:UpdateBtnState(0)
end

function LongTermItem:OnTabClick(isOn)
	if isOn then
		local currentTarget = self.mainView.UIController:GetCurrentTarget()

		for i = 1, #self.changePageTabList do
			if self.changePageTabList[i].gameObject == currentTarget then
				self:ToggleTo(i)

				return
			end
		end
	end
end

function LongTermItem:ToggleTo(index)
	self.ItemScrollPageExt:SetHorizontalPos(index - 1)
end

function LongTermItem:OnNextOrUpEvent(value)
	self:UpdateBtnState(value)

	local gotoIndex = self.bannerSelectIndex - 1

	if gotoIndex < 0 or gotoIndex > self.ItemScrollPageExt.allPageCount then
		return
	end

	self.ItemScrollPageExt:SetHorizontalPos(self.bannerSelectIndex - 1)
end

function LongTermItem:UpdateBtnState(value)
	self.LeftBtnCom.interactable = true
	self.RightBtnCom.interactable = true

	local tempValue = self.bannerSelectIndex + value

	if tempValue <= 1 then
		self.LeftBtnCom.interactable = false
		self.RightBtnCom.interactable = true
	end

	if tempValue >= self.ItemScrollPageExt.allPageCount then
		self.RightBtnCom.interactable = false
		self.LeftBtnCom.interactable = true
	end

	self.bannerSelectIndex = tempValue
end

function LongTermItem:InitNextOrUpBtnState()
	local num = self.ItemScrollPageExt.allPageCount

	if num <= 1 then
		LuaUtility.SetGameObjectShow(self.LeftBtnCom.gameObject, false)
		LuaUtility.SetGameObjectShow(self.RightBtnCom.gameObject, false)

		return
	end

	LuaUtility.SetGameObjectShow(self.LeftBtnCom.gameObject, true)
	LuaUtility.SetGameObjectShow(self.RightBtnCom.gameObject, true)

	self.LeftBtnCom.interactable = self.bannerSelectIndex ~= 1
	self.RightBtnCom.interactable = self.bannerSelectIndex ~= num
end

return LongTermItem
