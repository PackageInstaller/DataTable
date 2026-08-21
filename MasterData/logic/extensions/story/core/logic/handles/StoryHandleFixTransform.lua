-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/handles/StoryHandleFixTransform.lua

module("logic.extensions.story.core.logic.handles.StoryHandleFixTransform", package.seeall)

local M = class("StoryHandleFixTransform")

function M:ctor()
	self._getter = StoryFixTransformArgGetter.New()
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

	if getter.positiongetter.posValid then
		local targetVect

		if getter.positiongetter.isPosCfg then
			targetVect = StoryLogicUtil.GetCurStoryStagePosition(getter.positiongetter.posIndex)

			if not getter.rotationgetter.rotValid then
				targetTf.localRotation = StoryLogicUtil.GetCurStoryStateRotion(getter.positiongetter.posIndex)
			end
		else
			targetVect = getter.positiongetter.pos
		end

		if isLocal then
			targetTf.localPosition = targetVect
		else
			targetTf.position = targetVect
		end
	end

	if getter.rotationgetter.rotValid then
		local rotationTo = getter.rotationgetter.rotation

		if isLocal then
			targetTf.localRotation = Quaternion.Euler(rotationTo)
		else
			targetTf.rotation = Quaternion.Euler(rotationTo)
		end
	end

	if getter.scalegetter.scalValid then
		local scaleTo = getter.scalegetter.scale

		targetTf.localScale = scaleTo
	end
end

return M
