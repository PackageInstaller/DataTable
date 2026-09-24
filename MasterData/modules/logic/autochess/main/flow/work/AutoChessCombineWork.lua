-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessCombineWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessCombineWork", package.seeall)

local AutoChessCombineWork = class("AutoChessCombineWork", AutoChessBaseWork)

function AutoChessCombineWork:onStart()
	self.index = 1

	if tonumber(self.effect.targetId) == 1 then
		local chessEntity = self.entityMgr:getEntity(self.effect.fromId)

		if chessEntity then
			self.bornWarzone = chessEntity.warZone
			self.bornIndex = chessEntity.index

			local uidList = string.split(self.effect.effectString, "#")

			for _, uid in ipairs(uidList) do
				if uid ~= self.effect.targetId then
					local entity = self.entityMgr:getEntity(uid)

					if entity then
						entity:move(self.bornIndex)
					end
				end
			end

			self:delayCall(self.chessCombine1, AutoChessEnum.ChessAniTime.jump)
		else
			self:finishWork()
		end
	else
		self.bornWarzone = tonumber(self.effect.fromId)
		self.bornIndex = tonumber(self.effect.effectNum)

		for _, chess in ipairs(self.effect.chessList) do
			self.entityMgr:addEntity(self.bornWarzone, chess, self.bornIndex)
		end

		self:delayCall(self.chessDisband1, AutoChessEnum.ChessAniTime.born)
	end
end

function AutoChessCombineWork:chessCombine1()
	self:delDelayFunc(self.chessCombine1)

	self.index = 2

	local uidList = string.split(self.effect.effectString, "#")

	for _, uid in ipairs(uidList) do
		local entity = self.entityMgr:getEntity(uid)

		if entity then
			entity:die()
		end

		local chessPos = self.context:getChessPosition1(uid)

		if chessPos then
			chessPos.chess = AutoChessHelper.buildEmptyChess()
		end
	end

	self:delayCall(self.chessCombine2, AutoChessEnum.ChessAniTime.die)
end

function AutoChessCombineWork:chessCombine2()
	self:delDelayFunc(self.chessCombine2)

	self.index = 3

	local uidList = string.split(self.effect.effectString, "#")

	for _, uid in ipairs(uidList) do
		self.entityMgr:removeEntity(uid)
	end

	local chess = self.effect.chessList[1]

	self.entityMgr:addEntity(self.bornWarzone, chess, self.bornIndex)

	local chessPos = self.context:getChessPosition(self.bornWarzone, self.bornIndex + 1)

	if chessPos then
		chessPos.chess = chess
	end

	self:delayCall(self.finishWork, AutoChessEnum.ChessAniTime.born)
end

function AutoChessCombineWork:chessDisband1()
	self:delDelayFunc(self.chessDisband1)

	self.index = 2

	local indexList = string.splitToNumber(self.effect.effectString, "#")

	for k, chess in ipairs(self.effect.chessList) do
		local index = indexList[k]
		local entity = self.entityMgr:getEntity(chess.uid)

		if entity then
			entity:move(index)
		end

		local chessPos = self.context:getChessPosition(self.bornWarzone, index + 1)

		if chessPos then
			chessPos.chess = chess
		end
	end

	self:delayCall(self.finishWork, AutoChessEnum.ChessAniTime.jump)
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
		self:chessDisband1()
	elseif self.index == 2 then
		self:finishWork()
	end
end

return AutoChessCombineWork
