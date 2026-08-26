-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/TeamChessDieStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessDieStep", package.seeall)

local TeamChessDieStep = class("TeamChessDieStep", EliminateTeamChessStepBase)

function TeamChessDieStep:onStart()
	self:onDone(true)
end

return TeamChessDieStep
