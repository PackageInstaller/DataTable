-- chunkname: @IQIGame\\UI\\Archives\\StoryReviewStagePanel.lua

local StoryReviewStagePanel = {}
local StoryReviewPlotItemViewClass = require("IQIGame.UI.Archives.StoryReviewPlotItemView")
local StoryReviewPlotEventItemViewClass = require("IQIGame.UI.Archives.StoryReviewPlotEventItemView")

function StoryReviewStagePanel.New(go, mainView)
	local o = Clone(StoryReviewStagePanel)

	o:Initialize(go, mainView)

	return o
end

function StoryReviewStagePanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitDelegate()
	self:InitMembers()
	self:InitComponent()
	self:AddListener()
end

function StoryReviewStagePanel:InitMembers()
	self.plotItemViewList = {}
	self.plotDataArray = {}
	self.plotEventItemViewList = {}
	self.plotEventDataArray = {}
end

function StoryReviewStagePanel:InitComponent()
	self.plotScroll = self.PlotScroll:GetComponent("OptimizedScrollRect")

	self.plotScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdatePlotScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.plotEventScroll = self.PlotEventScroll:GetComponent("OptimizedGridRect")

	self.plotEventScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdatePlotEventScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.snapper = self.PlotScroll:GetComponent("Com.TheFallenGames.OSA.Core.Snapper8")
	self.snapper.SnappingEndedOrCancelled = self.snapper.SnappingEndedOrCancelled + self.onSnapperEndDelegate
	self.dotIconArray = {}

	local leftParentTrans = self.leftParent.transform
	local len = LuaUtility.GetChildCount(leftParentTrans)

	for i = 1, len do
		local trans = LuaUtility.GetChild(leftParentTrans, i - 1)

		self.dotIconArray[i] = trans:GetComponent("Toggle")
	end
end

function StoryReviewStagePanel:InitDelegate()
	function self.onSnapperEndDelegate()
		self:OnSnapperEnd()
	end
end

function StoryReviewStagePanel:AddListener()
	return
end

function StoryReviewStagePanel:RemoveListener()
	self.snapper.SnappingEndedOrCancelled = self.snapper.SnappingEndedOrCancelled - self.onSnapperEndDelegate
end

function StoryReviewStagePanel:OnSnapperEnd()
	local viewsHolder = self.plotScroll:GetItemViewsHolder(0)
	local instanceID = viewsHolder.instanceID
	local view = self.plotItemViewList[instanceID]
	local index = view.data.Index % 4 == 0 and 4 or view.data.Index % 4

	self.dotIconArray[index].isOn = true

	self:RefreshPlotEventScroll(view.data.Id)
end

function StoryReviewStagePanel:OnDestroy()
	return
end

function StoryReviewStagePanel:Open(itemIndex)
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	self:Refresh()
	self:SelectPlot(itemIndex)
	self:RefreshPlotEventScroll(self.plotDataArray[itemIndex + 1].Id)
	self:PlayPlotViewInAnimation()
end

function StoryReviewStagePanel:Close()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function StoryReviewStagePanel:PlayPlotViewInAnimation()
	local viewsHolder = self.plotScroll:GetItemViewsHolder(0)
	local view = self.plotItemViewList[viewsHolder.instanceID]

	view:PlayInAnimation()
end

function StoryReviewStagePanel:UpdatePlotEventScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.plotEventDataArray[index + 1]

	if not self.plotEventItemViewList[instanceID] then
		self.plotEventItemViewList[instanceID] = StoryReviewPlotEventItemViewClass.New(viewGameObject, self)
	end

	self.plotEventItemViewList[instanceID]:Refresh(data, index + 1)
end

function StoryReviewStagePanel:UpdatePlotScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.plotDataArray[index + 1]

	if not self.plotItemViewList[instanceID] then
		self.plotItemViewList[instanceID] = StoryReviewPlotItemViewClass.New(viewGameObject, self)

		self.plotItemViewList[instanceID]:ButtonInactive()
	end

	self.plotItemViewList[instanceID]:Refresh(data, OptimizedViewsHolder)
end

function StoryReviewStagePanel:RefreshPlotScroll()
	self.plotDataArray = StoryChapterModule.GetStoryReviewData()

	self.plotScroll:RefreshByItemCount(#self.plotDataArray)
end

function StoryReviewStagePanel:RefreshPlotEventScroll(generalDupID)
	self.plotEventDataArray = StoryChapterModule.GetStoryReviewStageData(generalDupID)

	self.plotEventScroll:RefreshByItemCount(#self.plotEventDataArray)
end

function StoryReviewStagePanel:Refresh()
	self:RefreshPlotScroll()
end

function StoryReviewStagePanel:SelectPlot(itemIndex)
	self.plotScroll:ScrollTo(itemIndex)
end

return StoryReviewStagePanel
