-- chunkname: @modules/logic/sp01/assassin2/controller/stealthgameflow/StealthEnemyTurnBeginWork.lua

module("modules.logic.sp01.assassin2.controller.stealthgameflow.StealthEnemyTurnBeginWork", package.seeall)

local StealthEnemyTurnBeginWork = class("StealthEnemyTurnBeginWork", BaseWork)
local TWEEN_MAP_WAIT_TIME = 0.24

function StealthEnemyTurnBeginWork:onStart(context)
	local isCancelSelected = true
	local mapId = AssassinStealthGameModel.instance:getMapId()

	if mapId == AssassinEnum.StealthConst.FirstStealthMap then
		local checkGuide = AssassinConfig.instance:getStealthMapForbidScaleGuide(mapId)

		if checkGuide then
			isCancelSelected = GuideModel.instance:isGuideFinish(checkGuide)
		end
	end

	if isCancelSelected then
		AssassinStealthGameController.instance:selectHero()
	end

	local hasEnemyOperation = AssassinStealthGameModel.instance:getHasEnemyOperation()

	if hasEnemyOperation then
		AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.TweenStealthMapPos, {
			scale = AssassinEnum.StealthConst.MinMapScale
		}, true)
		TaskDispatcher.cancelTask(self._tweenMapFinished, self)
		TaskDispatcher.runDelay(self._tweenMapFinished, self, AssassinEnum.StealthConst.MapTweenPosTime + TWEEN_MAP_WAIT_TIME)
	else
		TaskDispatcher.runDelay(self._tweenMapFinished, self, AssassinEnum.StealthConst.EnemyTurnWaitTime)
	end
end

function StealthEnemyTurnBeginWork:_tweenMapFinished()
	self:onDone(true)
end

function StealthEnemyTurnBeginWork:clearWork()
	TaskDispatcher.cancelTask(self._tweenMapFinished, self)
end

return StealthEnemyTurnBeginWork
