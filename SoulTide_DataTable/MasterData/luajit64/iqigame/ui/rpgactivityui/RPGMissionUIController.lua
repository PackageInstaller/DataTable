-- chunkname: @IQIGame\\UI\\RPGActivityUI\\RPGMissionUIController.lua

local RPGMissionUIController = {
	taskCellPool = {}
}
local RPGMissionCell = require("IQIGame.UI.RPGMission.RPGMissionCell")

function RPGMissionUIController.New(uiController)
	local obj = Clone(RPGMissionUIController)

	obj:__Init(uiController)

	return obj
end

function RPGMissionUIController:__Init(uiController)
	self.UIController = uiController
end

function RPGMissionUIController:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function RPGMissionUIController:OnInit()
	self:Initialize()
end

function RPGMissionUIController:GetPreloadAssetPaths()
	return nil
end

function RPGMissionUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RPGMissionUIController:IsManualShowOnOpen(userData)
	return false
end

function RPGMissionUIController:GetBGM(userData)
	return nil
end

function RPGMissionUIController:OnOpen(userData)
	self:Refresh(userData)
end

function RPGMissionUIController:OnClose(userData)
	self:OnHide()
end

function RPGMissionUIController:OnPause()
	return
end

function RPGMissionUIController:OnResume()
	return
end

function RPGMissionUIController:OnCover()
	return
end

function RPGMissionUIController:OnReveal()
	return
end

function RPGMissionUIController:OnRefocus(userData)
	return
end

function RPGMissionUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RPGMissionUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RPGMissionUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RPGMissionUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RPGMissionUIController:Initialize()
	self.taskList = self.goTaskList:GetComponent("ScrollAreaList")

	function self.taskList.onRenderCell(cell)
		self:OnRenderTaskCell(cell)
	end

	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnClose2 = self.goBtnClose2:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onTaskCommitResponseDelegate(cids, awards)
		self:OnTaskCommitResponse(cids, awards)
	end

	function self.onTaskUpdateDelegate(id)
		self:OnTaskUpdate(id)
	end

	self.goTitle:GetComponent("Text").text = RPGMissionUIApi:GetString("title")
	self.goSignEmpty:GetComponent("Text").text = RPGMissionUIApi:GetString("emptyTxt")
end

function RPGMissionUIController:Refresh(userData)
	self:RefreshTaskList()
end

function RPGMissionUIController:OnHide()
	for i, v in pairs(self.taskCellPool) do
		v:OnHide()
	end
end

function RPGMissionUIController:OnDestroy()
	for i, v in pairs(self.taskCellPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function RPGMissionUIController:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:AddListener(self.onClickBtnCloseDelegate)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
end

function RPGMissionUIController:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
end

function RPGMissionUIController:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function RPGMissionUIController:OnTaskUpdate(id)
	self.taskListDatum = RPGMissionModule.GetTaskDatum()

	self.taskList:RenderCellsDynamic(#self.taskListDatum)
	self.goSignEmpty:SetActive(#self.taskListDatum == 0)
end

function RPGMissionUIController:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

function RPGMissionUIController:OnRenderTaskCell(cell)
	local luaIndex = cell.index + 1
	local data = self.taskListDatum[luaIndex]
	local insID = cell.gameObject:GetInstanceID()
	local taskCell = self.taskCellPool[insID]

	if taskCell == nil then
		taskCell = RPGMissionCell.New(cell.gameObject)
		self.taskCellPool[insID] = taskCell
	end

	taskCell:Refresh(data)
end

function RPGMissionUIController:RefreshTaskList()
	self.taskListDatum = RPGMissionModule.GetTaskDatum()

	self.taskList:Refresh(#self.taskListDatum)
	self.goSignEmpty:SetActive(#self.taskListDatum == 0)
end

return RPGMissionUIController
