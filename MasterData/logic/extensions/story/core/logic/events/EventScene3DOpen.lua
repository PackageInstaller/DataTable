-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventScene3DOpen.lua

module("logic.extensions.story.core.logic.events.EventScene3DOpen", package.seeall)

local M = class("EventScene3DOpen", StoryEventBase)

function M:_OnInitCtor()
	self.m_referenceId = nil
	self.m_sceName = nil
	self._sceneUrl = nil
	self.m_handle = StoryHandleSceneOpen.New()
end

function M:OnEventExecuteInternal()
	local _key = self.config:GetArgValue(StoryArgKeyConst.RefAssets)

	if self.m_referenceId == _key then
		return
	end

	self.m_referenceId = _key
	self.m_sceName, self._sceneUrl = self.m_handle:Handle(self.config, self.binder)
end

function M:OnStoryCleanInternal()
	self:_disposeLoader()

	self.m_referenceId = nil
	self.m_sceName = nil
end

function M:_disposeLoader()
	SceneMapResMgr.instance:unload(self._sceneUrl)

	self.m_sceName = nil
	self._sceneUrl = nil
end

return M
