-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventScene2DClose.lua

module("logic.extensions.story.core.logic.events.EventScene2DClose", package.seeall)

local M = class("EventScene2DClose", StoryEventBase)

function M:_OnInitCtor()
	self.m_closeHandle = StoryHandleScene2DClose.New()
end

function M:OnEventExecuteInternal()
	self.m_closeHandle:Handle(self.config, self.binder)
end

function M:OnStoryCleanInternal()
	return
end

return M
