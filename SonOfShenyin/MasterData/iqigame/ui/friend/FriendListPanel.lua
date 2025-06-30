-- chunkname: @IQIGame\\UI\\Friend\\FriendListPanel.lua

local FriendListPanel = {}
local FriendListItemClass = require("IQIGame.UI.Friend.FriendListItem")
local RemarkView = require("IQIGame.UI.Friend.RemarkView")

function FriendListPanel.New(go, mainView)
	local o = Clone(FriendListPanel)

	o:Initialize(go, mainView)

	return o
end

function FriendListPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function FriendListPanel:InitMembers()
	self.friendViewList = {}
	self.ChangeRemarkPanel = nil
end

function FriendListPanel:InitComponent()
	self.FriendListScroll = self.FriendListGroup:GetComponent("OptimizedScrollRect")

	self.FriendListScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:FriendListGroupScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.ChangeRemarkPanel = RemarkView.New(self.RemarkPanel)

	self.ChangeRemarkPanel:Hide()
end

function FriendListPanel:InitDelegate()
	function self.DelegateUpdateFriend()
		self:UpdateFriend()
	end

	function self.DelegateOpenChangeRemark(pId)
		self:OpenChangeRemarkPanel(pId)
	end
end

function FriendListPanel:AddListener()
	EventDispatcher.AddEventListener(EventID.UpdateFriend, self.DelegateUpdateFriend)
	EventDispatcher.AddEventListener(EventID.OpenChangeRemarkPanel, self.DelegateOpenChangeRemark)
end

function FriendListPanel:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.UpdateFriend, self.DelegateUpdateFriend)
	EventDispatcher.RemoveEventListener(EventID.OpenChangeRemarkPanel, self.DelegateOpenChangeRemark)
end

function FriendListPanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function FriendListPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function FriendListPanel:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self.ChangeRemarkPanel:Dispose()

	for i = 1, #self.friendViewList do
		self.friendViewList[i]:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function FriendListPanel:Refresh()
	self.FriendDataS = FriendModule.GetFriends(Constant.FriendType.TYPE_FRIEND)

	if #self.FriendDataS <= 0 then
		LuaUtility.SetGameObjectShow(self.NoFriend, true)
		LuaUtility.SetGameObjectShow(self.FriendListGroup, false)
	else
		LuaUtility.SetGameObjectShow(self.NoFriend, false)
		LuaUtility.SetGameObjectShow(self.FriendListGroup, true)
	end

	self:RefreshFriendListPanelScroll(self.FriendDataS)
end

function FriendListPanel:UpdateFriend()
	self:Refresh()
end

function FriendListPanel:OpenChangeRemarkPanel(pId)
	self.ChangeRemarkPanel:Show()
	self.ChangeRemarkPanel:SetData(pId)
end

function FriendListPanel:RefreshFriendListPanelScroll(data)
	self.FriendListScroll:RefreshByItemCount(#data)
end

function FriendListPanel:FriendListGroupScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.FriendDataS[index + 1]

	if not self.friendViewList[instanceID] then
		self.friendViewList[instanceID] = FriendListItemClass.New(viewGameObject)
	end

	self.friendViewList[instanceID]:Refresh(data)
end

return FriendListPanel
