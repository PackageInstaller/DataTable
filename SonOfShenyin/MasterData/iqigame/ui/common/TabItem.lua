-- chunkname: @IQIGame\\UI\\Common\\TabItem.lua

local TabItem = Base:Extend("TabItem", "IQIGame.Onigao.UI.Common.TabItem", {})

function TabItem.New(toggleObject, tabView)
	local tbl = Clone(TabItem)

	tbl:OnInit(toggleObject)

	tbl.tabView = tabView

	return tbl
end

function TabItem:OnInit(toggleObject)
	self.toggleObject = toggleObject

	LuaCodeInterface.BindOutlet(self.toggleObject, self)

	function self.delegateOnValueChanged(isOn)
		if isOn then
			self:Show()
		else
			self:Hide()
		end
	end

	self:OnAddListeners()
end

function TabItem:OnDestroy()
	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.toggleObject, self)

	self.toggleObject = nil

	self:Dispose()
end

function TabItem:OnAddListeners()
	self.toggleObject:GetComponent("Toggle").onValueChanged:AddListener(self.delegateOnValueChanged)
end

function TabItem:OnRemoveListeners()
	self.toggleObject:GetComponent("Toggle").onValueChanged:RemoveListener(self.delegateOnValueChanged)
end

function TabItem:OnOpen(userData)
	logDebug("TabItem:OnOpen()")
end

function TabItem:OnClose(userData)
	logDebug("TabItem:OnClose()")
end

function TabItem:Show()
	self.tabView:Show()
end

function TabItem:Hide()
	self.tabView:Hide()
end

function TabItem:Dispose()
	self.tabView:Dispose()
end

return TabItem
