-- chunkname: @IQIGame\\UI\\FriendUI.lua

local FriendUI = {}

FriendUI = Base:Extend("FriendUI", "IQIGame.Onigao.UI.FriendUI", FriendUI)

local FriendListViewScript = require("IQIGame.UI.Friend.FriendListPanel")
local AddFriendViewScript = require("IQIGame.UI.Friend.AddFriendPanel")
local TOGGLE_FRIEND_LIST = 1
local TOGGLE_ADD_FRIEND = 2

function FriendUI:OnInit()
	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:InitTabs()

	self.RedDot_20003 = self.TypeTabs[2].transform:Find("RedDot").gameObject
end

function FriendUI:InitMembers()
	self.TypeTabs = {}
	self.ViewScript = {}
end

function FriendUI:InitComponent()
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.ViewScript[TOGGLE_FRIEND_LIST] = FriendListViewScript.New(self.FriendListView, self)
	self.ViewScript[TOGGLE_ADD_FRIEND] = AddFriendViewScript.New(self.AddFriendView, self)
end

function FriendUI:InitDelegate()
	function self.DelegateOnClickTab(isOn)
		self:OnClickTab(isOn)
	end

	function self.DelegateRefreshFriendCount()
		self:RefreshFriendCount()
	end
end

function FriendUI:GetPreloadAssetPaths()
	return nil
end

function FriendUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FriendUI:IsManualShowOnOpen(userData)
	return false
end

function FriendUI:GetBGM(userData)
	return nil
end

function FriendUI:OnOpen(userData)
	self.TypeTabs[1]:GetComponent("Toggle").isOn = true

	self:ToggleTo(1)
	self:RefreshFriendCount()
end

function FriendUI:OnClose(userData)
	return
end

function FriendUI:OnAddListeners()
	for i = 1, #self.TypeTabs do
		self.TypeTabs[i]:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnClickTab)
	end

	EventDispatcher.AddEventListener(EventID.UpdateFriend, self.DelegateRefreshFriendCount)
	RedDotModule.Subscribe(Constant.E_RedDotPath.LeftMenu_Friend_Application, self.RedDot_20003)
end

function FriendUI:OnRemoveListeners()
	for i = 1, #self.TypeTabs do
		self.TypeTabs[i]:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnClickTab)
	end

	EventDispatcher.RemoveEventListener(EventID.UpdateFriend, self.DelegateRefreshFriendCount)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.LeftMenu_Friend_Application, self.RedDot_20003)
end

function FriendUI:OnPause()
	return
end

function FriendUI:OnResume()
	return
end

function FriendUI:OnCover()
	return
end

function FriendUI:OnReveal()
	return
end

function FriendUI:OnRefocus(userData)
	return
end

function FriendUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FriendUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FriendUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FriendUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FriendUI:OnDestroy()
	for i = 1, #self.ViewScript do
		self.ViewScript[i]:OnDestroy()
	end

	self.commonReturnBtn:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
end

function FriendUI:InitTabs()
	local tabTexts = FriendUIApi:GetToggleTexts()

	for i = 1, #tabTexts do
		local tabBtn = UnityEngine.Object.Instantiate(self.TogglePrefab)

		tabBtn:GetComponent("ToggleHelperComponent").text = tabTexts[i]

		tabBtn.transform:SetParent(self.TabGroup.transform, false)

		self.TypeTabs[i] = tabBtn
	end
end

function FriendUI:OnClickTab(isOn)
	if isOn then
		local currentTarget = self.UIController:GetCurrentTarget()

		for i = 1, #self.TypeTabs do
			if self.TypeTabs[i].gameObject == currentTarget then
				self:ToggleTo(i)

				return
			end
		end
	end
end

function FriendUI:ToggleTo(panelIndex)
	for i = 1, #self.ViewScript do
		if panelIndex == i then
			self.ViewScript[i]:Show()
			self.ViewScript[i]:Refresh()
		else
			self.ViewScript[i]:Hide()
		end
	end
end

function FriendUI:RefreshFriendCount()
	local Curcount = #FriendModule.FriendDatas[Constant.FriendType.TYPE_FRIEND]
	local MaxCount = FriendModule.GetFriendMaxCount()

	self.CurFriendCount:GetComponent("Text").text = Curcount
	self.MaxFriendCount:GetComponent("Text").text = MaxCount
end

return FriendUI
