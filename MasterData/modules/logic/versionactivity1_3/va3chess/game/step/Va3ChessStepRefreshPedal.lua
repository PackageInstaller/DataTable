-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepRefreshPedal.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepRefreshPedal", package.seeall)

local Va3ChessStepRefreshPedal = class("Va3ChessStepRefreshPedal", Va3ChessStepBase)

function Va3ChessStepRefreshPedal:start()
	local pedalId = self.originData.id
	local newPedalStatus = self.originData.pedalStatus

	if pedalId and pedalId > 0 then
		local interactMgr = Va3ChessGameController.instance.interacts
		local interactObj = interactMgr and interactMgr:get(pedalId)

		if interactObj and interactObj.originData then
			interactObj.originData:setPedalStatus(newPedalStatus)
		end
	end

	self:finish()
end

return Va3ChessStepRefreshPedal
