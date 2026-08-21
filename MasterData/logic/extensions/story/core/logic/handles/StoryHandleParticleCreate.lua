-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleParticleCreate.lua

module("logic.extensions.story.core.logic.handles.StoryHandleParticleCreate", package.seeall)

local M = class("StoryHandleParticleCreate")

function M:ctor()
	self.m_transformHandle = StoryHandleFixTransform.New()
	self.m_proxyHandle = StoryHandleGOInstProxyCreate.New()
end

function M:Handle(assetUID, instUID, config, binder)
	local proxyInst = self.m_proxyHandle:Handle(StoryPtrTag.ParticleSystemInstance, assetUID, instUID, binder)

	if not proxyInst then
		return nil
	end

	self.m_transformHandle:Handle(config, proxyInst.proxyTarget, true)

	return proxyInst
end

return M
