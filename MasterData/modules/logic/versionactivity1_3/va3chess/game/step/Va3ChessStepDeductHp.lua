-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepDeductHp.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepDeductHp", package.seeall)

local Va3ChessStepDeductHp = class("Va3ChessStepDeductHp", Va3ChessStepBase)

function Va3ChessStepDeductHp:start()
	self:finish()
end

function Va3ChessStepDeductHp:finish()
	local evtMgr = Va3ChessGameController.instance.event

	if evtMgr then
		evtMgr:setCurEvent(nil)
	end

	local hp = self.originData.hp

	Va3ChessGameModel.instance:setHp(hp)
	Va3ChessGameController.instance:tryResumeSelectObj()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.CurrentHpUpdate)
	Va3ChessStepDeductHp.super.finish(self)
end

return Va3ChessStepDeductHp
