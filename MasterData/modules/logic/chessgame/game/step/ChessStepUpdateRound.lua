-- chunkname: @modules/logic/chessgame/game/step/ChessStepUpdateRound.lua

module("modules.logic.chessgame.game.step.ChessStepUpdateRound", package.seeall)

local ChessStepUpdateRound = class("ChessStepUpdateRound", BaseWork)

function ChessStepUpdateRound:init(stepData)
	self.originData = stepData
end

function ChessStepUpdateRound:onStart()
	self:finish()
end

function ChessStepUpdateRound:finish()
	local evtMgr = ChessGameController.instance.eventMgr
	local curRound = self.originData.currRound

	ChessGameModel.instance:setRound(curRound)

	if not ChessGameModel.instance:isTalking() then
		ChessGameController.instance:tryResumeSelectObj()
	end

	ChessGameController.instance:dispatchEvent(ChessGameEvent.CurrentRoundUpdate)

	if evtMgr then
		evtMgr:setCurEvent(nil)
	end

	ChessGameController.instance:forceRefreshObjSelectedView()
	self:onDone(true)
end

return ChessStepUpdateRound
