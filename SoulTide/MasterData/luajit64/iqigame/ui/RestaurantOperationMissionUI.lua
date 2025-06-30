-- chunkname: @IQIGame\\UI\\RestaurantOperationMissionUI.lua

local RestaurantOperationMissionUI = {
	taskItemPool = {}
}

RestaurantOperationMissionUI = Base:Extend("RestaurantOperationMissionUI", "IQIGame.Onigao.UI.RestaurantOperationMissionUI", RestaurantOperationMissionUI)

require("IQIGame.UIExternalApi.RestaurantOperationMissionUIApi")

local ROTaskItem = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationTask.ROTaskItem")

function RestaurantOperationMissionUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	self.TaskScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderTaskCell(cell)
	end
end

function RestaurantOperationMissionUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationMissionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationMissionUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationMissionUI:GetBGM(userData)
	return nil
end

function RestaurantOperationMissionUI:OnOpen(userData)
	self:UpdateView()
end

function RestaurantOperationMissionUI:OnClose(userData)
	return
end

function RestaurantOperationMissionUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function RestaurantOperationMissionUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function RestaurantOperationMissionUI:OnPause()
	return
end

function RestaurantOperationMissionUI:OnResume()
	return
end

function RestaurantOperationMissionUI:OnCover()
	return
end

function RestaurantOperationMissionUI:OnReveal()
	return
end

function RestaurantOperationMissionUI:OnRefocus(userData)
	return
end

function RestaurantOperationMissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationMissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationMissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationMissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationMissionUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function RestaurantOperationMissionUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function RestaurantOperationMissionUI:UpdateView()
	self.taskDataList = RestaurantOperationModule.GetRestaurantTaskDataList({
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

function RestaurantOperationMissionUI:OnRenderTaskCell(cell)
	local item = self.taskItemPool[cell.gameObject:GetInstanceID()]

	if item == nil then
		item = ROTaskItem.New(cell.gameObject)
		self.taskItemPool[cell.gameObject:GetInstanceID()] = item
	end

	item:SetData(self.taskDataList[cell.index + 1])
end

return RestaurantOperationMissionUI
