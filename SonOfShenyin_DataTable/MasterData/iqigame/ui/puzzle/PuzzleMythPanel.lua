-- chunkname: @IQIGame\\UI\\Puzzle\\PuzzleMythPanel.lua

local PuzzleMythPanel = {}

function PuzzleMythPanel.New(go, mainView)
	local o = Clone(PuzzleMythPanel)

	o:Initialize(go, mainView)

	return o
end

function PuzzleMythPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.currentStartIndex = 1

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function PuzzleMythPanel:InitComponent()
	self.buttonLast = self.returnBtn:GetComponent("Button")
	self.buttonNext = self.nextBtn:GetComponent("Button")
end

function PuzzleMythPanel:InitDelegate()
	function self.delegateOnClickReturnBtn()
		self:LastPage()
	end

	function self.delegateOnClickNextBtn()
		self:NextPage()
	end
end

function PuzzleMythPanel:AddListener()
	self.buttonLast.onClick:AddListener(self.delegateOnClickReturnBtn)
	self.buttonNext.onClick:AddListener(self.delegateOnClickNextBtn)
end

function PuzzleMythPanel:RemoveListener()
	self.buttonLast.onClick:RemoveListener(self.delegateOnClickReturnBtn)
	self.buttonNext.onClick:RemoveListener(self.delegateOnClickNextBtn)
end

function PuzzleMythPanel:LastPage()
	if self.currentStartIndex <= 1 then
		self:CheckTurningPageButtonState()

		return
	end

	coroutine.start(function()
		self.currentStartIndex = self.currentStartIndex - 2
		self.mythData = StoryModule.GetStoryMythData()

		local len = #self.mythData

		if len < self.currentStartIndex then
			return
		end

		self.buttonLast.interactable = false

		self.mainView:PageLeftEffect()
		self:RefreshLeftPage()
		coroutine.wait(self.mainView:GetPageLeftTime())
		self:RefreshRightPage()

		self.buttonLast.interactable = true

		self:CheckTurningPageButtonState()
	end)
end

function PuzzleMythPanel:NextPage()
	if self.currentStartIndex + 2 > #self.mythData then
		self:CheckTurningPageButtonState()

		return
	end

	coroutine.start(function()
		self.currentStartIndex = self.currentStartIndex + 2
		self.mythData = StoryModule.GetStoryMythData()

		local len = #self.mythData

		if len < self.currentStartIndex then
			return
		end

		self.buttonNext.interactable = false

		self.mainView:PageRightEffect()
		self:RefreshRightPage()
		coroutine.wait(self.mainView:GetPageRightTime())
		self:RefreshLeftPage()

		self.buttonNext.interactable = true

		self:CheckTurningPageButtonState()
	end)
end

function PuzzleMythPanel:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)
end

function PuzzleMythPanel:Open()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	self:Refresh()
end

function PuzzleMythPanel:Close()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function PuzzleMythPanel:CheckTurningPageButtonState()
	LuaUtility.SetGameObjectShow(self.nextBtn, self.currentStartIndex + 2 <= #self.mythData)
	LuaUtility.SetGameObjectShow(self.returnBtn, self.currentStartIndex > 1)
end

function PuzzleMythPanel:Refresh()
	self.mythData = StoryModule.GetStoryMythData()

	local len = #self.mythData

	if len < self.currentStartIndex then
		return
	end

	self:RefreshLeftPage()
	self:RefreshRightPage()
	self:CheckTurningPageButtonState()
end

function PuzzleMythPanel:RefreshLeftPage()
	if self.leftPrefab then
		GameObject.Destroy(self.leftPrefab)
	end

	LuaUtility.LoadAsset(self, CfgUtil.GetStoryResourceWithID(self.mythData[self.currentStartIndex]), function(owner, assetName, asset, duration, userData)
		self.leftPrefab = GameObject.Instantiate(asset, self.leftPart.transform)
	end)
end

function PuzzleMythPanel:RefreshRightPage()
	if self.rightPrefab then
		GameObject.Destroy(self.rightPrefab)
	end

	if self.mythData[self.currentStartIndex + 1] then
		LuaUtility.LoadAsset(self, CfgUtil.GetStoryResourceWithID(self.mythData[self.currentStartIndex + 1]), function(owner, assetName, asset, duration, userData)
			self.rightPrefab = GameObject.Instantiate(asset, self.rightPart.transform)
		end)
	end
end

return PuzzleMythPanel
