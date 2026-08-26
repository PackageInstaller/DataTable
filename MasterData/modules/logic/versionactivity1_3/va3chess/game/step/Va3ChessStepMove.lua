-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepMove.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepMove", package.seeall)

local Va3ChessStepMove = class("Va3ChessStepMove", Va3ChessStepBase)

function Va3ChessStepMove:start()
	local objId = self.originData.id
	local tarX = self.originData.x
	local tarY = self.originData.y
	local dir = self.originData.direction
	local interactMgr = Va3ChessGameController.instance.interacts

	if interactMgr then
		local interactObj = interactMgr:get(objId)

		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.ObjMoveStep, objId, tarX, tarY)
		self:updatePosInfo(interactObj, tarX, tarY)
		self:startMove(interactObj, tarX, tarY)

		if dir ~= nil then
			interactObj:getHandler():faceTo(dir)
		end
	end
end

function Va3ChessStepMove:updatePosInfo(interactObj, x, y)
	if interactObj and interactObj:getHandler() then
		interactObj:getHandler():updatePos(x, y)
	else
		self:finish()
	end
end

function Va3ChessStepMove:startMove(interactObj, x, y)
	if interactObj and interactObj:getHandler() then
		local interactType = interactObj.config.interactType

		if interactObj.config then
			if interactObj.config and interactObj.config ~= 0 then
				self:playEnemyMoveAudio(interactObj.config)
			end

			if interactType == Va3ChessEnum.InteractType.Player or interactType == Va3ChessEnum.InteractType.AssistPlayer then
				interactObj:getHandler():moveTo(x, y, self.onMainPlayerMoveEnd, self)
			else
				interactObj:getHandler():moveTo(x, y, self.onOtherObjMoveEnd, self)
			end
		end
	else
		self:finish()
	end
end

function Va3ChessStepMove:onMainPlayerMoveEnd()
	self:onObjMoveEnd()
	self:finish()
end

function Va3ChessStepMove:onOtherObjMoveEnd()
	local objId = self.originData.id
	local tarX = self.originData.x
	local tarY = self.originData.y

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.ObjMoveEnd, objId, tarX, tarY)
	self:finish()
end

function Va3ChessStepMove:onObjMoveEnd()
	local objId = self.originData.id
	local tarX = self.originData.x
	local tarY = self.originData.y

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.ObjMoveEnd, objId, tarX, tarY)
end

Va3ChessStepMove.lastEnemyMoveTime = {}
Va3ChessStepMove.minSkipAudioTime = 0.01

function Va3ChessStepMove:playEnemyMoveAudio(audioId)
	if audioId and audioId ~= 0 then
		local curTime = Time.realtimeSinceStartup

		if not Va3ChessStepMove.lastEnemyMoveTime[audioId] then
			if Va3ChessStepMove.lastEnemyMoveTime[audioId] <= curTime then
				Va3ChessStepMove.lastEnemyMoveTime[audioId] = curTime + Va3ChessStepMove.minSkipAudioTime

				AudioMgr.instance:trigger(audioId)
			end
		end
	end
end

function Va3ChessStepMove:finish()
	Va3ChessStepMove.super.finish(self)
end

return Va3ChessStepMove
