-- chunkname: @modules/logic/activity/controller/chessmap/step/ActivityChessStepGameFinish.lua

module("modules.logic.activity.controller.chessmap.step.ActivityChessStepGameFinish", package.seeall)

local ActivityChessStepGameFinish = class("ActivityChessStepGameFinish", ActivityChessStepBase)

function ActivityChessStepGameFinish:start()
	self:processSelectObj()
	self:processWinStatus()
end

function ActivityChessStepGameFinish:processSelectObj()
	ActivityChessGameController.instance:setSelectObj(nil)
end

function ActivityChessStepGameFinish:processWinStatus()
	if self.originData.win == true then
		logNormal("game clear!")
		ActivityChessGameController.instance:gameClear()
	else
		logNormal("game over!")

		if self.originData.failReason == ActivityChessEnum.FailReason.FailInteract then
			local pawnId = self.originData.failCharacter
			local interactMgr = ActivityChessGameController.instance.interacts

			if pawnId ~= 0 and interactMgr then
				local interactObj = interactMgr:get(pawnId)
				local interactCfg = interactObj.config

				if interactCfg then
					local v1 = "OnChessFailPause" .. Activity109ChessModel.instance:getEpisodeId() .. "_" .. (interactCfg.id or "")
					local v2 = GuideEvent[v1]
					local v3 = GuideEvent.OnChessFailContinue
					local v4 = ActivityChessStepGameFinish._gameOver
					local v5 = self

					GuideController.instance:GuideFlowPauseAndContinue(v1, v2, v3, v4, v5)

					return
				end
			end
		end

		self:_gameOver()
	end
end

function ActivityChessStepGameFinish:_gameOver()
	ActivityChessGameController.instance:gameOver()
end

return ActivityChessStepGameFinish
