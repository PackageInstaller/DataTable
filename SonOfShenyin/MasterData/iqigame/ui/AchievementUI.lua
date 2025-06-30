-- chunkname: @IQIGame\\UI\\AchievementUI.lua

local AchievementUI = {}

AchievementUI = Base:Extend("AchievementUI", "IQIGame.Onigao.UI.AchievementUI", AchievementUI)

local AchievementTaskParentItemClass = require("IQIGame.UI.Achievement.AchievementTaskParentItem")
local AchievementTaskDetailItemClass = require("IQIGame.UI.Achievement.AchievementTaskDetailItem")

function AchievementUI:OnInit()
	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
end

function AchievementUI:InitMembers()
	self.achievementTabItemList = {}
	self.achievementTaskDetailsItemList = {}
	self.currentSelectParentItem = nil
end

function AchievementUI:InitComponent()
	self.buttonReturn = self.buttonReturn:GetComponent("Button")
end

function AchievementUI:InitDelegate()
	function self.buttonReturnDelegate()
		self:OnButtonReturnClick()
	end

	function self.parentClickDelegate(taskParentItem)
		self:OnParentClick(taskParentItem)
	end
end

function AchievementUI:OnAddListeners()
	self.buttonReturn.onClick:AddListener(self.buttonReturnDelegate)
	EventDispatcher.AddEventListener(EventID.AchievementUIParentClick, self.parentClickDelegate)
end

function AchievementUI:OnRemoveListeners()
	self.buttonReturn.onClick:RemoveListener(self.buttonReturnDelegate)
	EventDispatcher.RemoveEventListener(EventID.AchievementUIParentClick, self.parentClickDelegate)
end

function AchievementUI:OnButtonReturnClick()
	UIModule.Close(Constant.UIControllerName.AchievementUI)
end

function AchievementUI:OnParentClick(taskParentItem)
	if self.currentSelectParentItem then
		self.currentSelectParentItem:ResetStatus()
	end

	taskParentItem:OnSelected()

	self.currentSelectParentItem = taskParentItem

	self:RefreshTaskDetails(taskParentItem.Data.type)
end

function AchievementUI:GetPreloadAssetPaths()
	return nil
end

function AchievementUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AchievementUI:IsManualShowOnOpen(userData)
	return false
end

function AchievementUI:GetBGM(userData)
	return nil
end

function AchievementUI:OnPause()
	return
end

function AchievementUI:OnResume()
	return
end

function AchievementUI:OnCover()
	return
end

function AchievementUI:OnReveal()
	return
end

function AchievementUI:OnRefocus(userData)
	return
end

function AchievementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AchievementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AchievementUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AchievementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AchievementUI:OnOpen(userData)
	self:Refresh()

	if self.achievementTabItemList[1] then
		self.achievementTabItemList[1]:OnButtonClick()
	end
end

function AchievementUI:OnClose(userData)
	return
end

function AchievementUI:OnDestroy()
	for _, v in pairsCfg(self.achievementTabItemList) do
		v:OnDestroy()
	end
end

function AchievementUI:Refresh()
	self:RefreshParent()

	if self.currentSelectParentItem then
		self:RefreshTaskDetails(self.currentSelectParentItem)
	end
end

function AchievementUI:RefreshParent()
	local data = AchievementModule.GetAchievementParentList()
	local index = 1

	for i = 1, getCfgTableLength(data) do
		if i > getCfgTableLength(self.achievementTabItemList) then
			local parentObject = GameObject.Instantiate(self.achievementParentItem, self.taskParentContent.transform)
			local parentItem = AchievementTaskParentItemClass.New(parentObject, self)

			table.insert(self.achievementTabItemList, parentItem)
		end

		self.achievementTabItemList[i]:Refresh(data[i])
		self.achievementTabItemList[i]:Show()

		index = i + 1
	end

	for i = index, getCfgTableLength(self.achievementTabItemList) do
		self.achievementTabItemList[i]:Hide()
	end
end

function AchievementUI:RefreshTaskDetails(parentTaskID)
	local data = AchievementModule.GetSortTaskList(parentTaskID)
	local index = 1

	for i = 1, getCfgTableLength(data) do
		if i > getCfgTableLength(self.achievementTaskDetailsItemList) then
			local detailObject = GameObject.Instantiate(self.taskDetailItem, self.taskDetailsContent.transform)
			local detailItem = AchievementTaskDetailItemClass.New(detailObject, self)

			table.insert(self.achievementTaskDetailsItemList, detailItem)
		end

		self.achievementTaskDetailsItemList[i]:Refresh(data[i])
		self.achievementTaskDetailsItemList[i]:Show()

		index = i + 1
	end

	for i = index, getCfgTableLength(self.achievementTaskDetailsItemList) do
		self.achievementTaskDetailsItemList[i]:Hide()
	end
end

return AchievementUI
