-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventAmbClose.lua

module("logic.extensions.story.core.logic.events.EventAmbClose", package.seeall)

local M = class("EventAmbClose", StoryEventBase)

function M:_OnInitCtor()
	self.m_handle = StoryHandleAmbStop.New()
end

function M:OnEventExecuteInternal()
	self.m_handle:Handle(self.config)
end

function M:OnStoryCleanInternal()
	return
end

return M
