-- chunkname: @modules/logic/chessgame/game/step/ChessStepGuide.lua

module("modules.logic.chessgame.game.step.ChessStepGuide", package.seeall)

local ChessStepGuide = class("ChessStepGuide", BaseWork)

function ChessStepGuide:init(stepData)
	self.originData = stepData
end

function ChessStepGuide:onStart()
	if GuideController.instance:isForbidGuides() then
		self:onDone(true)

		return
	end

	self._guideId = tonumber(self.originData.guideId)

	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.GuideStart, tostring(self._guideId))
end

function ChessStepGuide:_onGuideFinish(guideId)
	if self._guideId ~= guideId then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
	self:onDone(true)
end

function ChessStepGuide:clearWork()
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
end

return ChessStepGuide
