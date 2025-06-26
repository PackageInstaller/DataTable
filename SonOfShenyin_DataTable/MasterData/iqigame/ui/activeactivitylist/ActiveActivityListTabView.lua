-- chunkname: @IQIGame\\UI\\ActiveActivityList\\ActiveActivityListTabView.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local activityListSubTabView = require("IQIGame.UI.ActiveActivityList.ActiveActivityListSubTabView")
local m = {
	isSelect = false
}

function m.New(view, onClickEvent)
	local obj = Clone(m)

	obj:Init(view, onClickEvent)

	return obj
end

function m:Init(view, onClickEvent)
	self.View = view
	self.OnClickEvent = onClickEvent

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickBtn()
		self:OnClickBtn()
	end

	function self.DelegateOnClickTab(cfgID)
		self:OnClickSubTab(cfgID)
	end

	self.subTabItemPool = UIViewObjectPool.New(self.subTagPrefab, self.subItemParent.transform, function(_view)
		return activityListSubTabView.New(_view, self.DelegateOnClickTab)
	end)

	self:AddListeners()
end

function m:AddListeners()
	self.ClickBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtn)
end

function m:RemoveListeners()
	self.ClickBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtn)
end

function m:SetData(tabCfg)
	self.cfgID = tabCfg.Id
	self.isSelect = false
	self.cfg = tabCfg
	self.subTabList = ActiveActivityListModule.GetSubTabByActivityType(self.cfg.ActivityType)
	self.HasSubTab = table.len(self.subTabList) > 0

	UGUIUtil.SetText(self.UnSelectActivityNameText, self.cfg.Name)
	UGUIUtil.SetText(self.SelectActivityNameText, self.cfg.Name)
	self:CreateSubTabItem()
	self:SetSubTabParentState(false)
	self:RefreshRedDot()
end

function m:RefreshRedDot()
	LuaUtility.SetGameObjectShow(self.RedDot, ActiveActivityListModule.GetRedDotTypeByType(self.cfg))
	self.subTabItemPool:ForItems(function(_item)
		_item:RefreshRedDot()
	end)
end

function m:CreateSubTabItem()
	self.subTabItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	for i = 1, #self.subTabList do
		local subTabItem = self.subTabItemPool:GetFree(function(_item)
			return not _item.View.activeSelf
		end)

		subTabItem:Show()
		subTabItem:SetData(self.subTabList[i])

		if i == 1 then
			self.firstSubTabItem = subTabItem
		end
	end
end

function m:SetSubTabParentState(state)
	LuaUtility.SetGameObjectShow(self.subItemParent, state)
end

function m:OnClickBtn()
	if self.OnClickEvent ~= nil then
		if self.HasSubTab then
			self:OnClickSubTab(self.subTabList[1].Id)
			self.firstSubTabItem:OnSelected()
		else
			self.OnClickEvent(true, self.cfgID, self)
		end
	end

	self.isSelect = not self.isSelect

	self:SetSubTabParentState(self.isSelect)
	LuaUtility.SetGameObjectShow(self.Select, self.isSelect)
	LuaUtility.SetGameObjectShow(self.UnSelect, not self.isSelect)
end

function m:OnClickSubTab(cfgID)
	self.subTabItemPool:ForItems(function(_item)
		_item:OnUnSelected()
	end)

	if self.OnClickEvent ~= nil then
		self.OnClickEvent(false, cfgID, self)
		self:SetSubTabParentState(true)
		self:OnSelected()
	end
end

function m:OnSelected()
	LuaUtility.SetGameObjectShow(self.Select, true)
	LuaUtility.SetGameObjectShow(self.UnSelect, false)
end

function m:OnUnSelected()
	LuaUtility.SetGameObjectShow(self.Select, false)
	LuaUtility.SetGameObjectShow(self.UnSelect, true)
	self:SetSubTabParentState(false)

	self.isSelect = false
end

function m:InitSelectState()
	self.isSelect = false
end

function m:GetCfgID()
	return self.cfgID
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.subTabItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.subTabItemPool = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
