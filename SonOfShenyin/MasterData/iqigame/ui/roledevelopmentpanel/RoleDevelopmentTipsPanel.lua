-- chunkname: @IQIGame\\UI\\RoleDevelopmentPanel\\RoleDevelopmentTipsPanel.lua

local UITabList = require("IQIGame.UI.Common.UITabList")
local ScrollItem = {
	p1Content = {},
	p2Content = {},
	p3Content = {}
}

function ScrollItem.New(view)
	local obj = Clone(ScrollItem)

	obj:__Init(view)

	return obj
end

function ScrollItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	LuaCodeInterface.BindOutlet(self.p1Root, self.p1Content)
	LuaCodeInterface.BindOutlet(self.p2Root, self.p2Content)
	LuaCodeInterface.BindOutlet(self.p3Root, self.p3Content)
end

function ScrollItem:Show(data, isCurrent)
	self.gameObject.gameObject:SetActive(true)
	self.tagNowGo.gameObject:SetActive(isCurrent)

	if data.Type == 1 then
		self:__ShowProperty(data)
	elseif data.Type == 2 then
		self:__ShowLXZH(data)
	elseif data.Type == 3 then
		self:__ShowJob(data)
	else
		self.gameObject.gameObject:SetActive(false)
	end
end

function ScrollItem:__ShowProperty(data)
	self.p1Root.gameObject:SetActive(true)
	self.p2Root.gameObject:SetActive(false)
	self.p3Root.gameObject:SetActive(false)

	self.p1Content.textGo:GetComponent("Text").text = data.Title

	self:__ShowCommonContent(self.p1Content.iconGo, data.icon, self.p1Content.contentGo, data.Content)
end

function ScrollItem:__ShowLXZH(data)
	self.p1Root.gameObject:SetActive(false)
	self.p2Root.gameObject:SetActive(true)
	self.p3Root.gameObject:SetActive(false)
	self:__ShowCommonContent(self.p2Content.iconGo, data.icon, self.p2Content.contentGo, data.Content)
end

function ScrollItem:__ShowJob(data)
	self.p1Root.gameObject:SetActive(false)
	self.p2Root.gameObject:SetActive(false)
	self.p3Root.gameObject:SetActive(true)
	self:__ShowCommonContent(self.p3Content.iconGo, data.icon, self.p3Content.contentGo, data.Content)
end

function ScrollItem:__ShowCommonContent(iconGo, iconPath, contentGo, contentStr)
	contentGo:GetComponent("Text").text = contentStr

	if LuaUtility.StrIsNullOrEmpty(iconPath) then
		iconGo.gameObject:SetActive(false)
	else
		iconGo.gameObject:SetActive(true)
		AssetUtil.LoadImage(self, iconPath, iconGo.gameObject:GetComponent("Image"))
	end
end

function ScrollItem:Hide()
	self.gameObject.gameObject:SetActive(false)
end

function ScrollItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.p1Root, self.p1Content)
	LuaCodeInterface.ClearOutlet(self.p2Root, self.p2Content)
	LuaCodeInterface.ClearOutlet(self.p3Root, self.p3Content)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local panel = {
	roleCid = 0,
	scrollItemList = {}
}

function panel.New(view)
	local obj = Clone(panel)

	obj:__Init(view)

	return obj
end

function panel:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__InitTabList()

	self.itemAreaList = self.scrollArea.gameObject:GetComponent("ScrollAreaList")

	function self.itemAreaList.onRenderCell(cell)
		self:__OnRenderItem(cell)
	end

	function self.__OnCloseBtnClickEventProxy()
		self:Hide()
	end

	self.closeBtn.gameObject:GetComponent("Button").onClick:AddListener(self.__OnCloseBtnClickEventProxy)
	self:Hide()
end

function panel:__InitTabList()
	self.tabList = UITabList.Create()

	self.tabList:AddTableItem(self.tabItem1, nil, function(_isOn, _view)
		if not _isOn then
			return
		end

		self:__Refresh(1)
	end)
	self.tabList:AddTableItem(self.tabItem2, nil, function(_isOn, _view)
		if not _isOn then
			return
		end

		self:__Refresh(2)
	end)
	self.tabList:AddTableItem(self.tabItem3, nil, function(_isOn, _view)
		if not _isOn then
			return
		end

		self:__Refresh(3)
	end)
end

function panel:__OnRenderItem(cell)
	local insID = cell.gameObject:GetInstanceID()
	local scrollItem = self.scrollItemList[insID]

	if scrollItem == nil then
		scrollItem = ScrollItem.New(cell.gameObject)
		self.scrollItemList[insID] = scrollItem
	end

	local data = self.tipsListData[cell.index + 1]
	local isCurrent = false

	if self.tabList:GetSelectIndex() ~= 2 then
		isCurrent = cell.index == 0
	end

	scrollItem:Show(data, isCurrent)
end

function panel:Show(roleCid)
	self.gameObject.gameObject:SetActive(true)

	self.roleCid = roleCid

	self.tabList:ChangeSelectIndex(1)
end

function panel:__Refresh(_index)
	self.tipsListData = RoleDevelopmentModule.TipsCfgTable[self.tabList:GetSelectIndex()]

	local heroData = WarlockModule.WarlockDataDic[self.roleCid]
	local targetValue = 0

	if _index == 3 then
		targetValue = heroData.BaseData.Profession
	else
		targetValue = heroData.BaseData.Elements

		if targetValue == nil then
			targetValue = 0
		end
	end

	self:__SortByProperty(targetValue)
	self.itemAreaList:Refresh(#self.tipsListData)
end

function panel:__SortByProperty(targetValue)
	table.sort(self.tipsListData, function(a, b)
		local index_a = self:__GetValueInArrayIndex(a.OrderValue, targetValue)
		local index_b = self:__GetValueInArrayIndex(b.OrderValue, targetValue)

		if index_a == index_b then
			return a.Order < b.Order
		end

		return index_a < index_b
	end)
end

function panel:__GetValueInArrayIndex(array, value)
	local index = 99

	ForArray(array, function(k, v)
		if value == v then
			index = k

			return true
		end
	end)

	return index
end

function panel:Hide()
	self.gameObject.gameObject:SetActive(false)
end

function panel:Dispose()
	self.closeBtn.gameObject:GetComponent("Button").onClick:RemoveListener(self.__OnCloseBtnClickEventProxy)
	self.tabList:Dispose()
	ForPairs(self.scrollItemList, function(_, _scrollItem)
		_scrollItem:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return panel
