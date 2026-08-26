-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/TeamChessPerformReductionStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessPerformReductionStep", package.seeall)

local TeamChessPerformReductionStep = class("TeamChessPerformReductionStep", EliminateTeamChessStepBase)

function TeamChessPerformReductionStep:onStart()
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.StrongHoldPerformReduction)
	TeamChessUnitEntityMgr.instance:restoreEntityShowMode()

	local strongholds = EliminateTeamChessModel.instance:getStrongholds()
	local playerSoliderCount = 0

	for _, stronghold in pairs(strongholds) do
		playerSoliderCount = playerSoliderCount + stronghold:getPlayerSoliderCount()
	end

	local levelId = EliminateLevelModel.instance:getLevelId()

	if playerSoliderCount > 0 then
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamSettleEndAndIsHavePlayerSolider)
	end

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamSettleEndAndPlayerSoliderCount, string.format("%s_%s", levelId, playerSoliderCount))

	if GuideModel.instance:isGuideRunning(22011) or GuideModel.instance:isGuideRunning(22012) then
		GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, self._gudieEnd, self)
	else
		TaskDispatcher.runDelay(self._onDone, self, EliminateTeamChessEnum.teamChessUpdateActiveMoveStepTime)
	end
end

function TeamChessPerformReductionStep:_gudieEnd(guideId)
	if guideId ~= 22011 and guideId ~= 22012 then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._gudieEnd, self)
	self:_onDone(true)
end

return TeamChessPerformReductionStep
