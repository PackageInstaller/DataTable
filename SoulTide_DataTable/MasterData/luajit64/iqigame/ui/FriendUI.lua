-- chunkname: @IQIGame\\UI\\FriendUI.lua

local FriendUI = {
	SEARCH_MODE_RESULT = 2,
	CurrentTabIndex = 0,
	SEARCH_MODE_HOME = 1,
	TAB_INDEX_TYPE_MAP = {
		Constant.FriendType.TYPE_FRIEND,
		Constant.FriendType.TYPE_APPLICATION,
		Constant.FriendType.TYPE_STRANGER,
		Constant.FriendType.TYPE_MUTE
	}
}

FriendUI = Base:Extend("FriendUI", "IQIGame.Onigao.UI.FriendUI", FriendUI)

local FriendItemCell = require("IQIGame.UI.Friend.FriendItemCell")

function FriendUI:OnInit()
	function self.DelegateOnClickTab(isOn)
		self:OnClickTab(isOn)
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateUpdateFriends(cell)
		self:UpdateFriends(cell)
	end

	function self.DelegateAgreeAllApplication()
		self:AgreeAllApplication()
	end

	function self.DelegateDeleteAllApplication()
		self:DeleteAllApplication()
	end

	function self.DelegateOnGetRecommendFriends()
		self:OnGetRecommendFriends()
	end

	function self.DelegateSearchFriend()
		self:SearchFriend()
	end

	function self.DelegateUpdateFriend()
		self:UpdateFriend()
	end

	function self.DelegateGetRecommendFriends(friends)
		self:GetRecommendFriends(friends)
	end

	function self.DelegateUpdateSearchResult(friend)
		self:UpdateSearchResult(friend)
	end

	function self.DelegateOnSearchModeApplyAll()
		self:OnSearchModeApplyAll()
	end

	function self.DelegateOnSearchModeReturn()
		self:OnSearchModeReturn()
	end

	function self.DelegateOnPlayerHeadFrameLoaded()
		self:OnPlayerHeadFrameLoaded()
	end

	self.Tabs = {}
	self.RedPoints = {}

	for i = 1, 4 do
		local tabBtn = UnityEngine.Object.Instantiate(self.TabBtnPrefab)

		tabBtn.transform:SetParent(self.TabGrid.transform, false)

		local tabText = FriendUIApi:GetString("TabBtnText", i)
		local tabOutlet = {}

		LuaCodeInterface.BindOutlet(tabBtn, tabOutlet)
		UGUIUtil.SetText(tabOutlet.OnText1, tabText)
		UGUIUtil.SetText(tabOutlet.OffText1, tabText)

		self.RedPoints[i] = tabOutlet.RedPoint

		tabOutlet.RedPoint:SetActive(false)

		self.Tabs[i] = tabBtn

		LuaCodeInterface.ClearOutlet(tabBtn, tabOutlet)
	end

	self.ContentScrollArea = self.ContentGrid:GetComponent("ScrollAreaList")
	self.ContentScrollArea.onRenderCell = self.DelegateUpdateFriends

	UGUIUtil.SetText(self.TitleText, FriendUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.AgreeAllApplyBtn, FriendUIApi:GetString("AgreeAllApplyBtnText"))
	UGUIUtil.SetTextInChildren(self.ClearAllApplyBtn, FriendUIApi:GetString("ClearAllApplyBtnText"))
	UGUIUtil.SetTextInChildren(self.RecommendBtn, FriendUIApi:GetString("RecommendBtnText"))
	UGUIUtil.SetTextInChildren(self.SearchBtn, FriendUIApi:GetString("SearchBtnText"))
	UGUIUtil.SetTextInChildren(self.SearchModeApplyAllBtn, FriendUIApi:GetString("SearchModeApplyAllBtnText"))
	UGUIUtil.SetTextInChildren(self.SearchModeReturnBtn, FriendUIApi:GetString("SearchModeReturnBtnText"))
	UGUIUtil.SetText(self.NoneTitleText, FriendUIApi:GetString("NoneTitleText"))
	UGUIUtil.SetText(self.NoneBubbleText, FriendUIApi:GetString("NoneBubbleText"))
	UGUIUtil.SetText(self.NoneTipText, FriendUIApi:GetString("NoneTipText"))
	UGUIUtil.SetText(self.NoneBubbleApplyText, FriendUIApi:GetString("NoneBubbleApplyText"))
	UGUIUtil.SetText(self.NoneTipApplyText, FriendUIApi:GetString("NoneTipApplyText"))
	UGUIUtil.SetText(self.NoneBubbleMuteText, FriendUIApi:GetString("NoneBubbleMuteText"))
	UGUIUtil.SetText(self.NoneTipMuteText, FriendUIApi:GetString("NoneTipMuteText"))

	local searchInputField = self.SearchInputField:GetComponent("IQIGame.Onigao.Game.UI.InputField")

	searchInputField.placeholder.text = FriendUIApi:GetString("SearchInputFieldPlaceholder")
end

function FriendUI:GetPreloadAssetPaths()
	return nil
end

function FriendUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FriendUI:OnOpen(userData)
	self.SearchInputField:GetComponent("IQIGame.Onigao.Game.UI.InputField").text = ""

	self:UpdateView()
end

function FriendUI:OnClose(userData)
	return
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
	FriendItemCell.DisposeIn(self)

	self.ContentScrollArea = nil
end

function FriendUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.AgreeAllApplyBtn:GetComponent("Button").onClick:AddListener(self.DelegateAgreeAllApplication)
	self.ClearAllApplyBtn:GetComponent("Button").onClick:AddListener(self.DelegateDeleteAllApplication)
	self.SearchBtn:GetComponent("Button").onClick:AddListener(self.DelegateSearchFriend)
	self.RecommendBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnGetRecommendFriends)
	self.SearchModeApplyAllBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnSearchModeApplyAll)
	self.SearchModeReturnBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnSearchModeReturn)

	for i = 1, #self.Tabs do
		local toggle = self.Tabs[i]:GetComponent("Toggle")

		toggle.onValueChanged:AddListener(self.DelegateOnClickTab)
	end

	EventDispatcher.AddEventListener(EventID.UpdateFriend, self.DelegateUpdateFriend)
	EventDispatcher.AddEventListener(EventID.GetRecommendFriends, self.DelegateGetRecommendFriends)
	EventDispatcher.AddEventListener(EventID.SearchPlayerResult, self.DelegateUpdateSearchResult)
	EventDispatcher.AddEventListener(EventID.PlayerHeadFrameLoaded, self.DelegateOnPlayerHeadFrameLoaded)
end

function FriendUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.AgreeAllApplyBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateAgreeAllApplication)
	self.ClearAllApplyBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateDeleteAllApplication)
	self.SearchBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateSearchFriend)
	self.RecommendBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnGetRecommendFriends)
	self.SearchModeApplyAllBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnSearchModeApplyAll)
	self.SearchModeReturnBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnSearchModeReturn)

	for i = 1, #self.Tabs do
		local toggle = self.Tabs[i]:GetComponent("Toggle")

		toggle.onValueChanged:RemoveListener(self.DelegateOnClickTab)
	end

	EventDispatcher.RemoveEventListener(EventID.UpdateFriend, self.DelegateUpdateFriend)
	EventDispatcher.RemoveEventListener(EventID.GetRecommendFriends, self.DelegateGetRecommendFriends)
	EventDispatcher.RemoveEventListener(EventID.SearchPlayerResult, self.DelegateUpdateSearchResult)
	EventDispatcher.RemoveEventListener(EventID.PlayerHeadFrameLoaded, self.DelegateOnPlayerHeadFrameLoaded)
end

function FriendUI:UpdateView()
	self.Tabs[1]:GetComponent("Toggle").isOn = true

	self:ShowTab(1)
	self:CheckRedPointNotice()
	UGUIUtil.SetText(self.SearchModePlayerIDText, FriendUIApi:GetString("SearchModePlayerIDText", PlayerModule.PlayerInfo.baseInfo.guid))
end

function FriendUI:ShowTab(index)
	self.CurrentTabIndex = index

	local type = FriendUI.TAB_INDEX_TYPE_MAP[index]

	if type ~= Constant.FriendType.TYPE_STRANGER then
		self.SearchInputField:GetComponent("IQIGame.Onigao.Game.UI.InputField").text = ""
		self.SearchFunctionMode = FriendUI.SEARCH_MODE_HOME
		self.FriendDatas = FriendModule.GetFriends(type)

		self.ContentScrollArea:Refresh(#self.FriendDatas)
	elseif self.SearchFunctionMode == FriendUI.SEARCH_MODE_RESULT then
		local searchText = self.SearchInputField:GetComponent("IQIGame.Onigao.Game.UI.InputField").text

		if searchText ~= "" and tonumber(searchText) ~= nil and self:IsInt(tonumber(searchText)) then
			FriendModule.SearchPlayerByGUID(searchText)
		else
			FriendModule.GetRecommendFriends()
		end
	else
		self.FriendDatas = {}

		self.ContentScrollArea:Refresh(0)
	end

	self:UpdateSearchModeView()

	for i = 1, #self.Tabs do
		local functionBar = self["FunctionBar" .. i]

		if functionBar ~= nil then
			functionBar:SetActive(i == index)
		end
	end

	self.RedPoints[index]:SetActive(false)

	local friendMaxNum = CfgDiscreteDataTable[6506031].Data[index]
	local friendNumText = ""

	if type ~= Constant.FriendType.TYPE_STRANGER then
		friendNumText = FriendUIApi:GetString("FriendNumText", index, #self.FriendDatas, friendMaxNum)
	end

	self.FriendNumText:GetComponent("Text").text = friendNumText

	self.NoFriendNoticeView:SetActive(index == 1 and #self.FriendDatas == 0)
	self.NoFriendApplyView:SetActive(index == 2 and #self.FriendDatas == 0)
	self.NoFriendMuteView:SetActive(index == 4 and #self.FriendDatas == 0)
end

function FriendUI:UpdateFriends(cell)
	local friendItemCell = FriendItemCell.PackageOrReuseView(self, cell.gameObject)
	local friendData = self.FriendDatas[cell.index + 1]

	friendItemCell:SetData(friendData)
end

function FriendUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.FriendUI)
end

function FriendUI:OnClickTab(isOn)
	if isOn then
		local currentTarget = self.UIController:GetCurrentTarget()

		for i = 1, #self.Tabs do
			if self.Tabs[i] == currentTarget then
				self:ShowTab(i)

				return
			end
		end
	end
end

function FriendUI:AgreeAllApplication()
	local ids = {}

	for i = 1, #self.FriendDatas do
		table.insert(ids, self.FriendDatas[i].id)
	end

	local friendDatas = FriendModule.GetFriends(Constant.FriendType.TYPE_FRIEND)
	local friendNum = #friendDatas
	local friendMaxNum = CfgDiscreteDataTable[6506031].Data[1]

	if friendMaxNum <= friendNum then
		NoticeModule.ShowNotice(21040034)

		return
	end

	if #ids == 0 then
		return
	end

	FriendModule.SendDealWithApplication(ids, true)
end

function FriendUI:ClearAllApplyBtn()
	local ids = {}

	for i = 1, #self.FriendDatas do
		table.insert(ids, self.FriendDatas[i].id)
	end

	if #ids == 0 then
		return
	end

	FriendModule.SendDealWithApplication(ids, false)
end

function FriendUI:OnGetRecommendFriends()
	self.SearchFunctionMode = FriendUI.SEARCH_MODE_RESULT

	FriendModule.GetRecommendFriends()
end

function FriendUI:SearchFriend()
	local searchText = self.SearchInputField:GetComponent("IQIGame.Onigao.Game.UI.InputField").text

	if searchText == "" then
		return
	end

	if tonumber(searchText) ~= nil and self:IsInt(tonumber(searchText)) then
		self.SearchFunctionMode = FriendUI.SEARCH_MODE_RESULT

		FriendModule.SearchPlayerByGUID(searchText)
	else
		NoticeModule.ShowNotice(21040058)
	end
end

function FriendUI:OnSearchModeApplyAll()
	local pids = {}

	for i = 1, #self.FriendDatas do
		local friendData = self.FriendDatas[i]

		table.insert(pids, friendData.pId)
	end

	if #pids > 0 then
		FriendModule.SendApplyFriends(pids)
	end
end

function FriendUI:OnSearchModeReturn()
	self.SearchFunctionMode = FriendUI.SEARCH_MODE_HOME
	self.FriendDatas = {}

	self.ContentScrollArea:Refresh(0)
	self:UpdateSearchModeView()
end

function FriendUI:IsInt(num)
	if num < 0 or num > 2147483647 then
		return false
	end

	return true
end

function FriendUI:CheckRedPointNotice()
	local applications = FriendModule.GetFriends(Constant.FriendType.TYPE_APPLICATION)

	if #applications > 0 then
		self.RedPoints[2]:SetActive(true)
	end
end

function FriendUI:UpdateFriend()
	self:ShowTab(self.CurrentTabIndex)
	self:CheckRedPointNotice()
end

function FriendUI:GetRecommendFriends(friends)
	self.FriendDatas = friends

	self.ContentScrollArea:Refresh(#self.FriendDatas)
	self:UpdateSearchModeView()
end

function FriendUI:UpdateSearchResult(friend)
	self.FriendDatas = {
		friend
	}

	self.ContentScrollArea:Refresh(#self.FriendDatas)
	self:UpdateSearchModeView()
end

function FriendUI:UpdateSearchModeView()
	local type = FriendUI.TAB_INDEX_TYPE_MAP[self.CurrentTabIndex]

	self.SearchModeHome:SetActive(type == Constant.FriendType.TYPE_STRANGER and self.SearchFunctionMode == FriendUI.SEARCH_MODE_HOME)
	self.SearchModeResultBar:SetActive(type == Constant.FriendType.TYPE_STRANGER and self.SearchFunctionMode == FriendUI.SEARCH_MODE_RESULT)
end

function FriendUI:DeleteAllApplication()
	local applications = FriendModule.GetFriends(Constant.FriendType.TYPE_APPLICATION)
	local friendIds = {}

	for i = 1, #applications do
		table.insert(friendIds, applications[i].id)
	end

	FriendModule.SendDeleteFriends(friendIds)
end

function FriendUI:OnPlayerHeadFrameLoaded()
	local mask = self.ContentGrid:GetComponent(typeof(UnityEngine.UI.RectMask3D))

	mask:SetDirtyTarget()
end

return FriendUI
