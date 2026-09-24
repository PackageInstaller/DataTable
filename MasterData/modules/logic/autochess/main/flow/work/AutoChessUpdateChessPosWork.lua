-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessUpdateChessPosWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessUpdateChessPosWork", package.seeall)

local AutoChessUpdateChessPosWork = class("AutoChessUpdateChessPosWork", AutoChessBaseWork)

function AutoChessUpdateChessPosWork:onStart()
	local toWarZone = tonumber(self.effect.fromId)
	local toPos = tonumber(self.effect.effectNum)
	local chessPos = self.context:getChessPosition1(self.effect.targetId)
	local targetChessPos = self.context:getChessPosition(toWarZone, toPos + 1)

	if chessPos and targetChessPos and targetChessPos.chess.uid ~= tonumber(self.effect.targetId) then
		chessPos.chess = targetChessPos.chess
		targetChessPos.chess = chessPos.chess
	end

	local entity = self.entityMgr:getEntity(self.effect.targetId)

	if entity then
		entity:updateIndex(toWarZone, toPos)
	end

	self:finishWork()
end

return AutoChessUpdateChessPosWork
