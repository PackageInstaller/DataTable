-- chunkname: @modules/logic/activity/controller/chessmap/event/ActivityChessStateBattle.lua

module("modules.logic.activity.controller.chessmap.event.ActivityChessStateBattle", package.seeall)

local ActivityChessStateBattle = class("ActivityChessStateBattle", ActivityChessStateBase)

function ActivityChessStateBattle:start()
	logNormal("ActivityChessStateBattle start")

	if ViewMgr.instance:isOpenFinish(ViewName.ActivityChessGame) then
		self:startBattle()
	else
		ActivityChessGameController.instance:registerCallback(ActivityChessEvent.GameViewOpened, self.onOpenViewFinish, self)
	end
end

function ActivityChessStateBattle:onOpenViewFinish(viewParam)
	ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.GameViewOpened, self.onOpenViewFinish, self)

	if viewParam and viewParam.fromRefuseBattle then
		local actId = self.originData.activityId

		Activity109Rpc.instance:sendAct109AbortRequest(actId, self.onReceiveAboveGame, self)
	else
		self:startBattle()
	end
end

function ActivityChessStateBattle:startBattle()
	Activity109ChessController.instance:enterActivityFight(self.originData.battleId)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.EventFinishPlay)
end

function ActivityChessStateBattle:onReceiveAboveGame(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	logNormal("game over by refuse battle !")
	ActivityChessGameController.instance:gameOver()
end

function ActivityChessStateBattle:dispose()
	ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.GameViewOpened, self.onOpenViewFinish, self)
end

return ActivityChessStateBattle
