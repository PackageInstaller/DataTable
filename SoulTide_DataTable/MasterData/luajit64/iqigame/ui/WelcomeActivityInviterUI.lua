-- chunkname: @IQIGame\\UI\\WelcomeActivityInviterUI.lua

local WelcomeActivityInviterUI = {
	welcomeTasks = {},
	inviteTaskCellPool = {}
}

WelcomeActivityInviterUI = Base:Extend("WelcomeActivityInviterUI", "IQIGame.Onigao.UI.WelcomeActivityInviterUI", WelcomeActivityInviterUI)

local WelcomeNewInviteTaskCell = require("IQIGame.UI.Activity.WelcomeNew.WelcomeNewInviteTaskCell")

function WelcomeActivityInviterUI:OnInit()
	UGUIUtil.SetText(self.OpenTime, WelcomeActivityInviterUIApi:GetString("OpenTime"))
	UGUIUtil.SetText(self.BtnFriendListLabel, WelcomeActivityInviterUIApi:GetString("BtnFriendListLabel"))
	UGUIUtil.SetText(self.BtnCopyLabel, WelcomeActivityInviterUIApi:GetString("BtnCopyLabel"))

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnFriendList()
		self:OnBtnFriendList()
	end

	function self.delegateBtnCopy()
		self:OnBtnCopy()
	end

	function self.delegateUpdateOperations()
		self:OnUpdateOperations()
	end
end

function WelcomeActivityInviterUI:GetPreloadAssetPaths()
	return nil
end

function WelcomeActivityInviterUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function WelcomeActivityInviterUI:IsManualShowOnOpen(userData)
	return false
end

function WelcomeActivityInviterUI:GetBGM(userData)
	return nil
end

function WelcomeActivityInviterUI:OnOpen(userData)
	self:UpdateView()
end

function WelcomeActivityInviterUI:OnClose(userData)
	return
end

function WelcomeActivityInviterUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnFriendList:GetComponent("Button").onClick:AddListener(self.delegateBtnFriendList)
	self.BtnCopy:GetComponent("Button").onClick:AddListener(self.delegateBtnCopy)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function WelcomeActivityInviterUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnFriendList:GetComponent("Button").onClick:RemoveListener(self.delegateBtnFriendList)
	self.BtnCopy:GetComponent("Button").onClick:RemoveListener(self.delegateBtnCopy)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function WelcomeActivityInviterUI:OnPause()
	return
end

function WelcomeActivityInviterUI:OnResume()
	return
end

function WelcomeActivityInviterUI:OnCover()
	return
end

function WelcomeActivityInviterUI:OnReveal()
	return
end

function WelcomeActivityInviterUI:OnRefocus(userData)
	return
end

function WelcomeActivityInviterUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function WelcomeActivityInviterUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function WelcomeActivityInviterUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function WelcomeActivityInviterUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function WelcomeActivityInviterUI:OnDestroy()
	for i, v in pairs(self.inviteTaskCellPool) do
		v:Dispose()
	end
end

function WelcomeActivityInviterUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.WelcomeActivityInviterUI)
end

function WelcomeActivityInviterUI:OnUpdateOperations()
	self:UpdateView()
end

function WelcomeActivityInviterUI:UpdateView()
	self.welcomeTasks = {}
	self.operateEventID = ActiveWelcomeNewModule.GetOpenWelcomeNewActive()

	if self.operateEventID ~= nil and ActiveOperationEventModule.CheckIsOpen(self.operateEventID) then
		local eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)

		if eventPOD then
			local cfgGlobal = CfgWelcomeNewcomersGlobalTable[eventPOD.dataCfgId]

			UGUIUtil.SetText(self.goTitle, cfgGlobal.Name)
			UGUIUtil.SetText(self.OpenTimeValue, WelcomeActivityInviterUIApi:GetString("OpenTimeValue", getCustomDateTimeText(eventPOD.startTime, "MonthToMinuteFormat"), getCustomDateTimeText(eventPOD.endTime, "MonthToMinuteFormat")))
			UGUIUtil.SetText(self.TextDes, cfgGlobal.Desc1)

			for i, v in pairsCfg(CfgWelcomeTaskListTable) do
				if v.Team == eventPOD.dataCfgId then
					local completeNum, taskState = ActiveWelcomeNewModule.GetTaskSate(v.Id)
					local rankValue = 0

					if taskState == 1 then
						rankValue = 2
					elseif taskState == 0 then
						rankValue = 1
					end

					local t = {}

					t.cfg = v
					t.rank = rankValue

					table.insert(self.welcomeTasks, t)
				end
			end

			table.sort(self.welcomeTasks, function(a, b)
				local r = false

				if a.rank == b.rank then
					r = a.cfg.Id < b.cfg.Id
				else
					r = a.rank > b.rank
				end

				return r
			end)
		end

		self.scrollList:Refresh(#self.welcomeTasks)

		local data = ActiveWelcomeNewModule.GetHelpNewbiesDataPOD()

		if data then
			UGUIUtil.SetText(self.InvitationCode, WelcomeActivityInviterUIApi:GetString("InvitationCode", data.senior.inviteCode))
		end
	end
end

function WelcomeActivityInviterUI:OnRenderGridCell(cell)
	local data = self.welcomeTasks[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.inviteTaskCellPool[instanceID]

	if renderCell == nil then
		renderCell = WelcomeNewInviteTaskCell.New(cell.gameObject)
		self.inviteTaskCellPool[instanceID] = renderCell
	end

	renderCell:SetData(self.operateEventID, data.cfg)
end

function WelcomeActivityInviterUI:OnBtnFriendList()
	if self.operateEventID then
		ActiveWelcomeNewModule.GetFollowers(self.operateEventID)
	end
end

function WelcomeActivityInviterUI:OnBtnCopy()
	UnityEngine.GUIUtility.systemCopyBuffer = PlayerModule.PlayerInfo.baseInfo.guid
end

return WelcomeActivityInviterUI
