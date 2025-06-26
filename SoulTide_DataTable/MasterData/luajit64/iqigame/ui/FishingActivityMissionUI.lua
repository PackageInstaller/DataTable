-- chunkname: @IQIGame\\UI\\FishingActivityMissionUI.lua

local FishingActivityMissionUI = {
	taskItemPool = {}
}

FishingActivityMissionUI = Base:Extend("FishingActivityMissionUI", "IQIGame.Onigao.UI.FishingActivityMissionUI", FishingActivityMissionUI)

require("IQIGame.UIExternalApi.FishingActivityMissionUIApi")

local FishingActivityMissionItem = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivityMission.FishingActivityMissionItem")

function FishingActivityMissionUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	self.TaskScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderTaskCell(cell)
	end
end

function FishingActivityMissionUI:GetPreloadAssetPaths()
	return nil
end

function FishingActivityMissionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FishingActivityMissionUI:IsManualShowOnOpen(userData)
	return false
end

function FishingActivityMissionUI:GetBGM(userData)
	return nil
end

function FishingActivityMissionUI:OnOpen(userData)
	self:UpdateView()
end

function FishingActivityMissionUI:OnClose(userData)
	return
end

function FishingActivityMissionUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function FishingActivityMissionUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function FishingActivityMissionUI:OnPause()
	return
end

function FishingActivityMissionUI:OnResume()
	return
end

function FishingActivityMissionUI:OnCover()
	return
end

function FishingActivityMissionUI:OnReveal()
	return
end

function FishingActivityMissionUI:OnRefocus(userData)
	return
end

function FishingActivityMissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FishingActivityMissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FishingActivityMissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FishingActivityMissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FishingActivityMissionUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function FishingActivityMissionUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function FishingActivityMissionUI:UpdateView()
	self.taskDataList = FishingActivityModule.GetFishingActivityTaskDataList({
		1
	})

	table.sort(self.taskDataList, function(task1, task2)
		if task1.TaskStatus == task2.TaskStatus then
			return task1.cid < task2.cid
		end

		return task1.TaskStatus < task2.TaskStatus
	end)
	self.TaskScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.taskDataList)
end

function FishingActivityMissionUI:OnRenderTaskCell(cell)
	local item = self.taskItemPool[cell.gameObject:GetInstanceID()]

	if item == nil then
		item = FishingActivityMissionItem.New(cell.gameObject)
		self.taskItemPool[cell.gameObject:GetInstanceID()] = item
	end

	item:SetData(self.taskDataList[cell.index + 1])
end

return FishingActivityMissionUI
