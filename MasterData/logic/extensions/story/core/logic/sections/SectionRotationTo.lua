-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionRotationTo.lua

module("logic.extensions.story.core.logic.sections.SectionRotationTo", package.seeall)

local M = class("SectionRotationTo", StorySectionBase)

function M:_OnInitCtor()
	self.m_rotationHandle = StoryHandleRotationTo.New()
	self.m_angle = nil
end

function M:OnSectionEnableInternal()
	local targetGo = self.parent.bindingTarget

	if targetGo then
		self.m_angle = targetGo.transform.localEulerAngles
	else
		self.m_angle = Vector3.zero
	end
end

function M:OnStoryEvaluateInternal(time)
	local targetGo = self.parent.bindingTarget

	if targetGo then
		local progress = self:GetProgress(time)

		self.m_rotationHandle:Handle(self.config, targetGo, self.m_angle, progress, true)
	end
end

return M
