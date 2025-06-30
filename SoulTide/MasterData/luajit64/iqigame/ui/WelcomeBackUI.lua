-- chunkname: @IQIGame\\UI\\WelcomeBackUI.lua

local WelcomeBackUI = {
	completeNum = 0,
	showTaskTab = {},
	taskCellPool = {}
}

WelcomeBackUI = Base:Extend("WelcomeBackUI", "IQIGame.Onigao.UI.WelcomeBackUI", WelcomeBackUI)

local WelcomeBackTaskCell = require("IQIGame.UI.Activity.WelcomeBack.WelcomeBackTaskCell")

function WelcomeBackUI:OnInit()
	UGUIUtil.SetText(self.goTitle, WelcomeBackUIApi:GetString("goTitle"))
	UGUIUtil.SetText(self.BtnMsgLabel, WelcomeBackUIApi:GetString("BtnMsgLabel"))

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnMsg()
		self:OnBtnMsg()
	end

	function self.delegateTaskUpdate()
		self:OnTaskUpdate()
	end

	function self.onTaskCommitResponseDelegate(cids, awards)
		self:OnTaskCommitResponse(cids, awards)
	end
end

function WelcomeBackUI:GetPreloadAssetPaths()
	return nil
end

function WelcomeBackUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function WelcomeBackUI:IsManualShowOnOpen(userData)
	return false
end

function WelcomeBackUI:GetBGM(userData)
	return nil
end

function WelcomeBackUI:OnOpen(userData)
	self:UpdateView()
end

function WelcomeBackUI:OnClose(userData)
	return
end

function WelcomeBackUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnMsg:GetComponent("Button").onClick:AddListener(self.delegateBtnMsg)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.delegateTaskUpdate)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
end

function WelcomeBackUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnMsg:GetComponent("Button").onClick:RemoveListener(self.delegateBtnMsg)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.delegateTaskUpdate)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
end

function WelcomeBackUI:OnPause()
	return
end

function WelcomeBackUI:OnResume()
	return
end

function WelcomeBackUI:OnCover()
	return
end

function WelcomeBackUI:OnReveal()
	return
end

function WelcomeBackUI:OnRefocus(userData)
	return
end

function WelcomeBackUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function WelcomeBackUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function WelcomeBackUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function WelcomeBackUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function WelcomeBackUI:OnDestroy()
	for i, v in pairs(self.taskCellPool) do
		v:Dispose()
	end
end

function WelcomeBackUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.WelcomeBackUI)
end

function WelcomeBackUI:OnTaskUpdate()
	self:UpdateView()
end

function WelcomeBackUI:UpdateView()
	self.showTaskTab = ActiveWelcomeBackModule.GetWelcomeBackTaskData()
	self.completeNum = 0

	local index = 0

	for i, v in pairs(self.showTaskTab) do
		if v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK then
			if v.CurrentNum >= v.TargetNum then
				self.completeNum = self.completeNum + 1
			end
		else
			self.completeNum = self.completeNum + 1
			index = index + 1
		end
	end

	self.scrollList.startIndex = index

	self.scrollList:Refresh(#self.showTaskTab)
	UGUIUtil.SetText(self.OpenTimeValue, WelcomeBackUIApi:GetString("OpenTimeValue", PlayerModule.PlayerInfo.backflowTime))
end

function WelcomeBackUI:OnRenderGridCell(cell)
	local data = self.showTaskTab[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.taskCellPool[instanceID]

	if renderCell == nil then
		renderCell = WelcomeBackTaskCell.New(cell.gameObject)
		self.taskCellPool[instanceID] = renderCell
	end

	renderCell:SetData(data, cell.index + 1, self.completeNum)
end

function WelcomeBackUI:OnBtnMsg()
	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, DailyActivityTipsUIApi:GetString("TextMsg"))
end

function WelcomeBackUI:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

return WelcomeBackUI
