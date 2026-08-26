-- chunkname: @modules/logic/versionactivity3_4/bbs/controller/V3a4BBSController.lua

module("modules.logic.versionactivity3_4.bbs.controller.V3a4BBSController", package.seeall)

local V3a4BBSController = class("V3a4BBSController", BaseController)

function V3a4BBSController:onInit()
	return
end

function V3a4BBSController:onInitFinish()
	return
end

function V3a4BBSController:addConstEvents()
	StoryController.instance:registerCallback(StoryEvent.RefreshStep, self._onStep, self)
end

function V3a4BBSController:reInit()
	return
end

function V3a4BBSController:_onStep(param)
	local co = V3a4BBSConfig.instance:getTriggerBBSByStory(param.storyId, param.stepId)

	if co then
		local post = string.splitToNumber(co.post, "#")

		self:openV3a4BBSView(post[1], post[2])
	end
end

function V3a4BBSController:openV3a4BBSView(postId, step, elementId, callback, callbackTarget, callbackParams)
	if StoryModel.instance:isStoryAuto() then
		StoryModel.instance:setStoryAuto(false)
	end

	local param = {
		postId = postId,
		step = step,
		elementId = elementId,
		callback = callback,
		callbackTarget = callbackTarget,
		callbackParams = callbackParams
	}

	ViewMgr.instance:openView(ViewName.V3a4BBSView, param)
end

V3a4BBSController.instance = V3a4BBSController.New()

return V3a4BBSController
