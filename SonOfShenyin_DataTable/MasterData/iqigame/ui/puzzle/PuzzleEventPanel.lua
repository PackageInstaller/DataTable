-- chunkname: @IQIGame\\UI\\Puzzle\\PuzzleEventPanel.lua

local PuzzleEventPanel = {}
local PuzzleEventItemViewClass = require("IQIGame.UI.Puzzle.PuzzleEventItemView")

function PuzzleEventPanel.New(go, mainView)
	local o = Clone(PuzzleEventPanel)

	o:Initialize(go, mainView)

	return o
end

function PuzzleEventPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.currentStartIndex = 1

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function PuzzleEventPanel:InitComponent()
	self.itemViewArray = {}

	local gridTrans = self.gridContent.transform
	local len = LuaUtility.GetChildCount(gridTrans)

	for i = 1, len do
		local trans = LuaUtility.GetChild(gridTrans, i - 1)

		self.itemViewArray[i] = PuzzleEventItemViewClass.New(trans.gameObject, self)
	end

	self.buttonLast = self.returnBtn:GetComponent("Button")
	self.buttonNext = self.nextBtn:GetComponent("Button")
end

function PuzzleEventPanel:InitDelegate()
	function self.delegateOnClickReturnBtn()
		self:LastPage()
	end

	function self.delegateOnClickNextBtn()
		self:NextPage()
	end
end

function PuzzleEventPanel:AddListener()
	self.buttonLast.onClick:AddListener(self.delegateOnClickReturnBtn)
	self.buttonNext.onClick:AddListener(self.delegateOnClickNextBtn)
end

function PuzzleEventPanel:RemoveListener()
	self.buttonLast.onClick:RemoveListener(self.delegateOnClickReturnBtn)
	self.buttonNext.onClick:RemoveListener(self.delegateOnClickNextBtn)
end

function PuzzleEventPanel:OnDestroy()
	return
end

function PuzzleEventPanel:Open()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	self:Refresh()
end

function PuzzleEventPanel:Close()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function PuzzleEventPanel:LastPage()
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

function PuzzleEventPanel:NextPage()
	if self.currentStartIndex + 5 > #self.data then
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

function PuzzleEventPanel:CheckTurningPageButtonState()
	LuaUtility.SetGameObjectShow(self.nextBtn, self.currentStartIndex + 5 < #self.data)
	LuaUtility.SetGameObjectShow(self.returnBtn, self.currentStartIndex > 1)
end

function PuzzleEventPanel:Refresh()
	self.data = StoryModule.GetStoryEventData()

	local viewIndex = 1
	local len = self.currentStartIndex + 5

	for i = self.currentStartIndex, len do
		if i > #self.data then
			break
		end

		self.itemViewArray[viewIndex]:Refresh(self.data[i], viewIndex)

		viewIndex = viewIndex + 1
	end

	len = #self.itemViewArray

	for i = viewIndex, len do
		self.itemViewArray[i]:Hide()
	end

	self:CheckTurningPageButtonState()
end

return PuzzleEventPanel
