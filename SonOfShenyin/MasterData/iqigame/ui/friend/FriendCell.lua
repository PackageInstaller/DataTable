-- chunkname: @IQIGame\\UI\\Friend\\FriendCell.lua

local m = {
	HelpHeroList = {}
}
local FriendRoleItemScript = require("IQIGame.UI.Friend.FriendRoleItem")

function m.PackageOrReuseView(ui, view)
	if ui == nil or view == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_FriendItemCell == nil then
		ui.__SUB_UI_MAP_FriendItemCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_FriendItemCell
	local itemCell

	if subUIMap[view:GetInstanceID()] == nil then
		itemCell = m.__New(view)
		subUIMap[view:GetInstanceID()] = itemCell
	else
		itemCell = subUIMap[view:GetInstanceID()]
	end

	return itemCell
end

function m.__New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateRemarkBtn()
		self:RemarkBtnClick()
	end

	function self.DelegateDeleteBtn()
		self:DeleteBtnClick()
	end

	function self.DelegateVisitHomeBtn()
		self:VisitHomeBtnClick()
	end

	function self.DelegateAddFriend()
		self:AddFriend()
	end

	function self.DelegateAcceptFriend()
		self:AcceptFriend()
	end

	function self.DelegateIgnoreFriend()
		self:IgnoreFriend()
	end

	function self.DelegateOpenPlayerView()
		self:GetPlayerInfo()
	end

	function self.DelegateGetPlayerInfo(playerInfo)
		self:OpenPlayerInfoView(playerInfo)
	end

	self:InstantiateHeroItems()
	self:AddListeners()
	UGUIUtil.SetText(self.LvTitle, "Lv.")
end

function m:AddListeners()
	self.RemarksBtn:GetComponent("Button").onClick:AddListener(self.DelegateRemarkBtn)
	self.DeleteBtn:GetComponent("Button").onClick:AddListener(self.DelegateDeleteBtn)
	self.VisitHomeBtn:GetComponent("Button").onClick:AddListener(self.DelegateVisitHomeBtn)
	self.AddFriendBtn:GetComponent("Button").onClick:AddListener(self.DelegateAddFriend)
	self.AcceptBtn:GetComponent("Button").onClick:AddListener(self.DelegateAcceptFriend)
	self.IgnoreBtn:GetComponent("Button").onClick:AddListener(self.DelegateIgnoreFriend)
	self.DetailBtn:GetComponent("Button").onClick:AddListener(self.DelegateOpenPlayerView)
	EventDispatcher.AddEventListener(EventID.GetPlayerInfoResult, self.DelegateGetPlayerInfo)
end

function m:RemoveListeners()
	self.RemarksBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateRemarkBtn)
	self.DeleteBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateDeleteBtn)
	self.VisitHomeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateVisitHomeBtn)
	self.AddFriendBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateAddFriend)
	self.AcceptBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateAcceptFriend)
	self.IgnoreBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateIgnoreFriend)
	self.DetailBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOpenPlayerView)
	EventDispatcher.RemoveEventListener(EventID.GetPlayerInfoResult, self.DelegateGetPlayerInfo)
end

function m:SetData(friendData, ViewType, PrefabType)
	if friendData == nil then
		self.View:SetActive(false)

		return
	end

	self.FriendData = friendData

	if ViewType == FriendModule.TypeEnum.FriendList then
		self.AddOtherBtn:SetActive(false)
		self:RefreshHelpHeroData(self.FriendData.helpHeros)
	elseif ViewType == FriendModule.TypeEnum.AddFriend then
		self.ListOtherBtn:SetActive(false)
		self.HeroShowGroup:SetActive(false)
		self.Remark:SetActive(false)

		if PrefabType == FriendModule.TypeEnum.RecommendFriend then
			local isfriend = FriendModule.IsFriend(self.FriendData.pId)

			self.AddFriendBtn:SetActive(not isfriend)
			self.IsFriend:SetActive(isfriend)
			self.AcceptBtn:SetActive(false)
			self.IgnoreBtn:SetActive(false)
		elseif PrefabType == FriendModule.TypeEnum.RequestFriend then
			self.AddFriendBtn:SetActive(false)
		end
	end

	UGUIUtil.SetText(self.LvText, self.FriendData.pLv)
	UGUIUtil.SetText(self.FriendName, self.FriendData.pName)
	UGUIUtil.SetText(self.FriendID, self.FriendData.guid)
	UGUIUtil.SetText(self.Remark, self.FriendData.remark)

	if self.FriendData.online then
		UGUIUtil.SetText(self.Online, FriendUIApi:GetOnlinText(true))
	else
		local second = PlayerModule.GetServerTime() - friendData.lastLoginTime

		UGUIUtil.SetText(self.Online, getSimpleTimeDurationText(second <= 0 and 0 or second) .. FriendUIApi:GetOnlinText(false))
	end
end

function m:InstantiateHeroItems()
	local count = self.HeroShowGroup.transform:Find("Items").childCount

	for i = 1, count do
		local obj = self.HeroShowGroup.transform:Find("Items"):GetChild(i - 1).gameObject
		local item = FriendRoleItemScript.New(obj)

		self.HelpHeroList[i] = item
	end
end

function m:RefreshHelpHeroData(helpHeros)
	for i = 1, #self.HelpHeroList do
		if helpHeros[i] ~= nil and helpHeros[i] ~= {} then
			self.HelpHeroList[i]:SetData(helpHeros[i])
			self.HelpHeroList[i]:SetViewState(true)
		else
			self.HelpHeroList[i]:SetViewState(false)
		end
	end
end

function m:VisitHomeBtnClick()
	return
end

function m:RemarkBtnClick()
	EventDispatcher.Dispatch(EventID.OpenChangeRemarkPanel, self.FriendData.id)
end

function m:DeleteBtnClick()
	NoticeModule.ShowNotice(20028, function()
		FriendModule.SendDeleteFriend(self.FriendData.id)
	end, nil)
end

function m:AddFriend()
	FriendModule.SendApplyFriend(self.FriendData.pId)
end

function m:IgnoreFriend()
	FriendModule.SendDealWithApplication({
		self.FriendData.id
	}, false)
end

function m:AcceptFriend()
	FriendModule.SendDealWithApplication({
		self.FriendData.id
	}, true)
end

function m:OpenPlayerInfoView(playerData)
	UIModule.Open(Constant.UIControllerName.UserInfoUI, Constant.UILayer.UI, {
		playerData,
		false
	})
end

function m:GetPlayerInfo()
	UserInfoModule.GetSeverPlayerInfo(self.FriendData.pId, self.FriendData.serverId)
end

function m:Dispose()
	for i = 1, #self.HelpHeroList do
		self.HelpHeroList[i]:Dispose()
	end

	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
