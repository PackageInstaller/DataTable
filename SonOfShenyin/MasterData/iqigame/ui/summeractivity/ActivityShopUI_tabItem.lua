-- chunkname: @IQIGame\\UI\\SummerActivity\\ActivityShopUI_tabItem.lua

local ActivityShopUI_tabItem = {}

function ActivityShopUI_tabItem.New(go, mainView)
	local o = Clone(ActivityShopUI_tabItem)

	o:Initialize(go, mainView)

	return o
end

function ActivityShopUI_tabItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ActivityShopUI_tabItem:InitComponent()
	return
end

function ActivityShopUI_tabItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function ActivityShopUI_tabItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function ActivityShopUI_tabItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function ActivityShopUI_tabItem:OnClickButtonClick()
	self.mainView:OnTabSelected(self)
end

function ActivityShopUI_tabItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function ActivityShopUI_tabItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function ActivityShopUI_tabItem:Selected()
	LuaUtility.SetGameObjectShow(self.selectedRoot, true)
end

function ActivityShopUI_tabItem:UnSelected()
	LuaUtility.SetGameObjectShow(self.selectedRoot, false)
end

function ActivityShopUI_tabItem:Refresh(Data)
	self.data = Data

	LuaUtility.SetText(self.textName, self.data.TagName)

	if self.mainView.currentTabId and self.mainView.currentTabId == self.data.Id then
		self:Selected()
	else
		self:UnSelected()
	end
end

function ActivityShopUI_tabItem:OnDestroy()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return ActivityShopUI_tabItem
