-- chunkname: @IQIGame\\UI\\MazeSelectLevel\\MazeSelectLevelPaidView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnSelf()
		self:OnBtnSelf()
	end

	function self.DelegateUnlockChapterTasks()
		self:OnUnlockChapterTasks()
	end

	function self.DelegateOnUnlockNotify()
		self:OnUnlockNotify()
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateBtnSelf)
	EventDispatcher.AddEventListener(EventID.UnlockChapterTasksEvent, self.DelegateUnlockChapterTasks)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.DelegateOnUnlockNotify)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSelf)
	EventDispatcher.RemoveEventListener(EventID.UnlockChapterTasksEvent, self.DelegateUnlockChapterTasks)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.DelegateOnUnlockNotify)
end

function m:OnUnlockChapterTasks()
	if self.chapterCid then
		self:UpdateView(self.chapterCid)
	end
end

function m:OnUnlockNotify()
	self:RefreshOpenState()
end

function m:RefreshOpenState()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.MAZE_CHALLENGE_BONUS)
	local isBuy = false

	if self.chapterCid then
		isBuy = MazeChallengeBonusModule.IsBuyChallengeBonusByChapter(self.chapterCid)
	end

	self.View:SetActive(result and isBuy)
end

function m:UpdateView(chapterCid)
	self.chapterCid = chapterCid

	self:RefreshOpenState()

	local num, totalNum = MazeChallengeBonusModule.GetTaskNumsInChapter(chapterCid)

	UGUIUtil.SetText(self.TextComplete, MazeSelectLevelUIApi:GetString("TextComplete", num, totalNum))
end

function m:OnBtnSelf()
	UIModule.Open(Constant.UIControllerName.MazeChallengeBonusUI, Constant.UILayer.UI, self.chapterCid)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
