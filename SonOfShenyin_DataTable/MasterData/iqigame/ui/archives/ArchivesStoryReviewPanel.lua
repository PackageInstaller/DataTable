-- chunkname: @IQIGame\\UI\\Archives\\ArchivesStoryReviewPanel.lua

local ArchivesStoryReviewPanel = class(nil, BaseChildrenPanel)
local StoryReviewPlotItemViewClass = require("IQIGame.UI.Archives.StoryReviewPlotItemView")
local StoryReviewStagePanelClass = require("IQIGame.UI.Archives.StoryReviewStagePanel")
local animationPlotEvent_In = "PlotEvent_In"

function ArchivesStoryReviewPanel.New(go, mainView)
	local o = Clone(ArchivesStoryReviewPanel)

	o:Initialize(go, mainView)

	return o
end

function ArchivesStoryReviewPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ArchivesStoryReviewPanel:InitMembers()
	self.plotDataArray = {}
	self.plotItemViewList = {}
end

function ArchivesStoryReviewPanel:InitComponent()
	self.PlotScroll = self.PlotScroll:GetComponent("OptimizedScrollRect")

	self.PlotScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdatePlotScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.storyReviewStagePanel = StoryReviewStagePanelClass.New(self.PlotEvent, self)

	self.storyReviewStagePanel:Close()
end

function ArchivesStoryReviewPanel:InitDelegate()
	return
end

function ArchivesStoryReviewPanel:AddListener()
	return
end

function ArchivesStoryReviewPanel:RemoveListener()
	return
end

function ArchivesStoryReviewPanel:OnOpen()
	LuaUtility.SetGameObjectShow(self.PlotScroll.gameObject, true)
	LuaUtility.AnimationStayInTime(self.gameObject, animationPlotEvent_In, 0)
	self.storyReviewStagePanel:Close()
	self:RegisterCloseEvent(function()
		self:Close()
		self.mainView.MainPanel:Open()
	end)
	self:Refresh()
end

function ArchivesStoryReviewPanel:OnDestroy()
	return
end

function ArchivesStoryReviewPanel:UpdatePlotScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.plotDataArray[index + 1]

	if not self.plotItemViewList[instanceID] then
		self.plotItemViewList[instanceID] = StoryReviewPlotItemViewClass.New(viewGameObject, self)
	end

	self.plotItemViewList[instanceID]:Refresh(data, OptimizedViewsHolder)
end

function ArchivesStoryReviewPanel:RefreshPlotScroll()
	self.plotDataArray = StoryChapterModule.GetStoryReviewData()

	self.PlotScroll:RefreshByItemCount(#self.plotDataArray)
end

function ArchivesStoryReviewPanel:OpenStagePanel(itemIndex)
	LuaUtility.SetGameObjectShow(self.PlotScroll.gameObject, false)
	self.storyReviewStagePanel:Open(itemIndex)
	self:RegisterCloseEvent(function()
		self:Open()
		LuaUtility.ReversePlayAnimation(self.gameObject, animationPlotEvent_In)
	end)
	LuaUtility.PlayAnimation(self.gameObject, animationPlotEvent_In)
end

function ArchivesStoryReviewPanel:RegisterCloseEvent(func)
	self.mainView:RegisterCloseEvent(func)
end

function ArchivesStoryReviewPanel:Refresh()
	self:RefreshPlotScroll()
end

return ArchivesStoryReviewPanel
