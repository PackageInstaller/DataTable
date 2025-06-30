-- chunkname: @IQIGame\\UI\\ActivityNewDollMissionUI.lua

local ActivityNewDollMissionUI = {
	taskCellPool = {}
}

ActivityNewDollMissionUI = Base:Extend("ActivityNewDollMissionUI", "IQIGame.Onigao.UI.ActivityNewDollMissionUI", ActivityNewDollMissionUI)

local DollMissionTaskCell = require("IQIGame.UI.Activity.DollMission.DollMissionTaskCell")

function ActivityNewDollMissionUI:OnInit()
	self:Initialize()
end

function ActivityNewDollMissionUI:GetPreloadAssetPaths()
	return nil
end

function ActivityNewDollMissionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ActivityNewDollMissionUI:IsManualShowOnOpen(userData)
	return false
end

function ActivityNewDollMissionUI:GetBGM(userData)
	return nil
end

function ActivityNewDollMissionUI:OnOpen(userData)
	self:Refresh(userData)
end

function ActivityNewDollMissionUI:OnClose(userData)
	self:OnHide()
end

function ActivityNewDollMissionUI:OnPause()
	return
end

function ActivityNewDollMissionUI:OnResume()
	return
end

function ActivityNewDollMissionUI:OnCover()
	return
end

function ActivityNewDollMissionUI:OnReveal()
	return
end

function ActivityNewDollMissionUI:OnRefocus(userData)
	return
end

function ActivityNewDollMissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ActivityNewDollMissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ActivityNewDollMissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActivityNewDollMissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActivityNewDollMissionUI:Initialize()
	self.cellList = self.goTaskList:GetComponent("ScrollAreaList")

	function self.cellList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnClose2 = self.goBtnClose2:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onTaskUpdateDelegate(id)
		self:OnUpdateTask(id)
	end

	self.goTitle:GetComponent("Text").text = ActivityNewDollMissionUIApi:GetString("title")
end

function ActivityNewDollMissionUI:Refresh(userData)
	self.cellListDatum = ActivityDollMissionModule.GetTaskDatum()

	self.cellList:Refresh(#self.cellListDatum)
end

function ActivityNewDollMissionUI:OnHide()
	for i, v in pairs(self.taskCellPool) do
		v:OnHide()
	end
end

function ActivityNewDollMissionUI:OnDestroy()
	for i, v in pairs(self.taskCellPool) do
		v:OnDestroy()
	end
end

function ActivityNewDollMissionUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:AddListener(self.onClickBtnCloseDelegate)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
end

function ActivityNewDollMissionUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
end

function ActivityNewDollMissionUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function ActivityNewDollMissionUI:OnRenderCell(cell)
	local luaIndex = cell.index + 1
	local data = self.cellListDatum[luaIndex]
	local insID = cell.gameObject:GetInstanceID()
	local taskCell = self.taskCellPool[insID]

	if taskCell == nil then
		taskCell = DollMissionTaskCell.New(cell.gameObject)
		self.taskCellPool[insID] = taskCell
	end

	taskCell:Refresh(data)
end

function ActivityNewDollMissionUI:OnUpdateTask(id)
	self.cellListDatum = ActivityDollMissionModule.GetTaskDatum()

	self.cellList:RenderCells()
end

return ActivityNewDollMissionUI
