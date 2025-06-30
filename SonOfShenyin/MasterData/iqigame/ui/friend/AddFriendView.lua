-- chunkname: @IQIGame\\UI\\Friend\\AddFriendView.lua

local m = {}
local RECOMMEND = 1
local REQUEST = 2
local FriendCell = require("IQIGame.UI.Friend.FriendCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.RecommendContent = self.RecommendGroup:GetComponent("ScrollAreaList")

	function self.RecommendContent.onRenderCell(cell)
		self:OnRenderItem(cell, RECOMMEND)
	end

	self.RequestContent = self.RequestGroup:GetComponent("ScrollAreaList")

	function self.RequestContent.onRenderCell(cell)
		self:OnRenderItem(cell, REQUEST)
	end

	function self.DelegateGetRecommendFriends(friends)
		self:GetRecommendFriends(friends)
	end

	function self.DelegateUpdateSearchResult(friend)
		self:UpdateSearchResult(friend)
	end

	function self.DelegateSearchBtn()
		self:SearchBtnClick()
	end

	function self.DelegateUpdateFriend()
		self:UpdateFriend()
	end

	function self.DelegateClearInputText()
		self:ClearInputText()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.SearchBtn:GetComponent("Button").onClick:AddListener(self.DelegateSearchBtn)
	self.ClearBtn:GetComponent("Button").onClick:AddListener(self.DelegateClearInputText)
	EventDispatcher.AddEventListener(EventID.GetRecommendFriends, self.DelegateGetRecommendFriends)
	EventDispatcher.AddEventListener(EventID.SearchPlayerResult, self.DelegateUpdateSearchResult)
	EventDispatcher.AddEventListener(EventID.UpdateFriend, self.DelegateUpdateFriend)
end

function m:RemoveListeners()
	self.SearchBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateSearchBtn)
	self.ClearBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateClearInputText)
	EventDispatcher.RemoveEventListener(EventID.GetRecommendFriends, self.DelegateGetRecommendFriends)
	EventDispatcher.RemoveEventListener(EventID.SearchPlayerResult, self.DelegateUpdateSearchResult)
	EventDispatcher.RemoveEventListener(EventID.UpdateFriend, self.DelegateUpdateFriend)
end

function m:SetData()
	return
end

function m:OnRenderItem(cell, type)
	local data = self.FriendDatas[cell.index + 1]
	local item

	item = FriendCell.PackageOrReuseView(self, cell.gameObject)

	if type == RECOMMEND then
		item:SetData(data, FriendModule.TypeEnum.AddFriend, FriendModule.TypeEnum.RecommendFriend)
	elseif type == REQUEST then
		item:SetData(data, FriendModule.TypeEnum.AddFriend, FriendModule.TypeEnum.RequestFriend)
	end
end

function m:SearchBtnClick()
	local input = self.InputNameID:GetComponent("IQIGame.Onigao.Game.UI.InputField")

	if input.text ~= nil and input.text ~= "" then
		FriendModule.SearchPlayerByGUID(tonumber(input.text))

		return
	end

	logColorInfo("请输入ID", colorCode.Yellow)
end

function m:GetRecommendFriends(friends)
	self.FriendDatas = friends

	self.RecommendContent:Refresh(#self.FriendDatas)
end

function m:UpdateSearchResult(friend)
	self.FriendDatas = {
		friend
	}

	self.RecommendContent:Refresh(#self.FriendDatas)
end

function m:AccpectFriendResult()
	self.FriendDatas = FriendModule.GetFriends(Constant.FriendType.TYPE_APPLICATION)

	self.RequestContent:Refresh(#self.FriendDatas)
	self.NoRequest:SetActive(#self.FriendDatas <= 0)
end

function m:UpdateFriend()
	self:AccpectFriendResult()
end

function m:ClearInputText()
	self.InputNameID:GetComponent("IQIGame.Onigao.Game.UI.InputField").text = ""
end

function m:Show()
	self.View:SetActive(true)
	self:AccpectFriendResult()
	FriendModule.GetRecommendFriends()
end

function m:Hide()
	self.View:SetActive(false)
	self:ClearInputText()
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
