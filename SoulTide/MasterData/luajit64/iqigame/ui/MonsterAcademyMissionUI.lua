-- chunkname: @IQIGame\\UI\\MonsterAcademyMissionUI.lua

local MonsterAcademyMissionUI = {
	TaskItems = {},
	TaskItemPool = {}
}

MonsterAcademyMissionUI = Base:Extend("MonsterAcademyMissionUI", "IQIGame.Onigao.UI.MonsterAcademyMissionUI", MonsterAcademyMissionUI)

require("IQIGame.UIExternalApi.MonsterAcademyMissionUIApi")

local monsterAcademyTaskItem = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyTask.MonsterAcademyTaskItem")

function MonsterAcademyMissionUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateUpdateTaskEvent()
		self:OnUpdateTaskEvent()
	end

	self.scrollAreaList = self.TaskScrollArea:GetComponent("ScrollAreaList")

	function self.scrollAreaList.onRenderCell(cell)
		self:OnRenderTaskCell(cell)
	end
end

function MonsterAcademyMissionUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyMissionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyMissionUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyMissionUI:GetBGM(userData)
	return nil
end

function MonsterAcademyMissionUI:OnOpen(userData)
	self:UpdateView()
end

function MonsterAcademyMissionUI:OnClose(userData)
	return
end

function MonsterAcademyMissionUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateTaskEvent, self.delegateUpdateTaskEvent)
end

function MonsterAcademyMissionUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateTaskEvent, self.delegateUpdateTaskEvent)
end

function MonsterAcademyMissionUI:OnPause()
	return
end

function MonsterAcademyMissionUI:OnResume()
	return
end

function MonsterAcademyMissionUI:OnCover()
	return
end

function MonsterAcademyMissionUI:OnReveal()
	return
end

function MonsterAcademyMissionUI:OnRefocus(userData)
	return
end

function MonsterAcademyMissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyMissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyMissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyMissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyMissionUI:OnDestroy()
	for gameObject, item in pairs(self.TaskItemPool) do
		item:Dispose()
	end
end

function MonsterAcademyMissionUI:UpdateView()
	local tasks = MonsterAcademyModule.GetTaskDataList()

	self.TaskDataList = {}

	for i, v in pairs(tasks) do
		if v.state == MonsterAcademyConstant.TaskState.FINISH and v.cfgInfo.FinishIsShow > 0 then
			table.insert(self.TaskDataList, v)
		elseif v.state ~= MonsterAcademyConstant.TaskState.NOT_PICKED_UP and v.cfgInfo.UnLockDisplay >= 0 then
			table.insert(self.TaskDataList, v)
		end
	end

	table.sort(self.TaskDataList, function(data1, data2)
		if data1.state == data2.state then
			return data1.cfgID < data2.cfgID
		end

		return data1.state < data2.state
	end)
	self.scrollAreaList:Refresh(#self.TaskDataList)
end

function MonsterAcademyMissionUI:OnUpdateTaskEvent()
	self:UpdateView()
end

function MonsterAcademyMissionUI:OnRenderTaskCell(cell)
	local taskData = self.TaskDataList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local item = self.TaskItemPool[instanceID]

	if item == nil then
		item = monsterAcademyTaskItem.New(cell.gameObject)
		self.TaskItemPool[instanceID] = item
	end

	item:SetData(taskData)
end

function MonsterAcademyMissionUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.MonsterAcademyMissionUI)
end

return MonsterAcademyMissionUI
