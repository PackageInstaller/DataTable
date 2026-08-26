-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionPlayAudio.lua

module("modules.logic.guide.controller.action.impl.GuideActionPlayAudio", package.seeall)

local GuideActionPlayAudio = class("GuideActionPlayAudio", BaseGuideAction)

function GuideActionPlayAudio:ctor(guideId, stepId, actionParam)
	GuideActionPlayAudio.super.ctor(self, guideId, stepId, actionParam)

	self._audioId = tonumber(actionParam) or nil
end

function GuideActionPlayAudio:onStart(context)
	GuideActionPlayAudio.super.onStart(self, context)

	if self._audioId then
		GuideAudioMgr.instance:playAudio(self._audioId)
	else
		logError("Guide audio id nil, guide_" .. self.guideId .. "_" .. self.stepId)
	end

	self:onDone(true)
end

function GuideActionPlayAudio:onDestroy(context)
	if self._audioId then
		GuideAudioMgr.instance:stopAudio()
	end
end

return GuideActionPlayAudio
