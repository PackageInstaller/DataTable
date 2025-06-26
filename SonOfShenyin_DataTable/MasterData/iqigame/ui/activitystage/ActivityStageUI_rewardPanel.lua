-- chunkname: @IQIGame\\UI\\ActivityStage\\ActivityStageUI_rewardPanel.lua

local ActivityStageUI_rewardPanel = {}
local stageItemClass = require("IQIGame/UI/ActivityStage/ActivityStageUI_rewardPanel_stageItem")
local rewardItemClass = require("IQIGame/UI/ActivityStage/ActivityStageUI_rewardPanel_rewardItem")

function ActivityStageUI_rewardPanel.New(go, mainView)
	local o = Clone(ActivityStageUI_rewardPanel)

	o:Initialize(go, mainView)

	return o
end

function ActivityStageUI_rewardPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.stageScrollCellList = {}
	self.rewardScrollCellList = {}

	self:InitComponent()
	self:InitDelegate()
end

function ActivityStageUI_rewardPanel:InitComponent()
	self.stageScroll = self.stageScroll:GetComponent("OptimizedScrollRect")

	self.stageScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateStageScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.stageRewardScroll = self.stageRewardScroll:GetComponent("OptimizedScrollRect")

	self.stageRewardScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateRewardScroll(OptimizedParams, OptimizedViewsHolder)
	end)
end

function ActivityStageUI_rewardPanel:InitDelegate()
	function self.delegateOnClickButtonClose()
		self.mainView:SetViewShow(Constant.ActivityStageUI_stagePanelViewType.stage)
	end

	function self.onReceiveRewardResultEvent()
		self:Refresh()

		for _, v in pairs(self.stageScrollCellList) do
			if v.data.chapterId == self.activityChapterPOD.chapterId then
				v:OnClickButtonClick()

				break
			end
		end
	end
end

function ActivityStageUI_rewardPanel:AddListener()
	self.buttonClose:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClose)
	EventDispatcher.AddEventListener(EventID.ActivityDupReceiveRewardResultEvent, self.onReceiveRewardResultEvent)
end

function ActivityStageUI_rewardPanel:RemoveListener()
	self.buttonClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClose)
	EventDispatcher.RemoveEventListener(EventID.ActivityDupReceiveRewardResultEvent, self.onReceiveRewardResultEvent)
end

function ActivityStageUI_rewardPanel:UpdateRewardScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.rewardScrollDataList[index + 1]

	if not self.rewardScrollCellList[instanceID] then
		self.rewardScrollCellList[instanceID] = rewardItemClass.New(viewGameObject, self)
	end

	self.rewardScrollCellList[instanceID]:Refresh(data)
end

function ActivityStageUI_rewardPanel:UpdateStageScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.stageScrollDataList[index + 1]

	if not self.stageScrollCellList[instanceID] then
		self.stageScrollCellList[instanceID] = stageItemClass.New(viewGameObject, self)
	end

	self.stageScrollCellList[instanceID]:Refresh(data)
end

function ActivityStageUI_rewardPanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	self:AddListener()
end

function ActivityStageUI_rewardPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
	self:RemoveListener()
end

function ActivityStageUI_rewardPanel:Refresh()
	local activityPod = PlayerModule.GetActivityDup()

	self.stageScrollDataList = {}

	for _, v in pairs(activityPod) do
		table.insert(self.stageScrollDataList, v)
	end

	table.sort(self.stageScrollDataList, function(a, b)
		return a.chapterId < b.chapterId
	end)
	self.stageScroll:RefreshByItemCount(#self.stageScrollDataList)
end

function ActivityStageUI_rewardPanel:RefreshReward(activityChapterPOD)
	self.activityChapterPOD = activityChapterPOD

	local cfgChapter = CfgUtil.GetCfgActivityChapterDataWithID(self.activityChapterPOD.chapterId)

	self.rewardScrollDataList = {}

	local len = #cfgChapter.RewardDrop

	for i = 1, len, 2 do
		local t = {}

		t.start = cfgChapter.RewardDrop[i]
		t.drop = cfgChapter.RewardDrop[i + 1]
		t.chapterId = self.activityChapterPOD.chapterId

		table.insert(self.rewardScrollDataList, t)
	end

	self.stageRewardScroll:RefreshByItemCount(#self.rewardScrollDataList)

	local currentProgress, maxProgress = ActivityDungeonModule.GetChapterProgress(self.activityChapterPOD)

	LuaUtility.SetText(self.textCurrentProgress, currentProgress)
	LuaUtility.SetText(self.textMaxProgress, maxProgress)
end

function ActivityStageUI_rewardPanel:SelectStageFirst()
	local viewsHolder = self.stageScroll:GetItemViewsHolder(0)

	if viewsHolder then
		local instanceID = viewsHolder.instanceID

		self.stageScrollCellList[instanceID]:OnClickButtonClick()
	end
end

function ActivityStageUI_rewardPanel:SelectStageWithChapterID(chapterID)
	for _, v in pairs(self.stageScrollCellList) do
		if v.data.chapterId == chapterID then
			v:OnClickButtonClick()

			break
		end
	end
end

function ActivityStageUI_rewardPanel:SelectStage(stageItem)
	if self.currentStageItem then
		self.currentStageItem:UnSelected()

		self.currentStageItem = nil
	end

	self.currentStageItem = stageItem

	self.currentStageItem:Selected()
end

function ActivityStageUI_rewardPanel:GetStartNum()
	local num = 0

	for _, v in pairs(self.activityChapterPOD.passStar) do
		for _, v2 in pairs(v.conditionIds) do
			num = num + 1
		end
	end

	return num
end

function ActivityStageUI_rewardPanel:GetStartState(startNum)
	return self.activityChapterPOD.starState[startNum]
end

function ActivityStageUI_rewardPanel:OnDestroy()
	for i, v in pairs(self.stageScrollCellList) do
		v:OnDestroy()
	end

	self.stageScrollCellList = {}

	for i, v in pairs(self.rewardScrollCellList) do
		v:OnDestroy()
	end

	self.rewardScrollCellList = {}
end

return ActivityStageUI_rewardPanel
