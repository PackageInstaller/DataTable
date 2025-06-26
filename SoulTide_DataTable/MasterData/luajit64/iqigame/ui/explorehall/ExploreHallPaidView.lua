-- chunkname: @IQIGame\\UI\\ExploreHall\\ExploreHallPaidView.lua

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

	function self.DelegateUnlockChapterTask()
		self:OnUnlockChapterTask()
	end

	function self.DelegateOnUnlockNotify()
		self:OnUnlockNotify()
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateBtnSelf)
	EventDispatcher.AddEventListener(EventID.UnlockChapterTasksEvent, self.DelegateUnlockChapterTask)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.DelegateOnUnlockNotify)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSelf)
	EventDispatcher.RemoveEventListener(EventID.UnlockChapterTasksEvent, self.DelegateUnlockChapterTask)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.DelegateOnUnlockNotify)
end

function m:OnUnlockChapterTask()
	self:UpdateView()
end

function m:OnUnlockNotify()
	self:UpdateView()
end

function m:UpdateView()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.MAZE_CHALLENGE_BONUS)

	self.View:SetActive(result)

	if not result then
		return
	end

	local tabs = MazeChallengeBonusModule.CanGetRewardChapters()

	self.ImgRed:SetActive(#tabs > 0)
end

function m:OnBtnSelf()
	UIModule.Open(Constant.UIControllerName.MazeChallengeBonusUI, Constant.UILayer.UI)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
