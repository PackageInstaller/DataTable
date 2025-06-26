-- chunkname: @IQIGame\\UI\\MagicTowerSystemMissionUI.lua

local MagicTowerSystemMissionUI = {
	TaskItems = {}
}

MagicTowerSystemMissionUI = Base:Extend("MagicTowerSystemMissionUI", "IQIGame.Onigao.UI.MagicTowerSystemMissionUI", MagicTowerSystemMissionUI)

require("IQIGame.UIExternalApi.MagicTowerSystemMissionUIApi")

local MagicTowerTaskItem = require("IQIGame.UI.MagicTower.MagicTowerTaskItem")

function MagicTowerSystemMissionUI:OnInit()
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

	self.TaskRewardPool = MagicTowerTaskItem.CreateRewardPool(12, self.RewardCellPrefab)

	local scrollAreaList = self.TaskScrollArea:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderTaskCell(cell)
	end

	UGUIUtil.SetText(self.TitleText, MagicTowerSystemMissionUIApi:GetString("TitleText"))
end

function MagicTowerSystemMissionUI:GetPreloadAssetPaths()
	return nil
end

function MagicTowerSystemMissionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MagicTowerSystemMissionUI:IsManualShowOnOpen(userData)
	return false
end

function MagicTowerSystemMissionUI:GetBGM(userData)
	return nil
end

function MagicTowerSystemMissionUI:OnOpen(userData)
	self:UpdateView()
end

function MagicTowerSystemMissionUI:OnClose(userData)
	return
end

function MagicTowerSystemMissionUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.FullScreenCloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFullScreenCloseBtn)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitResponse)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
end

function MagicTowerSystemMissionUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.FullScreenCloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFullScreenCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.DelegateOnTaskCommitResponse)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
end

function MagicTowerSystemMissionUI:OnPause()
	return
end

function MagicTowerSystemMissionUI:OnResume()
	return
end

function MagicTowerSystemMissionUI:OnCover()
	return
end

function MagicTowerSystemMissionUI:OnReveal()
	return
end

function MagicTowerSystemMissionUI:OnRefocus(userData)
	return
end

function MagicTowerSystemMissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MagicTowerSystemMissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MagicTowerSystemMissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MagicTowerSystemMissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MagicTowerSystemMissionUI:OnDestroy()
	for gameObject, item in pairs(self.TaskItems) do
		item:Dispose()
	end

	self.TaskRewardPool:Dispose()
end

function MagicTowerSystemMissionUI:UpdateView()
	self.TaskDataList = self:GetTaskData()

	local scrollAreaList = self.TaskScrollArea:GetComponent("ScrollAreaList")

	scrollAreaList:Refresh(#self.TaskDataList)
end

function MagicTowerSystemMissionUI:GetTaskData()
	local taskDataList = MagicTowerModule.GetTaskDataList()

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

function MagicTowerSystemMissionUI:OnRenderTaskCell(cell)
	local item = self.TaskItems[cell.gameObject]

	if item == nil then
		item = MagicTowerTaskItem.New(cell.gameObject, self.TaskRewardPool, MagicTowerSystemMissionUIApi, false)
		self.TaskItems[cell.gameObject] = item
	end

	item:SetData(self.TaskDataList[cell.index + 1])
end

function MagicTowerSystemMissionUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function MagicTowerSystemMissionUI:OnClickFullScreenCloseBtn()
	UIModule.CloseSelf(self)
end

function MagicTowerSystemMissionUI:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

function MagicTowerSystemMissionUI:OnTaskUpdate(cid)
	self:UpdateView()
end

return MagicTowerSystemMissionUI
