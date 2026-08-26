-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepBase.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepBase", package.seeall)

local Va3ChessStepBase = class("Va3ChessStepBase")

function Va3ChessStepBase:init(stepData)
	self.originData = stepData
end

function Va3ChessStepBase:start()
	return
end

function Va3ChessStepBase:finish()
	local evtMgr = Va3ChessGameController.instance.event

	if evtMgr then
		evtMgr:nextStep()
	end
end

function Va3ChessStepBase:dispose()
	self.originData = nil
end

return Va3ChessStepBase
