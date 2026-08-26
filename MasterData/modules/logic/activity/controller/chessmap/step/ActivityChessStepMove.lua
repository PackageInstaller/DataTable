-- chunkname: @modules/logic/activity/controller/chessmap/step/ActivityChessStepMove.lua

module("modules.logic.activity.controller.chessmap.step.ActivityChessStepMove", package.seeall)

local ActivityChessStepMove = class("ActivityChessStepMove", ActivityChessStepBase)

function ActivityChessStepMove:start()
	local objId = self.originData.id
	local tarX = self.originData.x
	local tarY = self.originData.y
	local dir = self.originData.direction
	local interactMgr = ActivityChessGameController.instance.interacts

	if interactMgr then
		local interactObj = interactMgr:get(objId)

		self:startMove(interactObj, tarX, tarY)

		if dir ~= nil then
			interactObj:getHandler():faceTo(dir)
		end
	end
end

function ActivityChessStepMove:startMove(interactObj, x, y)
	if interactObj and interactObj:getHandler() then
		ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetAlwayUpdateRenderOrder, true)

		local interactType = interactObj.config.interactType

		if interactType == ActivityChessEnum.InteractType.Player then
			interactObj:getHandler():moveTo(x, y, self.finish, self)
			AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerMove)
		else
			interactObj:getHandler():moveTo(x, y)
			self:playEnemyMoveAudio()
			self:finish()
		end
	else
		self:finish()
	end
end

ActivityChessStepMove.lastEnemyMoveTime = nil
ActivityChessStepMove.minSkipAudioTime = 0.01

function ActivityChessStepMove:playEnemyMoveAudio()
	local curTime = Time.realtimeSinceStartup
	local needMerge = ActivityChessStepMove.lastEnemyMoveTime ~= nil and curTime - ActivityChessStepMove.lastEnemyMoveTime <= ActivityChessStepMove.minSkipAudioTime

	if not needMerge then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.EnemyMove)

		ActivityChessStepMove.lastEnemyMoveTime = curTime
	end
end

function ActivityChessStepMove:finish()
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetAlwayUpdateRenderOrder, false)
	ActivityChessStepMove.super.finish(self)
end

return ActivityChessStepMove
