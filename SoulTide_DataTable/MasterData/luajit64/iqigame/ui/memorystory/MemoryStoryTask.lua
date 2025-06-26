-- chunkname: @IQIGame\\UI\\MemoryStory\\MemoryStoryTask.lua

local TaskMould = require("IQIGame.UI.MemoryStory.MemoryStoryTaskMould")
local m = {
	tweenPositionTo = 0,
	tweenPositionFrom = 0,
	tweenAlphaFrom = 0,
	tweenAlphaTo = 0,
	taskMouldList = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)
	self:__PrepareEventProxy()
	self.MouldRoot.gameObject:SetActive(false)

	self.tweenAlpha = self.TweenRoot:GetComponent("TweenAlpha")
	self.tweenAlphaFrom = self.tweenAlpha.from
	self.tweenAlphaTo = self.tweenAlpha.to
	self.tweenPosition = self.TweenRoot:GetComponent("TweenPosition")
	self.tweenPositionFrom = self.tweenPosition.from
	self.tweenPositionTo = self.tweenPosition.to

	self:__AddEventProxy()
end

function m:__PrepareEventProxy()
	function self.openBtnClickedEventProxy()
		self:__OnOpenBtnClickedEventHandler()
	end

	function self.hideBtnClickedEventProxy()
		self:__OnHideBtnClickedEventHandler()
	end

	function self.memoryStoryPlayerReceiveTaskEventProxy(taskId)
		self:__OnMemoryStoryPlayerReceiveTaskEventHandler(taskId)
	end

	function self.memoryStoryPlayerTaskProgressChangeEventProxy(taskId, targetId)
		self:__OnMemoryStoryPlayerTaskProgressChangeEventHandler(taskId, targetId)
	end

	function self.memoryStoryPlayerSubmitTaskEventProxy(taskId)
		self:__OnMemoryStoryPlayerSubmitTaskEventHandler(taskId)
	end
end

function m:__AddEventProxy()
	self.ButtonOpen:GetComponent("Button").onClick:AddListener(self.openBtnClickedEventProxy)
	self.ButtonHide:GetComponent("Button").onClick:AddListener(self.hideBtnClickedEventProxy)
	EventDispatcher.AddEventListener(EventID.MemoryStoryPlayerReceiveTaskEvent, self.memoryStoryPlayerReceiveTaskEventProxy)
	EventDispatcher.AddEventListener(EventID.MemoryStoryPlayerTaskProgressChangeEvent, self.memoryStoryPlayerTaskProgressChangeEventProxy)
	EventDispatcher.AddEventListener(EventID.MemoryStoryPlayerSubmitTaskEvent, self.memoryStoryPlayerSubmitTaskEventProxy)
end

function m:__RemoveEventProxy()
	self.ButtonOpen:GetComponent("Button").onClick:RemoveListener(self.openBtnClickedEventProxy)
	self.ButtonHide:GetComponent("Button").onClick:RemoveListener(self.hideBtnClickedEventProxy)
	EventDispatcher.RemoveEventListener(EventID.MemoryStoryPlayerReceiveTaskEvent, self.memoryStoryPlayerReceiveTaskEventProxy)
	EventDispatcher.RemoveEventListener(EventID.MemoryStoryPlayerTaskProgressChangeEvent, self.memoryStoryPlayerTaskProgressChangeEventProxy)
	EventDispatcher.RemoveEventListener(EventID.MemoryStoryPlayerSubmitTaskEvent, self.memoryStoryPlayerSubmitTaskEventProxy)
end

function m:__OnOpenBtnClickedEventHandler()
	self:__DoShowTweenAnim()
end

function m:__OnHideBtnClickedEventHandler()
	self:__DoHideTweenAnim()
end

function m:__OnMemoryStoryPlayerReceiveTaskEventHandler(taskId)
	self:__AddTaskMould(taskId)
end

function m:__OnMemoryStoryPlayerTaskProgressChangeEventHandler(taskId, targetId)
	self:__RefreshTaskMould(taskId, targetId)
end

function m:__OnMemoryStoryPlayerSubmitTaskEventHandler(taskId)
	self:__RemoveTaskMould(taskId)
end

function m:__AddTaskMould(taskId)
	local taskCfg = CfgMemoryStoryTaskTable[taskId]

	if not taskCfg.IsShowTask then
		return
	end

	local mould = self:__GetFreeTaskMould()

	mould:SetData(taskId, true)

	if not self.view.gameObject.activeSelf then
		self.view.gameObject:SetActive(true)
		self:__DoShowTweenAnim()
	end
end

function m:__RefreshTaskMould(taskId, targetId)
	for _, v in pairs(self.taskMouldList) do
		if not v:IsFree() and v.TaskId == taskId then
			v:Refresh()
		end
	end
end

function m:__RemoveTaskMould(taskId)
	for _, v in pairs(self.taskMouldList) do
		if not v:IsFree() and v.TaskId == taskId then
			v:Free()
		end
	end
end

function m:__GetFreeTaskMould()
	for _, v in pairs(self.taskMouldList) do
		if v:IsFree() then
			return v
		end
	end

	local obj = UnityEngine.Object.Instantiate(self.MouldRoot)

	obj.transform:SetParent(self.MouldRoot.transform.parent, false)

	local mould = TaskMould.New(obj)

	table.insert(self.taskMouldList, mould)

	return mould
end

function m:__DoShowTweenAnim()
	self.tweenAlpha.from = self.tweenAlphaFrom
	self.tweenAlpha.to = self.tweenAlphaTo
	self.tweenPosition.from = self.tweenPositionFrom
	self.tweenPosition.to = self.tweenPositionTo

	self.tweenAlpha:ResetToBeginning()
	self.tweenAlpha:PlayForward()
	self.tweenPosition:ResetToBeginning()
	self.tweenPosition:PlayForward()
	self.ButtonOpen.gameObject:SetActive(false)
	self.ButtonHide.gameObject:SetActive(true)
end

function m:__DoHideTweenAnim()
	self.tweenAlpha.to = self.tweenAlphaFrom
	self.tweenAlpha.from = self.tweenAlphaTo
	self.tweenPosition.to = self.tweenPositionFrom
	self.tweenPosition.from = self.tweenPositionTo

	self.tweenAlpha:ResetToBeginning()
	self.tweenAlpha:PlayForward()
	self.tweenPosition:ResetToBeginning()
	self.tweenPosition:PlayForward()
	self.ButtonOpen.gameObject:SetActive(true)
	self.ButtonHide.gameObject:SetActive(false)
end

function m:Reset()
	local hasTaskShow = self:__HasTaskShow()

	self.view.gameObject:SetActive(hasTaskShow)
end

function m:__HasTaskShow()
	for _, v in pairs(self.taskMouldList) do
		if not v:IsFree() then
			return true
		end
	end

	return false
end

function m:OnDestroy()
	self:__RemoveEventProxy()

	for _, v in pairs(self.taskMouldList) do
		v:OnDestroy()
	end

	self.taskMouldList = nil

	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

function m:OnClose()
	for _, v in pairs(self.taskMouldList) do
		v:OnDestroy()
	end

	self.taskMouldList = {}

	self.view.gameObject:SetActive(false)
end

return m
