-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventSEOpen.lua

module("logic.extensions.story.core.logic.events.EventSEOpen", package.seeall)

local M = class("EventSEOpen", StoryEventBase)

function M:_OnInitCtor()
	self.m_handle = StoryHandleSEPlay.New()
	self.m_closeHandle = nil
end

function M:OnEventExecuteInternal()
	self.m_handle:Handle(self.config)
end

function M:OnStoryCleanInternal()
	return
end

return M
