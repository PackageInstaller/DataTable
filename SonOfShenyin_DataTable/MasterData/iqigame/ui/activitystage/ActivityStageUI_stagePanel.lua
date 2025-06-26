-- chunkname: @IQIGame\\UI\\ActivityStage\\ActivityStageUI_stagePanel.lua

local ActivityStageUI_stagePanel = {}
local stageItemClass = require("IQIGame/UI/ActivityStage/ActivityStageUI_stagePanel_stageItem")
local targetDescribeItemClass = require("IQIGame/UI/ActivityStage/ActivityStageUI_stagePanel_targetDescribeItem")

function ActivityStageUI_stagePanel.New(go, mainView)
	local o = Clone(ActivityStageUI_stagePanel)

	o:Initialize(go, mainView)

	return o
end

function ActivityStageUI_stagePanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.stageScrollCellList = {}
	self.targetDescribeCellList = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ActivityStageUI_stagePanel:InitComponent()
	self.stageScroll = self.stageScroll:GetComponent("OptimizedScrollRect")

	self.stageScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateStageScroll(OptimizedParams, OptimizedViewsHolder)
	end)
end

function ActivityStageUI_stagePanel:InitDelegate()
	function self.delegateOnClickButtonReward()
		self:OnClickButtonReward()
	end

	function self.delegateOnClickButtonStart()
		self:OnClickButtonStart()
	end
end

function ActivityStageUI_stagePanel:AddListener()
	self.buttonReward:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonReward)
	self.buttonStart:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonStart)
end

function ActivityStageUI_stagePanel:RemoveListener()
	self.buttonReward:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonReward)
	self.buttonStart:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonStart)
end

function ActivityStageUI_stagePanel:OnClickButtonStart()
	if not ActivityDungeonModule.CheckChapterIsEnabled(self.data.chapterId) then
		NoticeModule.ShowNotice(51012)

		return
	end

	local cfgChapter = CfgUtil.GetCfgActivityChapterDataWithID(self.data.chapterId)
	local userData = {}

	userData.OpenType = 2
	userData.ChapterType = cfgChapter.Type
	userData.StageId = self.cfgActivityStage.Id

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
end

function ActivityStageUI_stagePanel:OnClickButtonReward()
	self.mainView:SetViewShow(Constant.ActivityStageUI_stagePanelViewType.reward)
	self.mainView:RewardPanelSelect(self.data.chapterId)
end

function ActivityStageUI_stagePanel:UpdateStageScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.stageScrollDataList[index + 1]

	if not self.stageScrollCellList[instanceID] then
		self.stageScrollCellList[instanceID] = stageItemClass.New(viewGameObject, self)
	end

	self.stageScrollCellList[instanceID]:Refresh(data)
end

function ActivityStageUI_stagePanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function ActivityStageUI_stagePanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function ActivityStageUI_stagePanel:Refresh(Data)
	self.data = Data
	self.stageScrollDataList = ActivityDungeonModule.GetCfgActivityStageDataArray(self.data.chapterId)

	self.stageScroll:RefreshByItemCount(#self.stageScrollDataList)
	self:RefreshDot()
end

function ActivityStageUI_stagePanel:RefreshDot()
	LuaUtility.SetGameObjectShow(self.redDot_ButtonReward, RedDotModule.GetRedDotCntByRedDotID(Constant.E_RedDotPath.BattleActivity_Chapter_Reward) >= 1)
end

function ActivityStageUI_stagePanel:RefreshChallengeDetail()
	local len = #self.cfgActivityStage.ChallengeDesc

	for i = 1, len do
		local cfgCondition = CfgUtil.GetCfgConditionDataWithID(self.cfgActivityStage.ChallengeDesc[i])
		local cell = self:_GetTargetDescribeCell(i)

		cell:Refresh(cfgCondition, self.cfgActivityStage.Id)
	end
end

function ActivityStageUI_stagePanel:RefreshStageDetail(stageId)
	self.cfgActivityStage = CfgUtil.GetCfgActivityStageDataWithID(stageId)

	LuaUtility.SetText(self.textHead, self.cfgActivityStage.Name)
	LuaUtility.SetText(self.textDetail, self.cfgActivityStage.Desc)
	LuaUtility.SetText(self.textLevel, "Lv." .. self.cfgActivityStage.RecommendLevel)
	self:RefreshChallengeDetail()
end

function ActivityStageUI_stagePanel:_GetTargetDescribeCell(index)
	if not self.targetDescribeCellList[index] then
		local o = GameObject.Instantiate(self.targetDescribePrefab, self.targetDescribeContent.transform)

		self.targetDescribeCellList[index] = targetDescribeItemClass.New(o, self)
	end

	return self.targetDescribeCellList[index]
end

function ActivityStageUI_stagePanel:SelectStage(cell)
	if self.currentSelectStage then
		self.currentSelectStage:UnSelected()

		self.currentSelectStage = nil
	end

	self.currentSelectStage = cell

	self.currentSelectStage:Selected()
	self:RefreshStageDetail(cell.data.Id)
end

function ActivityStageUI_stagePanel:GetPassStart(stageId)
	local num = 0

	if self.data.passStar[stageId] and self.data.passStar[stageId].conditionIds then
		num = #self.data.passStar[stageId].conditionIds
	end

	return num
end

function ActivityStageUI_stagePanel:GetTargetIsComplete(stageId, conditionId)
	local result = false

	if self.data.passStar[stageId] and self.data.passStar[stageId].conditionIds then
		for _, v in pairs(self.data.passStar[stageId].conditionIds) do
			if v == conditionId then
				return true
			end
		end
	end

	return result
end

function ActivityStageUI_stagePanel:SelectFirst()
	local viewsHolder = self.stageScroll:GetItemViewsHolder(0)

	if viewsHolder then
		local instanceID = viewsHolder.instanceID

		self.stageScrollCellList[instanceID]:OnClickButtonClick()
	end
end

function ActivityStageUI_stagePanel:SetViewShow(type)
	self.mainView:SetViewShow(type)
end

function ActivityStageUI_stagePanel:OnDestroy()
	return
end

return ActivityStageUI_stagePanel
