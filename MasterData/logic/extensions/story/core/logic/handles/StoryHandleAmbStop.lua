-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleAmbStop.lua

module("logic.extensions.story.core.logic.handles.StoryHandleAmbStop", package.seeall)

local M = class("StoryHandleAmbStop")

function M:Handle(config)
	CriwareAudioFacade.instance:stopCurrentEnvironment()
end

return M
