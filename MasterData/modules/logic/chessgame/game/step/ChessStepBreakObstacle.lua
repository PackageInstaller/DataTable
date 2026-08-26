-- chunkname: @modules/logic/chessgame/game/step/ChessStepBreakObstacle.lua

module("modules.logic.chessgame.game.step.ChessStepBreakObstacle", package.seeall)

local ChessStepBreakObstacle = class("ChessStepBreakObstacle", BaseWork)

function ChessStepBreakObstacle:init(stepData)
	self.originData = stepData
end

function ChessStepBreakObstacle:onStart()
	self:breakObstacle()
end

function ChessStepBreakObstacle:breakObstacle()
	local hunterId = self.originData.hunterId
	local hunter = ChessGameController.instance.interactsMgr:get(hunterId)
	local obstacleId = self.originData.obstacleId
	local obstacle = ChessGameController.instance.interactsMgr:get(obstacleId)

	if not hunter or not obstacle then
		self:onDone(true)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_1ChessGame.play_ui_wangshi_bad)
	hunter:getHandler():breakObstacle(obstacle, self._onFlowDone, self)
end

function ChessStepBreakObstacle:_onFlowDone()
	local catchObj = ChessGameModel.instance:getCatchObj()

	if catchObj and catchObj.mo.id == self.originData.obstacleId then
		ChessGameModel.instance:setCatchObj(nil)
	end

	ChessGameController.instance:deleteInteractObj(self.originData.obstacleId)
	self:onDone(true)
end

return ChessStepBreakObstacle
