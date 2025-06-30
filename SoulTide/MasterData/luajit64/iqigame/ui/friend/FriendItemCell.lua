-- chunkname: @IQIGame\\UI\\Friend\\FriendItemCell.lua

local m = {}

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

function m.DisposeIn(ui)
	if ui.__SUB_UI_MAP_FriendItemCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_FriendItemCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_FriendItemCell = nil
end

function m.__New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(view, self)

	function self.DelegateSetAlias()
		self:SetAlias()
	end

	function self.DelegateVisitHome()
		self:VisitHome()
	end

	function self.DelegateStartPrivateChat()
		self:StartPrivateChat()
	end

	function self.DelegateDeleteFriend()
		self:DeleteFriend()
	end

	function self.DelegateAgreeApplication()
		self:AgreeApplication()
	end

	function self.DelegateRefuseApplication()
		self:RefuseApplication()
	end

	function self.DelegateApply()
		self:Apply()
	end

	function self.DelegateDeleteMute()
		self:DeleteMute()
	end

	function self.DelegateSetMute()
		self:SetMute()
	end

	function self.DelegateClearMute()
		self:ClearMute()
	end

	UGUIUtil.SetText(self.OnlineTimeLabel, FriendUIApi:GetString("OnlineTimeLabel"))
	UGUIUtil.SetTextInChildren(self.PrivateChatBtn, FriendUIApi:GetString("PrivateChatBtnText"))
	UGUIUtil.SetTextInChildren(self.AgreeBtn, FriendUIApi:GetString("AgreeBtnText"))
	UGUIUtil.SetTextInChildren(self.RefuseBtn, FriendUIApi:GetString("RefuseBtnText"))
	UGUIUtil.SetTextInChildren(self.ApplyBtn, FriendUIApi:GetString("ApplyBtnText"))
	UGUIUtil.SetTextInChildren(self.DeleteMuteBtn, FriendUIApi:GetString("DeleteMuteBtnText"))
	UGUIUtil.SetTextInChildren(self.MuteBtn, FriendUIApi:GetString("MuteBtnText"))
	UGUIUtil.SetTextInChildren(self.ClearMuteBtn, FriendUIApi:GetString("ClearMuteBtnText"))
	UGUIUtil.SetText(self.HasAppliedText, FriendUIApi:GetString("HasAppliedText"))
	UGUIUtil.SetText(self.HasDeleteMuteText, FriendUIApi:GetString("HasDeleteMuteText"))
	self:AddEventListeners()
end

function m:SetData(friendData)
	self.View:SetActive(friendData ~= nil)

	if friendData == nil then
		return
	end

	self.FriendData = friendData
	self.PlayerHeadIcon = PlayerHeadUI.New(self.PlayerIcon.transform:GetChild(0).gameObject)

	self.PlayerHeadIcon:SetData(friendData.headIcon, friendData.pLv, friendData.avatarFrame)
	UGUIUtil.SetText(self.FriendNameText, friendData.pName)
	UGUIUtil.SetText(self.FriendAliasText, friendData.remark)

	local isMuted = FriendModule.GetMutePlayerByPId(friendData.pId) ~= nil

	self.MuteBtn:SetActive(not isMuted)
	self.ClearMuteBtn:SetActive(isMuted)

	local onlineText = ""

	if friendData.online then
		onlineText = MiscApi:GetString("OnlineText")
	else
		onlineText = getSimpleTimeDurationText(PlayerModule.GetServerTime() - friendData.lastLoginTime, 3)
	end

	self.LastLoginTimeText:GetComponent("Text").text = onlineText

	for i = 1, 4 do
		self["FunctionBar" .. i]:SetActive(i == friendData.type)
	end

	self.AliasBtn:SetActive(friendData.type == 1)

	local isApplied = FriendModule.IsApplied(friendData.pId)

	self.ApplyBtn:SetActive(not isApplied and PlayerModule.PlayerInfo.baseInfo.pid ~= friendData.pId)
	self.HomeBtn:SetActive(false)

	if friendData.title > 0 then
		local path = UIGlobalApi.GetPrefabRoot(CfgPlayerCoatOfArmsTable[friendData.title].Prefab)

		AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil)
	end
end

function m:AddEventListeners()
	self.AliasBtn:GetComponent("Button").onClick:AddListener(self.DelegateSetAlias)
	self.HomeBtn:GetComponent("Button").onClick:AddListener(self.DelegateVisitHome)
	self.PrivateChatBtn:GetComponent("Button").onClick:AddListener(self.DelegateStartPrivateChat)
	self.DeleteBtn:GetComponent("Button").onClick:AddListener(self.DelegateDeleteFriend)
	self.AgreeBtn:GetComponent("Button").onClick:AddListener(self.DelegateAgreeApplication)
	self.RefuseBtn:GetComponent("Button").onClick:AddListener(self.DelegateRefuseApplication)
	self.ApplyBtn:GetComponent("Button").onClick:AddListener(self.DelegateApply)
	self.DeleteMuteBtn:GetComponent("Button").onClick:AddListener(self.DelegateDeleteMute)
	self.MuteBtn:GetComponent("Button").onClick:AddListener(self.DelegateSetMute)
	self.ClearMuteBtn:GetComponent("Button").onClick:AddListener(self.DelegateClearMute)
end

function m:RemoveEventListeners()
	self.AliasBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateSetAlias)
	self.HomeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateVisitHome)
	self.PrivateChatBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateStartPrivateChat)
	self.DeleteBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateDeleteFriend)
	self.AgreeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateAgreeApplication)
	self.RefuseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateRefuseApplication)
	self.ApplyBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateApply)
	self.DeleteMuteBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateDeleteMute)
	self.MuteBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateSetMute)
	self.ClearMuteBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateClearMute)
end

function m:OnLoadSucceed(assetName, asset, duration, userData)
	for i = 0, self.TitlePos.transform.childCount - 1 do
		local obj = self.TitlePos.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local goTitle = UnityEngine.Object.Instantiate(asset)

	goTitle.transform:SetParent(self.TitlePos.transform, false)
end

function m:SetAlias()
	UIModule.Open(Constant.UIControllerName.InputTextUI, Constant.UILayer.Tooltip, {
		yes = function(text)
			FriendModule.SendSetAlias(self.FriendData.id, text)
		end
	})
end

function m:VisitHome()
	NoticeModule.ShowNotice(21042035)
end

function m:StartPrivateChat()
	if UIModule.HasUI(Constant.UIControllerName.ChatUI) then
		EventDispatcher.Dispatch(EventID.OpenPrivateChatPanel, self.FriendData)
	else
		UIModule.Open(Constant.UIControllerName.ChatUI, Constant.UILayer.DefaultUI, self.FriendData)
	end

	UIModule.Close(Constant.UIControllerName.FriendUI)
end

function m:DeleteFriend()
	NoticeModule.ShowNotice(21040049, self.ConfirmDeleteFriend, nil, self)
end

function m:AgreeApplication()
	FriendModule.SendDealWithApplication({
		self.FriendData.id
	}, true)
end

function m:RefuseApplication()
	FriendModule.SendDealWithApplication({
		self.FriendData.id
	}, false)
end

function m:Apply()
	FriendModule.SendApplyFriend(self.FriendData.pId)
end

function m:DeleteMute()
	FriendModule.SendClearMute(self.FriendData.id)
end

function m:SetMute()
	FriendModule.SendMute(self.FriendData.pId)
end

function m:ClearMute()
	local friendData = FriendModule.GetMutePlayerByPId(self.FriendData.pId)

	FriendModule.SendClearMute(friendData.id)
end

function m:ConfirmDeleteFriend()
	FriendModule.SendDeleteFriend(self.FriendData.id)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveEventListeners()

	if self.PlayerHeadIcon ~= nil then
		self.PlayerHeadIcon:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
