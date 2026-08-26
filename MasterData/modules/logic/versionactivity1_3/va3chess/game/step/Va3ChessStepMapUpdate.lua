-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepMapUpdate.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepMapUpdate", package.seeall)

local Va3ChessStepMapUpdate = class("Va3ChessStepMapUpdate", Va3ChessStepBase)

function Va3ChessStepMapUpdate:start()
	self:processMapUpdate()
end

function Va3ChessStepMapUpdate:processMapUpdate()
	local actId = Va3ChessModel.instance:getActId()

	Va3ChessGameController.instance:updateServerMap(actId, self.originData)
	self:finish()
end

return Va3ChessStepMapUpdate
