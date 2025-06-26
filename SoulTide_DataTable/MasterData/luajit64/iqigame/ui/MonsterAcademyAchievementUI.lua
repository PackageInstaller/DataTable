-- chunkname: @IQIGame\\UI\\MonsterAcademyAchievementUI.lua

local MonsterAcademyAchievementUI = {
	achievementTaskData = {},
	achievementTaskCellPool = {}
}

MonsterAcademyAchievementUI = Base:Extend("MonsterAcademyAchievementUI", "IQIGame.Onigao.UI.MonsterAcademyAchievementUI", MonsterAcademyAchievementUI)

require("IQIGame.UIExternalApi.MonsterAcademyAchievementUIApi")

local MonsterAcademyAchievementTaskCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyAchievement.MonsterAcademyAchievementTaskCell")

function MonsterAcademyAchievementUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, MonsterAcademyAchievementUIApi:GetString("TextTitle"))

	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateTaskUpdate()
		self:OnTaskUpdate()
	end

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(renderCell)
		self:OnRenderGridCell(renderCell)
	end
end

function MonsterAcademyAchievementUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyAchievementUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyAchievementUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyAchievementUI:GetBGM(userData)
	return nil
end

function MonsterAcademyAchievementUI:OnOpen(userData)
	self:UpdateView()
end

function MonsterAcademyAchievementUI:OnClose(userData)
	return
end

function MonsterAcademyAchievementUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateTaskUpdate)
end

function MonsterAcademyAchievementUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateTaskUpdate)
end

function MonsterAcademyAchievementUI:OnPause()
	return
end

function MonsterAcademyAchievementUI:OnResume()
	return
end

function MonsterAcademyAchievementUI:OnCover()
	return
end

function MonsterAcademyAchievementUI:OnReveal()
	return
end

function MonsterAcademyAchievementUI:OnRefocus(userData)
	return
end

function MonsterAcademyAchievementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyAchievementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyAchievementUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyAchievementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyAchievementUI:OnDestroy()
	for i, v in pairs(self.achievementTaskCellPool) do
		v:Dispose()
	end
end

function MonsterAcademyAchievementUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function MonsterAcademyAchievementUI:OnTaskUpdate()
	self:UpdateView()
end

function MonsterAcademyAchievementUI:UpdateView()
	self.achievementTaskData = MonsterAcademyModule.GetMonsterAcademyAchievementData()

	self.scrollList:Refresh(#self.achievementTaskData)
end

function MonsterAcademyAchievementUI:OnRenderGridCell(cell)
	local taskData = self.achievementTaskData[cell.index + 1]

	if taskData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local insID = cell.gameObject:GetInstanceID()
	local achievementTaskCell = self.achievementTaskCellPool[insID]

	if achievementTaskCell == nil then
		achievementTaskCell = MonsterAcademyAchievementTaskCell.New(cell.gameObject)
		self.achievementTaskCellPool[insID] = achievementTaskCell
	end

	achievementTaskCell:SetData(taskData)
end

return MonsterAcademyAchievementUI
