-- chunkname: @IQIGame\\UI\\AmusementParkMissionUI.lua

local AmusementParkMissionUI = {
	taskItemPool = {}
}

AmusementParkMissionUI = Base:Extend("AmusementParkMissionUI", "IQIGame.Onigao.UI.AmusementParkMissionUI", AmusementParkMissionUI)

require("IQIGame.UIExternalApi.AmusementParkMissionUIApi")

local AmusementParkTaskItem = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkTask.AmusementParkTaskItem")

function AmusementParkMissionUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	self.TaskScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderTaskCell(cell)
	end
end

function AmusementParkMissionUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkMissionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkMissionUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkMissionUI:GetBGM(userData)
	return nil
end

function AmusementParkMissionUI:OnOpen(userData)
	self:UpdateView()
end

function AmusementParkMissionUI:OnClose(userData)
	return
end

function AmusementParkMissionUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function AmusementParkMissionUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function AmusementParkMissionUI:OnPause()
	return
end

function AmusementParkMissionUI:OnResume()
	return
end

function AmusementParkMissionUI:OnCover()
	return
end

function AmusementParkMissionUI:OnReveal()
	return
end

function AmusementParkMissionUI:OnRefocus(userData)
	return
end

function AmusementParkMissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkMissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkMissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkMissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkMissionUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.taskItemPool) do
		v:Dispose()
	end
end

function AmusementParkMissionUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function AmusementParkMissionUI:UpdateView()
	self.taskDataList = AmusementParkModule.GetAmusementParkTaskDataList({
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

function AmusementParkMissionUI:OnRenderTaskCell(cell)
	local item = self.taskItemPool[cell.gameObject:GetInstanceID()]

	if item == nil then
		item = AmusementParkTaskItem.New(cell.gameObject)
		self.taskItemPool[cell.gameObject:GetInstanceID()] = item
	end

	item:SetData(self.taskDataList[cell.index + 1])
end

return AmusementParkMissionUI
