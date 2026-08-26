-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepNextRound.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepNextRound", package.seeall)

local Va3ChessStepNextRound = class("Va3ChessStepNextRound", Va3ChessStepBase)

function Va3ChessStepNextRound:start()
	self:finish()
end

function Va3ChessStepNextRound:finish()
	local evtMgr = Va3ChessGameController.instance.event
	local curRound = self.originData.currentRound

	Va3ChessGameModel.instance:setRound(curRound)
	Va3ChessGameController.instance:tryResumeSelectObj()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.CurrentRoundUpdate)

	if evtMgr then
		evtMgr:setCurEvent(nil)
	end

	Va3ChessGameController.instance:forceRefreshObjSelectedView()
	Va3ChessStepNextRound.super.finish(self)
end

return Va3ChessStepNextRound
