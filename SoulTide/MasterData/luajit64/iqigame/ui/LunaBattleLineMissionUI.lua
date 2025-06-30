-- chunkname: @IQIGame\\UI\\LunaBattleLineMissionUI.lua

local LunaBattleLineMissionUI = {
	NormalTaskItems = {}
}

LunaBattleLineMissionUI = Base:Extend("LunaBattleLineMissionUI", "IQIGame.Onigao.UI.LunaBattleLineMissionUI", LunaBattleLineMissionUI)

require("IQIGame.UIExternalApi.LunaBattleLineMissionUIApi")

local ActivityTaskItem = require("IQIGame.UI.Activity.Common.ActivityTaskItem")
local LunaWorldTaskController = require("IQIGame.UI.LunaBattleLine.Mission.LunaWorldTaskController")

function LunaBattleLineMissionUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickFullScreenCloseBtn()
		self:OnClickFullScreenCloseBtn()
	end

	function self.DelegateOnTaskCommitResponse(cids, rewards)
		self:OnTaskCommitResponse(cids, rewards)
	end

	function self.DelegateOnTaskUpdate(cid)
		self:OnTaskUpdate(cid)
	end

	self.WorldTaskController = LunaWorldTaskController.New(self.WorldTaskView)

	local scrollAreaList = self.NormalTaskScrollArea:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderNormalTaskCell(cell)
	end

	UGUIUtil.SetText(self.TitleText, LunaBattleLineMissionUIApi:GetString("TitleText"))
end

function LunaBattleLineMissionUI:GetPreloadAssetPaths()
	return nil
end

function LunaBattleLineMissionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LunaBattleLineMissionUI:IsManualShowOnOpen(userData)
	return false
end

function LunaBattleLineMissionUI:GetBGM(userData)
	return nil
end

function LunaBattleLineMissionUI:OnOpen(userData)
	self:UpdateView(true)
end

function LunaBattleLineMissionUI:OnClose(userData)
	return
end

function LunaBattleLineMissionUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.FullScreenCloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFullScreenCloseBtn)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitResponse)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
end

function LunaBattleLineMissionUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.FullScreenCloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFullScreenCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitResponse)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
end

function LunaBattleLineMissionUI:OnPause()
	return
end

function LunaBattleLineMissionUI:OnResume()
	return
end

function LunaBattleLineMissionUI:OnCover()
	return
end

function LunaBattleLineMissionUI:OnReveal()
	return
end

function LunaBattleLineMissionUI:OnRefocus(userData)
	return
end

function LunaBattleLineMissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LunaBattleLineMissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LunaBattleLineMissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LunaBattleLineMissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LunaBattleLineMissionUI:OnDestroy()
	self.WorldTaskController:Dispose()

	for gameObject, item in pairs(self.NormalTaskItems) do
		item:Dispose()
	end

	self.TaskRewardPool:Dispose()
end

function LunaBattleLineMissionUI:UpdateView(isOpen)
	local worldTaskDataList = self:GetTaskData(2)

	self.WorldTaskController:SetData(worldTaskDataList[1])

	self.NormalTaskDataList = self:GetTaskData(3)

	local scrollAreaList = self.NormalTaskScrollArea:GetComponent("ScrollAreaList")
	local normalTaskNum = #self.NormalTaskDataList

	if isOpen then
		scrollAreaList:Refresh(normalTaskNum)
	else
		scrollAreaList:RenderCellsDynamic(normalTaskNum)
	end
end

function LunaBattleLineMissionUI:GetTaskData(childType)
	local taskDataList = LunaBattleLineModule.GetTaskDataList(childType)

	table.sort(taskDataList, function(data1, data2)
		local finish1 = data1.TaskStatus == TaskModule.TaskStatus.FINISH_TASK and 1 or 0
		local finish2 = data2.TaskStatus == TaskModule.TaskStatus.FINISH_TASK and 1 or 0

		if finish1 == finish2 then
			local targetOK1 = data1.CurrentNum >= data1.TargetNum and 1 or 0
			local targetOK2 = data2.CurrentNum >= data2.TargetNum and 1 or 0

			if targetOK1 == targetOK2 then
				return data1.cid < data2.cid
			end

			return targetOK2 < targetOK1
		end

		return finish1 < finish2
	end)

	return taskDataList
end

function LunaBattleLineMissionUI:OnRenderNormalTaskCell(cell)
	local item = self.NormalTaskItems[cell.gameObject]

	if item == nil then
		if self.TaskRewardPool == nil then
			self.TaskRewardPool = ActivityTaskItem.CreateRewardPool(12, self.RewardCellPrefab)
		end

		item = ActivityTaskItem.New(cell.gameObject, self.TaskRewardPool, LunaBattleLineMissionUIApi)
		self.NormalTaskItems[cell.gameObject] = item
	end

	item:SetData(self.NormalTaskDataList[cell.index + 1])
end

function LunaBattleLineMissionUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function LunaBattleLineMissionUI:OnClickFullScreenCloseBtn()
	UIModule.CloseSelf(self)
end

function LunaBattleLineMissionUI:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

function LunaBattleLineMissionUI:OnTaskUpdate(cid)
	self:UpdateView(false)
end

return LunaBattleLineMissionUI
