-- chunkname: @IQIGame\\UI\\Friend\\FriendListView.lua

local m = {}
local FriendCell = require("IQIGame.UI.Friend.FriendCell")
local RemarkView = require("IQIGame.UI.Friend.RemarkView")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.wrapContent = self.FriendListGroup:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	function self.DelegateUpdateFriend()
		self:UpdateFriend()
	end

	function self.DelegateOpenChangeRemark(pId)
		self:OpenChangeRemarkPanel(pId)
	end

	self.ChangeRemarkPanel = RemarkView.New(self.RemarkPanel)

	self.ChangeRemarkPanel:Hide()
	self:AddListeners()
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.UpdateFriend, self.DelegateUpdateFriend)
	EventDispatcher.AddEventListener(EventID.OpenChangeRemarkPanel, self.DelegateOpenChangeRemark)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.UpdateFriend, self.DelegateUpdateFriend)
	EventDispatcher.RemoveEventListener(EventID.OpenChangeRemarkPanel, self.DelegateOpenChangeRemark)
end

function m:SetData()
	return
end

function m:OnRenderItem(cell)
	local data = self.FriendDatas[cell.index + 1]
	local item = FriendCell.PackageOrReuseView(self, cell.gameObject)

	item:SetData(data, FriendModule.TypeEnum.FriendList)
end

function m:UpdateFriend()
	self.FriendDatas = FriendModule.GetFriends(Constant.FriendType.TYPE_FRIEND)

	self.wrapContent:Refresh(#self.FriendDatas)
	self.NoFriend:SetActive(#self.FriendDatas <= 0)
end

function m:Show()
	self.View:SetActive(true)
	self:UpdateFriend()
end

function m:Hide()
	self.View:SetActive(false)
end

function m:OpenChangeRemarkPanel(pId)
	self.ChangeRemarkPanel:Show()
	self.ChangeRemarkPanel:SetData(pId)
end

function m:Dispose()
	self:RemoveListeners()
	self.ChangeRemarkPanel:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
