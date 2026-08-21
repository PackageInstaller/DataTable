-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleRotationTo.lua

module("logic.extensions.story.core.logic.handles.StoryHandleRotationTo", package.seeall)

local M = class("StoryHandleRotationTo")

function M:ctor()
	self.m_getter = StoryRotationArgGetter.New()
end

function M:HandleCurve(config, targetGo, fromVect, progress, curve, isLocal)
	pritnError("暂时没法获取AnimationCurve")
end

function M:Handle(config, targetGo, fromVect, progress, isLocal)
	if goutil.isNil(targetGo) then
		return
	end

	if not config or not config:HasAnyArg() then
		return
	end

	local targetTf = targetGo.transform
	local getter = self.m_getter

	getter:UpdateAsset(config)

	local toVect = getter.rotation
	local rot = Quaternion.Lerp(Quaternion.Euler(fromVect), Quaternion.Euler(toVect), progress)

	if isLocal then
		targetTf.localRotation = rot
	else
		targetTf.rotation = rot
	end
end

return M
