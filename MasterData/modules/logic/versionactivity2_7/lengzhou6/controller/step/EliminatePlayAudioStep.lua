-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/step/EliminatePlayAudioStep.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminatePlayAudioStep", package.seeall)

local EliminatePlayAudioStep = class("EliminatePlayAudioStep", EliminateChessStepBase)

function EliminatePlayAudioStep:onStart()
	local audioId = self._data

	if audioId == nil then
		self:onDone(true)

		return
	end

	AudioMgr.instance:trigger(audioId)
	self:onDone(true)
end

return EliminatePlayAudioStep
