-- chunkname: @IQIGame\\UI\\Friend\\AddFriendPanel.lua

local AddFriendPanel = {}
local FriendItemClass = require("IQIGame.UI.Friend.FriendItem")

function AddFriendPanel.New(go, mainView)
	local o = Clone(AddFriendPanel)

	o:Initialize(go, mainView)

	return o
end

function AddFriendPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function AddFriendPanel:InitMembers()
	self.RecommendScrollViewCell = {}
	self.RequestScrollViewCell = {}
end

function AddFriendPanel:InitComponent()
	self.RecommendContent = self.RecommendGroup:GetComponent("ScrollAreaList")

	function self.RecommendContent.onRenderCell(cell)
		self:OnRenderRecommendItem(cell)
	end

	self.RequestContent = self.RequestGroup:GetComponent("ScrollAreaList")

	function self.RequestContent.onRenderCell(cell)
		self:OnRenderApplyItem(cell)
	end
end

function AddFriendPanel:InitDelegate()
	function self.DelegateGetRecommendFriends(friends)
		self:GetRecommendFriends(friends)
	end

	function self.DelegateSearchBtn()
		self:SearchBtnClick()
	end

	function self.DelegateUpdateSearchResult(friend)
		self:UpdateSearchResult(friend)
	end

	function self.DelegateClearInputText()
		self:ClearInputText()
	end

	function self.DelegateUpdateFriend()
		self:UpdateFriend()
	end
end

function AddFriendPanel:AddListener()
	EventDispatcher.AddEventListener(EventID.UpdateFriend, self.DelegateUpdateFriend)
	EventDispatcher.AddEventListener(EventID.GetRecommendFriends, self.DelegateGetRecommendFriends)
	EventDispatcher.AddEventListener(EventID.SearchPlayerResult, self.DelegateUpdateSearchResult)
	self.SearchBtn:GetComponent("Button").onClick:AddListener(self.DelegateSearchBtn)
	self.ClearBtn:GetComponent("Button").onClick:AddListener(self.DelegateClearInputText)
end

function AddFriendPanel:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.UpdateFriend, self.DelegateUpdateFriend)
	EventDispatcher.RemoveEventListener(EventID.GetRecommendFriends, self.DelegateGetRecommendFriends)
	EventDispatcher.RemoveEventListener(EventID.SearchPlayerResult, self.DelegateUpdateSearchResult)
	self.SearchBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateSearchBtn)
	self.ClearBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateClearInputText)
end

function AddFriendPanel:Show()
	self.InputNameID:GetComponent("IQIGame.Onigao.Game.UI.InputField").text = ""

	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function AddFriendPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function AddFriendPanel:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i = 1, #self.RecommendScrollViewCell do
		self.RecommendScrollViewCell[i]:OnDestroy()
	end

	for i = 1, #self.RequestScrollViewCell do
		self.RequestScrollViewCell[i]:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function AddFriendPanel:Refresh()
	FriendModule.GetRecommendFriends()
	self:RefreshAcceptData()
end

function AddFriendPanel:RefreshAcceptData()
	self.ApplyFriendDataS = FriendModule.GetFriends(Constant.FriendType.TYPE_APPLICATION)

	if #self.ApplyFriendDataS <= 0 then
		LuaUtility.SetGameObjectShow(self.NoRequest, true)
		LuaUtility.SetGameObjectShow(self.RequestListGroup, false)
	else
		LuaUtility.SetGameObjectShow(self.NoRequest, false)
		LuaUtility.SetGameObjectShow(self.RequestListGroup, true)
	end

	self.RequestContent:Refresh(#self.ApplyFriendDataS)
end

function AddFriendPanel:OnRenderApplyItem(cell)
	local applyData = self.ApplyFriendDataS[cell.index + 1]
	local insID = cell.gameObject:GetInstanceID()

	if self.RequestScrollViewCell[insID] == nil then
		local item = FriendItemClass.New(cell.gameObject, self)

		self.RequestScrollViewCell[insID] = item
	end

	self.RequestScrollViewCell[insID]:Refresh(applyData, 2)
end

function AddFriendPanel:OnRenderRecommendItem(cell)
	local recommendData = self.RecommendFriendDataS[cell.index + 1]
	local insID = cell.gameObject:GetInstanceID()

	if self.RecommendScrollViewCell[insID] == nil then
		local item = FriendItemClass.New(cell.gameObject, self)

		self.RecommendScrollViewCell[insID] = item
	end

	self.RecommendScrollViewCell[insID]:Refresh(recommendData, 1)
end

function AddFriendPanel:GetRecommendFriends(friends)
	self.RecommendFriendDataS = friends

	self.RecommendContent:Refresh(#self.RecommendFriendDataS)
end

function AddFriendPanel:UpdateSearchResult(friend)
	self.RecommendFriendDataS = {
		friend
	}

	self.RecommendContent:Refresh(#self.RecommendFriendDataS)
end

function AddFriendPanel:SearchBtnClick()
	local input = self.InputNameID:GetComponent("IQIGame.Onigao.Game.UI.InputField")

	if input.text ~= nil and input.text ~= "" then
		FriendModule.SearchPlayerByGUID(tonumber(input.text))

		return
	end

	logColorInfo("请输入ID", colorCode.Yellow)
end

function AddFriendPanel:ClearInputText()
	self.InputNameID:GetComponent("IQIGame.Onigao.Game.UI.InputField").text = ""

	self:Refresh()
end

function AddFriendPanel:UpdateFriend()
	self:Refresh()
end

return AddFriendPanel
