-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/chess/step/EliminateChessPlayAudioStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessPlayAudioStep", package.seeall)

local EliminateChessPlayAudioStep = class("EliminateChessPlayAudioStep", EliminateChessStepBase)

function EliminateChessPlayAudioStep:onStart()
	local count = EliminateChessModel.instance:getCurPlayAudioCount()

	if count > 5 then
		count = 5
	end

	local audioName = "ui_youyu_sources_dispel_" .. count
	local audioId = AudioEnum.VersionActivity2_2EliminateChess[audioName]

	AudioMgr.instance:trigger(audioId)
	EliminateChessModel.instance:addCurPlayAudioCount()
	self:onDone(true)
end

return EliminateChessPlayAudioStep
