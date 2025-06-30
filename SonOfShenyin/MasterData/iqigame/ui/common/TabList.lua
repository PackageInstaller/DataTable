-- chunkname: @IQIGame\\UI\\Common\\TabList.lua

local TabItem = require("IQIGame.UI.Common.TabItem")
local TabList = Base:Extend("TabList", "IQIGame.Onigao.UI.TabList", {})

function TabList.New(obj)
	local tbl = Clone(TabList)

	tbl:OnInit(obj)

	return tbl
end

function TabList:OnInit(obj)
	self.gameObject = obj

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.tabItems = {}

	self:OnAddListeners()
end

function TabList:OnDestroy()
	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function TabList:OnAddListeners()
	return
end

function TabList:OnRemoveListeners()
	return
end

function TabList:OnOpen(userData)
	return
end

function TabList:OnClose(userData)
	return
end

function TabList:Show()
	self.gameObject:SetActive(true)
end

function TabList:Hide()
	self.gameObject:SetActive(false)
end

function TabList:Items()
	return self.tabItems or {}
end

function TabList:AddItem(toggleObj, tab)
	local tabItem = TabItem.New(toggleObj, tab)

	table.insert(self.tabItems, tabItem)

	return tabItem
end

function TabList:RemoveAllItems()
	for _, tabItem in pairs(self:Items()) do
		tabItem:OnDestroy()
	end

	self.tabItems = {}
end

function TabList:GetPreloadAssetPaths()
	return nil
end

function TabList:GetOpenPreloadAssetPaths(userData)
	return nil
end

function TabList:OnPause()
	return
end

function TabList:OnResume()
	return
end

function TabList:OnCover()
	return
end

function TabList:OnReveal()
	return
end

function TabList:OnRefocus(userData)
	return
end

function TabList:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function TabList:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function TabList:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function TabList:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

return TabList
