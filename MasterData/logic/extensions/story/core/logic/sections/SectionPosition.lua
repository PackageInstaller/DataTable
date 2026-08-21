-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionPosition.lua

module("logic.extensions.story.core.logic.sections.SectionPosition", package.seeall)

local M = class("SectionPosition", StorySectionBase)

function M:_OnInitCtor()
	self.m_positionHandle = StoryHandleFixPosition.New()
end

function M:OnStoryEvaluateInternal(time)
	local targetGo = self.parent.bindingTarget

	self.m_positionHandle:Handle(self.config, targetGo, true)
end

return M
