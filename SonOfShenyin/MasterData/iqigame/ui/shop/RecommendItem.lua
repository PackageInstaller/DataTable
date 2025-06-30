-- chunkname: @IQIGame\\UI\\Shop\\RecommendItem.lua

local RecommendItem = {
	rollingTime = 0,
	rollingIndex = 0,
	shopScrollItemList = {},
	changePageTabList = {}
}
local recommendTabTagItemView = require("IQIGame.UI.Shop.ShopScrollItemView.RecommendTabTagItemView")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")

function RecommendItem.New(go, mainView)
	local o = Clone(RecommendItem)

	o:Initialize(go, mainView)

	return o
end

function RecommendItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitDelegate()
	self:InitComponent()
	self:AddListener()
end

function RecommendItem:InitComponent()
	self.ItemScrollPageExt = self.ItemScrollParent:GetComponent(typeof(ScrollRectPageExt))
	self.ItemScrollPageExt.OnDrageEnd = self.DelegateOnScrollDragEnd
	self.LeftBtnCom = self.LeftBtn:GetComponent("Button")
	self.RightBtnCom = self.RightBtn:GetComponent("Button")
	self.previewItemPool = UIViewObjectPool.New(self.secondTagPrefab, self.secondTagConent.transform, function(_view)
		return recommendTabTagItemView.New(_view, function(index)
			self:OnTopTagTabClick(index)
		end)
	end)
end

function RecommendItem:InitDelegate()
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

	function self.delegateOnButtonTrigger(sender, args)
		self:OnButtonTrigger(sender, args)
	end
end

function RecommendItem:AddListener()
	self.LeftBtnCom.onClick:AddListener(self.DelegateOnClickLeftBtn)
	self.RightBtnCom.onClick:AddListener(self.DelegateOnClickRightBtn)
	GameEntry.LuaEvent:Subscribe(ButtonTriggerEventArgs.EventId, self.delegateOnButtonTrigger)
end

function RecommendItem:RemoveListener()
	self.LeftBtnCom.onClick:RemoveListener(self.DelegateOnClickLeftBtn)
	self.RightBtnCom.onClick:RemoveListener(self.DelegateOnClickRightBtn)
	GameEntry.LuaEvent:Unsubscribe(ButtonTriggerEventArgs.EventId, self.delegateOnButtonTrigger)
end

function RecommendItem:Dispose()
	self:RemoveListener()

	for i = 1, #self.shopScrollItemList do
		UnityEngine.Object.Destroy(self.shopScrollItemList[i])
	end

	self.shopScrollItemList = nil

	self.previewItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.previewItemPool = nil
	self.LeftBtnCom = nil
	self.RightBtnCom = nil

	self:DisposeTimer()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)
end

function RecommendItem:DisposeTimer()
	if self.rollingTimer then
		self.rollingTimer:Stop()

		self.rollingTimer = nil
	end
end

function RecommendItem:StartRollingScroll()
	self:DisposeTimer()

	if self.rollingTimer == nil then
		self.rollingTimer = Timer.New(function()
			self.rollingTime = self.rollingTime + 1

			if self.rollingTime >= 5 then
				self:RollingScrollFunc()
			end
		end, 1, -1)

		self.rollingTimer:Start()
	end
end

function RecommendItem:RollingScrollFunc()
	if self.rollingIndex >= self.ItemScrollPageExt.allPageCount then
		self.rollingIndex = 1
	else
		self.rollingIndex = self.rollingIndex + 1
	end

	self:ToggleTo(self.rollingIndex)
end

function RecommendItem:RefreshAll(recommendCfgDatas)
	for i = 1, #self.shopScrollItemList do
		UnityEngine.Object.Destroy(self.shopScrollItemList[i].gameObject)
	end

	self.shopScrollItemList = {}

	self.previewItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	self.rollingIndex = 1
	self.rollingTime = 0

	self:RefreshItemScroll(recommendCfgDatas)
	self:StartRollingScroll()
end

function RecommendItem:RefreshItemScroll(recommendCfgDatas)
	self.ItemScrollPageExt.allPageCount = 0

	local tempBannerCfgs = recommendCfgDatas

	for i = 1, #tempBannerCfgs do
		self:CreateBannerItem(tempBannerCfgs[i], i)
		self:CreateTopTagTab(tempBannerCfgs[i], i)
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
	self:InitNextOrUpBtnState()
end

function RecommendItem:CreateBannerItem(cfg, index)
	AssetUtil.LoadAsset(self, UIGlobalApi.GetUIPrefab(cfg.ShopBannerPrefab), function(_, _assetUrl, _asset, _duration, _userData)
		self:LoadPrefabSuccess(_asset, _userData)
	end, nil, index)
end

function RecommendItem:LoadPrefabSuccess(_asset, index)
	local recommendItem = UnityEngine.Object.Instantiate(_asset)

	recommendItem.transform:SetParent(self.ItemScrollPageExt.Content.transform, false)

	self.shopScrollItemList[index] = recommendItem
end

function RecommendItem:CreateTopTagTab(cfg, index)
	local previewItem = self.previewItemPool:GetFree(function(_item)
		return not _item.View.activeSelf
	end)

	previewItem:SetData(cfg, index)
	previewItem:Show()
end

function RecommendItem:CreateChangeTab(index)
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

function RecommendItem:OnTabClick(isOn)
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

function RecommendItem:ToggleTo(index)
	self.ItemScrollPageExt:SetHorizontalPos(index - 1)
end

function RecommendItem:OnTopTagTabClick(index)
	self:ToggleTo(index)
end

function RecommendItem:OnScrollDragEnd(index)
	self.bannerSelectIndex = index + 1
	self.changePageTabList[self.bannerSelectIndex]:GetComponent("Toggle").isOn = true

	self.previewItemPool:ForItems(function(_item)
		if _item.Index == index + 1 then
			_item:Selected()
		else
			_item:UnSelected()
		end
	end)
	self:UpdateBtnState(0)

	self.rollingIndex = index + 1
	self.rollingTime = 0
end

function RecommendItem:OnNextOrUpEvent(value)
	self:UpdateBtnState(value)

	local gotoIndex = self.bannerSelectIndex - 1

	if gotoIndex < 0 or gotoIndex > self.ItemScrollPageExt.allPageCount then
		return
	end

	self.ItemScrollPageExt:SetHorizontalPos(self.bannerSelectIndex - 1)
end

function RecommendItem:UpdateBtnState(value)
	LuaUtility.SetGameObjectShow(self.LeftBtn, true)
	LuaUtility.SetGameObjectShow(self.RightBtn, true)

	local tempValue = self.bannerSelectIndex + value

	if tempValue <= 1 then
		LuaUtility.SetGameObjectShow(self.LeftBtn, false)
		LuaUtility.SetGameObjectShow(self.RightBtn, true)
	end

	if tempValue >= self.ItemScrollPageExt.allPageCount then
		LuaUtility.SetGameObjectShow(self.LeftBtn, true)
		LuaUtility.SetGameObjectShow(self.RightBtn, false)
	end

	self.bannerSelectIndex = tempValue
end

function RecommendItem:InitNextOrUpBtnState()
	local num = self.ItemScrollPageExt.allPageCount

	if num <= 1 then
		LuaUtility.SetGameObjectShow(self.LeftBtn, false)
		LuaUtility.SetGameObjectShow(self.RightBtn, false)

		return
	end

	LuaUtility.SetGameObjectShow(self.LeftBtn, self.bannerSelectIndex ~= 1)
	LuaUtility.SetGameObjectShow(self.RightBtn, self.bannerSelectIndex ~= num)
end

function RecommendItem:OnButtonTrigger(sender, args)
	if args.valueInt ~= 0 then
		JumpModule.Jump(args.valueInt)

		return
	end

	local userData = string.split(args.valueString, "|")

	self.mainView:JumpShop(userData)
end

return RecommendItem
