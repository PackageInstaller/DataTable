-- chunkname: @IQIGame\\UI\\Story\\JudgmentCheckers\\JudgmentCluesPanel.lua

local JudgmentCluesPanel = {}
local clueItemClass = require("IQIGame/UI/Story/JudgmentCheckers/JudgmentCluesPanel_ClueItem")

function JudgmentCluesPanel.New(go, mainView)
	local o = Clone(JudgmentCluesPanel)

	o:Initialize(go, mainView)

	return o
end

function JudgmentCluesPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.cluesItemCellList = {}
	self.cluesDataArray = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function JudgmentCluesPanel:InitComponent()
	self.cluesScroll = self.cluesScroll:GetComponent("OptimizedScrollRect")

	self.cluesScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateCluesScroll(OptimizedParams, OptimizedViewsHolder)
	end)
end

function JudgmentCluesPanel:InitDelegate()
	return
end

function JudgmentCluesPanel:AddListener()
	return
end

function JudgmentCluesPanel:RemoveListener()
	return
end

function JudgmentCluesPanel:UpdateCluesScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.cluesDataArray[index + 1]

	if not self.cluesItemCellList[instanceID] then
		self.cluesItemCellList[instanceID] = clueItemClass.New(viewGameObject, self)
	end

	self.cluesItemCellList[instanceID]:Refresh(data)
end

function JudgmentCluesPanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function JudgmentCluesPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function JudgmentCluesPanel:Refresh(ShowCheckersCluePanelTask)
	self.showCheckersCluePanelTask = ShowCheckersCluePanelTask

	self:RefreshClueScroll()
end

function JudgmentCluesPanel:RefreshClueScroll()
	self.cluesDataArray = PuzzleModule.currentStoryCluesList

	self.cluesScroll:RefreshByItemCount(#self.cluesDataArray)
end

function JudgmentCluesPanel:OnClueSelected(selectId)
	if self.showCheckersCluePanelTask then
		self.showCheckersCluePanelTask:Complete(selectId)
	end

	self.mainView:HideAllProblem()
end

function JudgmentCluesPanel:OnDestroy()
	return
end

return JudgmentCluesPanel
