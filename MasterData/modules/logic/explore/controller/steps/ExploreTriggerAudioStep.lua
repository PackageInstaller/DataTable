-- chunkname: @modules/logic/explore/controller/steps/ExploreTriggerAudioStep.lua

module("modules.logic.explore.controller.steps.ExploreTriggerAudioStep", package.seeall)

local ExploreTriggerAudioStep = class("ExploreTriggerAudioStep", ExploreStepBase)

function ExploreTriggerAudioStep:onStart()
	AudioMgr.instance:trigger(self._data.id)
	self:onDone()
end

return ExploreTriggerAudioStep
