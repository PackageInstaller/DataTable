-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleTransformTo.lua

module("logic.extensions.story.core.logic.handles.StoryHandleTransformTo", package.seeall)

local M = class("StoryHandleTransformTo")

function M:ctor()
	self.m_getter = StoryTransformToArgGetter.New()
end

function M:HandleCurve(config, targetGo, progress, curve, isLocal, lookAtPoint)
	pritnError("暂时没法获取AnimationCurve")
end

function M:Handle(config, targetGo, progress, isLocal, lookAtPoint)
	if goutil.isNil(targetGo) then
		return
	end

	if not config or not config:HasAnyArg() then
		return
	end

	local targetTf = targetGo.transform
	local getter = self.m_getter

	getter:UpdateAsset(config)

	if getter.posValid then
		local fromVect, toVect

		if getter.isPosCfg then
			fromVect = StoryLogicUtil.GetCurStoryStagePosition(getter.posFromIndex)
			toVect = StoryLogicUtil.GetCurStoryStagePosition(getter.posToIndex)
		else
			fromVect = getter.posFrom
			toVect = getter.posTo
		end

		if Vector3.Distance(fromVect, toVect) > 0.1 and lookAtPoint then
			if isLocal then
				targetTf.localRotation = Quaternion.LookRotation(toVect - fromVect, Vector3.up)
			else
				targetTf.rotation = Quaternion.LookRotation(toVect - fromVect, Vector3.up)
			end
		end

		local targetVect = fromVect + (toVect - fromVect) * progress

		if isLocal then
			targetTf.localPosition = targetVect
		else
			targetTf.position = targetVect
		end
	end

	if getter.rotValid then
		local rotationFrom = getter.rotationFrom
		local rotationTo = getter.rotationTo
		local angle = rotationFrom + (rotationTo - rotationFrom) * progress

		if isLocal then
			targetTf.localRotation = Quaternion.Euler(angle)
		else
			targetTf.rotation = Quaternion.Euler(angle)
		end
	end

	if getter.scalValid then
		local scaleFrom = getter.scaleFrom
		local scaleTo = getter.scaleTo

		targetTf.localScale = scaleFrom + (scaleTo - scaleFrom) * progress
	end
end

return M
