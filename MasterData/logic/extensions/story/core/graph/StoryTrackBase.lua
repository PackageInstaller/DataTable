-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/graph/StoryTrackBase.lua

module("logic.extensions.story.core.graph.StoryTrackBase", package.seeall)

local M = class("StoryTrackBase")

function M:ctor()
	self.LogicState = StoryDefine.StoryLogicState.None
	self.sections = {}
	self.parent = nil
	self.binder = nil
	self.config = nil
	self.storyBlackBoard = nil
	self.bindingTarget = nil
	self._isJumpShot = false

	self:_OnInitCtor()
end

function M:SortSection(list)
	table.sort(list, function(a, b)
		local tempA = a:TimeRange()
		local tempB = b:TimeRange()

		if tempA.x < tempB.x then
			return true
		end

		return false
	end)
end

function M:IsUsable()
	return self.LogicState ~= StoryDefine.StoryLogicState.Destroy and self.LogicState ~= StoryDefine.StoryLogicState.None
end

function M:Init(binder, config, parentShot, storyBlackBoard)
	self.parent = parentShot
	self.binder = binder
	self.config = config
	self.storyBlackBoard = storyBlackBoard
end

function M:OnStoryAwake()
	self:OnStoryAwakeInternal()

	for index, item in ipairs(self.sections) do
		item:OnStoryAwake()
	end
end

function M:SetJumpState(isJump)
	self._isJumpShot = isJump
end

function M:OnStoryEnter()
	if self.LogicState == StoryDefine.StoryLogicState.Enter then
		self:OnStoryExit()
	end

	self:SortSection(self.sections)

	self.LogicState = StoryDefine.StoryLogicState.Enter

	self:OnStoryEnterInternal()

	for index, value in ipairs(self.sections) do
		value:SetJumpState(self._isJumpShot)
		value:OnStoryEnter()
	end
end

function M:OnStoryExit()
	if self.LogicState == StoryDefine.StoryLogicState.Enter then
		for index, item in ipairs(self.sections) do
			item:OnStoryExit()
		end

		self.LogicState = StoryDefine.StoryLogicState.Exited

		self:OnStoryExitInternal()

		self.bindingTarget = nil
	end
end

function M:OnStoryDestroy()
	self:OnStoryExit()

	for index, item in ipairs(self.sections) do
		item:OnStoryDestroy()
	end

	self.LogicState = StoryDefine.StoryLogicState.Destroy

	self:OnStoryDestroyInternal()

	self.storyBlackBoard = nil
end

function M:OnStoryUpdate(deltaTime)
	if self.LogicState ~= StoryDefine.StoryLogicState.Enter then
		return
	end

	self:OnStoryUpdateInternal(deltaTime)

	for index, item in ipairs(self.sections) do
		item:OnStoryUpdate(deltaTime)
	end
end

function M:Evaluate(time)
	self:OnStoryEvaluateInternal(time)

	for index, item in ipairs(self.sections) do
		item:Evaluate(time)
	end
end

function M:MaxEndTime()
	local _time = 0

	for index, item in ipairs(self.config.sections) do
		if _time < item.endTime then
			_time = item.endTime
		end
	end

	return _time
end

function M:_OnInitCtor()
	return
end

function M:OnStoryAwakeInternal()
	return
end

function M:OnStoryEnterInternal()
	return
end

function M:OnStoryExitInternal()
	return
end

function M:OnStoryDestroyInternal()
	return
end

function M:OnStoryUpdateInternal(deltaTime)
	return
end

function M:OnStoryEvaluateInternal(time)
	return
end

return M
