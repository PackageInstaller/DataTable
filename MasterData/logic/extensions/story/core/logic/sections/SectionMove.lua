-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionMove.lua

module("logic.extensions.story.core.logic.sections.SectionMove", package.seeall)

local M = class("SectionMove", StorySectionBase)

function M:_OnInitCtor()
	self.m_posFrom = nil
	self.m_moveHandle = StoryHandleMoveTo.New()
end

function M:OnSectionEnableInternal()
	local targetGo = self.parent.bindingTarget

	if not goutil.isNil(targetGo) then
		self.m_posFrom = targetGo.transform.localPosition
	end
end

function M:OnSectionDisableInternal()
	self.m_posFrom = nil
end

function M:OnStoryEvaluateInternal(time)
	local targetGo = self.parent.bindingTarget

	if goutil.isNil(targetGo) then
		return
	end

	local progress = self:GetProgress(time)

	self.m_moveHandle:Handle(self.config, targetGo, self.m_posFrom, progress, true, true)
end

return M
