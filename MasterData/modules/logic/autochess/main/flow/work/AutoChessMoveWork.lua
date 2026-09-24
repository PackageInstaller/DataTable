-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessMoveWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessMoveWork", package.seeall)

local AutoChessMoveWork = class("AutoChessMoveWork", AutoChessBaseWork)

function AutoChessMoveWork:onStart()
	local chessPosA, warZone = self.context:getChessPosition1(self.effect.targetId)
	local chessPosB = self.context:getChessPosition(warZone, self.effect.effectNum + 1)

	if chessPosA and chessPosB then
		chessPosB.chess = chessPosA.chess
		chessPosA.chess = chessPosB.chess
	else
		logError(string.format("位置: %s %s 的ChessPosition数据为空,请检查", self.effect.fromId, self.effect.effectNum))
	end

	local chess = self.entityMgr:getEntity(self.effect.targetId)

	if chess then
		chess:move(self.effect.effectNum)
		self:delayCall(self.finishWork, AutoChessEnum.ChessAniTime.jump)
	else
		self:finishWork()
	end
end

return AutoChessMoveWork
