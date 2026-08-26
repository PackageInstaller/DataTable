-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/TeamChessFightResultStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessFightResultStep", package.seeall)

local TeamChessFightResultStep = class("TeamChessFightResultStep", EliminateTeamChessStepBase)

function TeamChessFightResultStep:onStart()
	local levelId = EliminateLevelModel.instance:getLevelId()

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessEnemyDie, levelId)

	if GuideModel.instance:isGuideRunning(22013) then
		GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, self._finishStep, self)
	else
		self:_Done()
	end
end

function TeamChessFightResultStep:_finishStep(guideId)
	if guideId ~= 22013 then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._finishStep, self)
	self:_Done()
end

function TeamChessFightResultStep:_Done()
	EliminateLevelController.instance:openEliminateResultView()
	self:onDone(true)
end

return TeamChessFightResultStep
