-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleSoundStop.lua

module("logic.extensions.story.core.logic.handles.StoryHandleSoundStop", package.seeall)

local M = class("StoryHandleSoundStop")

function M:Handle(config, playingID)
	CriwareAudioFacade.instance:stopVoice()
end

return M
