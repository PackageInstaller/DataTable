-- chunkname: @IQIGame\\UI\\Puzzle\\PuzzleCluePanel.lua

local PuzzleCluePanel = {}
local PuzzleClueDetailPanelClass = require("IQIGame.UI.Puzzle.PuzzleClueDetailPanel")
local ClueItemViewClass = require("IQIGame.UI.Puzzle.ClueItemView")
local GetClueTipPanelClass = require("IQIGame.UI.Puzzle.GetClueTipPanel")

function PuzzleCluePanel.New(go, mainView)
	local o = Clone(PuzzleCluePanel)

	o:Initialize(go, mainView)

	return o
end

function PuzzleCluePanel:ctor(go, mainView)
	self:Initialize(go, mainView)
end

function PuzzleCluePanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.currentStartIndex = 1

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function PuzzleCluePanel:InitComponent()
	self.detailPanel = PuzzleClueDetailPanelClass.New(self.clueDetailPanel, self)

	self.detailPanel:Hide()

	self.getClueTipPanel = GetClueTipPanelClass.New(self.getClueTipPanel, self)

	self.getClueTipPanel:Close()

	self.clueItemArray = {}

	local gridContentTrans = self.gridContent.transform
	local len = LuaUtility.GetChildCount(gridContentTrans)

	for i = 1, len do
		local trans = LuaUtility.GetChild(gridContentTrans, i - 1)
		local view = ClueItemViewClass.New(trans.gameObject, self)

		table.insert(self.clueItemArray, view)
	end

	self.buttonLast = self.returnBtn:GetComponent("Button")
	self.buttonNext = self.nextBtn:GetComponent("Button")
end

function PuzzleCluePanel:InitDelegate()
	function self.delegateOnClickReturnBtn()
		self:LastPage()
	end

	function self.delegateOnClickNextBtn()
		self:NextPage()
	end
end

function PuzzleCluePanel:AddListener()
	self.buttonLast.onClick:AddListener(self.delegateOnClickReturnBtn)
	self.buttonNext.onClick:AddListener(self.delegateOnClickNextBtn)
end

function PuzzleCluePanel:RemoveListener()
	self.buttonLast.onClick:RemoveListener(self.delegateOnClickReturnBtn)
	self.buttonNext.onClick:RemoveListener(self.delegateOnClickNextBtn)
end

function PuzzleCluePanel:OnDestroy()
	return
end

function PuzzleCluePanel:Open()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	self:Refresh()
end

function PuzzleCluePanel:Close()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function PuzzleCluePanel:_GetItem(index)
	if not self.clueItemArray[index] then
		return
	end
end

function PuzzleCluePanel:LastPage()
	if self.currentStartIndex <= 1 then
		self:CheckTurningPageButtonState()

		return
	end

	coroutine.start(function()
		self.buttonLast.interactable = false

		self.mainView:PageLeftEffect()
		coroutine.wait(self.mainView:GetPageLeftTime())

		self.currentStartIndex = self.currentStartIndex - 6

		self:Refresh()

		self.buttonLast.interactable = true
	end)
end

function PuzzleCluePanel:NextPage()
	if self.currentStartIndex + 5 > #PuzzleModule.currentStoryCluesList then
		self:CheckTurningPageButtonState()

		return
	end

	coroutine.start(function()
		self.buttonNext.interactable = false

		self.mainView:PageRightEffect()
		coroutine.wait(self.mainView:GetPageRightTime())

		self.currentStartIndex = self.currentStartIndex + 6

		self:Refresh()

		self.buttonNext.interactable = true
	end)
end

function PuzzleCluePanel:CheckTurningPageButtonState()
	LuaUtility.SetGameObjectShow(self.nextBtn, self.currentStartIndex + 5 < #PuzzleModule.currentStoryCluesList)
	LuaUtility.SetGameObjectShow(self.returnBtn, self.currentStartIndex > 1)
end

function PuzzleCluePanel:OnClickClue(clueItem)
	if self.detailPanel:GetIsShow() then
		if clueItem:GetIsSelected() then
			clueItem:UnSelected()
			self.detailPanel:ReduceClue(clueItem.cfgClue.Id)
		else
			clueItem:Selected()
			self.detailPanel:AddClue(clueItem.cfgClue.Id)
		end

		StoryUIApi:PlayPuzzleUIConnectClickSound()
	else
		if not clueItem.cfgClue.IsSurvey then
			return
		end

		EventDispatcher.Dispatch(EventID.BehaviourTreeNPCClueTriggerEvent, clueItem.cfgClue.ActionParam)
		UIModule.Close(Constant.UIControllerName.PuzzleUI)
	end
end

function PuzzleCluePanel:Refresh()
	self.clueList = PuzzleModule.currentStoryCluesList

	self:RefreshClueItems()
	self:CheckTurningPageButtonState()
end

function PuzzleCluePanel:RefreshClueItems()
	if not self.detailPanel:GetComposeIsEmpty() then
		self:RefreshItems()

		return
	end

	self.cfgCanCompose = PuzzleModule.GetTheFirstCanCompose()

	self:RefreshItems()

	if self.cfgCanCompose then
		self.detailPanel:Show()
		self.detailPanel:Expand()
		self.detailPanel:Refresh(self.cfgCanCompose)
	else
		self.detailPanel:Hide()
	end
end

function PuzzleCluePanel:RefreshItems()
	local viewIndex = 1
	local maxIndex = self.currentStartIndex + 5
	local canComposeSet = {}

	if self.cfgCanCompose then
		local len = #self.cfgCanCompose.CluesID

		for i = 1, len do
			canComposeSet[self.cfgCanCompose.CluesID[i]] = 1
		end
	end

	local len = #self.clueList

	for i = self.currentStartIndex, maxIndex do
		if len < i then
			break
		end

		self.clueItemArray[viewIndex]:Refresh(self.clueList[i])

		if canComposeSet[self.clueList[i]] then
			self.clueItemArray[viewIndex]:ShowComposeFlag()
		else
			self.clueItemArray[viewIndex]:HideComposeFlag()
		end

		self.clueItemArray[viewIndex]:Show()

		viewIndex = viewIndex + 1
	end

	len = #self.clueItemArray

	for i = viewIndex, len do
		self.clueItemArray[i]:Hide()
	end
end

function PuzzleCluePanel:UnSelectedAll()
	local len = #self.clueItemArray

	for i = 1, len do
		self.clueItemArray[i]:UnSelected()
	end
end

function PuzzleCluePanel:ShowClueComposeTips(clueID, callBack)
	self.getClueTipPanel:Open()
	self.getClueTipPanel:Refresh(clueID, callBack)
end

return PuzzleCluePanel
