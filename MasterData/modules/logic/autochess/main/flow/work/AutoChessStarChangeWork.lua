-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessStarChangeWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessStarChangeWork", package.seeall)

local AutoChessStarChangeWork = class("AutoChessStarChangeWork", AutoChessBaseWork)

function AutoChessStarChangeWork:onStart()
	local chessMo = self.effect.chessList[1]

	if chessMo then
		local chessPos = self.context:getChessPosition1(chessMo.uid)

		if chessPos then
			chessPos.chess = chessMo
		end

		local entity = self.entityMgr:getEntity(chessMo.uid)

		if entity then
			local delayTime = entity:updateStar(chessMo)

			self:delayCall(self.finishWork, delayTime)
		end
	else
		self:finishWork()
		logError("棋子升级的Effect中找不到棋子数据")
	end
end

return AutoChessStarChangeWork
