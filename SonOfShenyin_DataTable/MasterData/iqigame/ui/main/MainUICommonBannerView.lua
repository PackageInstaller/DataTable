-- chunkname: @IQIGame\\UI\\Main\\MainUICommonBannerView.lua

local bannerItemCell = require("IQIGame.UI.Main.BannerItemCell")
local m = {
	bannerTimes = 1,
	bannerTotalTimes = 5,
	changePageTabList = {},
	BannerItemList = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnScrollDragEnd(index)
		self:OnScrollDragEnd(index)
	end

	self.BannerScrollPageExt = self.BannerScroll:GetComponent(typeof(ScrollRectPageExt))
	self.BannerScrollPageExt.OnDrageEnd = self.DelegateOnScrollDragEnd

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(bannerCfgs)
	self.bannerCfgs = bannerCfgs
	self.BannerScrollPageExt.allPageCount = 0

	local serverTime = PlayerModule.GetServerTime()
	local tempBannerCfgs = {}
	local openTime = 0
	local closeTime = 0

	for i = 1, #self.bannerCfgs do
		if not LuaUtility.StrIsNullOrEmpty(self.bannerCfgs[i].OpenTime) then
			openTime = cfgDateTimeToTimeStamp(self.bannerCfgs[i].OpenTime)
			closeTime = cfgDateTimeToTimeStamp(self.bannerCfgs[i].OpenTime) + self.bannerCfgs[i].Duration[1]
		end

		if LuaUtility.StrIsNullOrEmpty(self.bannerCfgs[i].OpenTime) or openTime < serverTime and serverTime < closeTime then
			table.insert(tempBannerCfgs, self.bannerCfgs[i])
		end
	end

	for i = 1, #self.BannerItemList do
		self.BannerItemList[i]:Hide()
	end

	for i = 1, #tempBannerCfgs do
		local bannerItemView = self:CreateBannerItem(i, self.BannerScrollPageExt.Content.transform, self.BannerItemList)

		bannerItemView:SetData(tempBannerCfgs[i])
	end

	self.BannerScrollPageExt.allPageCount = #tempBannerCfgs

	for i = 1, #self.changePageTabList do
		LuaUtility.SetGameObjectShow(self.changePageTabList[i], i <= self.BannerScrollPageExt.allPageCount)
	end

	if self.BannerScrollPageExt.allPageCount <= 0 then
		return
	end

	for i = 1, self.BannerScrollPageExt.allPageCount do
		local tab = self:CreateChangeTab(i)
	end

	self.changePageTabList[1]:GetComponent("Toggle").isOn = true

	if self.BannerScrollPageExt.allPageCount >= 1 then
		self.BannerScrollPageExt:SetHorizontalPos(0)
	end

	self.BannerScrollPageExt:ListPageValueInit()
	self:BannerRoll()
end

function m:CreateChangeTab(index)
	local tab = self.changePageTabList[index]

	if tab == nil then
		tab = UnityEngine.Object.Instantiate(self.TabItemPrefab)

		tab.transform:SetParent(self.BannerToggle.transform, false)

		self.changePageTabList[index] = tab
	end

	tab:GetComponent("Toggle").isOn = false

	LuaUtility.SetGameObjectShow(tab, true)

	return tab
end

function m:CreateBannerItem(index, transPrent, itemList)
	local luaTable = itemList[index]

	if luaTable == nil then
		local bannerItem = UnityEngine.Object.Instantiate(self.BannerPrefab)

		bannerItem.transform:SetParent(transPrent, false)

		luaTable = bannerItemCell.New(bannerItem)
		itemList[index] = luaTable
	end

	luaTable:Show()

	return luaTable
end

function m:OnScrollDragEnd(index)
	self.bannerSelectIndex = index + 1
	self.changePageTabList[self.bannerSelectIndex]:GetComponent("Toggle").isOn = true
	self.bannerTimes = 1
end

function m:BannerRoll()
	self:StopBannerTimer()

	if self.BannerScrollPageExt.allPageCount <= 1 then
		return
	end

	self.bannerSelectIndex = 0

	self.BannerScrollPageExt:ResetHorizontalPos()
	self.BannerScrollPageExt:SetHorizontalPos(0)

	self.bannerRollTimer = Timer.New(function()
		self.bannerTimes = self.bannerTimes + 1

		if self.bannerTimes >= self.bannerTotalTimes then
			self.bannerSelectIndex = self.bannerSelectIndex + 1

			if self.bannerSelectIndex > self.BannerScrollPageExt.allPageCount then
				self.bannerSelectIndex = 1
			end

			self.BannerScrollPageExt:SetHorizontalPos(self.bannerSelectIndex - 1)
		end
	end, 1, -1)

	self.bannerRollTimer:Start()
end

function m:StopBannerTimer()
	if self.bannerRollTimer ~= nil then
		self.bannerRollTimer:Stop()

		self.bannerRollTimer = nil
	end
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:StopBannerTimer()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
