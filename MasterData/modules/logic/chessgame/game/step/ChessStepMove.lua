-- chunkname: @modules/logic/chessgame/game/step/ChessStepMove.lua

module("modules.logic.chessgame.game.step.ChessStepMove", package.seeall)

local ChessStepMove = class("ChessStepMove", BaseWork)

function ChessStepMove:init(stepData)
	self.originData = stepData
end

function ChessStepMove:onStart(catchObj)
	local objId = self.originData.id
	local tarX = self.originData.x
	local tarY = self.originData.y
	local dir = self.originData.direction

	self._catchObj = catchObj

	local interactsMgr = ChessGameController.instance.interactsMgr

	if interactsMgr then
		local interactObj = interactsMgr:get(objId)

		if not interactObj then
			self:onDone(true)

			return
		end

		self:updatePosInfo(interactObj, tarX, tarY)
		self:startMove(interactObj, tarX, tarY)

		if dir ~= nil then
			interactObj:getHandler():faceTo(dir)
		end
	end
end

function ChessStepMove:updatePosInfo(interactObj, x, y)
	if interactObj and interactObj:getHandler() then
		interactObj:getHandler():updatePos(x, y)
	else
		self:onDone(true)
	end
end

function ChessStepMove:startMove(interactObj, x, y)
	if interactObj and interactObj:getHandler() then
		local interactType = interactObj.config.interactType

		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_1ChessGame.play_ui_molu_jlbn_move)

		if interactType == ChessGameEnum.InteractType.Role then
			if self._catchObj then
				local posX, posY = self._catchObj.mo:getXY()
				local targetX, targetY = (x + posX) / 2, (y + posY) / 2

				interactObj:getHandler():moveTo(targetX, targetY, self.onMainPlayerMoveEnd, self)
			else
				interactObj:getHandler():moveTo(x, y, self.onMainPlayerMoveEnd, self)
			end
		else
			interactObj:getHandler():moveTo(x, y, self.onOtherObjMoveEnd, self)
		end
	else
		self:onDone(true)
	end
end

function ChessStepMove:onMainPlayerMoveEnd()
	self:onObjMoveEnd()
	self:onDone(true)
end

function ChessStepMove:onOtherObjMoveEnd()
	local objId = self.originData.id
	local tarX = self.originData.x
	local tarY = self.originData.y

	ChessGameController.instance:dispatchEvent(ChessGameEvent.ObjMoveEnd, objId, tarX, tarY)
	self:onDone(true)
end

function ChessStepMove:onObjMoveEnd()
	local objId = self.originData.id
	local tarX = self.originData.x
	local tarY = self.originData.y

	ChessGameController.instance:dispatchEvent(ChessGameEvent.ObjMoveEnd, objId, tarX, tarY)
end

ChessStepMove.lastEnemyMoveTime = {}
ChessStepMove.minSkipAudioTime = 0.01

function ChessStepMove:playEnemyMoveAudio(audioId)
	if audioId and audioId ~= 0 then
		local curTime = Time.realtimeSinceStartup

		if not ChessStepMove.lastEnemyMoveTime[audioId] then
			if ChessStepMove.lastEnemyMoveTime[audioId] <= curTime then
				ChessStepMove.lastEnemyMoveTime[audioId] = curTime + ChessStepMove.minSkipAudioTime

				AudioMgr.instance:trigger(audioId)
			end
		end
	end
end

return ChessStepMove
