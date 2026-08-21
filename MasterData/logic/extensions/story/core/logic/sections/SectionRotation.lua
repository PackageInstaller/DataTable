-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionRotation.lua

module("logic.extensions.story.core.logic.sections.SectionRotation", package.seeall)

local M = class("SectionRotation", StorySectionBase)

function M:_OnInitCtor()
	self.m_rotationHandle = StoryHandleFixRotation.New()
end

function M:OnStoryEvaluateInternal(time)
	local targetGo = self.parent.bindingTarget

	self.m_rotationHandle:Handle(self.config, targetGo, true)
end

return M
