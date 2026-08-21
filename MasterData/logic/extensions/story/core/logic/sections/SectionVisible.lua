-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionVisible.lua

module("logic.extensions.story.core.logic.sections.SectionVisible", package.seeall)

local M = class("SectionVisible", StorySectionBase)

function M:OnStoryEvaluateInternal(time)
	local targetGo = self.parent.bindingTarget

	if goutil.isNil(targetGo) then
		return
	end

	if not self.config:HasAnyArg() then
		return
	end

	local visible = self.config:GetArgValueBoolean(StoryArgKeyConst.GameObjectActive)

	goutil.setActive(targetGo, visible)
end

function M:OnSectionDisableInternal()
	local targetGo = self.parent.bindingTarget

	if goutil.isNil(targetGo) then
		return
	end

	local exitVisible = self.config:GetArgValueBoolean(StoryArgKeyConst.GameObjectActiveExit)

	if exitVisible then
		local visible = self.config:GetArgValueBoolean(StoryArgKeyConst.GameObjectActive)

		goutil.setActive(targetGo, not visible)
	end
end

return M
