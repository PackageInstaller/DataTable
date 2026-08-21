-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventScene2DOpen.lua

module("logic.extensions.story.core.logic.events.EventScene2DOpen", package.seeall)

local M = class("EventScene2DOpen", StoryEventBase)

function M:_OnInitCtor()
	self.m_referenceId = nil
	self.m_sceName = nil
	self._loader = nil
	self.m_handle = StoryHandleScene2DOpen.New()
end

function M:OnEventExecuteInternal()
	self._loader, self.m_sceName = self.m_handle:Handle(self.config, self.binder)

	if self._loader then
		self._loader:startLoad(self._onSceneLoaded, self)
	end
end

function M:OnStoryCleanInternal()
	if not string.nilorempty(self.m_referenceId) then
		local handle = StoryHandleScene2DClose.New()

		handle:Handle(self.config, self.binder)
	end

	self:_disposeLoader()

	self.m_referenceId = nil
	self.m_sceName = nil
end

function M:_disposeLoader()
	if self._loader then
		self._loader:dispose()
	end

	self._loader = nil
end

function M:_onSceneLoaded(res)
	if not res or not res.IsSuccess then
		return
	end

	SceneUtils.SetActiveScene(self.m_sceName)
end

return M
