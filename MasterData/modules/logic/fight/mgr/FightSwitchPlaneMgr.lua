-- chunkname: @modules/logic/fight/mgr/FightSwitchPlaneMgr.lua

module("modules.logic.fight.mgr.FightSwitchPlaneMgr", package.seeall)

local FightSwitchPlaneMgr = class("FightSwitchPlaneMgr", FightBaseClass)

function FightSwitchPlaneMgr:onConstructor()
	return
end

function FightSwitchPlaneMgr:_startSwitch()
	local transitionMgr = FightHelper.getTransitionMgr()

	if transitionMgr then
		transitionMgr:setTransition(FightTransitionMgr.TransitionEnum.SwitchPlaning)
	end
end

function FightSwitchPlaneMgr:_endSwitch()
	local transitionMgr = FightHelper.getTransitionMgr()

	if transitionMgr then
		transitionMgr:clearTransition()
	end
end

function FightSwitchPlaneMgr:switchPlane()
	FightController.instance:dispatchEvent(FightEvent.BeforeSwitchPlane)
	self:_startSwitch()

	local flow = self:com_registFlowSequence()

	flow:registWork(FightSwitchPlaneSequence)
	flow:registFinishCallback(self.onSwitchPlaneDone)
	flow:start()
end

function FightSwitchPlaneMgr:onSwitchPlaneDone()
	self:_endSwitch()
	FightController.instance:dispatchEvent(FightEvent.AfterSwitchPlane)
end

function FightSwitchPlaneMgr:onDestructor()
	self:_endSwitch()
end

return FightSwitchPlaneMgr
