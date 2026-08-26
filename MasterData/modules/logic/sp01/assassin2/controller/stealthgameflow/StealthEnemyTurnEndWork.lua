-- chunkname: @modules/logic/sp01/assassin2/controller/stealthgameflow/StealthEnemyTurnEndWork.lua

module("modules.logic.sp01.assassin2.controller.stealthgameflow.StealthEnemyTurnEndWork", package.seeall)

local StealthEnemyTurnEndWork = class("StealthEnemyTurnEndWork", BaseWork)

function StealthEnemyTurnEndWork:onStart(context)
	local posX, posY, scale = AssassinStealthGameModel.instance:getMapPosRecordOnTurn()

	if posX and posY and scale then
		AssassinStealthGameModel.instance:setMapPosRecordOnTurn()
		AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.TweenStealthMapPos, {
			x = posX,
			y = posY,
			scale = scale
		})
		TaskDispatcher.cancelTask(self._tweenMapFinished, self)
		TaskDispatcher.runDelay(self._tweenMapFinished, self, AssassinEnum.StealthConst.MapTweenPosTime)
	else
		self:_tweenMapFinished()
	end
end

function StealthEnemyTurnEndWork:_tweenMapFinished()
	self:onDone(true)
end

function StealthEnemyTurnEndWork:clearWork()
	TaskDispatcher.cancelTask(self._tweenMapFinished, self)
end

return StealthEnemyTurnEndWork
