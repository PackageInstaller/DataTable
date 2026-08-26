-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepBrazierTrigger.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepBrazierTrigger", package.seeall)

local Va3ChessStepBrazierTrigger = class("Va3ChessStepBrazierTrigger", Va3ChessStepBase)

function Va3ChessStepBrazierTrigger:start()
	local brazierId = self.originData.brazierId
	local interactMgr = Va3ChessGameController.instance.interacts
	local interactObj = interactMgr and interactMgr:get(brazierId)

	if interactObj then
		if interactObj.originData then
			interactObj.originData:setBrazierIsLight(true)
		end

		local handler = interactObj:getHandler()

		if handler and handler.refreshBrazier then
			handler:refreshBrazier()
			AudioMgr.instance:trigger(AudioEnum.chess_activity142.LightBrazier)
		end
	end

	local fireballNum = self.originData.fireballNum

	Va3ChessGameModel.instance:setFireBallCount(fireballNum, true)
	self:finish()
end

function Va3ChessStepBrazierTrigger:finish()
	Va3ChessStepBrazierTrigger.super.finish(self)
end

function Va3ChessStepBrazierTrigger:dispose()
	Va3ChessStepBrazierTrigger.super.dispose(self)
end

return Va3ChessStepBrazierTrigger
