-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessSummonWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessSummonWork", package.seeall)

local AutoChessSummonWork = class("AutoChessSummonWork", AutoChessBaseWork)

function AutoChessSummonWork:onStart()
	local chess = self.effect.chessList[1]

	if chess then
		local chessPos = self.context:getChessPosition(self.effect.targetId, self.effect.effectNum + 1)

		if chessPos then
			chessPos.chess = chess
		end

		self.entityMgr:addEntity(self.effect.targetId, chess, self.effect.effectNum)
		self:delayCall(self.finishWork, AutoChessEnum.ChessAniTime.born)
	else
		self:finishWork()
		logError("召唤棋子的Effect中找不到棋子数据")
	end
end

return AutoChessSummonWork
