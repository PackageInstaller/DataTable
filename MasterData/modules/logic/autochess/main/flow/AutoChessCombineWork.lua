-- chunkname: @modules/logic/autochess/main/flow/AutoChessCombineWork.lua

module("modules.logic.autochess.main.flow.AutoChessCombineWork", package.seeall)

local AutoChessCombineWork = class("AutoChessCombineWork", BaseWork)

function AutoChessCombineWork:ctor(effect)
	self.effect = effect
	self.mgr = AutoChessEntityMgr.instance
	self.chessMo = AutoChessModel.instance:getChessMo()
end

function AutoChessCombineWork:onStart()
	self.index = 1

	if tonumber(self.effect.targetId) == 1 then
		local chessEntity = self.mgr:getEntity(self.effect.fromId)

		if chessEntity then
			self.bornWarzone = chessEntity.warZone
			self.bornIndex = chessEntity.index

			local uidList = string.split(self.effect.effectString, "#")

			for _, uid in ipairs(uidList) do
				if uid ~= self.effect.targetId then
					local entity = self.mgr:getEntity(uid)

					if entity then
						entity:move(self.bornIndex)
					end
				end
			end

			TaskDispatcher.runDelay(self.chessCombine1, self, AutoChessEnum.ChessAniTime.jump)
		else
			self:finishWork()
		end
	else
		self.bornWarzone = tonumber(self.effect.fromId)
		self.bornIndex = tonumber(self.effect.effectNum)

		for _, chess in ipairs(self.effect.chessList) do
			self.mgr:addEntity(self.bornWarzone, chess, self.bornIndex)
		end

		TaskDispatcher.runDelay(self.chessDisband1, self, AutoChessEnum.ChessAniTime.born)
	end
end

function AutoChessCombineWork:chessCombine1()
	self.index = 2

	local uidList = string.split(self.effect.effectString, "#")

	for _, uid in ipairs(uidList) do
		local entity = self.mgr:getEntity(uid)

		if entity then
			entity:die()
		end

		local chessPos = self.chessMo:getChessPosition1(uid, self.chessMo.lastSvrFight)

		chessPos.chess = AutoChessHelper.buildEmptyChess()
	end

	TaskDispatcher.runDelay(self.chessCombine2, self, AutoChessEnum.ChessAniTime.die)
end

function AutoChessCombineWork:chessCombine2()
	self.index = 3

	local uidList = string.split(self.effect.effectString, "#")

	for _, uid in ipairs(uidList) do
		self.mgr:removeEntity(uid)
	end

	local chess = self.effect.chessList[1]

	self.mgr:addEntity(self.bornWarzone, chess, self.bornIndex)

	local chessPos = self.chessMo:getChessPosition(self.bornWarzone, self.bornIndex + 1, self.chessMo.lastSvrFight)

	chessPos.chess = chess

	TaskDispatcher.runDelay(self.finishWork, self, AutoChessEnum.ChessAniTime.born)
end

function AutoChessCombineWork:chessDisband1()
	self.index = 2

	local indexList = string.splitToNumber(self.effect.effectString, "#")

	for k, chess in ipairs(self.effect.chessList) do
		local index = indexList[k]
		local entity = self.mgr:getEntity(chess.uid)

		if entity then
			entity:move(index)
		end

		local chessPos = self.chessMo:getChessPosition(self.bornWarzone, index + 1, self.chessMo.lastSvrFight)

		chessPos.chess = chess
	end

	TaskDispatcher.runDelay(self.finishWork, self, AutoChessEnum.ChessAniTime.jump)
end

function AutoChessCombineWork:onStop()
	if tonumber(self.effect.targetId) == 1 then
		if self.index == 1 then
			TaskDispatcher.cancelTask(self.chessCombine1, self)
		elseif self.index == 2 then
			TaskDispatcher.cancelTask(self.chessCombine2, self)
		elseif self.index == 3 then
			TaskDispatcher.cancelTask(self.finishWork, self)
		end
	elseif self.index == 1 then
		TaskDispatcher.cancelTask(self.chessDisband1, self)
	elseif self.index == 2 then
		TaskDispatcher.cancelTask(self.finishWork, self)
	end
end

function AutoChessCombineWork:onResume()
	if tonumber(self.effect.targetId) == 1 then
		if self.index == 1 then
			self:chessCombine1()
		elseif self.index == 2 then
			self:chessCombine2()
		elseif self.index == 3 then
			self:finishWork()
		end
	elseif self.index == 1 then
		self:chessDisband1(true)
	elseif self.index == 2 then
		self:finishWork()
	end
end

function AutoChessCombineWork:clearWork()
	self.effect = nil
	self.mgr = nil
	self.chessMo = nil
end

function AutoChessCombineWork:finishWork()
	self:onDone(true)
end

return AutoChessCombineWork
