-- chunkname: @IQIGame\\UI\\WelcomeActivityInviteeUI.lua

local WelcomeActivityInviteeUI = {
	invitedReward = {},
	newPlayerReward = {},
	rewardCellPool1 = {},
	rewardCellPool2 = {}
}

WelcomeActivityInviteeUI = Base:Extend("WelcomeActivityInviteeUI", "IQIGame.Onigao.UI.WelcomeActivityInviteeUI", WelcomeActivityInviteeUI)

local WelcomeNewInviteTaskRewardCell = require("IQIGame.UI.Activity.WelcomeNew.WelcomeNewInviteTaskRewardCell")

function WelcomeActivityInviteeUI:OnInit()
	UGUIUtil.SetText(self.OpenTime, WelcomeActivityInviteeUIApi:GetString("OpenTime"))
	UGUIUtil.SetText(self.RewardTitle1, WelcomeActivityInviteeUIApi:GetString("RewardTitle1"))
	UGUIUtil.SetText(self.RewardTitle2, WelcomeActivityInviteeUIApi:GetString("RewardTitle2"))
	UGUIUtil.SetText(self.InputTitle, WelcomeActivityInviteeUIApi:GetString("InputTitle"))
	UGUIUtil.SetText(self.BtnSubmitLabel, WelcomeActivityInviteeUIApi:GetString("BtnSubmitLabel"))
	UGUIUtil.SetText(self.InvitedState, WelcomeActivityInviteeUIApi:GetString("InvitedState"))
	UGUIUtil.SetText(self.InvitedTitle, WelcomeActivityInviteeUIApi:GetString("InvitedTitle"))
	UGUIUtil.SetText(self.Placeholder, WelcomeActivityInviteeUIApi:GetString("Placeholder"))

	self.scrollList1 = self.ScrollArea1:GetComponent("ScrollAreaList")

	function self.scrollList1.onRenderCell(cell)
		self:OnRenderGridCell1(cell)
	end

	self.scrollList2 = self.ScrollArea2:GetComponent("ScrollAreaList")

	function self.scrollList2.onRenderCell(cell)
		self:OnRenderGridCell2(cell)
	end

	function self.delegateBtnClose()
		self:onBtnClose()
	end

	function self.delegateBtnSubmit()
		self:OnBtnSubmit()
	end

	function self.delegateUpdateOperations()
		self:OnUpdateOperations()
	end
end

function WelcomeActivityInviteeUI:GetPreloadAssetPaths()
	return nil
end

function WelcomeActivityInviteeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function WelcomeActivityInviteeUI:IsManualShowOnOpen(userData)
	return false
end

function WelcomeActivityInviteeUI:GetBGM(userData)
	return nil
end

function WelcomeActivityInviteeUI:OnOpen(userData)
	self:UpdateView()
end

function WelcomeActivityInviteeUI:OnClose(userData)
	return
end

function WelcomeActivityInviteeUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnSubmit:GetComponent("Button").onClick:AddListener(self.delegateBtnSubmit)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function WelcomeActivityInviteeUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnSubmit:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSubmit)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function WelcomeActivityInviteeUI:OnPause()
	return
end

function WelcomeActivityInviteeUI:OnResume()
	return
end

function WelcomeActivityInviteeUI:OnCover()
	return
end

function WelcomeActivityInviteeUI:OnReveal()
	return
end

function WelcomeActivityInviteeUI:OnRefocus(userData)
	return
end

function WelcomeActivityInviteeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function WelcomeActivityInviteeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function WelcomeActivityInviteeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function WelcomeActivityInviteeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function WelcomeActivityInviteeUI:OnDestroy()
	for i, v in pairs(self.rewardCellPool1) do
		v:Dispose()
	end

	for i, v in pairs(self.rewardCellPool2) do
		v:Dispose()
	end
end

function WelcomeActivityInviteeUI:OnUpdateOperations()
	self:UpdateView()
end

function WelcomeActivityInviteeUI:UpdateView()
	self.invitedReward = {}
	self.newPlayerReward = {}
	self.operateEventID = ActiveWelcomeNewModule.GetOpenWelcomeNewActive()

	if self.operateEventID ~= nil and ActiveOperationEventModule.CheckIsOpen(self.operateEventID) then
		local eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)

		if eventPOD then
			local cfgGlobal = CfgWelcomeNewcomersGlobalTable[eventPOD.dataCfgId]

			UGUIUtil.SetText(self.goTitle, cfgGlobal.Name)
			UGUIUtil.SetText(self.OpenTimeValue, WelcomeActivityInviteeUIApi:GetString("OpenTimeValue", getCustomDateTimeText(eventPOD.startTime, "MonthToMinuteFormat"), getCustomDateTimeText(eventPOD.endTime, "MonthToMinuteFormat")))
			UGUIUtil.SetText(self.TextDes, cfgGlobal.Desc2)

			for i = 1, #cfgGlobal.InvitedReward, 2 do
				local tab = {}

				tab.ID = cfgGlobal.InvitedReward[i]
				tab.Num = cfgGlobal.InvitedReward[i + 1]

				table.insert(self.invitedReward, tab)
			end

			for i = 1, #cfgGlobal.NewPlayerReward, 2 do
				local tab = {}

				tab.ID = cfgGlobal.NewPlayerReward[i]
				tab.Num = cfgGlobal.NewPlayerReward[i + 1]

				table.insert(self.newPlayerReward, tab)
			end
		end

		self.scrollList1:Refresh(#self.invitedReward)
		self.scrollList2:Refresh(#self.newPlayerReward)

		local helpNewbiesDataPOD = ActiveWelcomeNewModule.GetHelpNewbiesDataPOD()

		if helpNewbiesDataPOD and helpNewbiesDataPOD.rookie then
			UGUIUtil.SetText(self.InvitedCode, helpNewbiesDataPOD.rookie.usedInviteCode)
			UGUIUtil.SetText(self.InvitedName, helpNewbiesDataPOD.rookie.name)

			if not helpNewbiesDataPOD.rookie.useCode then
				self.InvitedInput:SetActive(true)
				self.Invited:SetActive(false)
			else
				self.InvitedInput:SetActive(false)
				self.Invited:SetActive(true)
			end
		end
	end
end

function WelcomeActivityInviteeUI:OnRenderGridCell1(cell)
	local data = self.invitedReward[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.rewardCellPool1[instanceID]

	if renderCell == nil then
		renderCell = WelcomeNewInviteTaskRewardCell.New(cell.gameObject)
		self.rewardCellPool1[instanceID] = renderCell
	end

	renderCell:SetData(data)
end

function WelcomeActivityInviteeUI:OnRenderGridCell2(cell)
	local data = self.newPlayerReward[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.rewardCellPool2[instanceID]

	if renderCell == nil then
		renderCell = WelcomeNewInviteTaskRewardCell.New(cell.gameObject)
		self.rewardCellPool2[instanceID] = renderCell
	end

	renderCell:SetData(data)
end

function WelcomeActivityInviteeUI:onBtnClose()
	UIModule.Close(Constant.UIControllerName.WelcomeActivityInviteeUI)
end

function WelcomeActivityInviteeUI:OnBtnSubmit()
	if self.operateEventID == nil then
		return
	end

	local code = tonumber(self.Input:GetComponent("Text").text)

	if code == nil or code == 0 then
		NoticeModule.ShowNotice(21045045)

		return
	end

	ActiveWelcomeNewModule.SubmitInviteCode(self.operateEventID, code)
end

return WelcomeActivityInviteeUI
