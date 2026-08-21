-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleFixRotation.lua

module("logic.extensions.story.core.logic.handles.StoryHandleFixRotation", package.seeall)

local M = class("StoryHandleFixRotation")

function M:ctor()
	self._getter = StoryRotationArgGetter.New()
end

function M:Handle(config, targetGo, isLocal)
	if goutil.isNil(targetGo) then
		return
	end

	if not config or not config:HasAnyArg() then
		return
	end

	local targetTf = targetGo.transform
	local getter = self._getter

	getter:UpdateAsset(config)

	if getter.rotValid then
		if isLocal then
			targetTf.localRotation = Quaternion.Euler(getter.rotation)
		else
			targetTf.rotation = Quaternion.Euler(getter.rotation)
		end
	end
end

return M
