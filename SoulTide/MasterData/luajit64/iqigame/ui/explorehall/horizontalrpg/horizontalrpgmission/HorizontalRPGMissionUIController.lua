-- chunkname: @IQIGame\\UI\\ExploreHall\\HorizontalRPG\\HorizontalRPGMission\\HorizontalRPGMissionUIController.lua

local HorizontalRPGMissionUIController = {
	taskCellPool = {}
}
local HorizontalRPGMissionCell = require("IQIGame.UI.ExploreHall.HorizontalRPG.HorizontalRPGMission.HorizontalRPGMissionCell")

function HorizontalRPGMissionUIController.New(uiController)
	local obj = Clone(HorizontalRPGMissionUIController)

	obj:__Init(uiController)

	return obj
end

function HorizontalRPGMissionUIController:__Init(uiController)
	self.UIController = uiController
end

function HorizontalRPGMissionUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function HorizontalRPGMissionUIController:OnInit()
	self:Initialize()
end

function HorizontalRPGMissionUIController:GetPreloadAssetPaths()
	return nil
end

function HorizontalRPGMissionUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HorizontalRPGMissionUIController:IsManualShowOnOpen(userData)
	return false
end

function HorizontalRPGMissionUIController:GetBGM(userData)
	return nil
end

function HorizontalRPGMissionUIController:OnOpen(userData)
	self:Refresh(userData)
end

function HorizontalRPGMissionUIController:OnClose(userData)
	self:OnHide()
end

function HorizontalRPGMissionUIController:OnAddListeners()
	return
end

function HorizontalRPGMissionUIController:OnRemoveListeners()
	return
end

function HorizontalRPGMissionUIController:OnPause()
	return
end

function HorizontalRPGMissionUIController:OnResume()
	return
end

function HorizontalRPGMissionUIController:OnCover()
	return
end

function HorizontalRPGMissionUIController:OnReveal()
	return
end

function HorizontalRPGMissionUIController:OnRefocus(userData)
	return
end

function HorizontalRPGMissionUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HorizontalRPGMissionUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HorizontalRPGMissionUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HorizontalRPGMissionUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HorizontalRPGMissionUIController:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function HorizontalRPGMissionUIController:Initialize()
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

	function self.onClickBtnGetAll()
		self:OnBtnGetAll()
	end

	self.goTitle:GetComponent("Text").text = HorizontalRPGMissionUIApi:GetString("title")
	self.goSignEmpty:GetComponent("Text").text = HorizontalRPGMissionUIApi:GetString("emptyTxt")
end

function HorizontalRPGMissionUIController:Refresh(userData)
	self:RefreshTaskList()
end

function HorizontalRPGMissionUIController:OnHide()
	for i, v in pairs(self.taskCellPool) do
		v:OnHide()
	end
end

function HorizontalRPGMissionUIController:OnDestroy()
	for i, v in pairs(self.taskCellPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function HorizontalRPGMissionUIController:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:AddListener(self.onClickBtnCloseDelegate)

	if self.goBtnGetAll then
		self.goBtnGetAll:GetComponent("Button").onClick:AddListener(self.onClickBtnGetAll)
	end

	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
end

function HorizontalRPGMissionUIController:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:RemoveListener(self.onClickBtnCloseDelegate)

	if self.goBtnGetAll then
		self.goBtnGetAll:GetComponent("Button").onClick:RemoveListener(self.onClickBtnGetAll)
	end

	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
end

function HorizontalRPGMissionUIController:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function HorizontalRPGMissionUIController:OnTaskUpdate(id)
	self.taskListDatum = HorizontalRPGModule.GetAmusementParkTaskDataList()

	self.taskList:RenderCellsDynamic(#self.taskListDatum)
	self.goSignEmpty:SetActive(#self.taskListDatum == 0)
end

function HorizontalRPGMissionUIController:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

function HorizontalRPGMissionUIController:OnRenderTaskCell(cell)
	local luaIndex = cell.index + 1
	local data = self.taskListDatum[luaIndex]
	local insID = cell.gameObject:GetInstanceID()
	local taskCell = self.taskCellPool[insID]

	if taskCell == nil then
		taskCell = HorizontalRPGMissionCell.New(cell.gameObject)
		self.taskCellPool[insID] = taskCell
	end

	taskCell:Refresh(data)
end

function HorizontalRPGMissionUIController:RefreshTaskList()
	self.taskListDatum = HorizontalRPGModule.GetAmusementParkTaskDataList()

	self.taskList:Refresh(#self.taskListDatum)
	self.goSignEmpty:SetActive(#self.taskListDatum == 0)
end

function HorizontalRPGMissionUIController:OnBtnGetAll()
	log("一键领取")
end

return HorizontalRPGMissionUIController
