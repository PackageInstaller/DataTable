-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleAnimatorPlay.lua

module("logic.extensions.story.core.logic.handles.StoryHandleAnimatorPlay", package.seeall)

local M = class("StoryHandleAnimatorPlay")

function M:Handle(animatorAdapter, layerName, stateName, speed)
	if goutil.isNil(animatorAdapter) then
		return
	end

	if string.nilorempty(stateName) then
		return
	end

	animatorAdapter:ClearIdleQueue()
	animatorAdapter:PlayIdle(stateName, speed)
end

return M
