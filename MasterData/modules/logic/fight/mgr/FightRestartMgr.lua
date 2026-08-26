-- chunkname: @modules/logic/fight/mgr/FightRestartMgr.lua

module("modules.logic.fight.mgr.FightRestartMgr", package.seeall)

local FightRestartMgr = class("FightRestartMgr", FightBaseClass)

function FightRestartMgr:onConstructor()
	return
end

function FightRestartMgr:restart()
	self:_startRestart()

	local flow = self:com_registFlowSequence()

	flow:registWork(FightRestartSequence)
	flow:registFinishCallback(self.onRestartFinish, self)
	flow:start()
end

function FightRestartMgr:_startRestart()
	FightSystem.instance.restarting = true

	local transitionMgr = FightHelper.getTransitionMgr()

	if transitionMgr then
		transitionMgr:setTransition(FightTransitionMgr.TransitionEnum.Restarting)
	end
end

function FightRestartMgr:onRestartFinish()
	self:_endRestart()
end

function FightRestartMgr:cancelRestart()
	self:_endRestart()
end

function FightRestartMgr:_endRestart()
	FightSystem.instance.restarting = false

	local transitionMgr = FightHelper.getTransitionMgr()

	if transitionMgr then
		transitionMgr:clearTransition(FightTransitionMgr.TransitionEnum.Restarting)
	end
end

function FightRestartMgr:restartFightFail()
	ToastController.instance:showToast(-80)
	self:cancelRestart()
	FightController.instance:exitFightScene()
end

function FightRestartMgr:directStartNewFight()
	local work = self:com_registWork(FightWorkDirectStartNewFightAfterEndFight)

	work:start()
end

function FightRestartMgr:directSwitchBattle()
	local work = self:com_registWork(FightWorkDirectSwitchBattleAfterEndFight)

	work:start()
end

function FightRestartMgr:fastRestart()
	self:_startRestart()

	local flow = self:com_registFlowSequence()

	flow:registWork(FightFastRestartSequence)
	flow:registFinishCallback(self.onRestartFinish, self)
	flow:start()
end

function FightRestartMgr:onDestructor()
	self:_endRestart()
end

return FightRestartMgr
