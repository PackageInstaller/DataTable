-- chunkname: @IQIGame\\UI\\WelcomeInvitedHistoryUI.lua

local WelcomeInvitedHistoryUI = {
	friendListTab = {},
	friendCellPool = {}
}

WelcomeInvitedHistoryUI = Base:Extend("WelcomeInvitedHistoryUI", "IQIGame.Onigao.UI.WelcomeInvitedHistoryUI", WelcomeInvitedHistoryUI)

local WelcomeNewFriendCell = require("IQIGame.UI.Activity.WelcomeNew.WelcomeNewFriendCell")

function WelcomeInvitedHistoryUI:OnInit()
	UGUIUtil.SetText(self.TitleText, WelcomeInvitedHistoryUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.NameLabel, WelcomeInvitedHistoryUIApi:GetString("NameLabel"))
	UGUIUtil.SetText(self.MsgLabel, WelcomeInvitedHistoryUIApi:GetString("MsgLabel"))
	UGUIUtil.SetText(self.TextNoRecord, WelcomeInvitedHistoryUIApi:GetString("TextNoRecord"))

	self.scrollList = self.ScrollAreaList:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell1(cell)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end
end

function WelcomeInvitedHistoryUI:GetPreloadAssetPaths()
	return nil
end

function WelcomeInvitedHistoryUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function WelcomeInvitedHistoryUI:IsManualShowOnOpen(userData)
	return false
end

function WelcomeInvitedHistoryUI:GetBGM(userData)
	return nil
end

function WelcomeInvitedHistoryUI:OnOpen(userData)
	self:UpdateView()
end

function WelcomeInvitedHistoryUI:OnClose(userData)
	return
end

function WelcomeInvitedHistoryUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.CloseBtn2:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function WelcomeInvitedHistoryUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.CloseBtn2:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function WelcomeInvitedHistoryUI:OnPause()
	return
end

function WelcomeInvitedHistoryUI:OnResume()
	return
end

function WelcomeInvitedHistoryUI:OnCover()
	return
end

function WelcomeInvitedHistoryUI:OnReveal()
	return
end

function WelcomeInvitedHistoryUI:OnRefocus(userData)
	return
end

function WelcomeInvitedHistoryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function WelcomeInvitedHistoryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function WelcomeInvitedHistoryUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function WelcomeInvitedHistoryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function WelcomeInvitedHistoryUI:OnDestroy()
	for i, v in pairs(self.friendCellPool) do
		v:Dispose()
	end
end

function WelcomeInvitedHistoryUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.WelcomeInvitedHistoryUI)
end

function WelcomeInvitedHistoryUI:UpdateView()
	self.friendListTab = ActiveWelcomeNewModule.friendList

	self.scrollList:Refresh(#self.friendListTab)
	self.NoRecordView:SetActive(#self.friendListTab == 0)
end

function WelcomeInvitedHistoryUI:OnRenderGridCell1(cell)
	local data = self.friendListTab[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.friendCellPool[instanceID]

	if renderCell == nil then
		renderCell = WelcomeNewFriendCell.New(cell.gameObject)
		self.friendCellPool[instanceID] = renderCell
	end

	renderCell:SetData(cell.index + 1, data)
end

return WelcomeInvitedHistoryUI
