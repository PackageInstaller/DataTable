-- chunkname: @IQIGame\\UI\\DailyPicturePuzzleMissionUI.lua

local DailyPicturePuzzleMissionUI = {
	taskPool = {}
}

DailyPicturePuzzleMissionUI = Base:Extend("DailyPicturePuzzleMissionUI", "IQIGame.Onigao.UI.DailyPicturePuzzleMissionUI", DailyPicturePuzzleMissionUI)

local PicturePuzzleTaskCell = require("IQIGame.UI.Activity.PicturePuzzle.PicturePuzzleTaskCell")

function DailyPicturePuzzleMissionUI:OnInit()
	UGUIUtil.SetText(self.goTitle, DailyPicturePuzzleMissionUIApi:GetString("Title"))
	UGUIUtil.SetText(self.TextDes, DailyPicturePuzzleMissionUIApi:GetString("TextDes"))

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaListGroup")

	function self.scrollList.onRenderGroupPage(renderPage, groupIndex)
		self:OnRenderGroupPage(renderPage, groupIndex)
	end

	function self.scrollList.onRenderGroupCell(renderCell, groupIndex, gridIndex)
		self:OnRenderGroupCell(renderCell, groupIndex, gridIndex)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end
end

function DailyPicturePuzzleMissionUI:GetPreloadAssetPaths()
	return nil
end

function DailyPicturePuzzleMissionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DailyPicturePuzzleMissionUI:IsManualShowOnOpen(userData)
	return false
end

function DailyPicturePuzzleMissionUI:GetBGM(userData)
	return nil
end

function DailyPicturePuzzleMissionUI:OnOpen(userData)
	self:UpdateView()
end

function DailyPicturePuzzleMissionUI:OnClose(userData)
	return
end

function DailyPicturePuzzleMissionUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.goBtnClose2:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function DailyPicturePuzzleMissionUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.goBtnClose2:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function DailyPicturePuzzleMissionUI:OnPause()
	return
end

function DailyPicturePuzzleMissionUI:OnResume()
	return
end

function DailyPicturePuzzleMissionUI:OnCover()
	return
end

function DailyPicturePuzzleMissionUI:OnReveal()
	return
end

function DailyPicturePuzzleMissionUI:OnRefocus(userData)
	return
end

function DailyPicturePuzzleMissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DailyPicturePuzzleMissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DailyPicturePuzzleMissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DailyPicturePuzzleMissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DailyPicturePuzzleMissionUI:OnDestroy()
	for i, v in pairs(self.taskPool) do
		v:Dispose()
	end
end

function DailyPicturePuzzleMissionUI:UpdateView()
	local uiTasksReward, processingReward, finishedReward = ActivePicturePuzzleModule.GetPicturePuzzleTaskData({
		1
	})
	local uiTasksDay, processingDay, finishedDay = ActivePicturePuzzleModule.GetPicturePuzzleTaskData({
		2
	})

	self.taskList = {}

	local showTab = {}

	if #uiTasksReward > 0 then
		self.taskList[1] = uiTasksReward
		showTab[1] = #uiTasksReward
	end

	if #uiTasksDay > 0 then
		self.taskList[2] = uiTasksDay
		showTab[2] = #uiTasksDay
	end

	if #showTab > 0 then
		self.scrollList:RefreshOnLua(showTab)
	end
end

function DailyPicturePuzzleMissionUI:OnRenderGroupPage(renderPage, groupIndex)
	local typeDates = groupIndex + 1

	renderPage.prefabPage:GetComponentInChildren(typeof(UnityEngine.UI.Text)).text = DailyPicturePuzzleMissionUIApi:GetString("TitleTask", typeDates)
end

function DailyPicturePuzzleMissionUI:OnRenderGroupCell(renderCell, groupIndex, gridIndex)
	local taskDates = self.taskList[groupIndex + 1]

	if taskDates == nil or taskDates[gridIndex + 1] == nil then
		renderCell.gameObject:SetActive(false)

		return
	end

	local task = taskDates[gridIndex + 1]

	renderCell.gameObject:SetActive(true)

	local instanceID = renderCell.gameObject:GetInstanceID()
	local tackCell = self.taskPool[instanceID]

	if tackCell == nil then
		tackCell = PicturePuzzleTaskCell.New(renderCell.gameObject)
		self.taskPool[instanceID] = tackCell
	end

	tackCell:SetData(task)
end

function DailyPicturePuzzleMissionUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.DailyPicturePuzzleMissionUI)
end

return DailyPicturePuzzleMissionUI
