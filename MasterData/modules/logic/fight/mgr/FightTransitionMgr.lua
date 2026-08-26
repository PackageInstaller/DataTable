-- chunkname: @modules/logic/fight/mgr/FightTransitionMgr.lua

module("modules.logic.fight.mgr.FightTransitionMgr", package.seeall)

local FightTransitionMgr = class("FightTransitionMgr", FightBaseClass)

FightTransitionMgr.TransitionEnum = {
	Restarting = 1,
	SwitchPlaning = 2,
	None = 0
}

function FightTransitionMgr:onConstructor()
	self.transitionEnum = FightTransitionMgr.TransitionEnum.None
end

function FightTransitionMgr:setTransition(transitionEnum)
	if self.transitionEnum ~= FightTransitionMgr.TransitionEnum.None then
		logError("当前过度状态不为空？")
	end

	self.transitionEnum = transitionEnum
end

function FightTransitionMgr:checkTransitionIsEmpty()
	return self.transitionEnum == FightTransitionMgr.TransitionEnum.None
end

function FightTransitionMgr:clearTransition()
	self.transitionEnum = FightTransitionMgr.TransitionEnum.None
end

return FightTransitionMgr
